# Time Sinatra
This is a backend app to fake current time for integration tests between different apps.

It returns the current time for a clock unless you post a different configuration for the clock

# Run Migrations
bundle exec sequel -m ./lib/db/migrations postgres://user:user@127.0.0.1/time --echo


