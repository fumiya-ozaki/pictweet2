Rails.application.routes.draw do
  devise_for :users
  root to:  'tweets#index' #ルートパス/にアクセスした時にトップ（ツイート画面へ戻る）
  resources :tweets do #7つのアクション全てを使ったため削除
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
    resources :users, only: :show
  end
