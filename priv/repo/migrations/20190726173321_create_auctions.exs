defmodule Aapi.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :start_time, :time
      add :product_id, :string
      add :bid_value, :integer
      add :user_id, :string
      add :end_time, :time      

      timestamps()
    end

  end
end
