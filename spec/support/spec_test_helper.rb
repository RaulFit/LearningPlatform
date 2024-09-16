module SpecTestHelper
  def login(user)
    post user_sessions_path, params: { user: { username: user.username, password: user.password } }
  end
end
