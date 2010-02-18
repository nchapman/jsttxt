# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def smash(text)
    return text.gsub(/<\/?[^>]+>/, "").gsub(/\n/, " ").gsub(/\s+/, " ").slice(0, 200)
  end
end
