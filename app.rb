require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/flash'

require_relative 'models/contact'
also_reload 'models/contact'

enable :sessions

helpers do
  def offset(page=1)
    page -= 1
    page * 20
  end

  def current_page(params_page)
    params_page = params_page.to_i
    params_page = 1 if params_page < 1
    return params_page # why do things break if i don't have explicit return here?
  end
end

get '/' do
  page = current_page(params[:page])
  offset_by = offset(page)
  @contacts = Contact.limit(20).offset(offset_by)
  erb :index, locals: { page: page }
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end

get '/add_contact' do
  erb :entry
end

get '/results' do
  page = current_page(params[:page])
  search = params[:search].downcase
  offset_by = offset(page)
  @contacts = Contact.where('lower(first_name) = ? OR lower(last_name) = ?', search, search).limit(20).offset(offset_by)
  erb :results, locals: { page: page }
end

post '/page' do
  redirect '/?page=' + params[:page]
end

post '/search' do
  redirect '/results?search=' + params[:search]
end

post '/add_contact' do
  attributes = {
    first_name: params[:first_name],
    last_name: params[:last_name],
    phone_number: params[:phone_number]
  }
  new_contact = Contact.create(attributes)
  flash[:success] = "Your contact #{params[:first_name]} #{params[:last_name]} was successfully added."
  redirect '/contacts/' + new_contact.id.to_s
end
