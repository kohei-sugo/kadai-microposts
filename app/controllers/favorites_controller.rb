class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def index
    @user = current_user
    favpost_ids = Favorite.where(user_id: @user.id).select(:micropost_id)
    @microposts = Micropost.where(id: favpost_ids).order('created_at DESC').page(params[:page])
  end
  
  def create
    select_post = Micropost.find(params[:micropost_id])
    current_user.favorite(select_post)
    flash[:success] = 'ポストをお気に入りに追加しました。'
    redirect_to :back
  end

  def destroy
    select_post = Micropost.find(params[:micropost_id])
    current_user.unfavorite(select_post)
    flash[:success] = 'ポストのお気に入りを解除しました。'
    redirect_to :back
  end
end
