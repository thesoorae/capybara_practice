class GoalCommentsController < ApplicationController
  def new
    @goal = Goal.find(params[:goal_id])
    render :new
  end

  def create
    gc = GoalComment.new(gc_params)
    gc.author_id = current_user.id
    gc.goal_id = params[:goal_id]
    flash[:errors] = gc.errors.full_messages unless gc.save
      redirect_to user_url(gc.goal.user_id)

  end

  def gc_params
    params.require(:goal_comment).permit(:body)
  end

end
