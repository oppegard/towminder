class RemindeesController < ApplicationController


  # GET /remindees/new
  # GET /remindees/new.xml
  def new
    @remindee = Remindee.new(:starting_month => 4, :ending_month => 11)
    4.times do |i|
      @remindee.reminder_day_and_weeks.build(:day_of_week => Date::DAYNAMES[i+2])
    end
    @remindee.at = "hour"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @remindee }
    end
  end

  # POST /remindees
  # POST /remindees.xml
  def create
    @remindee = Remindee.new(params[:remindee])

    respond_to do |format|
      if @remindee.save
        
        # make flash success msg informative
        flash[:success] = 'You will receive reminders on the '
        flash[:success] += @remindee.reminder_day_and_weeks.collect {|rdaw| "#{rdaw.week_of_month.titleize} #{rdaw.day_of_week.titleize}"}.to_sentence
        flash[:success] += " from #{Date::MONTHNAMES[@remindee.starting_month]} through #{Date::MONTHNAMES[@remindee.ending_month]}."
        
        format.html { redirect_to root_url }
        format.xml  { render :xml => @remindee, :status => :created, :location => @remindee }
      else
        format.html { render :action => "new" }
        #format.html { render root_url, :layout => "remindees", :template => "new" }
        format.xml  { render :xml => @remindee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # FIXME: Allow cellphone to be submitted in format other than 3035551234
  def destroy
    @remindee = Remindee.find_by_cellphone(params[:cellphone_to_destroy])
    if @remindee.nil?
      flash[:not_removed] = "Couldn't find your number. Make sure you enter only digits, e.g. 3035551234."
    else
      @remindee.destroy
      flash[:removed] = "You were successfully removed from Towminder."
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml  { head :ok }
    end
  end
end
