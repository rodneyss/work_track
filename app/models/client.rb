class Client < ActiveRecord::Base
  belongs_to :company
  has_many :jobs
end
