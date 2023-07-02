class Router 
  def initialize(request)
    @request = request
  end

  def route!
     if @request.path == "/"
         [200, {"Content-Type" => "text/plain"}, ["Welcome home!"]]
     else
         not_found
     end
  end 
  
  private 

  def route_info 
        @route_info ||= begin
        resource = path_fragments[0] || "base"
        id, action = find_id_and_action(path_fragments[1]) 
        { resource: resource, id: id, action: action } 
        end
  end  

  def path_fragments
        @path_fragments ||= @request.path.split("/").reject(&:empty?)
  end 

  def find_id_and_action(fragment) 
    case fragment
    when "new"
        [nil, :new]
    when nil
        action = @request.get? ? :index : :create 
        [nil, action]
    else
        [fragment, @request.get? ? :show : :update]
    end
  end

  def not_found 
     [404, {"Content-Type" => "text/plain"}, [msg]]
  end 

  def msg
     "Not found!"
  end

end