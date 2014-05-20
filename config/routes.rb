Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :alerts do
    resources :alerts, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :alerts, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :alerts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
