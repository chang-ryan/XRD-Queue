module EntriesHelper

  def split_entries(entries=Entry)
    @unscanned_entries = entries.where(:scanned => false)
                                 .order(created_at: :asc)
                                 .search(params[:unscanned_search])
                                 .paginate(:per_page => 5, :page => params[:unscanned_page])
    @scanned_entries   = entries.where(:scanned => true)
                                 .order(updated_at: :desc)
                                 .search(params[:scanned_search])
                                 .paginate(:per_page => 5, :page => params[:scanned_page])
  end

end
