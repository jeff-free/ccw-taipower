class Relative < ApplicationRecord
  include Importable
  has_one :organization, dependent: :nullify
  has_many :expenditures, through: :organization
  belongs_to :representative
  enum kinship_type: [:oneself, :spouse, :other_kinship]

  def self.kinship_type_mapping
    { oneself: '本人', spouse: '配偶', other_kinship: '其他' }.with_indifferent_access
  end
end
