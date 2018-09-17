class RelativeBuilder

  def self.import(file)
    return false unless file

    xlsx = Roo::Spreadsheet.open(file)
    relative_relation_sheet = xlsx.sheet('重量級民代(立委、正副議長)親屬關係表').drop(1)
    relative_title_sheet = xlsx.sheet('重量級民代(立委、正副議長)親屬職稱表').drop(1)
    Organization.select(:id, :owner_name, :relative_id).in_batches do |orgs|
      relative_relation_sheet.each do |row|
        next if row[2].blank?

        owned_orgs = orgs.where(owner_name: row[1])
        next if owned_orgs.blank?

        title = 'pending'
        relative = Relative.create(name: row[1],
                                   title: relative_title_sheet[],
                                   kinship_type: Relative.kinship_type_mapping.key(row[2]),
                                   representative: Representative.find_by(name: row[0]))
        owned_orgs.update_all(owner: relative)


      end
    end
    
  end

  def initialize
    
  end
end
