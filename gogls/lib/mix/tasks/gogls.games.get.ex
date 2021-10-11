defmodule Mix.Tasks.Gogls.Games.Get do
  use Mix.Task
  alias Gogls.Media.Game
  alias Gogls.Repo

  @games_url "https://embed.gog.com/games/ajax/filtered"

  @shortdoc "Query each page of games from the GOG API and insert them into the database"
  def run(_) do
    Mix.Task.run("app.start")

    response = HTTPoison.get(@games_url)

    case response do
      {:ok, res} ->
        body = Jason.decode!(res.body)

        total_pages = body["totalPages"]

        Range.new(1, total_pages)
        |> Enum.map(&query(&1, total_pages))

      {:error, e} ->
        IO.inspect(e)
    end
  end

  defp query(page, total_pages) do
    request = HTTPoison.get(@games_url, [], params: %{page: page})

    case request do
      {:ok, response} ->
        body = Jason.decode!(response.body)

        games = body["products"]

        Enum.map(games, &to_map/1)
        |> Enum.each(&insert_or_update/1)

        if page >= 0 and page <= total_pages do
          # Sleep before making any more queries
          sleep()
          query(page + 1, total_pages)
        else
          IO.inspect("Completed game migration")
        end

      {:error, e} ->
        IO.inspect(e)
    end
  end

  defp to_map(game) do
    %{
      developer: game["developer"],
      title: game["title"],
      category: game["category"],
      available: game["buyable"],
      original_category: game["originalCategory"],
      image: game["image"],
      slug: game["slug"],
      rating: game["rating"],
      gog_id: game["id"],
      genres: game["genres"],
      price: price(game),
      is_coming_soon: game["isComingSoon"],
      is_price_visible: game["isPriceVisible"],
      supported_operating_systems: game["supportedOperatingSystems"],
      is_in_development: game["isInDevelopment"],
      age_requirement: game["ageLimit"],
      release_date: release_date(game),
      support_url: game["supportUrl"],
      forum_url: game["forumUrl"],
      global_release_date: global_release_date(game),
      video_url: game["video"]["id"],
      video_provider: game["video"]["provider"],
      gallery: game["gallery"],
      publisher: game["publisher"],
      is_discounted: game["isDiscounted"],
      is_wishlistable: game["isWishlistable"]
    }
  end

  defp insert_or_update(game) do
    case Repo.get_by(Game, gog_id: game.gog_id, title: game.title) do
      nil -> %Game{}
      existing_game -> existing_game
    end
    |> Game.changeset(game)
    |> Repo.insert_or_update()
  end

  defp price(game) do
    game["price"]["amount"]
    |> Float.parse()
    |> case do
      {float, _} -> float
      :error -> :error
    end
  end

  defp release_date(game) do
    game["releaseDate"]
    |> case do
      nil ->
        nil

      unix ->
        unix
        |> DateTime.from_unix!()
        |> DateTime.to_date()
    end
  end

  defp global_release_date(game) do
    game["globalReleaseDate"]
    |> case do
      nil ->
        nil

      unix ->
        unix
        |> DateTime.from_unix!()
        |> DateTime.to_date()
    end
  end

  defp sleep() do
    Process.sleep(Enum.random(60000..120_000))
  end
end
