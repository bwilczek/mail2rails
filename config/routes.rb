Rails.application.routes.draw do
  # get 'messages/show/:id' => 'messages#show'
  # get 'messages/index' => 'messages#index'
  
  get 'api/inbox/:inbox' => 'messages#inbox_index_json'
  get 'inbox/:inbox' => 'messages#inbox_index'
  get 'api/inbox/:inbox/message/:id' => 'messages#inbox_message_json'
  get 'inbox/:inbox/message/:id' => 'messages#inbox_message'
end
