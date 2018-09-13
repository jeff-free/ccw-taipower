class Relative < ApplicationRecord
  include Importable
  has_one :organization
  enum kinship_type: [:onself, :spouse, :other_kinship]
end
