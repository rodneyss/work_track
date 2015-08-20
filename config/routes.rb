Rails.application.routes.draw do
  resources :jobs
  resources :clients
  resources :payslips, :except => [:new, :create]
  resources :companies
  resources :users

  root :to => 'pages#index'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/all' => 'jobs#all'

  get '/archieve/:id/:year' => 'jobs#archieve'

  get '/clientjob' => 'jobs#client_job'

  get '/finalize' => 'payslips#finalize' 

  get '/users/new_worker_company/:id' => 'users#new_worker_company'

  get '/:something' => 'pages#index'

  post '/startstop/:id' => 'jobs#start_stop'

  post '/jobcomplete/:id' => 'jobs#job_complete'




end
