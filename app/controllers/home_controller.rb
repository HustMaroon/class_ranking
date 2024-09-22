class HomeController < ApplicationController
  def index
    redirect_to scoring_records_path if user_signed_in?
  end
end
