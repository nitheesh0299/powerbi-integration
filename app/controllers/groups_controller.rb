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
    groupId=params[:groupId]
    @url= "https://api.powerbi.com/v1.0/myorg/groups/#{groupId}/users"
    response=HTTParty.post(@url,
        :body => { :displayName=>params[:username], :emailAddress=>params[:email], :groupUserAccessRight=> params[:accessrights],:principalType=> params[:principalType]},
        :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
  end

  def getGroupUsers
    @groupID=params[:id]


    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request3['value']  
  end

  def createNewGroup
  end
  def createNewUser
    @PowerbiUser = PowerbiUser.new(username: params[:username], group_id: params[:groupId], firm_id: params[:companyId], email: params[:email], role: params[:accessrights] )
    @PowerbiUser.save
    @company_name = ActiveRecord::Base.connection.execute("SELECT parties.company_name, parties.firm_id FROM parties")
    @accessRightsArray=["Admin","Contributor","Member","Viewer"]
    @principalTypeArray=["App","Group","User"]
    @url = "https://api.powerbi.com/v1.0/myorg/groups"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request['value']

    groupId=params[:groupId]
    @url= "https://api.powerbi.com/v1.0/myorg/groups/#{groupId}/users"
    response=HTTParty.post(@url,
        :body => { :displayName=>params[:username], :emailAddress=>params[:email], :groupUserAccessRight=> params[:accessrights],:principalType=> params[:principalType]},
        :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
  end
end
