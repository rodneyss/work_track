# == Schema Information
#
# Table name: payslips
#
#  id         :integer          not null, primary key
#  paid       :boolean          default(FALSE)
#  start      :datetime         default(Mon, 13 Jul 2015 05:20:27 UTC +00:00)
#  end        :datetime
#  finalized  :boolean          default(FALSE)
#  user_id    :integer
#  seconds    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :payslip do
    
  end

end
