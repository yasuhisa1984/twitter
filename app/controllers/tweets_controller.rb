class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]
  
  def index
    @tweets = Tweet.all
    if params[:back]
      @tweet = Tweet.new(tweet_params)
    else
      @tweet = Tweet.new
    end
  end
  
 
  def edit
  end

  def confirm
    @tweets = Tweet.all
    @tweet = Tweet.new(tweet_params)
    render :index if @tweet.invalid?
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "ツイートを更新しました！"
    else
      render 'edit'
    end
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweets = Tweet.all
    if @tweet.save
      redirect_to tweets_path, notice: "ツイートしました！"
    else
      render 'index'
    end
  end
  
  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "ツイートを削除しました！"
  end  

  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end
