class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :print]
  before_action :authenticate_user!
  def index
    @reports = Report.where(user_id: current_user.id).decorate
  end

  def show
  end

  def new
    @report = Report.new
    @professors = User.where(coordenador: true)
  end


  def edit
  end

  def create
    @report = Report.new(report_params)

    @report.user_id = current_user.id
    respond_to do |format|
      if @report.save
        # SignatureService.new(@report)
        format.html { redirect_to @report, notice: 'O relatório foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def print
    respond_to do |format|
      format.pdf do
        doc = ReportService.new(@report)
        send_data doc.render, type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_report
      @report = Report.find(params[:id]).decorate
    end

    def report_params
      params.require(:report).permit(:company, :educational_institution, :worked_days, :daily_worked_hours,
                                     :report_date, :performed_activities, :supervisor_email, :professor_id)
    end
end
