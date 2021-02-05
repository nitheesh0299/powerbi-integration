require 'base64'
require 'json'
require 'httparty'

class PowerbiSessionsController < ApplicationController
    BASE_URL   = "https://login.windows.net/9d5463e8-81bb-4342-8242-8e970dcbb974/oauth2/token"
    RESOURCE   = "https://analysis.windows.net/powerbi/api"
    @@access_token=""
    def new
      if session[:user_id] != nil
        #puts session[:user_id]
      #   @username      = "bitspilanips@versaclouderp.com"
      #   @password      = "BitsPilani123!"
        @username      = params[:email]
        @password      = params[:password]
        ##@refresh_token = refresh_token
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
        #puts @array
        #puts "next"
        # puts session[:email_id]
        # puts session[:company_id]
        @access_token=@array[:access_token]
        @@access_token= @array[:access_token]
        end
    end
  
    def embed_report
        @reportID = "0969feb9-ec39-4dc2-a5e4-5beb1985581c"
        @url = "https://app.powerbi.com/reportEmbed?reportId={{reportID}}"
        @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{@@access_token}"})
        render inline: @request
          # @request="ddf"
    end
  
    def destroy
    end
    
    def report
      @reportID = "0969feb9-ec39-4dc2-a5e4-5beb1985581c"
    #   @url = "https://api.powerbi.com/v1.0/myorg/reports/#{@reportID}"
    #   @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{@@access_token}"})
    @url = "https://app.powerbi.com/groups/me/reports/#{@reportID}"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{@@access_token}"})
    end
end