Rails.application.routes.draw do
  get 'messages/show/:id' => 'messages#show'

  get 'messages/index' => 'messages#index'
  
  # get 'api/inbox/:inbox' => 'messages#inbox_index_api'
end
