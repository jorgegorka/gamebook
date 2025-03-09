class BooksSeed
  class << self
    def create_seed_data(account)
      new.create(account)
    end
  end

  def create(account)
    p 'creating books'
    user = account.users.first

    3.times {  user.books.create! title: Faker::Book.title, summary: Faker::Lorem.paragraph, remarks: Faker::Lorem.paragraph }
  end
end
