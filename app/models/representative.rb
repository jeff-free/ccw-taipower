class Representative < ApplicationRecord
  enum party: [:no_party, :dpp, :kmt]
  scope :councilors, ->(){ where.not(party: nil) }

  def is_councilor
    !party.blank?
  end
end
