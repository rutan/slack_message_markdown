# encoding: utf-8

require 'kramdown'
require 'kramdown/parser/slack_kramdown'
require 'html/pipeline'
require 'escape_utils'

module SlackMessageMarkdown
  module Filters
    class SlackMessageFilter < HTML::Pipeline::TextFilter
      def call
        link_list = @text.scan(/<((?:@|#|https?:\/\/)[^>]+)>/).flatten
        html = Kramdown::Document.new(EscapeUtils.unescape_html(@text), input: 'SlackKramdown', hard_wrap: true).to_html
        link_list.map { |n| "&lt;#{n}&gt;" }.each do |pattern|
          html.gsub!(pattern) do |match|
            case match[4]
            when '@'; link_mention(match[5, match.size - 11])
            when '#'; link_channel(match[5, match.size - 11])
            else; link_url(match[4, match.size - 8])
            end
          end
        end
        html
      end

      def link_mention(uid)
        user = @context[:on_get_user] ? @context[:on_get_user].call(uid) : nil
        if user
          "<a href=\"#{EscapeUtils.escape_html user[:url].to_s}\" class=\"mention\">@#{EscapeUtils.escape_html user[:name].to_s}</a>"
        else
          "&lt;@#{uid}&gt;"
        end
      end

      def link_channel(uid)
        channel = @context[:on_get_channel] ? @context[:on_get_channel].call(uid) : nil
        if channel
          "<a href=\"#{EscapeUtils.escape_html channel[:url].to_s}\" class=\"channel\">##{EscapeUtils.escape_html channel[:name].to_s}</a>"
        else
          "&lt;##{uid}&gt;"
        end
      end

      def link_url(url)
        if context[:cushion_link]
          "<a href=\"#{context[:cushion_link]}#{EscapeUtils.escape_url url}\">#{EscapeUtils.escape_html url}</a>"
        else
          "<a href=\"#{EscapeUtils.escape_html url}\">#{EscapeUtils.escape_html url}</a>"
        end
      end
    end
  end
end
