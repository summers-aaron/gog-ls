defmodule GoglsWeb.Schema do
  use Absinthe.Schema
  import_types(GoglsWeb.Schema.MediaTypes)

  alias GoglsWeb.Resolvers

  query do
    @desc "Get all games"
    field :games, list_of(:game) do
      resolve(&Resolvers.Media.list_games/3)
    end
  end
end
