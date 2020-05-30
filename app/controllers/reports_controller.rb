class ReportsController < ApplicationController
  include SignatureTokenConcern

  before_action :set_report, only: [:show, :edit, :update, :destroy, :print, :verify, :cancel, :approve]
  before_action :set_professors, only: [:new, :create]
  before_action :authenticate_user!, except: [:print]

  def index
    reports_collection
  end

  def show
    redirect_to verify_report_path(@report) if current_user.coordenador?

  end

  def new
    @report = Report.new

  end


  def verify
    return render_unauthorized unless current_user.coordenador?
  end

  def approve
    return render_unauthorized unless current_user.coordenador?

    if @report.update_column(:approved, true)
      redirect_to reports_path
      flash[:notice] = "O Relatório foi aprovado!"
    end
  end

  def cancel
    return render_unauthorized unless current_user.coordenador?

    if @report.update_column(:cancel_reason, cancel_report_params['cancel_reason'])
      @report.cancel!
      redirect_to reports_path
      flash[:notice]= "O relatório foi rejeitado"
    else
    end
  end


  def create
    @report = Report.new(report_params)

    @report.user_id = current_user.id
    respond_to do |format|
      if @report.save
        SignatureService.new(@report).send_email
        format.html { redirect_to @report, notice: 'O relatório foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
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
                                     :report_date, :performed_activities, :supervisor_email, :supervisor_nome, :professor_id)
    end

    def cancel_report_params
      params.require(:report).permit(:cancel_reason)
    end


    def authenticate_print
      user_signed_in? ? authenticate_user! : validate_token
    end

    def reports_collection
      if current_user.admin?
        @reports = Report.all.decorate

      elsif current_user.coordenador?
        @reports = fetch_reports.order('created_at DESC')
                                .decorate

      else
        @reports = Report.where(user_id: current_user.id).decorate
      end
    end

    def fetch_reports
      case params[:r]

      when 'rejected'
        rejected_reports
      when 'approved'
        approved_reports
      else
        pending_reports
      end
    end

    def pending_reports
      Report.where(professor_id: current_user.id)
            .where('canceled_at IS NULL')
            .where('cancel_reason IS NULL')
            .where(approved: false)
    end

    def rejected_reports
      Report.where(professor_id: current_user.id)
            .where('canceled_at IS NOT NULL')
            .where(approved: false)
    end

    def approved_reports
      Report.where(professor_id: current_user.id)
            .where(approved: true)
    end

    def set_professors
      @professors = User.where(coordenador: true)
    end

end
