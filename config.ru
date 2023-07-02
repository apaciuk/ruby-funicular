require 'rack'
require_relative './application'

use Rack::Reloader, 0 if ENV['RACK_ENV'] == 'development'
use Rack::Static, urls: ['/public', "/favicon.ico"], root: '.' # serve static files
run Application.new