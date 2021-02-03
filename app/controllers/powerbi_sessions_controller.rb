class PowerbiSessionsController < ApplicationController
    def new
        
    end
  
    def create
        if session[:user_id] != nil
            psessions[:email]= params[:email]
            psessions[:password]= params[:password] 
            redirect_to root_url,notice: "paramters updated"
        end
    end
  
    def destroy

    end
end
