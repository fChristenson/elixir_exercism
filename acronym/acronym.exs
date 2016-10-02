defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  def abbreviate(string) when string == nil do
    ""
  end

  def abbreviate(string) when string == "" do
    ""
  end

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string)
    |> Enum.flat_map(fn w -> String.split(w, "_") end)
    |> Enum.flat_map(fn w -> String.split(w, "-") end)
    |> Enum.flat_map(fn w -> splitCase(w) end)
    |> Enum.map(fn w -> String.first(w) end)
    |> Enum.map(fn l -> String.upcase(l) end)
    |> Enum.reduce(fn (l, acc) -> acc <> l end)
  end

  defp splitCase(w) do
    result = Regex.named_captures(~r/.+(?<i>[A-Z])/, w, [{:return, :index}])
    if result != nil do
      {i, _} = Map.get(result, "i")
      String.split_at(w, i)
      |> Tuple.to_list
    else
        [w]
    end
  end
end
