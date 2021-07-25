class CheckinsController < ApplicationController
  def create
    # create a new check-in from POSTed email matched to user and add it to the log
    # no auth/auth required
  end

  def show
    # return latest check-in with profile picture and relevant information
    # admin required
  end

  def index
    # return full list of check-ins from the past week (interim timeframe)
    # admin required
  end
end
