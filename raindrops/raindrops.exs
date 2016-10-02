defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  def convert(1) do
    "1"
  end

  def convert(3) do
    int_to_raindrop "3"
  end

  def convert(5) do
    int_to_raindrop "5"
  end

  def convert(7) do
    int_to_raindrop "7"
  end

  @spec convert(pos_integer) :: String.t
  def convert(number) do
    if !is_relevant_prime(number) do
        Integer.to_string(number)
      else
        factors(number, div(number, 2))
        |> Enum.reverse
        |> Enum.filter(&is_relevant_prime/1)
        |> Enum.filter(fn i -> i <= 7 end)
        |> Enum.map(&Integer.to_string/1)
        |> Enum.map(&int_to_raindrop/1)
        |> Enum.join
    end
  end

  defp is_relevant_prime(i) do
    cond do
      rem(i, 3) == 0 -> true

      rem(i, 5) == 0 -> true

      rem(i, 7) == 0 -> true

      true -> false
    end
  end

  defp int_to_raindrop(i) do
    case i do
      "3" -> "Pling"

      "5" -> "Plang"

      "7" -> "Plong"

      _ -> i
        
    end

  end

  def factors(1, _), do: [1]
  
  def factors(_, 1), do: [1]
  
  def factors(n, i) do
    if rem(n, i) == 0 do
      [i|factors(n, i-1)]
    else
      factors(n, i-1)
    end
  end
end
