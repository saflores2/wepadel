class Ubication < ApplicationRecord

	# Asociaciones
	belongs_to :user
	has_many :tournaments, dependent: :destroy
	has_many :participations, dependent: :destroy

	#Active Record
	has_one_attached :photo

	# Geocoder
	geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

	# Validaciones
	validates :name, :last_name, :address, presence: true
end
