defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    String.split(sentence)
    |> Enum.filter(fn w -> !Regex.match?(~r/[\:]/, w) end)
    |> Enum.flat_map(fn w -> String.split(w, "_") end)
    |> Enum.reduce(%{}, fn (w, acc) -> 
      Map.put(acc, formatWord(w), add(acc, formatWord(w))) end)
  end

  defp formatWord(word) do
    String.replace(word, ~r/[,!@$%^&]/, "")
    |> String.downcase
  end

  defp add(acc, w) do
    val = Map.get(acc, w)

    if val == nil do
      1
    else
      val + 1
    end
  end
end
