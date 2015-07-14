# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  address    :string
#  notes      :text
#  start      :datetime
#  end        :datetime
#  seconds    :integer          default(0)
#  comments   :text
#  client_id  :integer
#  company_id :integer
#  completed  :boolean          default(FALSE)
#  paid       :boolean          default(FALSE)
#  photo1     :string
#  photo2     :string
#  photo3     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Job, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
