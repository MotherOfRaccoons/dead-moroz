module Sortable
  extend ActiveSupport::Concern

  private

  def sort_direction
    params[:direction] == 'desc' ? 'desc' : 'asc'
  end

  def sort_column
    sortable_columns.include?(params[:sort]) ? params[:sort] : self.class::SORTABLE_COLUMNS[0]
  end

  def sortable_columns
    self.class::SORTABLE_COLUMNS
  end
end
