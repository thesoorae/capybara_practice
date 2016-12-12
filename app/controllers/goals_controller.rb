class GoalsController < ApplicationController
  def create
    goal = Goal.new(goal_params)
    user = goal.user
    flash[:errors] = goal.errors.full_messages unless goal.save
    redirect_to user_url(user)
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end 
  end

  def destroy

  end

  private

  def goal_params
    params.require(:goal).permit(:goal_text, :visibility, :user_id)
  end
end
