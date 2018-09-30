class RelativeBuilder
  def self.import(file)
    return false unless file

    xlsx = Roo::Spreadsheet.open(file)
    import_by_scanning_relatives(xlsx)
    import_by_representative_selfs
  end

  def self.import_by_scanning_relatives(xlsx)
    Organization.where(owner_name: relative_array(xlsx).map { |row| row[:name] }).in_batches do |orgs|
      relative_array(xlsx).each do |row|
        owned_orgs = orgs.where(owner_name: row[:name])

        kinship_type = '其他' unless row[:detail][:kinship] == '配偶'
        relative = Relative.find_or_create_by(
          name: row[:name],
          title: relative_title_hash(xlsx)[row[:name]],
          kinship_type: Relative.kinship_type_mapping.key(kinship_type),
          kinship_name: row[:detail][:kinship],
          representative: Representative.find_by(name: row[:detail][:representative])
        )
        next if owned_orgs.blank?
        owned_orgs.update_all(relative_id: relative.id)
      end
    end
  end

  def self.import_by_representative_selfs
    Relative.transaction do
      Organization.where(owner_name: Representative.pluck(:name)).each do |org|
        representative = Representative.find_by(name: org.owner_name)
        relative = Relative.oneself.find_or_create_by(
          name: org.owner_name,
          title: representative.job_title,
          kinship_name: '本人',
          representative: representative
        )
        org.update(relative_id: relative.id)
      end
    end
  end

  def self.relative_array(xlsx)
    @relative_array ||= Hash.new do |h, key|
      h[key] = key.sheet('重量級民代(立委、正副議長)親屬關係表').drop(1).map do |r|
        next if r[1] == 'N/A' || r[2].blank?

        { name: r[1], detail: { representative: r[0], kinship: r[2] } }
          .with_indifferent_access
      end.compact
    end
    @relative_array[xlsx]
  end

  def self.relative_title_hash(xlsx)
    @relative_title_hash ||= Hash.new do |h, key|
      h[key] = Hash[
        key.sheet('重量級民代(立委、正副議長)親屬職稱表').drop(1).map { |row| [row[0], row[1]] }
      ].with_indifferent_access
    end
    @relative_title_hash[xlsx]
  end
end
