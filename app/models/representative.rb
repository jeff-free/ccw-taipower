class Representative < ApplicationRecord
  include PartyClassifiable
  include Importable
  JOB_TYPE_MAPPING = {
    self.human_attribute_name('job_type.congressman') => :congressman,
    self.human_attribute_name('job_type.local_council_speaker') => :local_council_speaker
  }.with_indifferent_access

  has_many :relatives
  has_many :organizations, through: :relatives
  has_many :expenditures, through: :organizations
  enum job_type: [:congressman, :local_council_speaker]

  def self.import(file)
    return false unless file

    xlsx = Roo::Spreadsheet.open(file)
    transaction do
      congressman_sheet = xlsx.sheet('立法委員配偶關係表')
      (2..congressman_sheet.last_row).each do |row_number|
        row = congressman_sheet.row(row_number)
        Representative.congressman.where(
          name: row[1],
          party: PARTIES_MAPPING[row[9]] || PARTIES_MAPPING['其他'],
          job_title: '立法委員'
        ).first_or_create
      end
      local_council_speaker_sheet = xlsx.sheet('正副議長職稱表')
      (2..local_council_speaker_sheet.last_row).each do |row_number|
        row = local_council_speaker_sheet.row(row_number)
        Representative.local_council_speaker.where(
          name: row[1],
          party: PARTIES_MAPPING[row[3]] || PARTIES_MAPPING['其他'],
          job_title: row[0]
        ).first_or_create
      end
    end
  end
end
