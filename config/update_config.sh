#!/usr/bin/env sh
#
# Fetch the password from 1Password
password=$(op read "op://Jason/db/password")

# Update the Elixir config file
sed -i '' "s/password: .*/password: \"$password\",/" ~/Projects/timeline/config/config.exs
