# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  username            :string           not null
#  ripeness_preference :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :bunches_to_sell,
    foreign_key: :seller_id,
    class_name: :Bunche
end
