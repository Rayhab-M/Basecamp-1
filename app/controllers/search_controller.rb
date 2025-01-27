class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @search_term = params[:search]
    
    if current_user.admin?
      # Admin can search users and projects
      @users = User.where('email LIKE ?', "%#{@search_term}%")
      @projects = Project.where('name LIKE ? OR description LIKE ?', "%#{@search_term}%", "%#{@search_term}%")
    else
      # Regular users can only search their own projects
      @projects = current_user.projects.where('name LIKE ? OR description LIKE ?', "%#{@search_term}%", "%#{@search_term}%")
      @users = []  # No user search for regular users
    end
  end
end
