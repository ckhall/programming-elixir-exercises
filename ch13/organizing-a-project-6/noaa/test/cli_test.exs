defmodule CliTest do
  use ExUnit.Case
  doctest Noaa.CLI

  import ExUnit.CaptureIO
  import Noaa.CLI

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
  
  test "column_from_xml returns the text of the given element name" do
    assert column_from_element("<foo>bar</foo>", "foo") == "bar"
  end
  
  test "column_from_xml returns nil if given element name does not exist" do
    assert column_from_element("<foo>bar</foo>", "baz") == ""
  end

  test "printing an error to print an error" do
    result = capture_io(fn ->
      print({ :error, "foobar" })
    end)
    assert result == "foobar\n"      
  end
end