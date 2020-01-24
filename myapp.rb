require "roda"
require "sequel"
require "bcrypt"
require "rack/protection"

DB = Sequel.connect(adapter: :postgres, database: 'myapp_development', host: 'localhost', user: 'root', password: 'Scrum123')

class Myapp < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

  Sequel::Model.plugin :validation_helpers

  use Rack::Session::Cookie, secret: "some_nice_long_random_string_DSKJH4378EYR7EGKUFH", key: "_myapp_session"
  use Rack::Protection
  plugin :csrf

  require './models/user.rb'

  route do |r|
    r.root do
      view("layout")
    end
    r.is "login" do
      r.get do
        view("login")
      end
    end
    r.post "login" do
      if user = User.authenticate(r["email"], r["password"])
        session[:user_id] = user.id
        r.redirect "/"
      else
        r.redirect "/login"
      end
    end
    r.post "logout" do
      session.clear
      r.redirect "/"
    end

    r.on "users" do
      r.get "new" do
        response
        @user = User.new
        view("users/new")
      end

      r.get ":id" do |id|
        @user = User[id]
        view("users/show")
      end

      r.is do
        r.get do
          @users = User.order(:id)
          view("users/index")
        end

        r.post do
          @user = User.new(r["user"])
          if @user.valid? && @user.save
            r.redirect "/users"
          else
            view("users/new")
          end
        end
      end
    end
  end
end
