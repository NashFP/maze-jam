# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :generator_display,
  namespace: GeneratorDisplay

# Configures the endpoint
config :generator_display, GeneratorDisplayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SMbYBRa+IQ28WlK/l1wnGAlsRqy3mgph2u3MEtkBipoR7in3HO7idASXfM3c0tPX",
  render_errors: [view: GeneratorDisplayWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GeneratorDisplay.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
