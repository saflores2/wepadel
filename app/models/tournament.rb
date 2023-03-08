class Tournament < ApplicationRecord
  belongs_to :user
  self.inheritance_column = :foo
  has_many :participations, dependent: :destroy
  has_one_attached :photo
  validates :name, :start_date, :end_date, :type, :category, :places, :ubication_address, :price, presence: true
  validates_inclusion_of :type, in: ["Champions League", "Americano", "Express"]
  # validates_inclusion_of :gender, in: ["Femenino", "Masculino", "Mixto"]
  validates_inclusion_of :category, in: ["Masculino 1ra", "Masculino 2da", "Masculino 3ra", "Masculino 4ta", "Masculino 5ta", "Masculino 6ta", "Femenino A", "Femenino B", "Femenino C", "Femenino D", "Mixto A", "Mixto B", "Mixto C", "Mixto D", "Otra"]
end
