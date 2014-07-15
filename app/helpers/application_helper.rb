module ApplicationHelper
  def navbar_item(title, link, options={})
    opts = if options[:tab]
      { data: { toggle: "tab" } }
    else
      nil
    end

    content_tag :li, class: "#{"active" if @active_item == title.downcase.to_sym}" do
      link_to title, link, opts
    end
  end

  def for_admin
    yield if current_user && current_user.admin?
  end
end
