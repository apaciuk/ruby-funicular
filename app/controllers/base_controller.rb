class BaseController 
   attr_reader :request

   def initialize(request)
         @request = request
   end 

    def index 
        build_response <<-HTML
        <html>
            <head><title>Ruby Funicular</title></head>
            <body>
                <h1>Welcome to Ruby Funicular</h1>
                <p>It's a fun ride!</p>
            </body>
        </html>
        HTML
    end

   private  

   def build_response(body, status: 200)
    [status, { "Content-Type" => "text/html" }, [body]]
   end

   def redirect_to(uri)
         build_response("", 302, "Location" => uri)
   end 

   def params
         @request.params
   end 

end