class Domain < ApplicationRecord
  belongs_to :user

  after_create :check_domain_and_update_result

  validates :name, presence: true
  validates :model_type, presence: true
  validates :model_identifier, presence: true

  private

  def check_domain_and_update_result
    response = Domains::CheckDotnetService.new(self).call
    if response[:success]
      update!(model_result: response[:result])
    else
      errors.add(:base, response[:error])
      # raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
