class Item < Sequel::Model
  one_to_many :subitems

  RodaApp.route('item') do |r|
    # POST /items/new
    r.post 'create' do
      response
      @item = Item.new
      view("items/create")
    end

    r.get 'show' do
      @item = Item[id]
      view("items/show")
    end

    r.post 'update' do
      @item = Item.edit
      view("items/update")
    end

    r.delete 'destroy' do
      @item = Item.delete
      view("items/destroy")
    end
  end
end
