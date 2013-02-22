require 'open-uri'
require 'timeout'

class Pin < ActiveRecord::Base
  
  attr_accessor :image_url
  attr_accessible :description, :image, :image_remote_url, :image_url
  
  before_validation :download_remote_image, :if => lambda { |pin| pin.image_url.present? }

  validates :description, presence: true
  validates :user_id, presence: true
  validates_presence_of :download_remote_image, :if=> :image_url_provided?, :message => 'is invalid or inaccessible'
  validates_attachment :image, presence: true, 
  															content_type: {content_type: ['image/jpg', 'image/jpeg', 'image/JPG', 'image/png', 'image/gif']},
  															size: {less_than: 5.megabytes}

  belongs_to :user
  has_attached_file :image, 
  		:storage => :s3,
  		:s3_credentials => {
        :bucket => ENV['S3_BUCKET_NAME'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      },
    	styles:{ 
  			thumb: "4800@>",
  			small: "160x120>",
  			medium: "320x240>",
  			large: "640x480>"
  		 }


	private
  
      	  def image_url_provided? 
            puts "[DEBUG] executing image_url_provided test for url #{self.image_url}"
      	    !self.image_url.blank?
      	  end

      	  def download_remote_image
            self.image = do_download_remote_image
            self.image_remote_url = image_url 
            puts "[DEBUG] image_remote_url has been set to image_url"

      	  end #end def download_remote_image

          def do_download_remote_image
            io = open(URI.parse(image_url))
              def  io.original_filename; base_uri.path.split('/').last; 
              end
            io.original_filename.blank? ? nil : io
            rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
              print "An error occurred ",$!, "\n"

          end
 
end #end class pin
