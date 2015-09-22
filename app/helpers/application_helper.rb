module ApplicationHelper
  def gravatar_url(player, options = {})
    options.assert_valid_keys :size
    size = options[:size] || 32
    digest = player.email.blank? ? "0" * 32 : Digest::MD5.hexdigest(player.email)
    "http://www.gravatar.com/avatar/#{digest}?d=mm&s=#{size}"
  end

  def format_time(time)
    "#{time_ago_in_words(time)} ago"
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
