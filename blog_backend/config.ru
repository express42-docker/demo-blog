require 'prometheus/client/rack/collector'
require 'prometheus/client/rack/exporter'
use Prometheus::Client::Rack::Collector
use Prometheus::Client::Rack::Exporter
require './blog_app'
require 'rack'
run Blog
