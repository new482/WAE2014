class DivideByZeroController < ApplicationController
  def index

  end

  def printOut
    @var1 = params[:var1].to_i
    @var2 = params[:var2].to_i
    begin
      @result = @var1/@var2
    rescue ZeroDivisionError => e
      @result = e.backtrace
    end
  end
end
