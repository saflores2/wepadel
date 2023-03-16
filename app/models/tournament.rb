class Tournament < ApplicationRecord
  belongs_to :user
  self.inheritance_column = :foo
  has_many :participations, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_one_attached :photo
  validates :name, :start_date, :end_date, :type, :category, :address, :places, presence: true
  validates_inclusion_of :type, in: ["Champions League", "Americano", "Express", "Otro"]
  validates_inclusion_of :category, in: ["Masculino 1ra", "Masculino 2da", "Masculino 3ra", "Masculino 4ta", "Masculino 5ta", "Masculino 6ta", "Femenino A", "Femenino B", "Femenino C", "Femenino D", "Mixto A", "Mixto B", "Mixto C", "Mixto D", "Otra"]
  validate :places_valid

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  private

  def places_valid
    if (type == "Champions League" && places != 16) || (type == "Express" && places != 8) || (type == "Americano" && places.odd? )
      errors.add(:places, "cupos no coinciden con tipo de torneo")
    end
  end
end
