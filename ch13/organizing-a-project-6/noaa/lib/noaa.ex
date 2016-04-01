defmodule Noaa do
  
  @host "http://w1.weather.gov/xml/current_obs"
  
  def fetch(station) do
    station
    |> to_url
    |> HTTPoison.get
    |> handle_response(station)
  end
  
  defp to_url(station) do
    "#{@host}/#{station}.xml"
  end
  
  defp handle_response({ :ok, %{ status_code: 200, body: body } }, _) do
    { :ok, body }
  end

  defp handle_response({ _, %{ status_code: 404, body: _ } }, station) do
    { :error,  "Station #{station} not found" }
  end

  defp handle_response({ _, %{ status_code: status, body: _ } }, _) do
    { :error,  "#{status}" }
  end
end
