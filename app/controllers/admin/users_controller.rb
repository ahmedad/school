class Admin::UsersController < Admin::ApplicationController
  before_filter :verify_logged_in
  def new
    @page_title = 'Add User'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User created'
       redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'user updated'

      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = 'User Removed'

      redirect_to admin_users_path 
  end

  def index
    @users = User.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
  end
   
  private
  def user_params
    params.require(:user).permit(:name, :email, :password )
    
  end
end
