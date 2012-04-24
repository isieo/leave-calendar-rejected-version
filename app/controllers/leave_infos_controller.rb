class LeaveInfosController < ApplicationController
  before_filter :load_organization


  # GET /leave_infos
  # GET /leave_infos.json
  def index
    @leave_infos = current_user.leave_infos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leave_infos }
    end
  end

  # GET /leave_infos/1
  # GET /leave_infos/1.json
  def show
    @leave_info = current_user.leave_infos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leave_info }
    end
  end

  # GET /leave_infos/new
  # GET /leave_infos/new.json
  def new
    @leave_info = current_user.leave_infos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @leave_info }
    end
  end

  # GET /leave_infos/1/edit
  def edit
    @leave_info = current_user.leave_infos.find(params[:id])
  end

  # POST /leave_infos
  # POST /leave_infos.json
  def create
    @leave_info = current_user.leave_infos.new(params[:leave_info])

    respond_to do |format|
      if @leave_info.save
        format.html { redirect_to @leave_info, notice: 'Leave info was successfully created.' }
        format.json { render json: @leave_info, status: :created, location: @leave_info }
      else
        format.html { render action: "new" }
        format.json { render json: @leave_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leave_infos/1
  # PUT /leave_infos/1.json
  def update
    @leave_info = current_user.leave_infos.find(params[:id])

    respond_to do |format|
      if @leave_info.update_attributes(params[:leave_info])
        format.html { redirect_to @leave_info, notice: 'Leave info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leave_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_infos/1
  # DELETE /leave_infos/1.json
  def destroy
    @leave_info = LeaveInfo.find(params[:id])
    @leave_info.destroy

    respond_to do |format|
      format.html { redirect_to leave_infos_url }
      format.json { head :no_content }
    end
  end
end
