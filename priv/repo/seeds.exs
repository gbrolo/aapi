# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Aapi.Repo.insert!(%Aapi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Aapi.Repo
alias Aapi.Directory.Auction

Repo.insert! %Auction{start_time: ~T[18:30:00], product_id: "100", bid_value: 389, user_id: "10akTPVebtZrD9LlUmEZ3TAJfVz2", end_time: ~T[19:00:00]}
Repo.insert! %Auction{start_time: ~T[09:30:00], product_id: "101", bid_value: 325, user_id: "10akTPVebtZrD9LlUmEZ3TAJfVz2", end_time: ~T[10:00:00]}
Repo.insert! %Auction{start_time: ~T[14:30:00], product_id: "102", bid_value: 325, user_id: "10akTPVebtZrD9LlUmEZ3TAJfVz2", end_time: ~T[15:00:00]}