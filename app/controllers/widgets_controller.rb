class WidgetsController < ApplicationController
  respond_to :json

  def index
    respond_with Widget.all
  end
  def show; end
  def create; end
  def update; end
  def destroy; end
end
