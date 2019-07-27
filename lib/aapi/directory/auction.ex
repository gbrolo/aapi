defmodule Aapi.Directory.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auctions" do    
    field :bid_value, :integer    
    field :start_time, :time
    field :end_time, :time
    field :product_id, :string
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:start_time, :product_id, :bid_value, :user_id, :end_time])
    |> validate_required([:start_time, :product_id, :bid_value, :user_id, :end_time])
  end
end
