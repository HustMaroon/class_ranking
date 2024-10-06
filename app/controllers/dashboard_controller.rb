class DashboardController < ApplicationController
  before_action :only_allow_mod

  def index
    this_monday = Date.today.prev_occurring(:monday)
    @current_monday = params[:monday].present? ? params[:monday].to_date : this_monday.to_date
    sql = <<-SQL
      SELECT klasses.name as kname, 
        SUM(scoring_records.attendees) as sum_attendees,
        SUM(scoring_records.cleaness) as sum_cleaness,
        SUM(scoring_records.clothing) as sum_clothing,
        SUM(scoring_records.outdoor_act) as sum_outdoor_act,
        (SUM(scoring_records.attendees) + SUM(scoring_records.cleaness) + SUM(scoring_records.clothing) + SUM(scoring_records.outdoor_act)) as total,
        klasses.id as id
      FROM klasses
      INNER JOIN scoring_records ON scoring_records.klass_id = klasses.id
      WHERE scoring_records.assessment_date >= '#{@current_monday}'
      AND scoring_records.assessment_date <= '#{@current_monday + 5.days}'
      GROUP BY klasses.id
      ORDER BY total;
    SQL
    @rankings = ActiveRecord::Base.connection.execute(sql).values
    @scoring_records = ScoringRecord.where(assessment_date: @current_monday..(@current_monday + 5.days))
  end

  private

  def only_allow_mod
    redirect_to(root_path) unless current_user&.mod?
  end
end