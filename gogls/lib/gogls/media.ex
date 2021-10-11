defmodule Gogls.Media do
    alias Gogls.Repo
    alias Gogls.Media.Game
    alias Gogls.Media.Movie
    alias Gogls.Media.Expansion

    def get_game(id) do
        Repo.get(Game, id)
    end

    def get_expansion(id) do
        Repo.get(Expansion, id)
    end

    def get_movie(id) do
        Repo.get(Movie, id)
    end
end