class Representative < ApplicationRecord
  has_many :kinships
  has_many :relatives, through: :kinship
  enum party: [:no_party, :dpp, :kmt]
  enum job_type: [:legislator, :正副議長]
end
