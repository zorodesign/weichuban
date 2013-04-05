#encoding:UTF-8.
class BooksController < ApplicationController
  before_filter :find_user
  before_filter :signed_in_user, only: [:new, :edit, :create, :destroy, :update]
  #before_filter :correct_user,   only: [:new, :edit, :create, :destroy, :update]

  def new
    @book = current_user.books.build if signed_in?
  end
  
  def show
    @book = current_user.books.find( params[:id] )
  end
  
  def edit
    @book = current_user.books.find( params[:id] )
  end
  
  def destroy
  end
  
  def create
    @book = current_user.books.build(params[:book])
    if @book.save
      flash[:success] = "cool!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    @book = current_user.books.find( params[:id] )
    if @book.update_attributes( params[:book] )
      flash[:success] = "您的书名已更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @books = @user.books
  end
  
  protected

  def find_user
    @user = User.find( params[:user_id] )
  end
  
end
