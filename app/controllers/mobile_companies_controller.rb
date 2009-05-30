class MobileCompaniesController < ApplicationController
  # GET /mobile_companies
  # GET /mobile_companies.xml
  def index
    @mobile_companies = MobileCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mobile_companies }
    end
  end

  # GET /mobile_companies/1
  # GET /mobile_companies/1.xml
  def show
    @mobile_company = MobileCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mobile_company }
    end
  end

  # GET /mobile_companies/new
  # GET /mobile_companies/new.xml
  def new
    @mobile_company = MobileCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mobile_company }
    end
  end

  # GET /mobile_companies/1/edit
  def edit
    @mobile_company = MobileCompany.find(params[:id])
  end

  # POST /mobile_companies
  # POST /mobile_companies.xml
  def create
    @mobile_company = MobileCompany.new(params[:mobile_company])

    respond_to do |format|
      if @mobile_company.save
        flash[:notice] = 'MobileCompany was successfully created.'
        format.html { redirect_to(@mobile_company) }
        format.xml  { render :xml => @mobile_company, :status => :created, :location => @mobile_company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mobile_company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mobile_companies/1
  # PUT /mobile_companies/1.xml
  def update
    @mobile_company = MobileCompany.find(params[:id])

    respond_to do |format|
      if @mobile_company.update_attributes(params[:mobile_company])
        flash[:notice] = 'MobileCompany was successfully updated.'
        format.html { redirect_to(@mobile_company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mobile_company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_companies/1
  # DELETE /mobile_companies/1.xml
  def destroy
    @mobile_company = MobileCompany.find(params[:id])
    @mobile_company.destroy

    respond_to do |format|
      format.html { redirect_to(mobile_companies_url) }
      format.xml  { head :ok }
    end
  end
end
