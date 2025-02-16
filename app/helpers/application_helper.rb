module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice
      "alert-success"
    when :alert
      "alert-warning"
    when :error
      "alert-danger"
    else
      "alert-info"
    end
  end

  def breadcrumbs
    content_tag(:nav, aria: { label: "breadcrumb" }) do
      content_tag(:ol, class: "breadcrumb p-2 rounded bg-light") do
        links = []
        links << breadcrumb_item("Dashboard", admin_dashboard_path)

        pages = {
          "users" => "Users",
          "categories" => "Categories",
          "breeds" => "Breeds",
          "pets" => "Pets",
          "donate_pets" => "Donate Pet Requests",
          "adopt_pets" => "Adopt Pet Requests"
        }

        links << breadcrumb_item(pages[controller_name], send("admin_#{controller_name}_path")) if pages[controller_name]

        links << content_tag(:li, action_name.humanize, class: "breadcrumb-item h5 mb-0 active", style: "color: rgb(105, 108, 255); text-decoration:none", aria: { current: "page" }) if action_name != "index"

        links.join.html_safe
      end
    end
  end

  private

  def breadcrumb_item(name, path)
    content_tag(:li, link_to(name, path, class: "h5 mb-0 text-decoration-none", style: "color: rgb(105, 108, 255);"), class: "breadcrumb-item")
  end
end
