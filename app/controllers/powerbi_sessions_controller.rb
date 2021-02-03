require 'base64'
require 'json'
require 'httparty'

class PowerbiSessionsController < ApplicationController

    BASE_URL   = "https://login.windows.net/9d5463e8-81bb-4342-8242-8e970dcbb974/oauth2/token"
    RESOURCE   = "https://analysis.windows.net/powerbi/api"

    def new
        if session[:user_id] != nil
            @username= params[:email]
            @password= params[:password] 
            @client_id     = "c33afef1-d8a2-4ce7-8009-7866fd32a6df"
            @client_secret = ".IQU-.mxg_m82323p57Fssv1VR1i7OKXq2"
            @grant_type    = 'password'
            @scope = 'openid'
            #response = HTTParty.post(BASE_URL, build_body, build_headers)
            response=HTTParty.post(BASE_URL,
            :body => { :username=>@username, :password=>@password, :client_id=> @client_id, :client_secret=> @client_secret, :grant_type=> @grant_type, :resource=> RESOURCE, :scope=> @scope },
            :headers => { 'Content-Type'=> 'application/x-www-form-urlencoded'})
            data = response.body
            @array = JSON.parse(data, symbolize_names: true)
            #puts @array
            #puts "next"
            # puts session[:email_id]
            # puts session[:company_id]
            @access_token= @array[:access_token] 
            session[:access_token] =@access_token
            # redirect_to root_path
        end
    end
    
    def create
        #puts "jhae"
        #puts @embedtoken
        @report_id=0969feb9-ec39-4dc2-a5e4-5beb1985581c
        url = "https://api.powerbi.com/v1.0/myorg/reports/#{@report_id}"
        @request = HTTParty.get(url, :headers => {:Authorization=> "Bearer #{@array[:access_token]}"})
        #print "request_begins"
        #puts @request
    end
  
    def destroy

    end
end
