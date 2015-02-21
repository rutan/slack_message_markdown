# encoding: utf-8

require 'kramdown'
require 'kramdown/parser/kramdown'

module Kramdown
  module Parser
    class SlackKramdown < GFM
      def initialize(source, options)
        super
        @block_parsers = [:multiple_blockquote, :codeblock, :codeblock_fenced_gfm, :blockquote]
        @span_parsers = [:codespan, :html_entity]
      end

      MULTIPLE_BLOCKQUOTE_START = /^#{OPT_SPACE}>>>\s*\n.+/m

      def parse_multiple_blockquote
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        result = @src.matched.gsub(/^#{OPT_SPACE}>>>\s*/, '')

        el = new_block_el(:blockquote, nil, nil, location: start_line_number)
        @tree.children << el
        parse_blocks(el, result)
        true
      end
      define_parser(:multiple_blockquote, MULTIPLE_BLOCKQUOTE_START)
    end
  end
end
