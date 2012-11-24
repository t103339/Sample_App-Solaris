class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def index
    # @users = User.paginate(page: params[:page], per_page: 10, order: 'name ASC')
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def edit
    # @user defined by before filter "correct_user"
    # @user = User.find(params[:id])
  end

  def update

    # @user defined by before filter "correct_user"
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a succesful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end

  end

  private

     def signed_in_user
       if signed_in?
          # proceed to path originally selected.
       else
          # store selected path and go to signin first.
          store_location
          redirect_to signin_path, notice: "Please sign in."
       end
     end

     def correct_user
       @user = User.find(params[:id])
       if current_user?(@user)
          # do nothing here
       else
          redirect_to root_path, notice: "Not your profile to edit."
       end
     end

     def admin_user
       redirect_to(root_path) unless current_user.admin?
     end

end
