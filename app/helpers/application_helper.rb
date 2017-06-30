module ApplicationHelper
  def full_title page_title = ""
    page_title.empty? ? t(".title") : page_title + " | " + t(".title")
  end
end
