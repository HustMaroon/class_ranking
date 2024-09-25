class ScoringRecordsController < ApplicationController
  def index
    this_monday = Date.today.wday == 1 ? Date.today : Date.today.prev_occurring(:monday)
    @scoring_records = if current_user.assessor?
      current_user.scoring_records.where('assessment_date >= ?', this_monday)
    else
      params[:filter] == 'this_week' ? ScoringRecord.where('assessment_date >= ?', this_monday) : ScoringRecord.page(params[:page] || 1)
    end
  end

  def new
    @scoring_record = ScoringRecord.new
  end

  def create
    @scoring_record = current_user.scoring_records.new(scoring_record_params)
    @scoring_record.save

    respond_to do |format|
      format.js { render 'form_result' }
    end
  end

  def edit
    @scoring_record = ScoringRecord.find(params[:id])
  end

  def update
    @scoring_record = ScoringRecord.find(params[:id])
    @scoring_record.update(scoring_record_params)
    respond_to do |format|
      format.js { render 'form_result' }
    end
  end

  private

  def scoring_record_params
    params.require(:scoring_record).permit(:assessment_date, :klass_id, :attendees, :cleaness, :clothing, :outdoor_act, :note)
  end
end