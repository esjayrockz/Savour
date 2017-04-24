class Dish < ApplicationRecord
  searchkick
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_attached_file :image, styles: { medium: "400x600>", thumb: "60x90>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
