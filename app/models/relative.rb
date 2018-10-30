class Relative < ApplicationRecord
  include Importable
  has_many :organizations, dependent: :nullify
  has_many :expenditures, through: :organizations
  belongs_to :representative
  enum kinship_type: [:oneself, :spouse, :other_kinship]

  def self.kinship_type_mapping
    { '本人': :oneself, '配偶': :spouse, '其他': :other_kinship }.with_indifferent_access
  end
end
