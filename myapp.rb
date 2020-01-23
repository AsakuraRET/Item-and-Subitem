require "roda"
require "sequel"

DB = Sequel.connect(adapter: :postgres, database: 'myapp_development', host: 'localhost', user: 'root', password: 'Scrum123')

class Myapp < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

  route do |r|
    r.root do
      view("homepage")
    end
  end
end