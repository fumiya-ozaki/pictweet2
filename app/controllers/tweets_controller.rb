class TweetsController < ApplicationController
 before_action :set_tweet, only: [:edit, :show] #editとshowのアクション前に実行。下に変数定義
 before_action :move_to_index, except: [:index, :show]
def index
  @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
end

def new
  @tweet = Tweet.new #modelのクラスからツイートのデータを全部持ってくる
end

def create
  Tweet.create(tweet_params) #ツイートの新規作成引数でパラムスを入れないと余計な情報まで持ってきてしまう
end

def destroy
  tweet = Tweet.find(params[:id]) #全部のツイートからIDのデータを持ってくる
  tweet.destroy
end

def edit
end

def update
 tweet = Tweet.find(params[:id])
 tweet.update(tweet_params) #これは何？？？
end

def show
  @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
end

def search
  @tweets = Tweet.search(params[:keyword])
end


private
def tweet_params
  params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
end

def set_tweet
  @tweet = Tweet.find(params[:id])
end

def move_to_index
  redirect_to action: :index unless user_signed_in?
end

end