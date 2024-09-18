module SpecTestHelper
  def login(user)
    post user_sessions_path, params: { user: { username: user.username, password: user.password } }
  end

  def log_out(user)
    delete user_session_path(user)
  end
end
