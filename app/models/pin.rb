require 'open-uri'
require 'timeout'

class Pin < ActiveRecord::Base

  attr_accessor :image_url
  attr_accessible :description, :image, :image_remote_url, :image_url


  before_validation :download_remote_image, :if => lambda { |pin| pin.image_url.present? }
  
  validates_attachment :image, :presence => true, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image,gif', 'image/JPG']}, size: { less_than: 5.megabytes }

  validates :description, presence: true
  validates :user_id, presence: true

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
    !self.image_url.blank?
  end

  def download_remote_image
    return if self.image.present?
    begin
      Timeout::timeout(2) do
        self.image = URI.parse(image_url)
        self.image_remote_url = image_url
      end
    rescue Exception => e
      Rails.logger.error "Failed to download image from \"#{image_url}\": #{e.message}"
    end
  end
  
end