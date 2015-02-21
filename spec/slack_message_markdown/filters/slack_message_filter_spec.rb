# encoding: utf-8
require 'spec_helper'

describe SlackMessageMarkdown::Filters::SlackMessageFilter do
  subject do
    context = {
      on_get_user: -> (uid) {
        if uid == 'U00000000'
          { name: 'name', url: 'about:blank' }
        else
          nil
        end
      },
    }
    filter = SlackMessageMarkdown::Filters::SlackMessageFilter.new(text, context)
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
    let(:text) { "Hey\n&gt;&gt;&gt; This is\nquote." }
    it { should eq "Hey<br />\n<blockquote>\nThis is<br />\nquote.\n</blockquote>\n" }
  end

  context 'valid user' do
    let(:text) { "<@U00000000>" }
    it { should eq "<a href=\"about:blank\" class=\"mention\">@name</a><br />\n" }
  end

  context 'invalid user' do
    let(:text) { "<@U12345678>" }
    it { should eq "&lt;@U12345678&gt;<br />\n" }
  end
end
