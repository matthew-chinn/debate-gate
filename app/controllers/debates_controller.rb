class DebatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @debates = Debate.all
  end

  def new
    @new_debate = Debate.new
    @categories = Category.all
  end

  def create
    @created_debate = Debate.create(debate_params)

    if @created_debate.errors.any?
      flash[:danger] = "New debate could not be made"
      @new_debate = @created_debate
      render 'new'
    else
      flash[:success] = "Debate created successfully"
      redirect_to debate_path(@created_debate)
    end

  end

  def show
    @debate = Debate.find(params[:id])
    @pros = Argument.pro_arguments_for(@debate.id)
    @cons = Argument.con_arguments_for(@debate.id)
  end

  private
  def debate_params
    params.require(:debate).permit(:title, :description, :creator_id)
  end
end
