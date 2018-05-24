class SearchController < ApplicationController
  def index
    @songs = Song.search(params[:query])
    @songs = @songs.page(params[:page]).per(20)
  end
end
