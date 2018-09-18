require 'open-uri'

class Organization < ApplicationRecord
  include Importable
  belongs_to :owner, class_name: 'Relative', foreign_key: :relative_id,
                     required: false
  enum np_type: [:np100_1, :np100_2, :np100_3, :np200, :np300, :np400,
                 :np500, :np600, :np700]

  def self.np_type_mapping
    Hash[np_types.keys.map{ |key| [key, key.upcase.dasherize] }].freeze
  end

  def self.import_from_api
    base_uri = "#{ENV['npo_moi_api_endpoint']}&key=#{ENV['npo_moi_api_key']}"
    np_type_mapping.each do |type_enum_format, type_api_format|
      next if type_enum_format.in?(['np400', 'np500', 'np600', 'np700'])

      end_point_uri = "#{base_uri}&nptype=#{type_api_format}"
      response = open(end_point_uri,
                      ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
                      read_timeout: 300).read
      JSON.parse(response).each do |org|
        next unless org['負責人(理事長/理事主席)'].present? || org['負責人'].present?

        case type_enum_format
        when 'np100_1', 'np100_2', 'np100_3'
          where(name: org['團體名稱'],
                owner_name: org['負責人(理事長/理事主席)'],
                np_type: type_enum_format).first_or_create
        when 'np200'
          where(name: org['教會名稱'],
                owner_name: org['負責人'],
                np_type: type_enum_format).first_or_create
        when 'np300'
          where(name: org['寺廟名稱'],
                owner_name: org['負責人'],
                np_type: type_enum_format).first_or_create
        end
      end
    end
  end

  def self.import(file)
    return false unless file

    xlsx = Roo::Spreadsheet.open(file)
    expenditures_org_names = Expenditure.pluck(:organization_name)
    npo_moi_700_sheet = xlsx.sheet('內政部社區發展協會資料').drop(1).keep_if do |row|
      row[2].present? && expenditures_org_names.include?(row[1])
    end
    transaction do
      npo_moi_700_sheet.each do |row|
        org = Organization.np700.find_or_create_by(
          name: row[1],
          owner_name: row[2]
        )
        Expenditure.where(organization_name: row[1]).update_all(organization_id: org.id)
      end
    end
  end
end
