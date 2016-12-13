class Goal < ActiveRecord::Base
  validates :goal_text, :user_id, :visibility, presence:true

  belongs_to :user,
  inverse_of: :goals

  
end
