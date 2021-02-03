require 'base64'
require 'json'
require 'httparty'

class Oauth2Controller < ApplicationController
  # response.set_header('X-Frame-Options', 'ALLOWALL')
  # before_action :allow_iframe

  # def allow_iframe
  #   response.set_header('X-Frame-Options', 'ALLOWALL')
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  #   response.headers['Set-Cookie'] = 'Secure;SameSite=None'
  # end

  BASE_URL   = "https://login.windows.net/9d5463e8-81bb-4342-8242-8e970dcbb974/oauth2/token"
  RESOURCE   = "https://analysis.windows.net/powerbi/api"

  def index(client_id: nil, client_secret: nil)
    if session[:user_id] != nil
      #puts session[:user_id]
      @username      = "bitspilanips@versaclouderp.com"
      @password      = "BitsPilani123!"
      @username      = $powerbi_mail
      @password      = $powerbi_password
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
      @access_token= @array[:access_token]
      
      

      ##IMPORT REPORT API START##
      # response=HTTParty.post("https://api.powerbi.com/v1.0/myorg/groups/"PUT GROUP ID"/imports?datasetDisplayName=RLSTest3_KB_Hi.pbix&nameConflict=Ignore",
      # :body => "--vishnu-kjhgsadhgad\r\nContent-Disposition: form-data; filename=\"RLSTest3_KB_Hi.pbix\"; name=\"RLSTest3_KB_Hi.pbix\";\r\nContent-Type: application/octet-stream\r\n\r\n"+File.read('/mnt/c/Users/"PUT REST OF THE FILE PATH HERE"')+"\r\n--vishnu-kjhgsadhgad--\r\n",
      # :headers => {'Authorization'=> "Bearer #{@access_token}",  'Content-Type'=> 'multipart/form-data', 'boundary'=>"vishnu-kjhgsadhgad"})
      # @data = response.code
      # puts @data
      # puts response
      # process_id = response["id"]
      # puts process_id
      # process_url = "https://api.powerbi.com/v1.0/myorg/groups/"PUT GROUP ID"/imports/#{process_id}"
      # puts process_url
      # response = HTTParty.get(process_url, :headers => {:Authorization=> "Bearer #{@array[:access_token]}"})
      # response_data = JSON.parse(response.body, symbolize_names: true)
      # puts response.code
      # puts response_data
      # puts response_data[:datasets][0][:id]
      # puts response_data[:reports][0][:id]
      # uploadReportId = response_data[:reports][0][:id]
      # uploaddatasetId = response_data[:datasets][0][:id]
      #puts '--f05e5244-f876-43b9-bc87-d71598f6b32a  Content-Disposition: form-data '+File.read('/mnt/c/Users/Vishnu/O2C.pbix').force_encoding("ISO-8859-1").encode("UTF-8")+' --f05e5244-f876-43b9-bc87-d71598f6b32a--'
      ##IMPORT REPORT API END##
      

      ##UPDATE PARAMETERS API START##
      # response2=HTTParty.post("https://api.powerbi.com/v1.0/myorg/groups/"PUT GROUP ID"/datasets/"PUT DATASET ID"/Default.UpdateParameters",
      # :body => {:updateDetails => [:name => "Database", :newValue => "testkb2"]}.to_json,
      # :headers => { 'Authorization'=> "Bearer #{@access_token}",
      #               'Content-Type'=> 'application/json; charset=utf-8',
      #               'Accept'=> 'application/octet-stream'
      #             })
      ##UPDATE PARAMETERS API END##
      
      ##CREATE DATASOUCRES IN GATEWAY API START##
      # response123=HTTParty.post("https://api.powerbi.com/v1.0/myorg/gateways/"PUT GATEWAY ID"/datasources",
      # :body => {
      #   :dataSourceType => "PostgreSQL",
      #   :connectionDetails => "{\"server\":\"PUT SERVER NAME\",\"database\":\"PUT DATABASE NAME\"}",
      #   :datasourceName => "testkb2 datas1",
      #   :credentialDetails => {
      #     :credentialType => "Basic",
      #     :credentials => "PUT ENCRYPTED CREDENTIALS HERE",
      #     :encryptedConnection => "Encrypted", 
      #     :encryptionAlgorithm => "RSA-OAEP", 
      #     :privacyLevel => "None"
      #   }
      # }.to_json,
      # :headers => { 'Authorization'=> "Bearer #{@access_token}",
      #               'Content-Type'=> 'application/json',
      #             })
      # puts response123
      ##CREATE DATASOURCES IN GATEWAY API END##

      #puts '--f05e5244-f876-43b9-bc87-d71598f6b32a  Content-Disposition: form-data '+File.read('/mnt/c/Users/Vishnu/O2C.pbix').force_encoding("ISO-8859-1").encode("UTF-8")+' --f05e5244-f876-43b9-bc87-d71598f6b32a--'
      #  embedt()
    end
  end
  # def embedt(access_token: nil, group_id: nil, resource: nil, resource_id: nil, dataset_id: nil, urole: nil)
  #   @access_token= @array[:access_token]
  #   @group_id = "84843ee3-b32f-41ce-8663-0301a6562970"
  #   @resource = RESOURCE
  #   @rdidnow = Rdid.find(session[:company_id]) 
  #   @report_id = @rdidnow[:reportId]
  #   @dataset_id = @rdidnow[:datasetId]
  #   @urole = session[:role]
  #   #puts @report_id
  #   #puts @dataset_id
  #   puts "role"
  #   puts @urole
  #   url = "https://api.powerbi.com/v1.0/myorg/groups/#{@group_id}/reports/#{@report_id}/GenerateToken"
  #   if @urole!= "Head"
  #     response=HTTParty.post(url,
  #     #:body => '{ "accessLevel" :  "View", "allowSaveAs" : "false", "datasetId" : "'+@dataset_id+'" }',
  #     #:datasetId => ["#{@dataset_id}"], :username => 'RLSTest', :roles => ["#{@urole}"]
  #     :body => {:accessLevel => 'View' , :allowSaveAs => 'false' , :identities => [:username => 'RLSTest', :roles => ["#{@urole}"], :datasets => [@dataset_id]]}.to_json,
  #     :headers => { 'Authorization'=> "Bearer #{@access_token}",
  #                   'Content-Type'=> 'application/json; charset=utf-8',
  #                   'Accept'=>'application/json'
  #                 })
  #     test={:accessLevel => 'View' , :allowSaveAs => 'false' , :identities => [:username => 'RLSTest', :roles => ["#{@urole}"],:datasets => @dataset_id] }
  #     print "test"
  #     print test
  #   else
  #     response=HTTParty.post(url,
  #     #:body => '{ "accessLevel" :  "View", "allowSaveAs" : "false", "datasetId" : "'+@dataset_id+'" }',
  #     #:datasetId => ["#{@dataset_id}"], :username => 'RLSTest', :roles => ["#{@urole}"]
  #     :body => {:accessLevel => 'Edit' , :allowSaveAs => 'true', :datasets => @dataset_id}.to_json,
  #     :headers => { 'Authorization'=> "Bearer #{@access_token}",
  #                   'Content-Type'=> 'application/json; charset=utf-8',
  #                   'Accept'=>'application/json'
  #                 })
  #     test={:accessLevel => 'Edit' , :allowSaveAs => 'false' ,:datasets => @dataset_id }
  #     print "test"
  #     print test
  #   end

  #     #data = response.code
  #     #puts response
  #     @embedtoken=response["token"]
  #     #puts response.code
  #     #puts response.body, response.code, response.message, response.headers.inspect
  #     query()
  # end
  # def query
  #   #puts "jhae"
  #   #puts @embedtoken
  #   url = "https://api.powerbi.com/v1.0/myorg/groups/#{@group_id}/reports/#{@report_id}"
  #   @request = HTTParty.get(url, :headers => {:Authorization=> "Bearer #{@array[:access_token]}"})
  #   #print "request_begins"
  #   #puts @request
  # end
    
end


## 5d20fe5a-d0fd-4744-87f6-dec317051578 - app id