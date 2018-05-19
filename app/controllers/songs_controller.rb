class SongsController < ApplicationController
  def index
    @songs = Song.all.order("created_at desc")
    @hot_songs = Song.hot_songs
    # @user_panel = true
  end

  def new
    @song = Song.new
  end

  def show
    @hot_songs = Song.hot_songs
    @song = Song.find(params[:id])
    @comments = @song.comments
    @like_count = @song.likes.count
  end

  def create
    @user = current_user
    @song = @user.songs.build(song_params)
    if @song.save
      flash[:success] = "Publish success"
      redirect_to(@song)
    else
      render 'new'
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      flash[:success] = "Successfully updated"
      redirect_to(@song)
    else
      flash[:error] = "Update fail"
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @song = @user.songs.find(params[:id])
    if @song.destroy
      flash[:success] = "Song was successfully deleted"
      redirect_to(@song)
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :file, :artist, :description)
  end

  # def find_song
  #   @song = current_user.songs.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   flash[:warning] = "Permission denied"
  #   redirect_to root_path
  # end
end
