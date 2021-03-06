defmodule Lichex do
  alias Lichex.{Client, Summary, Variants}

  def chart_rating(username, variant) do
    with {:ok, variant} <- Variants.validate(variant),
         {:ok, ratings} <- Client.Ratings.history(username, variant),
         {:ok, chart} <- Asciichart.plot(ratings, height: 15) do
      IO.puts(chart)
    end
  end

  def summarize(username, count) do
    with {:ok, games} <- Client.Games.previous(username, count) do
      username
      |> Summary.new(games)
      |> IO.puts()
    end
  end
end
