require "pry"
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      found_item = find_item_match(req)
      if found_item
        resp.write "#{found_item.price}"
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

  def find_item_match(req)
    @@items.detect {|item| req.path.match(/#{item.name}/)}
  end
end
