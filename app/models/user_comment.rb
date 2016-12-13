class UserComment < ActiveRecord::Base
  validates :body, :user_id, :author_id, presence: true

  belongs_to :user
  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

end
