class Pin < ActiveRecord::Base
  attr_accessible :description, :image

  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true, 
  															content_type: {content_type: ['image/jpg', 'image/png', 'image/gif', 'image/jpeg']},
  															size: {less_than: 5.megabytes}

  belongs_to :user
  has_attached_file :image, styles:{ medium: "320x240>", thumb: "80x60>"},
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => ":attachment/:id/:style.:extension",
  :bucket => "omrails_images"
end
