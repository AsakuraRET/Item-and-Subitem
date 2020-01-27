class Subitem < Sequel::Model
  many_to_one :item

  RodaApp.route('subitem') do |r|
    # POST /items/new
    r.post 'create' do
      response
      @subitem = Subitem.new
      view("subitems/create")
    end

    r.get 'show' do
      @subitem = Subitem[id]
      view("subitems/show")
    end

    r.post 'update' do
      @subitem = Subitem.edit
      view("subitems/update")
    end

    r.delete 'destroy' do
      @subitem = Subitem.delete
      view("subitems/destroy")
    end
  end
end
