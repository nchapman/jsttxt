class NotesController < ApplicationController
  before_filter :require_user, :except => :show
  
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.find(:all, :conditions => {:user_id => current_user.id}, :order => "created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])
    
    if @note.public? || (current_user && @note.user_id == current_user.id)
      respond_to do |format|
        format.html # show.html.erb
        #format.xml  { render :xml => @note }
      end
    else
      require_user
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new
    
    @note.body_html = params[:t] if params[:t]

    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = current_user.notes.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    
    @note.user = current_user

    respond_to do |format|
      if @note.save
        flash[:notice] = 'Note was successfully saved.'
        format.html { redirect_to(@note) }
        #format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        #format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = current_user.notes.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        flash[:notice] = 'Note was successfully saved.'
        format.html { redirect_to(@note) }
        #format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        #format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = current_user.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      #format.xml  { head :ok }
    end
  end
  
  def search
    @query = params[:query]
    @notes = Note.search(@query)
    
    respond_to do |format|
      format.html
      #format.xml  { render :xml => @notes }
    end
  end
end
