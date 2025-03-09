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
      account.users.create! name: "Account admin", email_address: 'admin@test.com', role: User::ROLE_ADMIN,
                             password: '111111111', password_confirmation: '111111111'
      account.users.create! name: "regular name", email_address: 'user@test.com', role: User::ROLE_READER,
                             password: '111111111', password_confirmation: '111111111'

      account
    end
end
