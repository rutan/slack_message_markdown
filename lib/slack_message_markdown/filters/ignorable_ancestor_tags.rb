# encoding: utf-8

module SlackMessageMarkdown
  module Filters
    module IgnorableAncestorTags
      DEFAULT_IGNORED_ANCESTOR_TAGS = %w(pre code tt).freeze
      def ignored_ancestor_tags
        if context[:ignored_ancestor_tags]
          DEFAULT_IGNORED_ANCESTOR_TAGS | context[:ignored_ancestor_tags]
        else
          DEFAULT_IGNORED_ANCESTOR_TAGS
        end
      end
    end
  end
end
