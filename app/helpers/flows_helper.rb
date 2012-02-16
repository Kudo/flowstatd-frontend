module FlowsHelper
  def generateClassName(flowSum)
    if (flowSum > 5300)
      retStr = ' ui-state-error';
    elsif (flowSum > 5000)
      retStr = ' ui-state-highlight';
    else
      retStr = ''
    end

    return retStr
  end
end
