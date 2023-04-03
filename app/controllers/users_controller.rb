class UsersController < ApplicationController

    before_action :set_user,only: [:show, :edit, :update ,:destroy]
    before_action :require_user,only: [:edit, :update, :destroy]
    before_action :require_same_user,only: [:edit, :update, :destroy]

    def new
        @user=User.new
    end

    def show
        @articles=@user.articles.paginate(page: params[:page], per_page: 4)
    end

    def index
        @users=User.paginate(page: params[:page], per_page: 4)
    end
        
    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice]="User Details updated successfully"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user=User.new(user_params)
        if @user.save   
            flash[:notice]="welcome to alpha blog #{@user.username} , Your account Was Created Successfully"
            session[:user_id]=@user.id
            redirect_to articles_path 
        else
            render 'new'
        end
    end

    def follow
        @user=User.find(params[:format])
        current_user.followings<<@user
        redirect_to users_path
    end

    def unfollow
        @user=User.find(params[:format])
        @unfollow=Follow.where(follower_id: current_user.id ,followed_user_id: @user.id).first
        @unfollow.destroy
        redirect_to users_path
    end

    def destroy
        @user.destroy
        session[:user_id]=nil if @user == current_user
        flash[:notice]="Account and Associated Articles Has Been Deleted"
        redirect_to articles_path
    end

    private

    def user_params
        params.require(:user).permit(:username,:email,:password)
    end

    def set_user
        @user=User.find(params[:id])
    end

    def require_same_user 
        if current_user!=@user && !current_user.admin?
            flash[:alert]="You Can Only Update And Delete Your Own Profile"
            redirect_to @user
        end 
    end

end
