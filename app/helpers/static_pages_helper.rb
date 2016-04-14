module StaticPagesHelper

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    link_to link_text, link_path, class: class_name
  end

end
