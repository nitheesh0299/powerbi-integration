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
    @company_names = ActiveRecord::Base.connection.execute("SELECT parties.company_name, parties.firm_id FROM parties")    
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
    

    if(params[:group_id]!=nil && params[:user_id]!=nil && params[:company_name]!=nil)
      @updated_groupID=params[:group_id]    
      @updated_userID=params[:user_id]
      @updated_companyname=params[:company_name]

      #
      # @old_data = ActiveRecord::Base.connection.execute("SELECT group_id, email, role  FROM powerbi_users where username='"+@updated_userID+"'")
      # puts @old_data.values
      @old_data = ActiveRecord::Base.connection.execute("SELECT group_id, email, role  FROM powerbi_users where username='"+@updated_userID+"'")
      @old_groupid = @old_data.getvalue(0, 0)
      @email=@old_data.getvalue(0,1)
      @role=@old_data.getvalue(0,2)  
      

      @updated_firmidPG = ActiveRecord::Base.connection.execute("SELECT parties.firm_id  FROM parties where parties.company_name='"+@updated_companyname+"'")
      @updated_firmid = @updated_firmidPG.getvalue(0, 0)
      

      
      @deleteurl= "https://api.powerbi.com/v1.0/myorg/groups/#{@old_groupid}/users/#{@email}"
       response=HTTParty.delete(@deleteurl,:headers => {:Authorization=> "Bearer #{session[:access_token]}"})

      @updateurl= "https://api.powerbi.com/v1.0/myorg/groups/#{@updated_groupID}/users"
      response=HTTParty.post(@updateurl,:body => { :emailAddress=>@email, :groupUserAccessRight=> @role},
      :headers => {:Authorization=> "Bearer #{session[:access_token]}"})

      @PowerbiUser = ActiveRecord::Base.connection.execute("UPDATE powerbi_users set group_id='"+@updated_groupID+"',company_name='"+@updated_companyname+"',firm_id='"+@updated_firmid.to_s+"' where username='"+@updated_userID+"'")

      
      # ADD https://api.powerbi.com/v1.0/myorg/groups/@updated_groupID/users
      # PARAMS emailAddress
    end
    
    
  end

  def getGroupUsers
    @groupID=params[:id]


    @url = "https://api.powerbi.com/v1.0/myorg/groups/#{@groupID}/users"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request3['value']  
  end

  def createNewGroup
    @url= "https://api.powerbi.com/v1.0/myorg/groups"
    response=HTTParty.post(@url,
        :body => { :name => params[:Groupname] },
        :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
  end
  def createNewUser
    # @PowerbiUser = PowerbiUser.new(username: params[:username], group_id: params[:groupId], firm_id: params[:companyId], email: params[:email], role: params[:accessrights] )
    # @PowerbiUser.save
    @url = "https://api.powerbi.com/v1.0/myorg/groups"
    @request = HTTParty.get(@url, :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
    @array = @request['value']

    groupId=params[:groupId]

    @url= "https://api.powerbi.com/v1.0/myorg/admin/groups/#{groupId}/users"
    response=HTTParty.post(@url,
        :body => { :UserEmailAddress => params[:email],:groupUserAccessRight=>params[:accessrights] },
        :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
  end

  def updateUserGroup    
    if(params[:group_id]!=nil)
      @groupID=params[:group_id]    
    end

    if(params[:user_id]!=nil)
      @userID=params[:user_id]    
    end

    @PowerbiUser = ActiveRecord::Base.connection.execute("UPDATE powerbi_users set group_id="+@groupID+" where username="+@userID)
    @PowerbiUser.save
    # Also add this user to the powerBI group_id
    # 

    @powerbi_users = ActiveRecord::Base.connection.execute("SELECT parties.company_name, users.username, users.group_id FROM powerbi_users users left join parties ON users.firm_id = parties.firm_id")
    groupId=params[:groupId]
    @url= "https://api.powerbi.com/v1.0/myorg/groups/#{groupId}/users"
    response=HTTParty.post(@url,
        :body => { :displayName=>params[:username], :emailAddress=>params[:email], :groupUserAccessRight=> params[:accessrights],:principalType=> params[:principalType]},
        :headers => {:Authorization=> "Bearer #{session[:access_token]}"})
  end
  def versa_power_bi
    @users_data = ActiveRecord::Base.connection.execute("SELECT * FROM users us")    
  end
end
