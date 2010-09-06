class OptionsController < ApplicationController
  def index
    @options = Option.all
  end

  def new
    @options = Option.new
  end

  def edit
    @options = Option.find(params[:id])
    render :new
  end

  def update
    @option = Option.find(params[:id])
    success = @option.update_attributes(params[:table])
    success ? redirect_to(options_path) : render(:new)
  end

  def destroy
    @option = Option.find(params[:id])
    flash[:notice] = t(:successfully_deleted, :what => @option.name)
    @option.destroy
    redirect_to options_path
  end

end