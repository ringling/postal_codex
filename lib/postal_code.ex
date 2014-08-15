defmodule PostalCode do
  defstruct name: nil, number: nil

  @postal_district_oio_url "http://oiorest.dk/danmark/postdistrikter.json"

  def find_postal_code(countries, country, postal_number) do
    countries
    |> get_postal_codes(country)
    |> get_postal_code(postal_number)
  end

  defp get_postal_codes(nil, _country), do: nil
  defp get_postal_codes(countries, country) do
    countries |> Map.get(country)
  end

  defp get_postal_code(nil, _postal_number), do: nil
  defp get_postal_code(postal_codes, postal_number) do
    postal_codes |> Map.get(postal_number)
  end

  def load_from_oio do
    case HTTPoison.get(@postal_district_oio_url) do
      %HTTPoison.Response{status_code: 200, body: body} ->
        codes = body |> Poison.Parser.parse! |> list_to_map
        { :ok, codes }
      %HTTPoison.Response{status_code: 404} ->
        { :error, :not_found }
    end
  end

  defp list_to_map(codes) do
    codes
    |> Enum.reduce(%{},
      fn(pc, acc) ->
        no = String.to_integer(pc["nr"])
        acc |> Map.put(no, pc["navn"])
      end
    )
  end

end
