# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  phone           :string
#  address         :string
#  company_id      :integer
#  boss            :boolean          default(FALSE)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :email

  has_many :payslips
  belongs_to :company
  has_many :jobs, :through => :payslips

end
