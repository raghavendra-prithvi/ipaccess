require 'fileutils'
class AddressesController < ApplicationController
  protect_from_forgery :except => [:assign]
  before_filter :validity_check,:only =>[:assign]
  
  #################################################################################
  ########### This method will be called by the POst request /addresses/assign#####
  #################################################################################
  def assign
    content = "1.2.0.0/16, #{params[:ip]} , #{params[:device]}\n"

## Reading the Environment variable IPALLOC_DATAPATH
    ip_alloc_file = ENV["IPALLOC_DATAPATH"]
    given_ip = params[:ip].split(".")
    ##Read the File
    #temp file to inset data in the middle
    tempfile = File.open("tmpfile", 'w')
    inserted = true
    File.open(ip_alloc_file,'r') do |file|
      while line = file.gets
        if(line.split(",").length == 3)
          data = line.split(",").map(&:strip)
          line_ip = data[1].split(".")
          if(given_ip[2] > line_ip[2])
              tempfile << line
          elsif(given_ip[2] == line_ip[2])
                if(given_ip[3] > line_ip[3])
                    tempfile << line
                elsif(given_ip[3] == line_ip[3])
                  #Updating the device if exists
                  tempfile << content
                  inserted = false
                else
                  if inserted == true
                    tempfile << content
                    inserted = false
                  end 
                  tempfile << line
                end  
          else
            if(inserted == true)
              tempfile << content
              inserted = false
            end  
            tempfile << line
          end
        end
      end
    end
    if inserted == true
      tempfile << content
    end  
    tempfile.close
    FileUtils.mv("tmpfile", ip_alloc_file)
    render :json => {:status=>"Saved Successfully"}
  end

# This is a backup code which will do only simple assignment at the botton of File. It will not sort the IPaddresses
def old_assign
  content = "1.2.0.0/16, #{params[:ip]} , #{params[:device]}\n"
    ip_alloc_file = ENV["IPALLOC_DATAPATH"]
    op = {:ip => ip_alloc_file}
    File.open(ip_alloc_file, "a+") do |f|
      f << content
    end
    render :json => op.to_json    
  
end  


end
