# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_justxt_session',
  :secret      => '2cfbbe5e2f2173847b8ee2145d69654de445ca2221df069cc7e1490229d2e17cb6c3e0d204b9472a36d5284430ab2bc51f382696e93283dbfe5367deff259c23'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
