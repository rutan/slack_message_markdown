# encoding: utf-8

require 'html/pipeline'
require 'slack_message_markdown/filters/slack_message_filter'
require 'slack_message_markdown/filters/emoji_filter'
require 'slack_message_markdown/filters/bold_filter'
require 'slack_message_markdown/filters/italic_filter'

module SlackMessageMarkdown
  class Processor
    def initialize(context = {})
      @context = context
    end
    attr_reader :context

    def filters
      @filters ||= [
        SlackMessageMarkdown::Filters::SlackMessageFilter,
        SlackMessageMarkdown::Filters::EmojiFilter,
        SlackMessageMarkdown::Filters::BoldFilter,
        SlackMessageMarkdown::Filters::ItalicFilter,
      ]
    end

    def call(src_text, context = {}, result = nil)
      HTML::Pipeline.new(self.filters, self.context).call(src_text, context, result)
    end
  end
end
