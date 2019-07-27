defmodule AapiWeb.Router do
	use AapiWeb, :router

	pipeline :api do
		plug :accepts, ["json"]
	end

	scope "/api", AapiWeb do
		pipe_through :api
		resources "/auctions", AuctionController, except: [:new, :edit]
	end

	pipeline :browser do
		plug(:accepts, ["html"])
	end

	scope "/", AapiWeb do
		pipe_through :browser
		get "/", DefaultController, :index
	end

end
