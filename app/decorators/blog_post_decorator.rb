class BlogPostDecorator < SimpleDelegator
  include DateHelper

  def display_status
    if draft?
      html = <<-HTML
        <span class="bg-gray-100 text-gray-400 rounded text-sm px-2 py-1">
          Draft
        </span>
      HTML
    elsif scheduled?
      html = <<-HTML
        <span class="bg-yellow-100 text-yellow-700 rounded text-sm px-2 py-1">
          Scheduled for #{ date_yyyy_mm_dd(published_at) }
        </span>
      HTML
    end

    html.html_safe unless published?
  end
end
