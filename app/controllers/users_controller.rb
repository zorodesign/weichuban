#encoding:UTF-8.
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
     if @user.save
       sign_in @user
       redirect_to @user
     else
       render 'new'
    end
  end
  
  def edit
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "您的设置已更新成功"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

  def signed_in_user
    redirect_to signin_url, notice: "请您新登录，谢谢~" unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
end