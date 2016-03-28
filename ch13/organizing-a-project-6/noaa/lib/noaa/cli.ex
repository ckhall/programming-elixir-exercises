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
    IO.puts """
    usage: noaa --station <station>
    """
    System.halt(0)
  end

  def process(station) do
    Noaa.fetch(station)
  end
end
