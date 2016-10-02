defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.filter(strand, fn(x) -> x == nucleotide end)
    |> Enum.count
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    result = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    Enum.reduce(strand, result, fn(x, acc) ->
      Map.put(acc, x, Map.fetch!(acc, x) + 1)
    end)
  end
end
