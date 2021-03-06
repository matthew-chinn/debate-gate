class DebatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category_id]
      category = Category.find(params[:category_id])
      @debates = category.debates
      @category = category.name
    else
      @debates = Debate.all
      @category = "All"
    end
    @categories = Category.all
  end

  def new
    @new_debate = Debate.new
    @categories = Category.all
  end

  def create
    @created_debate = Debate.create(debate_params)
    
    #add categories to debate
    if categories = params[:debate][:categories]
        categories.each do |c|
            if c.blank?
                next
            end
            @created_debate.categories << Category.find(c.to_i)
        end
    end

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
