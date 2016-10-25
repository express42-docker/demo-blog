require 'prometheus/client/rack/collector'
require 'prometheus/client/rack/exporter'
use Prometheus::Client::Rack::Collector
use Prometheus::Client::Rack::Exporter
require './ui_app'
run UI
