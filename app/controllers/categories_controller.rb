class CategoriesController < ApplicationController
  def create
    name = params[:name]

    if name.blank?
      msg = {error: "Name cannot be blank"}
      render json: msg, status: 400
    end

    existing = Category.find_by( name: name )
    #category should not exist yet, eventually add this to schema
    if existing 
      msg = {error: "Category already exists"}
      render json: msg, status: 400
    else
      res = Category.create(name: name)
      msg = {name: name, id: res.id}
      render :json => msg
    end
  end
end
