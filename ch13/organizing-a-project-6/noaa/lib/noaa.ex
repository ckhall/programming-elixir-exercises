defmodule Noaa do
  
  @host "http://w1.weather.gov/xml/current_obs"
  
  def fetch(station) do
    station
    |> to_url
    |> HTTPoison.get
    |> handle_response
  end
  
  def to_url(station) do
    "#{@host}/#{station}.xml"
  end
  
  def column_from_xml(xml, elem) do
    res = Regex.run(~r/<#{elem}>(.+)<\/#{elem}>/, xml)
    case res do
      [_, text] -> text
      _         -> nil
    end
  end
  
  defp handle_response({:ok, %{ status_code: 200, body: body}}) do
    { :ok, body }
  end

  defp handle_response({_, %{ status_code: 404, body: body}}) do
    { :error,  "Station not found"}
  end

  defp handle_response({_, %{ status_code: status, body: _}}) do
    { :error,  "#{status}"}
  end
end
