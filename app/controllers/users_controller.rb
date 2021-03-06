class UsersController < ApplicationController
  before_action :authenticate_user, { only: [:index, :show, :edit, :update] }
  before_action :forbid_login_user, { only: [:login_form, :new, :create, :login] }

  def login_form
  end

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
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "default.jpg"
    )

    if @user.save
      session[:user_id] = @user.id
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

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user-images/#{@user.image_name}", image.read)
    end

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
    redirect_to("/")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      flash[:notice] = "ログインに成功しました"

      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています。"
      @email = params[:email]
      @password = params[:password]

      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"

      redirect_to("/")
  end
end
