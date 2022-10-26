# frozen_string_literal: true

module SorceryTestHelper
  def login_user(user = nil, password = '123456789', route = nil, http_method = :post)
    user ||= create(:user, password: password, password_confirmation: password)
    route ||= sign_in_path
    send(http_method, route, params: { login: { email: user.email, password: password } })
  end

  def student_login_user(user)
    post sign_in_path, params: { email: user.email,
                                 password: '123456789' }
    follow_redirect!
  end

  def logout_user(route = nil, http_method = :delete)
    route ||= sign_in_url
    send(http_method, route)
  end
end
