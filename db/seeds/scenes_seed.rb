class ScenesSeed
  class << self
    def create_seed_data(account)
      new.create(account)
    end
  end

  def create(account)
    p 'creating books'

    Chapter.all.each do |chapter|
      4.times {  chapter.scenes.create! title: Faker::GreekPhilosophers.quote, body: Faker::Lorem.paragraph, notes: Faker::Lorem.paragraph }
    end
  end
end
