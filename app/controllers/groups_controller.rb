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

    @groupID="84843ee3-b32f-41ce-8663-0301a6562970"
    # if(params[:id]==nil)
    # {
    #     @groupID="84843ee3-b32f-41ce-8663-0301a6562970"
    # }
    # else{
    #   @groupID=params[:id]
    # }
   
    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request1 = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @userArray = @request1['value']  

    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupId}/reports"
    @request2 = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @reportArray = @request2['value']  
  end

  def getGroupUsers
    @groupID=params[:id]


    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request['value']  
  end

  def createNewGroup
  end
end
