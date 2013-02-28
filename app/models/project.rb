class Project < ActiveRecord::Base
  attr_accessible :blurb, :category, :cost, :description, :progressupdate, :title
end
