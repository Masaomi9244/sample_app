class UsersController < ApplicationController
    def index
        @users = User.all.order(created_at: :desc)
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def new
    end

    def create
        @user = User.new(name: params[:name], email: params[:email])

        if @user.save
            flash[:notice] = "ユーザの登録が完了しました"
            redirect_to("/users/index")
        else
            render("users/new")
        end
    end
    
    def update
        @user = User.find_by(id: params[:id])
        @user.name = params[:name]
        @user.email = params[:email]

        if @user.save
            flash[:notice] = "ユーザ情報を編集しました"
            redirect_to("/users/index")
        else
            render("users/edit")
        end
    end

    def destroy
        @user =User.find_by(id: params[:id])
        @user.destroy
        @user.save
        
        flash[:notice] = "ユーザを削除しました"
        redirect_to("/users/index")
    end
end
