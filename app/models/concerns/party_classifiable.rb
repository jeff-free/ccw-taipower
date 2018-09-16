module PartyClassifiable
  extend ActiveSupport::Concern
  PARTIES_MAPPING = {
    dpp: '民主進步黨',
    kmt: '中國國民黨',
    npp: '時代力量',
    pfp: '親民黨',
    no_party: '無黨籍',
    other: '其他'
  }.with_indifferent_access

  included do
    enum party: [:dpp, :kmt, :npp, :pfp, :no_party, :other]
  end
end
