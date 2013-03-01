class Project < ActiveRecord::Base
  attr_accessible :blurb, :category, :cost, :description, :progressupdate, :title

	validates :user_id, presence: true

  belongs_to :user

end
