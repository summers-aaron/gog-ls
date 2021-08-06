defmodule Mix.Tasks.Gogls.Games.Get do
  use Mix.Task

  @shortdoc ""
  def run(_) do
    HTTPoison.start
    HTTPoison.get("https://embed.gog.com/games/ajax/filtered?search=indie%20game%20the%20movie&limit=1")
    |> fn {:ok, x} -> x.body end.()
    |> Jason.decode()
    |> IO.inspect
  end
end