class SearchController < ApplicationController
  def index
    @songs = Song.search(params[:search])
  end
end
