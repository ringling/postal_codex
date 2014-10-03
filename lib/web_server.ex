defmodule WebServer do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  get "/postal_code/:country/:postal_code" do
    postal_district_name = PostalCodex.Server.postal_code(String.to_atom(country), String.to_integer(postal_code))
    mp = %{name: postal_district_name, code: String.to_integer(postal_code)}
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, :jiffy.encode(mp))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
