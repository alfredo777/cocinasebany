require 'sinatra'
require 'useragent'
require 'pony'
require 'i18n'
require 'handlebars'
require 'open-uri'
require 'nokogiri'
require 'json'
require "conekta"
require "useragent"
require "bootstrap-sass"

enable :sessions
enable :cross_origin

$HOSTREMOTE = "https://admin-rockstars.herokuapp.com"

get "/" do 
  string = request.user_agent
  user_agent = UserAgent.parse(string)
  session[:browser] = user_agent.browser
  session[:platform] = user_agent.platform
  puts user_agent
  erb :"index", layout: :"layouts/app"
end


get "/contactus" do 
  from_email = "#{params[:email]}"
  puts from_email
  mail_stablish = erb :"contact", locals: {email: from_email, name: params[:name], subject: params[:subject], message: params[:message] }
  send_mail("respuesta-rockstars@rockstars.mx", "Email de contacto de #{from_email}", mail_stablish, "contacto@rockstars.mx")
  erb :"contactus"
end


def send_payment
end

def encode_json( uri, paramsx, redirectx)
  response = open("#{$HOSTREMOTE}#{uri}?#{paramsx}").read
  puts response
  json = JSON.parse(response)
  puts json
  
  case redirectx
  when "no"
  puts "sin redirección"
  when "back"
  redirect back
  else
  redirect redirectx 
  end
  @json = json
end

def send_mail(from_email, subject, body_mail, to_email)
  Pony.mail(:to => to_email, :from => from_email, :subject => subject, :body => ERB.new(body_mail).result, content_type: "text/html", :via => :smtp, :via_options => { :address => 'smtp.sendgrid.net', :port => '587', :domain => 'www.rockstars.mx', :user_name => 'app46363412@heroku.com', :password => 'kow7vnbz0153', :authentication => :plain, :enable_starttls_auto => true })
end

helpers do

  def mobile_validate?
    platform = session[:platform].to_s
    puts "#{platform.downcase}"
     case platform.downcase  
     when 'iphone'
      true
     when 'android'
      true
     when 'firefox'
      true
     when 'windows phone'
      true
     when 'linux'
      true
     else
      false
     end  
  end
end

