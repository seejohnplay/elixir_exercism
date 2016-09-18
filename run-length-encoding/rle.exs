defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes
    |> Enum.chunk_by(&(&1))
    |> Enum.reduce("", fn(x, acc) -> acc <> "#{length x}#{List.first x}" end)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/[A-Z]|\d+/, string)
    |> List.flatten
    |> Enum.chunk(2)
    |> Enum.map(fn(x) -> [String.to_integer(List.first(x)), List.last(x)] end)
    |> Enum.reduce("", fn(x, acc) -> acc <> String.duplicate(List.last(x), List.first(x)) end)
  end
end
