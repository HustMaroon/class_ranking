class DashboardController < ApplicationController
  before_action :only_allow_mod

  def index
    this_monday = Date.today.wday == 1 ? Date.today : Date.today.prev_occurring(:monday)
    sql = <<-SQL
      SELECT klasses.name as kname, 
        AVG(scoring_records.attendees) as avg_attendees,
        AVG(scoring_records.cleaness) as avg_cleaness,
        AVG(scoring_records.clothing) as avg_clothing,
        AVG(scoring_records.outdoor_act) as avg_outdoor_act,
        (AVG(scoring_records.attendees) + AVG(scoring_records.cleaness) + AVG(scoring_records.clothing) + AVG(scoring_records.outdoor_act)) / 4 as avg
      FROM klasses
      INNER JOIN scoring_records ON scoring_records.klass_id = klasses.id
      WHERE scoring_records.assessment_date >= '#{this_monday.to_date}'
      GROUP BY klasses.id
      ORDER BY avg;
    SQL
    @rankings = ActiveRecord::Base.connection.execute(sql).values
  end

  private

  def only_allow_mod
    redirect_to(root_path) unless current_user&.mod?
  end
end