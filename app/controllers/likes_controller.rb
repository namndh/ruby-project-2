class LikesController < ApplicationController
  def create
    if current_user
      @song = Song.find(params[:song_id])
      @like = @song.likes.find_by(user_id: current_user.id)
      if @like
        @like.destroy
      else
        @like = @song.likes.create(user_id: current_user.id)
      end
      redirect_back fallback_location: root_path
    else
      flash[:error] = "Not allowed. Please sign in."
      redirect_to new_user_session_path
    end
  end
end
