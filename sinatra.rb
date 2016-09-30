require 'sinatra'
require 'json'

FACTS = [ 
  {:name => 'born', :value => '1915'},
  {:name => 'occupation', :value =>'Singer and Handsome Devil'},
  {:name => 'nickname', :value => 'Ol\' blue eyes'}, 
  {:name => 'hats', :value => 'Always cool!'}
]

get '/' do 
  @title = "Welcome to sinatra as a service!"
  @message = "Sinatra as a service is dedicated to bringing you closer to the sinatra fandom!"
  @endpoints = [
    {:name => 'Random Facts!', :path => 'GET /fact'},
    {:name => 'Get the list of fan club members', :path => 'GET /fans'},
    {:name => 'Add a new member to the fan club', :path => 'POST /fans'}
  ]
  erb :index
end

get '/fact' do

  fact = FACTS.sample
  content_type :json
  { :fact => fact }.to_json

end

get '/fans' do
  fans = []
  File.foreach('fans.txt') do |line|
    fans << line.gsub(/\s+/, ' ').strip
  end
  content_type :json
  { :fans => fans }
end

post '/fans' do
  fan = params[:fan]
  open('fans.txt', 'a') { |f|
    f.puts fan+'\n'
  }
end