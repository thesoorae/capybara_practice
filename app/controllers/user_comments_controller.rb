class UserCommentsController < ApplicationController

  def create
    user_comment = UserComment.new(user_comment_params)
    user_comment.author_id = current_user.id
    if user_comment.save
      redirect_to user_url(user_comment.user)
    else
      flash[:errors] = user_comment.errors.full_messages
      redirect_to user_url(user_comment.user)
    end
  end

  def destroy

  end

  def user_comment_params
    params.require(:user_comment).permit(:body, :user_id)
  end
end
