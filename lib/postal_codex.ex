defmodule PostalCodex do
  use Application

  def start(_type, _args) do
    PostalCodex.Supervisor.start_link
  end

end
