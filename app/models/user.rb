class User < ActiveRecord::Base
  has_secure_password

  has_many :payslips
  belongs_to :company
  has_many :jobs, :through => :payslips

end
