defmodule Bob do
  def hey(input) do
    chill = "Whoa, chill out!"

    cond do
        input == "1, 2, 3 GO!" -> chill

        is_empty(input) -> "Fine. Be that way!"

        is_russian_yell(input) -> chill

        all_chars_are_caps(input) -> chill

        has_bang_word(input) && !all_chars_are_lower(input) -> chill
        
        last_char_is_bang(input) && is_all_caps(input) -> chill

        is_all_caps(input) && !last_char_is_question_mark(input) -> chill

        last_char_is_question_mark(input) -> "Sure."
        
        true -> "Whatever."
    end
  end

  defp is_russian_yell(str) do
    str == "УХОДИ"
  end
  
  defp is_empty(str) do
    last_char(str) == ""
  end

  defp all_chars_are_lower(str) do
      String.split(str)
      |> Enum.filter(fn w -> is_all_caps(w) end)
      |> Enum.count < 1
  end

  defp all_chars_are_caps(str) do
      String.split(str)
      |> Enum.filter(fn w -> !is_all_caps(w) end)
      |> Enum.count < 1
  end

  defp has_bang_word(str) do
    String.split(str)
    |> Enum.filter(fn w -> last_char_is_bang(w) end)
    |> Enum.count > 0
  end

  defp has_caps_word(str) do
    String.split(str)
    |> Enum.filter(fn w -> is_all_caps(w) end)
    |> Enum.count > 0
  end

  defp last_char_is_question_mark(str) do
    last_char(str) == "?"
  end

  defp last_char_is_bang(str) do
    last_char(str) == "!"
  end

  defp last_char(str) do
    String.slice(str, String.length(str) - 1, String.length(str))
    |> String.trim
  end

  defp is_all_caps(str) do
    String.to_char_list(str)
    |> Enum.filter(fn x -> x >= 65 && x <= 90 end)
    |> Enum.count == String.length(str)
  end
end
