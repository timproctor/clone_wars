require_relative '../../database'

class MenuItems < Sequel::Model(:menu_items)

  def self.find(id)
    DB[:menu_items].where(:id => id.to_i).to_a.first
  end

  def self.update_item(id, params)
    menu_item = DB[:menu_items].where(:id => id.to_i).to_a.first
    menu_item[:name]         = params[:name]
    menu_item[:ingredients]  = params[:ingredients]
    menu_item[:price]  = params[:price]

    DB[:menu_items].where(:id => id.to_i).update(menu_item)
  end

  def self.add_item(params)
    DB[:menu_items].insert(params)
  end

  def self.delete_item(id)
    DB[:menu_items].where(:id=>id.to_i).delete
  end

end
