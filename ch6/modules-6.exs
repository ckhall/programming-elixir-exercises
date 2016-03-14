defmodule Chop do
  def guess(num, range) do
    # guess 1/2 way between bottom and top of range
    a..b = range
    guess = div(a+b, 2)
    IO.puts "Is it #{guess}?"
    check_guess(num, guess, range)
  end

  defp check_guess(num, num, _), do: IO.puts "Yes, it's #{num}"

  defp check_guess(num, guess, range) when guess < num do
    _..b = range
    guess(num, guess+1..b)
  end

  defp check_guess(num, guess, range) when guess > num do
    a.._ = range
    guess(num, a..guess-1)
  end
end
