module EntriesHelper

  def split_entries(entries)
    @unscanned_entries = @entries.where(:scanned => false)
                              .paginate(:per_page => 5,  :page => params[:page])
    @scanned_entries   = @entries.where(:scanned => true)
                              .paginate( :per_page => 5, :page => params[:page])
  end

end
