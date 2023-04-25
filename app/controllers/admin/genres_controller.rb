class Admin::GenresController < ApplicationController
  before_action :authenticate_admin! #ログイン済みの管理者のみに権限を与える

  def index #ジャンル管理画面(一覧・追加を兼ねる)
    @genre = Genre.new
    @genres = Genre.all
  end

  def create #ジャンルデータ登録
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "新しいジャンルを追加しました。"
      redirect_to admin_genres_path #ジャンル管理画面へ遷移
    else
      @genres = Genre.all
      render :index #失敗した場合は既存のジャンル管理画面へ遷移しエラーメッセージが表示される
    end
  end

  def edit #ジャンル編集
    @genre = Genre.find(params[:id])
  end

  def update #ジャンルデータ更新
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルを変更しました。"
      redirect_to admin_genres_path #ジャンル管理画面へ遷移
    else
      render :edit #失敗した場合は編集画面へ遷移
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end