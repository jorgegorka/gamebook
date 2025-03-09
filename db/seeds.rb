return if Rails.env.production?

require_relative 'seeds/accounts_seed'
require_relative 'seeds/books_seed'
require_relative 'seeds/chapters_seed'
require_relative 'seeds/scenes_seed'

account = AccountsSeed.create_seed_data
BooksSeed.create_seed_data(account)
ChaptersSeed.create_seed_data(account)
ScenesSeed.create_seed_data(account)
