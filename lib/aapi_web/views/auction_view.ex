defmodule AapiWeb.AuctionView do
  use AapiWeb, :view
  alias AapiWeb.AuctionView

  def render("index.json", %{auctions: auctions}) do
    %{data: render_many(auctions, AuctionView, "auction.json")}
  end

  def render("show.json", %{auction: auction}) do
    %{data: render_one(auction, AuctionView, "auction.json")}
  end

  def render("auction.json", %{auction: auction}) do
    %{id: auction.id,
      start_time: auction.start_time,
      product_id: auction.product_id,
      bid_value: auction.bid_value,
      user_id: auction.user_id,
      end_time: auction.end_time,      
      creation_date: NaiveDateTime.to_string(auction.inserted_at)
    }
  end

  def render("update_auction_success.json", %{auction: auction}) do
    %{status: "success",
      message: "successfully updated auction status",
      data: %{
        id: auction.id,
        start_time: auction.start_time,
        product_id: auction.product_id,
        bid_value: auction.bid_value,
        user_id: auction.user_id,
        end_time: auction.end_time,        
        creation_date: NaiveDateTime.to_string(auction.inserted_at)
      }
    }
  end

  def render("update_bid_error.json", %{auction: auction}) do
    %{status: "error",
      message: "higher_bid_value_error: bid value must be higher to commit",
      data: %{
        id: auction.id,
        start_time: auction.start_time,
        product_id: auction.product_id,
        bid_value: auction.bid_value,
        user_id: auction.user_id,
        end_time: auction.end_time,        
        creation_date: NaiveDateTime.to_string(auction.inserted_at)
      }
    }
  end
end
