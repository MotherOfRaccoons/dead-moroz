class Gift < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :added_by, class_name: 'User'
end
