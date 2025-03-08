class AccountsSeed
  class << self
    def create_seed_data
      new.create
    end
  end

  def create
    p 'creating account'
    create_account
  end

  private

    def create_account
      account = Account.create!(name: 'The writer')
      account.users.create! name: "Account admin", username: 'adminfirst', email: 'admin@test.com', role: User::ADMIN,
                             password: '111111', password_confirmation: '111111'
      account.users.create! name: "regular name", username: 'regularusername', email: 'regular@test.com', role: User::READER,
                             password: '111111', password_confirmation: '111111'
    end
end
