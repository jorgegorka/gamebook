class ChaptersSeed
  class << self
    def create_seed_data(account)
      new.create(account)
    end
  end

  def create(account)
    p 'creating chapters'

    account.books.each do |book|
      3.times {  book.chapters.create! title: Faker::Company.bs, summary: Faker::Lorem.paragraph }
    end
  end
end
