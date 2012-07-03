class FlowsController < ApplicationController
  def index
    require 'flowd_client'
    flow_client_obj = FlowdClient.new(APP_CONFIG['flowd_address'], APP_CONFIG['flowd_port'])
    date = nil
    begin
      require 'date'
      date = Date.strptime(params[:date], '%Y-%m-%d')
    rescue
      date = nil
    end
    @flows = flow_client_obj.get_top(50, date)

    if (@flows == nil)
      render :file => "#{RAILS_ROOT}/public/500.html", :layout => false, :status => 500
    end
  end

  def show
    require 'flowd_client'
    flow_client_obj = FlowdClient.new(APP_CONFIG['flowd_address'], APP_CONFIG['flowd_port'])
    date = nil
    begin
      require 'date'
      date = Date.strptime(params[:date], '%Y-%m-%d')
    rescue
      date = nil
    end
    @flows = flow_client_obj.get_ip(params[:id], date)

    if (@flows == nil)
      render :file => "#{RAILS_ROOT}/public/500.html", :layout => false, :status => 500
    end
  end

  def query
    if (!params[:ip] || !params[:ip].match(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/))
      render :file => "#{RAILS_ROOT}/public/500.html", :layout => false, :status => 500
    else
      redirect_to :action => 'show', :id => params[:ip]
    end
  end
end
