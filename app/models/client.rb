# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  phone      :string
#  email      :string
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Client < ActiveRecord::Base
  belongs_to :company
  has_many :jobs
end
