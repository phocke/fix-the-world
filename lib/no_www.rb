class NoWWW

  STARTS_WITH_WWW = /^www\./i
  
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env['SERVER_NAME'] =~ STARTS_WITH_WWW
      puts "redirecting from #{Rack::Request.new(env).url}"
      [301, { 'Location' => Rack::Request.new(env).url.sub(/www\./i, '') }, ['Redirecting...']]
    else
      @app.call(env)
    end
  end
  
end
