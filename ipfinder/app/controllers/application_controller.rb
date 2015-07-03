class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def validity_check
    valid = true
    params[:ip] = params[:id] if params[:ip].nil?
    @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
    if (params[:ip] =~ @ip_regex).nil?
      valid = false
    end
    if (valid == false)
      render :json => {:error=>"InvalidInput", :ip => params[:ip]}
    end  
  end 
  
end
