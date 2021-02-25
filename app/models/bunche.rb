# == Schema Information
#
# Table name: bunches
#
#  id         :bigint           not null, primary key
#  cost       :float            not null
#  quantity   :integer          default(1), not null
#  ripeness   :string           not null
#  seller_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bunche < ApplicationRecord
  validates :cost, :quantity, :ripeness, presence: true

  belongs_to :seller,
    class_name: :User
end
