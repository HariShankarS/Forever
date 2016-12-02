class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :photographs
  accepts_nested_attributes_for :photographs, reject_if: :all_blank, allow_destroy: true
  acts_as_votable

  def liked_users
    get_upvotes.voters.collect(&:name).join(", ")
  end


  def commented_users
    User.joins("INNER JOIN comments on comments.user_id = users.id and comments.post_id = #{self.id}").select("REPLACE(group_concat(distinct users.name), ',', ', ') as commented_users").group("comments.post_id").first.try(:commented_users)
  end
end
