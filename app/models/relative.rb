class Relative < ApplicationRecord
  has_one :organization
  enum kinship: [:father, :mother, :sister]
end
