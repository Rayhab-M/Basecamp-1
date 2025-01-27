class UsersController < ApplicationController
  before_action :authenticate_user!  # Ensure user is signed in
  before_action :authenticate_admin!, only: [:index]  # Restrict index to admins only
  before_action :correct_user_or_admin, only: [:show, :edit, :update, :destroy]  # Ensure users can edit/update their own account or admins can edit/update any account

  def index
    @users = User.all  # Admins can view all users
  end

  def show
    @user = User.find(params[:id])  # Both admin and regular users can view a user
  end

  def edit
    @user = User.find(params[:id])
    # Admins or the user themselves can edit the account
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin? || current_user == @user  # Admins or user themselves can delete
      @user.destroy
      redirect_to current_user.admin? ? users_path : root_path, notice: "User deleted successfully."
    else
      redirect_to root_path, alert: "You are not authorized to delete this user."
    end
  end

  def set_admin
    user = User.find(params[:id])
    user.update(admin: true)
    redirect_to user, notice: "#{user.email} is now an admin."
  end

  def remove_admin
    user = User.find(params[:id])
    user.update(admin: false)
    redirect_to user, notice: "#{user.email} is no longer an admin."
  end

  private

  def authenticate_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied! Only admins can perform this action."
    end
  end

  # Ensure the user can only access their own account unless they are an admin
  def correct_user_or_admin
    @user = User.find(params[:id])
    unless current_user == @user || current_user.admin?
      redirect_to root_path, alert: "Access denied! You can only view or edit your own account unless you are an admin."
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :admin)  # Permit necessary attributes
  end
end
