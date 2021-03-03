defmodule CursoElixirDb.Exercises.Class11 do

  defp consumer(url, callback) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        callback.(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def save_relevant_info_from_view(body \\ nil) do
    if is_nil(body) do
      consumer("https://explodingtopics.com", fn body -> save_relevant_info_from_view(body) end)
    else
      {:ok, document} = Floki.parse_document(body)
      nodes = Floki.find(document, "div.topicInfoContainer")
      titles = for {_, _, [title]} <- Floki.find(nodes, "div.tileKeyword"), do: title
      descriptions = for {_, _, [description]} <- Floki.find(nodes, "div.tileDescription"), do: description
      {scores, gradients} = obtain_scores_and_gradients(nodes)
      for card <- List.zip([titles, descriptions, scores, gradients]), do: persist_card_info(card)
    end
  end

  defp obtain_scores_and_gradients(nodes) do
    scoresAndGradients = for {_, _, scoreOrGradient} <- Floki.find(nodes, "div.scoreTagItem") do
      case scoreOrGradient do
        [gradient] -> %{score: nil, gradient: gradient}
        [_svg | [score | _nothing]] -> %{score: score, gradient: nil}
      end
    end
    scores = for %{score: score} <- scoresAndGradients, score != nil, do: score
    gradients = for %{gradient: gradient} <- scoresAndGradients, gradient != nil, do: gradient
    {scores, gradients}
  end

  defp persist_card_info({title, description, score, gradient}) do
    import CursoElixirDb.HelperTopics
    current = %{title: title, description: description, score: score, gradient: gradient}
    case get_topics_by(%{title: title}) do
      nil -> create_topics(current)
      old -> update_topics(old, current)
    end
  end
end
