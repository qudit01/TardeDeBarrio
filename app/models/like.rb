class Like < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :likeable, polymorphic: true

  # Valida la unicidad del like de su usuario
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
end
