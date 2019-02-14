Decidim::FileAuthorizationHandler::AdminEngine.routes.draw do
  post '/delete_authorizations' => 'censuses#delete_authorizations'
end
