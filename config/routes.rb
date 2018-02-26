Rms::Application.routes.draw do

	devise_for :usuarios
	resources :usuarios

  get 'proveedores/get_by_cuit', to: "proveedores#get_by_cuit", as: :cuit

  get 'proveedores/poseidon', to: 'proveedores#get_by_poseidon'

  resources :estados_pagos do
    member do
      put 'enable'
    end
  end

  resources :proveedores do
    member do
      put 'enable'
    end
  end

  resources :monedas do
    member do
      put 'enable'
    end
  end

  resources :condiciones_pagos do
    member do
      put 'enable'
    end
  end
  resources :attachments

  resources :requerimientos do
		# Rutea materiales con referencia a requerimientos para new y para create (post)
		# requerimientos/3/materiales/new
    #
    resources :materiales, :only => [:new, :create, :index]
    resources :presupuestos, :only => [:new, :create]
    resources :notificaciones, :only => [:new, :create, :index]
    resources :attachments, :only => [:show, :new, :create]
    member do
    	put 'solicitar_aprobacion'
    	put 'rechazar'
    	get 'rechazar', :action => 'motivo_rechazo'
    	put 'aprobar'
    	put 'aprobacion/compras', :action => 'solicitar_aprobacion_compras'
    	get 'rechazar/presupuestos', :action => 'motivo_rechazo_compras'
    	put 'rechazar/presupuestos', :action => 'rechazar_por_compras'
      put 'cancelar', :action => 'cancelar_por_compras'
      get 'cancelar_compra', :action => 'motivo_cancelar_compra'
      put 'cancelar_compra', :action => 'cancelar_compra'
    	put 'comprar'
    	put 'recepcionar'
      put 'pagar'
    	put 'verificar_entrega', :action => 'verificar_entrega'
    	get 'rechazar_entrega', :action => 'motivo_rechazo_entrega'
    	put 'rechazar_entrega'
    	put 'finalizar'
    end
  end

  resources :presupuestos, :only => [:destroy, :update, :edit, :show] do
    resources :attachments, :only => [:new, :create]
  	member do
  		put 'aprobar'
  	end
  end

  # Rutea el resto (materiales) sin referencia a requerimientos
  resources :materiales, :only => [:show, :destroy, :update, :edit] do
  	resources :caracteristicas, :only => [:new, :create]
  end

  resources :caracteristicas, :only => [:show, :destroy, :update, :edit]

#  resources :material

#  resources :usuarios

  resources :rubros do
    member do
      put 'enable'
    end
  end


  resources :sectores do
    member do
      put 'enable'
    end
  end

  resources :empresas do
    member do
      put 'enable'
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "requerimientos#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

