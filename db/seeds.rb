return if Rails.env.production?

require_relative 'seeds/accounts_seed'

AccountsSeed.create_seed_data
