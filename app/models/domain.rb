class Domain < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :model_type, presence: true
  validates :model_name, presence: true
  validates :model_result, numericality: { only_integer: true }
end
