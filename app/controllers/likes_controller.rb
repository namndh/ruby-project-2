class LikesController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    @like = @song.likes.find_by(user_id: current_user.id)
    if @like
      @like.destroy
    else
      @like = @song.likes.create(user_id: current_user.id)
    end
    redirect_back fallback_location: root_path
  end
end
