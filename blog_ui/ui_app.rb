require 'rubygems'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/static_assets'
require 'rest-client'
require 'tilt/haml'
require 'haml'

class UI < Sinatra::Base
  register Sinatra::StaticAssets

  backend_host = ENV['BLOG_BACKEND_HOST'] || '127.0.0.1'
  backend_port = ENV['BLOG_BACKEND_PORT'] || '8080'

  configure do
    enable :sessions
  end

  before do
    session[:flashes] = [] if session[:flashes].class != Array
  end

  get '/' do
    @title='All posts'

    begin
      @posts = JSON.parse(RestClient::Request.execute(method: :get, url: "http://#{backend_host}:#{backend_port}/posts", timeout: 1))
    rescue
      session[:flashes] << { type: 'alert-danger', message: 'Can\'t show blog posts, some problems with backend. <a href="." class="alert-link">Refresh?</a>' }
    end

    @flashes = session[:flashes]
    session[:flashes] = nil
    haml :posts
  end

  get '/new' do
    @title= 'New sosts'

    @flashes = session[:flashes]
    session[:flashes] = nil
    haml :new_post
  end

  post '/new/?' do
    begin
      RestClient.post(
                       "http://#{backend_host}:#{backend_port}/add_post",
                       title: params['title'],
                       text: params['text'],
                       timestamp: Time.now.to_i,
                       tags: params['tags']
                     )
    rescue
      session[:flashes] << { type: 'alert-danger', message: 'Can\'t save your post, some problems with backend' }
  else
    session[:flashes] << { type: 'alert-success', message: 'Post successuly published' }
  end
    redirect '/'
  end

  get '/health' do
    status 200
  end

end
