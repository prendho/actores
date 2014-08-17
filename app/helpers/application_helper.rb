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

  def breadcrumbs(*links)
    content_tag :ol, class: "breadcrumb" do
      links.map do |link|
        if link.is_a?(String)
          content_tag :li, link, class: "active"
        elsif link.is_a?(Hash)
          content_tag :li do
            link_to link[:name], link[:path]
          end
        end
      end.join("").html_safe
    end
  end
end
