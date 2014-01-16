class Project < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :instruments
  has_many :project_devices
  has_many :devices, through: :project_devices
  has_many :users
  has_many :surveys
  has_many :responses
  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: true
end
