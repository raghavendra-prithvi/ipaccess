class DevicesController < ApplicationController
  before_filter :validity_check,:only =>[:show]

  def show
    ip = params[:id].to_s
    ipAllocFilePath = ENV["IPALLOC_DATAPATH"]
    device = ""
    File.open(ipAllocFilePath,'r') do |fileb|
      while line = fileb.gets
        if(line.split(",").length == 3)
          data = line.split(",").map(&:strip)
          if(ip == data[1])
            device = data[2]       
            break
          end
        end
      end
    end
    if(device.length > 0)
      output = {:device => device, :ip => params[:id] }  
    else
      output = {:error => "NotFound", :ip => params[:id]}
    end
    render :json => output.to_json
  end
end
