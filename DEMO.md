## OTP


## Supervisor

### Before

{:ok, postal_server} = PostalCodex.Server.start(%{dk: %{2850=> "Nærum"}})
Process.alive?(postal_server)
PostalCodex.Server.postal_code(postal_server, :dk, 2850) # CRASSSSSSSSSH
Process.alive?(postal_server)
PostalCodex.Server.postal_code(postal_server, :dk, 2850) #  (EXIT) no process
