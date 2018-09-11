class Organization < ApplicationRecord
  belongs_to :owner, class_name: 'Relative', foreign_key: :relative_id
  enum np_type: []
end
