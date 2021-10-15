defmodule GoglsWeb.Resolvers.Media do
  def list_games(_parent, _args, _resolution) do
    {:ok, Gogls.Media.list_games()}
  end
end
