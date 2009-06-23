class RemindeesController < ApplicationController

  # GET /remindees
  # GET /remindees.xml
  def index
    @remindees = Remindee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @remindees }
    end
  end

  # GET /remindees/1
  # GET /remindees/1.xml
  def show
    @remindee = Remindee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @remindee }
    end
  end

  # GET /remindees/new
  # GET /remindees/new.xml
  def new
    @remindee = Remindee.new(:starting_month => 4, :ending_month => 11)
    4.times do |i|
      @remindee.reminder_day_and_weeks.build(:day_of_week => Date::DAYNAMES[i+2])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @remindee }
    end
  end

  # GET /remindees/1/edit
  def edit
    @remindee = Remindee.find(params[:id])
  end

  # POST /remindees
  # POST /remindees.xml
  def create
    @remindee = Remindee.new(params[:remindee])

    respond_to do |format|
      if @remindee.save
        flash[:notice] = 'Remindee was successfully created.'
        format.html { redirect_to(@remindee) }
        format.xml  { render :xml => @remindee, :status => :created, :location => @remindee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @remindee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /remindees/1
  # PUT /remindees/1.xml
  def update
    @remindee = Remindee.find(params[:id])

    respond_to do |format|
      if @remindee.update_attributes(params[:remindee])
        flash[:notice] = 'Remindee was successfully updated.'
        format.html { redirect_to(@remindee) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @remindee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /remindees/1
  # DELETE /remindees/1.xml
  def destroy
    @remindee = Remindee.find_by_cellphone(params[:cellphone_to_destroy])
    @remindee.destroy

    respond_to do |format|
      format.html { redirect_to(remindees_url) }
      format.xml  { head :ok }
    end
  end
end
