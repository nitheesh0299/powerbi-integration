require 'base64'
require 'json'
require 'httparty'

class GroupsController < ApplicationController
  def index
   
  end
  def getAllGroups  
    @url = "https://api.powerbi.com/v1.0/myorg/groups"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request['value']

    

    if(params[:id]!=nil)
      @groupID=params[:id]
    else
      @groupID="84843ee3-b32f-41ce-8663-0301a6562970"
    end
    
    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request1 = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @userArray = @request1['value']  

    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/reports"
    @request2 = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @reportArray = @request2['value']  

    @powerbi_users = ActiveRecord::Base.connection.execute("SELECT parties.company_name, users.username, users.group_id FROM powerbi_users users left join parties ON users.firm_id = parties.firm_id")
  end

  def getGroupUsers
    @groupID=params[:id]


    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request3['value']  
  end

  def createNewGroup
  end
end
