class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  # def index
  #   @likes=Like.all
  #   render json: @likes
  # end
  # def show 
  #   if @post
  #     render json @post.likes
  #   else
  #     render json: {message:"invalid input"}
  #   end
  # end   
  def create
    if already_liked?
     render json: {message: "you already like this post"}
    else
      @post.likes.create(user_id: @current_user.id)
      LikeMailer.with(user: @post.user).like_email.deliver_later
      render json: {message: "like created succesfull"}
    end
  end
  def already_liked?
    Like.where(user_id: @current_user.id, post_id: params[:post_id]).exists?
  end
  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
      render json:{message: "Unlike Post Succesfull"}
    end
    
  end
  private
  def find_post
    @post = Post.find(params[:post_id])
  end
  def find_like
    @like = @post.likes.find(params[:id])
 end
end
