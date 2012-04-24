class RequestsController < ApplicationController
  before_filter :load_organization
  before_filter :authenticate_user!
  
  def index
    @requests = current_user.requests.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = current_user.requests.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.text { render 'show.html',layout: false }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = current_user.requests.new
  
    @request.comment = params[:comment] if !params[:comment].nil?
    @request.type = params[:type]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = current_user.requests.find(params[:id])
    
    respond_to do |format|
      
      format.html 
      format.text { render 'edit.text',:layout=>false }
    end
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = current_user.requests.new
    @request.type = params[:request][:type]
    @request.start_date = params[:request][:start_date]
    @request.end_date = params[:request][:end_date]
    @request.comment = params[:request][:comment]
    @request.status = "Pending"
    @request.organization_id = current_user.organization.id

    respond_to do |format|
      if @request.save
        format.html { redirect_to requests_url, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = current_user.requests.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to requests_url, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = current_user.requests.find(params[:id])
    @request.status = "Cancelled"
    @request.save

    respond_to do |format|
      format.html { redirect_to requests_url }
      format.json { head :no_content }
    end
  end
    
  def cancellation
    @request = current_user.requests.find(params[:request_id])
    
    respond_to do |format|  
      format.html 
      format.text { render 'cancellation.text',:layout=>false }
    end
  end
  
  def cancel
    @request = current_user.requests.find(params[:request_id])
    if params[:request][:cancel] == "1"
      @request.status = "Cancelled"
      @request.save
      redirect_to requests_path, notice: 'Request is successfully cancelled.'
    else
      redirect_to requests_path, notice: 'Error in cancelling request'
    end
  end
  
    def approving
    @request = Request.find(params[:request_id])
    
    respond_to do |format|  
      format.html 
      format.text { render 'approving.text',:layout=>false }
    end
  end
  
  def approve
    @request = Request.find(params[:request_id])
    if params[:request][:approve] == "2"
      @request.status = "Approved"
      @request.save
      if @request.type == "Annual"
        @info = @request.user.leave_infos.where(:leave_type => "Annual Leave").all.first
        @info.remaining_leave = @info.remaining_leave - (@request.end_date.to_date - @request.start_date.to_date)
        @info.save
      elsif @request.type == "Medical"
        @info = @request.user.leave_infos.where(:leave_type => "Medical Leave").all.first
        @info.remaining_leave = @info.remaining_leave - (@request.end_date.to_date - @request.start_date.to_date)
        @info.save
      end
      redirect_to admin_index_path, notice: 'Request is successfully approved.'
    else
      redirect_to admin_index_path, notice: 'Request approval error'
    end
  end
  
  def rejecting
    @request = Request.find(params[:request_id])
    
    respond_to do |format|  
      format.html 
      format.text { render 'rejecting.text',:layout=>false }
    end
  end
  
  def reject
    @request = Request.find(params[:request_id])
    if params[:request][:reject] == "3"
      @request.status = "Rejected"
      @request.save
      redirect_to admin_index_path, notice: 'Request rejected successfully '
    else
      redirect_to admin_index_path, notice: 'Request rejecting error'
    end
  end
  
end
