class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:info] = t "not_found"
      redirect_to root_path
      return
    end
    @title = t "#{params[:type]}", count: ""
    @users = @user.send(params[:type]).paginate page: params[:page]
    render "users/show_follow"
  end

  def create
    @user = User.find_by params[:followed_id]
    current_user.follow @user
    @follow = current_user.active_relationships.build
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by params[:id].followed
    current_user.unfollow @user
    @unfollow = current_user.active_relationships.find_by followed_id: @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please"
      redirect_to login_url
    end
  end
end
