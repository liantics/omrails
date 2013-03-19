class Project < ActiveRecord::Base
  attr_accessible :title, :blurb, :category, :cost, :description, :progressupdate

	validates :title, :description, :user_id, presence: true
	validates :cost, :numericality => true

  belongs_to :user

end
