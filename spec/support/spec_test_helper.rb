module SpecTestHelper
  def login(user)
    post login_path, params: { account: user.account, password: user.password }
  end
end