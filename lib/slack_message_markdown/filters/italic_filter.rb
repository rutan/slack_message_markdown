# encoding: utf-8

require 'html/pipeline'
require 'slack_message_markdown/filters/ignorable_ancestor_tags'

module SlackMessageMarkdown
  module Filters
    class ItalicFilter < HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search(".//text()").each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?('_')
          html = italic_filter(content)
          next if html == content
          node.replace(html)
        end
        doc
      end

      def italic_filter(text)
        text.gsub(ITALIC_PATTERN) do
          "<i>#{$1}</i>"
        end
      end

      ITALIC_PATTERN = /(?<=^|\W)_(.+)_(?=\W|$)/
    end
  end
end
