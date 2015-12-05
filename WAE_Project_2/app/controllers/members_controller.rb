class MembersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :login_required, except: [:index, :show]
  before_action :role_required, except: [:index, :show]
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  #after_filter :index


  # GET /members
  # GET /members.json
  def index
    if current_user.role_id == 1
      @members = User.all
      @checkAdmin = 1
      @members_recent_register = User.order('created_at desc').limit(5)
      @members_recent_login = User.order('last_sign_in_at desc').limit(5)
    else
      render :show
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = User.new
  end

  # GET /members/1/edit
  def edit
    if params[:ban] == '1'
      User.find(params[:id]).update_attribute('role_id', 3)
      @notice = 'Successfully banned'
    elsif params[:ban] == '0'
      User.find(params[:id]).update_attribute('role_id', 2)
      @notice = 'Successfully unbanned'
    end
    if params[:admin] == '1'
      User.find(params[:id]).update_attribute('role_id', 1)
      @notice = 'Successfully made admin'
    elsif params[:admin] == '0'
      User.find(params[:id]).update_attribute('role_id', 2)
      @notice = 'Removed as admin'
    end
    redirect_to :back, notice: @notice
  end

  # POST /members
  # POST /members.json
  def create
    @member = User.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params[:member]
    end
end
