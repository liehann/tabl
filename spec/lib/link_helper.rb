class LinkHelper
  def self.link_to(text, href)
    "<a href='#{href}'>#{ERB::Util.h(text)}</a>"
  end

  def link_to(text, href)
    LinkHelper.link_to(text, href)
  end
end

