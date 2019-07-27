defmodule Aapi.DirectoryTest do
  use Aapi.DataCase

  alias Aapi.Directory

  describe "auctions" do
    alias Aapi.Directory.Auction

    @valid_attrs %{auction_id: "some auction_id", bid_value: 42, duration_seconds: 42, end_time: ~T[14:00:00], product_id: "some product_id", user_id: "some user_id"}
    @update_attrs %{auction_id: "some updated auction_id", bid_value: 43, duration_seconds: 43, end_time: ~T[15:01:01], product_id: "some updated product_id", user_id: "some updated user_id"}
    @invalid_attrs %{auction_id: nil, bid_value: nil, duration_seconds: nil, end_time: nil, product_id: nil, user_id: nil}

    def auction_fixture(attrs \\ %{}) do
      {:ok, auction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_auction()

      auction
    end

    test "list_auctions/0 returns all auctions" do
      auction = auction_fixture()
      assert Directory.list_auctions() == [auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      auction = auction_fixture()
      assert Directory.get_auction!(auction.id) == auction
    end

    test "create_auction/1 with valid data creates a auction" do
      assert {:ok, %Auction{} = auction} = Directory.create_auction(@valid_attrs)
      assert auction.auction_id == "some auction_id"
      assert auction.bid_value == 42
      assert auction.duration_seconds == 42
      assert auction.end_time == ~T[14:00:00]
      assert auction.product_id == "some product_id"
      assert auction.user_id == "some user_id"
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_auction(@invalid_attrs)
    end

    test "update_auction/2 with valid data updates the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{} = auction} = Directory.update_auction(auction, @update_attrs)
      assert auction.auction_id == "some updated auction_id"
      assert auction.bid_value == 43
      assert auction.duration_seconds == 43
      assert auction.end_time == ~T[15:01:01]
      assert auction.product_id == "some updated product_id"
      assert auction.user_id == "some updated user_id"
    end

    test "update_auction/2 with invalid data returns error changeset" do
      auction = auction_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_auction(auction, @invalid_attrs)
      assert auction == Directory.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{}} = Directory.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_auction!(auction.id) end
    end

    test "change_auction/1 returns a auction changeset" do
      auction = auction_fixture()
      assert %Ecto.Changeset{} = Directory.change_auction(auction)
    end
  end
end
