# coding: utf-8

require 'rubygems'
require 'sinatra'
require 'erb'

require "unicode" #1.8 compatable

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end


ITUNES_LINK = "http://itunes.com/apps/"

def convert_name(str)
  regex = /[!¡"#\$%'()*+,\\\-.\/:;<=>¿?@\[\]\^_`{|}~\s]/
  temp = str.downcase.gsub(/\342\204\242/, "").to_s  #removing TM(trademark)
  Unicode.normalize_KD(temp).gsub(/[^\x00-\x7F]/,'').to_s.gsub(regex,'').gsub('&', 'and')
end

def build_app_or_company_link(application_name, company_name, app_or_company)
  case app_or_company
  when "company"
     [ ITUNES_LINK + company_name, "Company Name" ]
  when "application"
     [ ITUNES_LINK + application_name, "Application Name" ]
  else 
     [ ITUNES_LINK + company_name + "/" + application_name, "Application by Company" ] 
  end
end

get '/' do
  headers["Content-Type"] ||= "text/html; charset=UTF-8"
  erb :index
end

post '/create_app_link' do
  session[:selection] = params[:app_or_comp]
  @application_name = convert_name(params[:application_name]) if params[:application_name]
  @company_name = convert_name(params[:company_name]) if params[:company_name]
  @link, @link_label = build_app_or_company_link(@application_name, @company_name, params[:app_or_comp])
  headers["Content-Type"] ||= "text/html; charset=UTF-8"
  erb :index
end
