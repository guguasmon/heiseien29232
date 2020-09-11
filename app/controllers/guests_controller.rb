class GuestsController < ApplicationController
  def index
  end
  def new
    @guest = Guest.new
  end
end
