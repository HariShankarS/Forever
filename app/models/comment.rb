class Comment < ActiveRecord::Base
  validates_presence_of :user_id, :post_id, :cmnt
  belongs_to :user
  belongs_to :post
  acts_as_votable

  def liked_users
    get_upvotes.voters.collect(&:name).join(", ")
  end
end
