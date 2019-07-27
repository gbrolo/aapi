defmodule AapiWeb.AuctionControllerTest do
  use AapiWeb.ConnCase

  alias Aapi.Directory
  alias Aapi.Directory.Auction

  @create_attrs %{
    auction_id: "some auction_id",
    bid_value: 42,
    duration_seconds: 42,
    end_time: ~T[14:00:00],
    product_id: "some product_id",
    user_id: "some user_id"
  }
  @update_attrs %{
    auction_id: "some updated auction_id",
    bid_value: 43,
    duration_seconds: 43,
    end_time: ~T[15:01:01],
    product_id: "some updated product_id",
    user_id: "some updated user_id"
  }
  @invalid_attrs %{auction_id: nil, bid_value: nil, duration_seconds: nil, end_time: nil, product_id: nil, user_id: nil}

  def fixture(:auction) do
    {:ok, auction} = Directory.create_auction(@create_attrs)
    auction
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all auctions", %{conn: conn} do
      conn = get(conn, Routes.auction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create auction" do
    test "renders auction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.auction_path(conn, :show, id))

      assert %{
               "id" => id,
               "auction_id" => "some auction_id",
               "bid_value" => 42,
               "duration_seconds" => 42,
               "end_time" => "14:00:00",
               "product_id" => "some product_id",
               "user_id" => "some user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.auction_path(conn, :create), auction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update auction" do
    setup [:create_auction]

    test "renders auction when data is valid", %{conn: conn, auction: %Auction{id: id} = auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.auction_path(conn, :show, id))

      assert %{
               "id" => id,
               "auction_id" => "some updated auction_id",
               "bid_value" => 43,
               "duration_seconds" => 43,
               "end_time" => "15:01:01",
               "product_id" => "some updated product_id",
               "user_id" => "some updated user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, auction: auction} do
      conn = put(conn, Routes.auction_path(conn, :update, auction), auction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete auction" do
    setup [:create_auction]

    test "deletes chosen auction", %{conn: conn, auction: auction} do
      conn = delete(conn, Routes.auction_path(conn, :delete, auction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.auction_path(conn, :show, auction))
      end
    end
  end

  defp create_auction(_) do
    auction = fixture(:auction)
    {:ok, auction: auction}
  end
end
