defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """

  def encode(string) when string == "" do
    ""
  end

  @spec encode(String.t) :: String.t
  def encode(string) do
    String.graphemes(string)
    |> Enum.chunk_by(fn e -> e end)
    |> Enum.map(fn array -> Integer.to_string(Enum.count(array)) <> List.first(array) end)
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/[1-9]+[A-Z]/, string)
    |> Enum.map(&List.first/1)
    |> Enum.map(&expand_encoded_string/1)
    |> Enum.join
  end

  defp expand_encoded_string(string) do
    val =
    if String.length(string) == 3 do
      String.to_integer(String.slice(string, 0..1))
    else
      String.to_integer(String.slice(string, 0..0))
    end

    letter = String.slice(string, -1..-1)
    concat_strings(val, letter)
  end

  defp concat_strings(n, letter, acc \\ "")

  defp concat_strings(n, _, acc) when n == 0 do
    acc
  end

  defp concat_strings(n, letter, acc) do
    acc = acc <> letter
    concat_strings(n - 1, letter, acc)
  end
end
