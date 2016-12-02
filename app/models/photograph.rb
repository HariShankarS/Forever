class Photograph < ActiveRecord::Base
  belongs_to :post
  has_attached_file :chitram, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :chitram, content_type: /\Aimage\/.*\z/
end
