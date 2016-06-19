class ArgumentsController < ApplicationController
  def new
    @debate_id = params[:id]
    @debate = Debate.find(@debate_id)

    #for counter and supporter arguments
    @ref_argument_id = params[:argument_id]
    @ref_argument = Argument.find(@ref_argument_id)
    @ref_type = params[:type]

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
      if params[:ref][:type]
        if params[:ref][:type] == "Supporter"
          Argument.find(params[:ref][:id]).supporting_arguments << @created_arg
        else
          Argument.find(params[:ref][:id]).counter_arguments << @created_arg
        end
        redirect_to argument_path(params[:ref][:id]) and return #original argument
      end

      redirect_to debate_path(@created_arg.debate_id) and return #debate
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
                                     :debate_id, :proponent )
  end
end
