## OTP


## Supervisor

### Before
```elixir
{:ok, postal_server} = PostalCodex.Server.start(%{dk: %{2850=> "Nærum"}})
Process.alive?(postal_server)
PostalCodex.Server.postal_code(postal_server, :dk, 2850) # CRASSSSSSSSSH
Process.alive?(postal_server)
PostalCodex.Server.postal_code(postal_server, :dk, 2850) #  (EXIT) no process
```
### After


__Show crash without supervisor__
```elixir
Process.registered # List of registered names
PostalCodex.Server.start_link(%{dk: %{2850=> "Nærum"}})
PostalCodex.Server.postal_code(:dk, 2850) # => Nærum
PostalCodex.Server.crash
PostalCodex.Server.postal_code(:dk, 2850) # => Nærum

postal_server = Process.whereis(:postal_server)
send(postal_server, :stop)
PostalCodex.Server.postal_code(:dk, 2850) # => Nærum
```


## ETS

### Before
```elixir
Profiler.run(PostalCodex.Server, 100000) #=> 717422 reqs/sec
Profiler.run(PostalCodex.Server, 100000, 10) #=> 1030068 reqs/sec
```
### After
