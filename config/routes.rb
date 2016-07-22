Rails.application.routes.draw do
  get 'table_sort/index'

  get 'slide_show/index'

  get 'misc/charactor'

  root 'blogs#index'

  get 'blogs/index_no_entry' => 'blogs#index_no_entry'
  get 'blogs/index_with_unapproved_comment' => 'blogs#index_with_unapproved_comment'

  resources :blogs, { only: [ :index, :show ] } do
    resources :entries do
      resources :comments
    end
  end

  # routingのエラーをエラーハンドラーで処理させる
  # root 'errors#routing_error'   # rootを捕まえたければこんな感じ
  # *anythingは任意のURLパスを示す特殊な値 ※実践Rails4 p.122
  get '*anything' => 'errors#routing_error'

  # 何でも捕まえるやつ…
  # match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
