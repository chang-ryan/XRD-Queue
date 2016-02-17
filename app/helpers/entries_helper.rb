module EntriesHelper

  def split_entries(entries)
    @unscanned_entries = @entries.where(:scanned => false)
                                 .search(params[:unscanned_search])
                                 .paginate(:per_page => 5, :page => params[:unscanned_page])
    @scanned_entries   = @entries.where(:scanned => true)
                                 .search(params[:scanned_search])
                                 .paginate(:per_page => 5, :page => params[:scanned_page])
  end

end
