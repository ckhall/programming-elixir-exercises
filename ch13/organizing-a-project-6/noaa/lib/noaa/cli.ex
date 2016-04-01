defmodule Noaa.CLI do

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Returns a tuple of `{ yser, project, count }` or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean, station: :string ],
                                     aliases:  [ h:    :help,    s:       :station ])

    case parse do
      { [ help: true ], _, _ }       -> :help
      { [ station: station ], _, _ } -> String.upcase(station)
      _                              -> :help
    end
  end

  def process(:help) do
    IO.puts "usage: noaa --station <station>"
  end

  def process(station) do
    Noaa.fetch(station)
    |> print
  end
  
  def column_from_element(xml, elem) do
    # cheap and easy way, no xml parser required
    res = Regex.run(~r/<#{elem}>(.+)<\/#{elem}>/, xml)
    case res do
      [_, text] -> text
      _         -> ""
    end
  end
    
  def fields do
    [ location:                "Location",
      latitude:                "Lat",
      longitude:               "Lng",
      observation_time_rfc822: "Observation Time",
      weather:                 "Weather",
      temperature_string:      "Temp",
      relative_humidity:       "Relative Humidity",
      wind_string:             "Wind",
      pressure_string:         "Pressure",
      dewpoint_string:         "Dewpoint" ]
  end

  def print({:error, message}) do
    IO.puts(message)
  end

  def print({ :ok, xml}) do
    IO.puts "Weather information"
    IO.puts "*******************"
    Enum.each(Keyword.keys(fields), fn(field) ->
      IO.puts "#{fields[field]}: #{column_from_element(xml, field)}"
    end)
  end
end
