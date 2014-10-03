defmodule PostalCodex.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Logger.info "Loading oio postal codes"
    {:ok, postal_codes} = PostalCode.load_from_oio
    Logger.info "Loading of #{postal_codes |> Map.keys |> length} codes finished"
    Logger.info "Starting web server"
    {:ok, web_server_pid} = Plug.Adapters.Cowboy.http WebServer, []
    Logger.info "Started, Cowboy webserver(#{inspect web_server_pid}) running on http://<server_ip>:4000/streams"
    countries = %{dk: postal_codes }
    Supervisor.start_link(__MODULE__, countries)
  end

  def init(countries) do
    processes = [worker(PostalCodex.Server, [countries])]
    supervise(processes, strategy: :one_for_one)
  end

end
