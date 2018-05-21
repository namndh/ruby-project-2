class CommentsController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    if current_user
      @comment = @song.comments.create(user_id: current_user.id, content: comment_params[:content])
      redirect_to song_path(@song)
    else
      flash[:error] = "Not allowed. Please sign in."
      redirect_to new_user_session_path
    end
  end

  def destroy
    @song = Song.find(params[:song_id])
    @comment = @song.comments.find(params[:id])
    if current_user && (@comment.user == current_user || @song.user == current_user)
      if @comment.destroy
        flash[:success] = "Comment successfully deleted"
      end
    else
      flash[:error] = "Not allowed"
    end
    redirect_to song_path(@song)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
