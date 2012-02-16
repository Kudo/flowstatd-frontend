require 'socket'
require 'date'

class FlowdClient
  def initialize(servAddr, servPort)
    @servAddr = servAddr
    @servPort = servPort
  end

  def get_top(top_number=100)
    sock_obj = TCPSocket.open(@servAddr, @servPort)
    sock_obj.print("TOP #{top_number}\r\n")
    first_line = sock_obj.gets.chop
    if (first_line =~ /No data/i)
      return nil
    end
    ret_hash = {}
    ret_hash[:time] = DateTime.strptime(first_line[6..-1], '%Y-%m-%d %H:%M:%S')
    ret_hash[:data] = []
    sock_obj.gets
    sock_obj.gets
    while line = sock_obj.gets
      val_array = line.split
      ret_hash[:data] << { :index => val_array[0].to_i, :ip => val_array[1], :upload => val_array[2].to_f, :download => val_array[3].to_f, :sum => val_array[4].to_f }
      count = val_array[0].to_i
    end
      ret_hash[:count] = count
    sock_obj.close
    return ret_hash
  end

  def get_top_old(top_number=100, date=Date.today-1)
    sock_obj = TCPSocket.open(@servAddr, @servPort)
    str_date = date.strftime('%Y %m %d')
    sock_obj.print("TOPR #{str_date} #{top_number}\r\n")
    if (sock_obj.gets =~ /No data/i)
      return nil
    end
    ret_hash = {}
    ret_hash[:time] = date
    ret_hash[:data] = []
    sock_obj.gets
    sock_obj.gets
    while line = sock_obj.gets
      val_array = line.split
      ret_hash[:data] << { :index => val_array[0].to_i, :ip => val_array[1], :upload => val_array[2].to_f, :download => val_array[3].to_f, :sum => val_array[4].to_f }
      count = val_array[0].to_i
    end
    ret_hash[:count] = count
    sock_obj.close
    return ret_hash
  end

  def get_ip(ip)
    sock_obj = TCPSocket.open(@servAddr, @servPort)
    sock_obj.print("GET #{ip}\r\n")
    if (sock_obj.gets =~ /No data/i)
      return nil
    end
    ret_hash = {}
    ret_hash[:time] = DateTime.strptime(sock_obj.gets.chop[6..-1], '%Y-%m-%d %H:%M:%S')
    ret_hash[:sum] = sock_obj.gets.chop.sub(/^.+:\s+([\d\.]+)\s.+$/, "\\1").to_f
    ret_hash[:data] = []
    sock_obj.gets
    sock_obj.gets
    sock_obj.gets
    while line = sock_obj.gets
      val_array = line.split
      ret_hash[:data] << { :hour => val_array[0].to_i, :ip => val_array[1], :upload => val_array[2].to_f, :download => val_array[3].to_f, :sum => val_array[4].to_f }
      data_count = val_array[0].to_i
    end
      ret_hash[:data_count] = data_count
    sock_obj.close
    return ret_hash
  end

  def get_ip_old(ip, date=Date.today-1)
    sock_obj = TCPSocket.open(@servAddr, @servPort)
    str_date = date.strftime('%Y %m %d')
    sock_obj.print("GETR #{str_date} #{ip}\r\n")
    if (sock_obj.gets =~ /No data/i)
      return nil
    end
    ret_hash = {}
    ret_hash[:time] = date
    sock_obj.gets
    ret_hash[:sum] = sock_obj.gets.chop.sub(/^.+:\s+([\d\.]+)\s.+$/, "\\1").to_f
    ret_hash[:data] = []
    sock_obj.gets
    sock_obj.gets
    sock_obj.gets
    while line = sock_obj.gets
      val_array = line.split
      ret_hash[:data] << { :hour => val_array[0].to_i, :ip => val_array[1], :upload => val_array[2].to_f, :download => val_array[3].to_f, :sum => val_array[4].to_f }
      data_count = val_array[0].to_i
    end
      ret_hash[:data_count] = data_count
    sock_obj.close
    return ret_hash
  end


end
