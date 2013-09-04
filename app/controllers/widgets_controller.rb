class WidgetsController < ApplicationController
  respond_to :json

  rescue_from Exception, :with => :error_render_method

  def error_render_method(e)
    respond_with_error(e.message)
    
    true
  end

  def index
    respond_with Widget.all
  end

  def show
    respond_with Widget.where(:name => params[:id]).first!
  end
  
  def create
    w = Widget.create(:name => params["name"])

    w.save ? respond_with(w) : respond_with_error('validation_failed')
  end

  def destroy
    if Widget.where(:name => params[:id]).first!.destroy
      respond_with_success
    else
      respond_with_error
    end
  end

  private

  def respond_with_success
    render :json => { :success => true }
  end

  def respond_with_error(e)
    render :json => { :error => e }
  end
end
