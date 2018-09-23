module PartyClassifiable
  extend ActiveSupport::Concern
  PARTIES_MAPPING = {
    '民主進步黨': :dpp,
    '中國國民黨': :kmt,
    '時代力量': :npp,
    '親民黨': :pfp,
    '無黨籍': :no_party,
    '其他': :other
  }.with_indifferent_access

  included do
    enum party: [:dpp, :kmt, :npp, :pfp, :no_party, :other]
  end
end
