class ArgumentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @debate_id = params[:debate_id]
    @debate = Debate.find(@debate_id)
    @creator_id = current_user.id
    @cancel_path = debate_path(@debate_id)

    #for counter and supporter arguments
    if params[:id]
      @cancel_path = argument_path(params[:id])
      @ref_argument_id = params[:id]
      @ref_argument = Argument.find(@ref_argument_id)
      @ref_type = params[:type]

      @pro = @ref_argument.proponent
      @pro = @ref_type == "Supporting" ? @pro : !@pro #if counter argument, flip 
    else
      if params[:side] == "pro"
        @pro = true
      elsif params[:side] == "con"
        @pro = false
      end
    end
    @new_arg = Argument.new
  end

  def create
    @created_arg = Argument.create(arg_params)
    @debate_id = @created_arg.debate_id
    @debate = Debate.find(@debate_id)
    @pro = @created_arg.proponent

    @links = get_links_from_params 

    if @created_arg.errors.any?
      flash[:danger] = "New argument could not be made"
      @new_arg = @created_arg
      @creator_id = current_user.id

      if params[:ref]
        @ref_argument_id = params[:ref][:id]
        @ref_type = params[:ref][:id]
      end

      render 'new'
    else #successful creation
      #flash[:success] = "Argument created successfully"

      @created_arg.update_attribute(:links, @links)

      redirect_to debate_path(@created_arg.debate_id) and return #debate
    end
  end

  def show
    @arg = Argument.find(params[:id])
    @counter_arguments = @arg.counter_arguments
    @supporter_arguments = @arg.supporting_arguments 
    @links = @arg.links
    @links ||= []
  end

  #view for supporting or counter arguments
  def supporting_or_counter
      @arg = Argument.find(params[:id])
      @type = params[:type] #supporting or counter
      if @type == "supporting"
          @side_arguments = @arg.supporting_arguments
          @pro = @arg.proponent
      else #string == "counter" argument
          @side_arguments = @arg.supporting_arguments
          @pro = @arg.proponent
      end
  end

  def toggle_favoritor
      ret = Favorite.toggle( params[:user_id], params[:id] )
      render text: "#{ret}"
  end

  private
  def arg_params
    params.require(:argument).permit(:title, :description, :creator_id,
                                     :debate_id, :proponent, :links )
  end

  def supporting_or_counter_arguments?
    if params[:ref][:type] != ""
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


  def get_links_from_params
    params[:argument][:links].split("\n").delete_if{|elem| elem.blank?}
  end
end
