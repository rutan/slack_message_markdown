# encoding: utf-8
require 'spec_helper'

describe SlackMessageMarkdown::Filters::SlackMessageFilter do
  subject do
    filter = SlackMessageMarkdown::Filters::SlackMessageFilter.new(text)
    filter.call.to_s
  end

  context 'code' do
    let(:text) { 'my code `val a = 1`' }
    it { should eq "my code <code>val a = 1</code><br />\n" }
  end

  context 'blockquote' do
    let(:text) { '> Hello' }
    it { should eq "<blockquote>\nHello\n</blockquote>\n" }
  end

  context 'triple blockquote' do
    let(:text) { "Hey\n>>>\nThis is\nquote." }
    it { should eq "Hey<br />\n<blockquote>\nThis is<br />\nquote.\n</blockquote>\n" }
  end
end
