require 'rubygems'
require 'sinatra'
require 'sinatra/json'
require 'mongo'
require 'json/ext'

class Blog < Sinatra::Base
  mongo_host = ENV['MONGO_HOST'] || '127.0.0.1'
  mongo_port = ENV['MONGO_PORT'] || '27017'
  mongo_database = ENV['MONGO_DATABASE'] || 'test'

  db = Mongo::Client.new(["#{mongo_host}:#{mongo_port}"], database: mongo_database, heartbeat_frequency: 2)
  set :mongo_db, db[:posts]

  post '/add_post/?' do
    content_type :json
    halt 400, json(error: 'No title in blog post') if params['title'].nil? or params['title'].empty?
    halt 400, json(error: 'No text in blog post') if params['text'].nil? or params['text'].empty?
    halt 400, json(error: 'No timestamp in blog post') if params['timestamp'].nil? or params['timestamp'].empty?
    db = settings.mongo_db
    result = db.insert_one title: params['title'], timestamp: params['timestamp'], text: params['text'], tags: params['tags']
    db.find(_id: result.inserted_id).to_a.first.to_json
  end

  get '/posts/?' do
    content_type :json
    settings.mongo_db.find.sort(timestamp: -1).to_a.to_json
  end

  get '/health' do
    if db.cluster.servers.count == 0
      status 500
    else
      status 200
    end
  end

  get '/response_node' do
    content_type :json
    json(node: Socket.gethostname.to_json)
  end

  get '/*' do |request|
    halt 404
  end

  error 500 do
    halt 500, json(reply: 'Internal Server Error')
  end
end
