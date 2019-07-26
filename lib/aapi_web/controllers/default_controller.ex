defmodule AapiWeb.DefaultController do
    use AapiWeb, :controller

    def index(conn, _params) do
        text conn, "API is live!"
    end
end