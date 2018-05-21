class SongsController < ApplicationController

  def hot_songs
    @songs = Song.hot_songs
    @new_songs = Song.all.order("created_at desc")
    render 'index'
  end

  def my_songs
    @songs = current_user.songs
    render 'index'
  end

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @songs = @user.songs
    else
      if current_user
        @songs = current_user.songs
      else
        @songs = Song.hot_songs
      end
    end
    @hot_songs = Song.hot_songs
  end

  def new
    @song = Song.new
  end

  def show
    @hot_songs = Song.hot_songs
    @song = Song.find(params[:id])
    @comments = @song.comments.order("created_at desc")
    @like_count = @song.likes.count
  end

  def create
    @user = current_user
    if @user
      @song = @user.songs.build(song_params)
      if @song.save
        flash[:success] = "Upload success"
        redirect_to(@song)
      else
        render 'new'
      end
    else
      flash[:error] = "Not allowed. Please sign in."
      redirect_to new_user_session_path
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if current_user
      if current_user.id == @song.user.id
        if @song.update(song_params)
          flash[:success] = "Successfully updated"
          redirect_to(@song)
        else
          flash[:error] = "Update fail"
          render 'edit'
        end
      else
        flash[:error] = "Not allowed"
        redirect_to(@song)
      end
    else
      flash[:error] = "Not allowed. Please sign in."
      redirect_to new_user_session_path
    end
  end

  def destroy
    @user = current_user
    if !@user
      flash[:error] = "Not allowed. Please sign in."
      redirect_to new_user_session_path
    else
      @song = Song.find(params[:id])
      if @song.user == @user
        if @song.destroy
          flash[:success] = "Song was successfully deleted"
          redirect_to(@song)
        end
      else
        flash[:error] = "Not allowed"
        redirect_back fallback_location: root_path
      end
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
