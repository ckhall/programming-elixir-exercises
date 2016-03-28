defmodule CliTest do
  use ExUnit.Case
  doctest Noaa.CLI

  import Noaa.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end
  
  test "station argument is returned by option parsing with -s and --station options" do
    assert parse_args(["-s",        "ABCD"]) == "ABCD"
    assert parse_args(["--station", "ABCD"]) == "ABCD"
  end
  
  test "accepts lowercase station argument and upcases it" do
    assert parse_args(["-s",        "abcd"]) == "ABCD"
  end
end