defmodule AapiWeb.AuctionController do
  use AapiWeb, :controller

  alias Aapi.Directory
  alias Aapi.Directory.Auction

  action_fallback AapiWeb.FallbackController

  def index(conn, _params) do
    auctions = Directory.list_auctions()
    render(conn, "index.json", auctions: auctions)
  end

  def create(conn, %{"auction" => auction_params}) do
    with {:ok, %Auction{} = auction} <- Directory.create_auction(auction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.auction_path(conn, :show, auction))
      |> render("show.json", auction: auction)
    end
  end

  def show(conn, %{"id" => id}) do
    auction = Directory.get_auction!(id)
    render(conn, "show.json", auction: auction)
  end

  def update(conn, %{"id" => id, "auction" => auction_params}) do
    auction = Directory.get_auction!(id)      

    # if bid_value is higher then update, otherwise don't
    if (auction.bid_value < auction_params["bid_value"]) do
      with {:ok, %Auction{} = auction} <- Directory.update_auction(auction, auction_params) do
        render(conn, "update_auction_success.json", auction: auction)
      end
    else      
      render(conn, "update_bid_error.json", auction: auction)
    end
  end

  def delete(conn, %{"id" => id}) do
    auction = Directory.get_auction!(id)

    with {:ok, %Auction{}} <- Directory.delete_auction(auction) do
      send_resp(conn, :no_content, "")
    end
  end
end
