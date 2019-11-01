class PicturesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to pictures_path, success: "作成しました！"
    else
      # 入力フォームを再描画します。
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, success: "編集しました！"
    else
      render :edit
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, success: "作成しました！"
      else
        render :new
      end
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, danger:"削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_correct_user
    @picture = Picture.find_by(id:params[:id])
    if @picture.user_id != current_user.id
      redirect_to pictures_path, danger:"権限がありません"
    end
  end

  end
