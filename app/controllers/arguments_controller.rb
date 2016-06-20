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

    @links = get_links 

    if @created_arg.errors.any?
      flash[:danger] = "New argument could not be made"
      @new_arg = @created_arg
      render 'new'
    else #successful creation
      flash[:success] = "Argument created successfully"

      @created_arg.update_attribute(:links, @links)
      if supporting_or_counter_arguments?
        redirect_to argument_path(params[:ref][:id]) and return #original argument
        #render 'new'
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

  def supporting_or_counter_arguments?
    if params[:ref][:type]
      arg = Argument.find(params[:ref][:id])
      if params[:ref][:type] == "Supporter"
        arg.supporting_arguments << @created_arg
        @created_arg.proponent = arg.proponent
        @created_arg.save
      else
        arg.counter_arguments << @created_arg
        @created_arg.proponent = !arg.proponent
        @created_arg.save
      end
      return true
    end

    return false
  end


  def get_links
    params[:argument][:links].split("\n")
  end
end
