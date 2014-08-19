# == Schema Information
#
# Table name: device_users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  active          :boolean
#  device_id       :integer
#  created_at      :datetime
#  updated_at      :datetime
#  project_id      :integer
#

class DeviceUser < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :username, :password, :password_confirmation

  belongs_to :device
  belongs_to :project
end
