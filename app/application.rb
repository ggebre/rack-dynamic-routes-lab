
class Application 
    @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            
            item_name = req.path.split("/items/").last.chomp 
            if item_name
                found_item = @@items.find {|item| item.name == item_name}
                if found_item
                    resp.write "#{found_item.price}"
                else 
                    resp.write "Item not found"
                    resp.status = 400
                end
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish

    end
end