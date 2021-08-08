defmodule Mix.Tasks.Gogls.Games.Get do
  use Mix.Task
  alias Gogls.Media.Game
  alias Gogls.Repo
  alias Gogls.Media.Movie
  alias Gogls.Media.Expansion

  @shortdoc ""
  def run(_) do
    Mix.Task.run("app.start")
    product =
      HTTPoison.get("https://embed.gog.com/games/ajax/filtered?search=Witcher&limit=1")
      |> fn {:ok, x} -> x.body end.()
      |> Jason.decode!()
      |> fn x -> x["products"] end.()
      |> List.first()
      
    if product["type"] == 1 do
      insert_movie(product)
    end
    if product["type"] == 2 do
      insert_game(product)
    end
    if product["type"] == 3 do
      insert_expansion(product)
    end
  end

  defp price(product) do
    product["price"]["amount"]
    |> Float.parse()
    |> case do
      {float, _} -> float
      :error -> :error
    end
  end

  defp insert_game(product) do
    %Game{
        developer: product["developer"],
        title: product["title"],
        category: product["category"],
        available: product["buyable"],
        original_category: product["originalCategory"],
        image: product["image"],
        slug: product["slug"],
        rating: product["rating"],
        gog_id: product["id"],
        genres: product["genres"],
        price: price(product),
        is_coming_soon: product["isComingSoon"],
        is_price_visible: product["isPriceVisible"],
        supported_operating_systems: product["supportedOperatingSystems"],
        is_in_development: product["isInDevelopment"],
        age_requirement: product["ageLimit"],
        release_date: product["releaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
        support_url: product["supportUrl"],
        forum_url: product["forumUrl"],
        global_release_date: product["globalReleaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
        video_url: product["video"]["id"],
        video_provider: product["video"]["provider"],
        gallery: product["gallery"],
        publisher: product["publisher"],
        is_discounted: product["isDiscounted"],
        is_wishlistable: product["isWishlistable"]
      }
      |> Repo.insert
  end

  defp insert_movie(product) do
    %Movie{
      studio:  product["developer"],
      title: product["title"],
      category: product["category"],
      available: product["buyable"],
      original_category: product["originalCategory"],
      image: product["image"],
      slug: product["slug"],
      rating: product["rating"],
      gog_id: product["id"],
      genres: product["genres"],
      price: price(product),
      is_coming_soon: product["isComingSoon"],
      is_price_visible: product["isPriceVisible"],
      age_requirement: product["ageLimit"],
      release_date: product["releaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
      support_url: product["supportUrl"],
      forum_url: product["forumUrl"],
      global_release_date: product["globalReleaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
      video_url: product["video"]["id"],
      video_provider: product["video"]["provider"],
      gallery: product["gallery"],
      publisher: product["publisher"],
      is_discounted: product["isDiscounted"],
      is_wishlistable: product["isWishlistable"]
    }
    |> Repo.insert
  end
  
  defp insert_expansion(product) do
    %Expansion{
      developer: product["developer"],
      title: product["title"],
      available: product["buyable"],
      image: product["image"],
      slug: product["slug"],
      rating: product["rating"],
      gog_id: product["id"],
      price: price(product),
      is_coming_soon: product["isComingSoon"],
      is_price_visible: product["isPriceVisible"],
      is_in_development: product["isInDevelopment"],
      age_requirement: product["ageLimit"],
      release_date: product["releaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
      support_url: product["supportUrl"],
      forum_url: product["forumUrl"],
      global_release_date: product["globalReleaseDate"] |> DateTime.from_unix!() |> DateTime.to_date(),
      video_url: product["video"]["id"],
      video_provider: product["video"]["provider"],
      gallery: product["gallery"],
      publisher: product["publisher"],
      is_discounted: product["isDiscounted"],
      is_wishlistable: product["isWishlistable"]
    }
    |> Repo.insert
  end
end