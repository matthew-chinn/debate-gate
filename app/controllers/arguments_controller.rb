class ArgumentsController < ApplicationController
  def new
    @debate_id = params[:id]
    @debate = Debate.find(@debate_id)
    @pro
    if params[:side] == "pro"
      @pro = true
    elsif params[:side] == "con"
      @pro = false
    end
    @new_arg = Argument.new
  end

  def create
    @created_arg = Argument.create(arg_params)
    @debate_id = @created_arg.debate_id
    @debate = Debate.find(@debate_id)
    @pro = @created_arg.proponent

    if @created_arg.errors.any?
      flash[:danger] = "New argument could not be made"
      @new_arg = @created_arg
      render 'new'
    else
      flash[:success] = "Argument created successfully"
      params[:id] = @created_arg.debate_id
      redirect_to debate_path(@created_arg.debate_id)
    end
  end

  def show
    @arg = Argument.find(params[:id])
    @counter_arguments = @arg.counter_arguments
    @supporter_arguments = @arg.supporting_arguments 
  end

  private
  def arg_params
    params.require(:argument).permit(:title, :description, :creator_id,
                                     :debate_id, :proponent)
  end
end
