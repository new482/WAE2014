class BasicsController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def quotations
    ##Check for there is any input
    if params[:quotation]
      @quotation = Quotation.new  #Create a Model object

      ##Check if new catagory entered
      if params[:category_new]!=''
        @quotation.category = params[:category_new]
      else
        @quotation.category = params[:quotation][:category]
      end

      @quotation.author_name = params[:quotation][:author_name]
      @quotation.quote = params[:quotation][:quote]

      ##Insert into database and check if success
      if @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new
      end

    else
        @quotation = Quotation.new
    end

    ##Sorting and check if there is a Cookie
    if cookies[:cookie_id].blank?
      if params[:sort_by] == "date"
        @quotations = Quotation.all.order(:created_at)
      else
        @quotations = Quotation.all.order(:category)
      end
    else
      @quotations = Quotation.all.where("id NOT IN (#{cookies[:cookie_id]})").order(:category)
    end

  end


  ##Grab some parts of author or quote ans query with Like in the database
  def search
    @search_output = Quotation.all.where('lower(author_name) LIKE lower(?) or lower(quote) LIKE lower(?)',                                       "%#{params[:search_input]}%", "%#{params[:search_input]}%")
  end



  ##Output xml of our website
  def xmlGenerator
    @xml = Quotation.all
    respond_to do |format|
      format.html
      format.json { render :json => @xml }
      format.xml { render :xml => @xml }
    end
  end


  ##Output xml from other groups website
  def xmlParsing
    this_url = Nokogiri::XML(open(params[:url]))
    this_url.xpath('//quotations/quotation').each do |row|
      @quotation = Quotation.new
      @quotation.author_name = row.xpath('author-name').inner_text
      @quotation.category = row.xpath('category-id').inner_text
      @quotation.quote = row.xpath('quote').inner_text
      @quotation.save
    end
<<<<<<< HEAD
    redirect_to root_path
=======
    redirect_to basics_quotations_path
>>>>>>> ec4ed160773dfdd524d9a2b1eef044bb87c83645
  end


  ##Delete quotations by grab the quotation id from the database
  def killQuotation
    if cookies[:cookie_id].blank?
      cookies[:cookie_id] = params[:id]
    else
      cookies[:cookie_id] += "," + params[:id]
    end
<<<<<<< HEAD
    redirect_to root_path
=======
    redirect_to basics_quotations_path
>>>>>>> ec4ed160773dfdd524d9a2b1eef044bb87c83645
  end


  ##Clear all quotation id that deleted or killed
  def clearCookie
    cookies.delete :cookie_id
<<<<<<< HEAD
    redirect_to root_path
  end

=======
    redirect_to basics_quotations_path
  end

	def qn7_13
	end

>>>>>>> ec4ed160773dfdd524d9a2b1eef044bb87c83645
end
