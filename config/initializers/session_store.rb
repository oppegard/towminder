# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_towminder_session',
  :secret      => 'ef5f6be26f5e8d5bad32975ae942ab02bbfa084dfdb617288ac555c9ccb2470307feb27809bdab1e2c5e8806c0e1d6afa6083052e1e376c78c02086bca7eeea4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
