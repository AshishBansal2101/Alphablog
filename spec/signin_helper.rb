def sign_in(admin=false)
    post '/users', params: {
        user: {
          username: 'ashish',
          email: 'ash@gmail.com',
          password:"12345678"
         }
        }
    user=User.find_by(username: 'ashish')
    user.toggle!(:admin) if admin
    return user
end

def new_article
    sign_in
    post '/articles', params: {
        article: {
          title: "this is title",
          description: "hey there this is testing"
        }
      }
      
    return Article.find_by(title: "this is title")
end