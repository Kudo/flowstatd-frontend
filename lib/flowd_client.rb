require 'socket'
require 'date'
require 'json'

class FlowdClient
  def initialize(servAddr, servPort)
    @servAddr = servAddr
    @servPort = servPort
  end

  def get_top(top_number=100, date=nil)
    commandObj = {
      :command => "showTopList",
      :limit => top_number,
    }
    if date
      sDate = date.strftime('%Y-%m-%d')
      commandObj[:date] = sDate
    else
      commandObj[:date] = "today"
    end
    sockObj = TCPSocket.open(@servAddr, @servPort)
    sockObj.print(commandObj.to_json)
    sockObj.close_write
    respObj = JSON.parse(sockObj.read)
    if (respObj["retCode"] != 0)
      return nil
    end
    if respObj.has_key? 'datetime'
      respObj["time"] = DateTime.strptime(respObj["datetime"], '%Y-%m-%d %H:%M:%S')
    elsif respObj.has_key? 'date'
      respObj["time"] = DateTime.strptime(respObj["date"], '%Y-%m-%d')
    end
    respObj["count"] = respObj["data"].length
    sockObj.close
    return respObj
  end

  def get_ip(ip, date=nil)
    commandObj = {
      :command => "getFlow",
      :ip => ip,
    }
    if date
      sDate = date.strftime('%Y-%m-%d')
      commandObj[:date] = sDate
    else
      commandObj[:date] = "today"
    end
    sockObj = TCPSocket.open(@servAddr, @servPort)
    sockObj.print(commandObj.to_json)
    sockObj.close_write
    respObj = JSON.parse(sockObj.read)
    if (respObj["retCode"] != 0)
      return nil
    end
    if respObj.has_key? 'datetime'
      respObj["time"] = DateTime.strptime(respObj["datetime"], '%Y-%m-%d %H:%M:%S')
    elsif respObj.has_key? 'date'
      respObj["time"] = DateTime.strptime(respObj["date"], '%Y-%m-%d')
    end
    respObj["count"] = respObj["data"].length
    sockObj.close
    return respObj
  end

end
