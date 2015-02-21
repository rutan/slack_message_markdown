# encoding: utf-8
require 'spec_helper'

describe SlackMessageMarkdown::Processor do
  subject do
    context = {
      asset_root: '/assets',
      original_emoji_set: {
        'ru_shalm' => 'http://toripota.com/img/ru_shalm.png'
      },
      on_get_user: -> (_) { { name: 'ru_shalm', url: 'http://toripota.com' } },
      cushion_link: 'http://localhost/?url='
    }
    processor = SlackMessageMarkdown::Processor.new(context)
    processor.call(text)[:output].to_s
  end

  let :text do
<<EOS
<@U12345> *SlackMessageMarkdown* is `text formatter` _gem_ .
> :ru_shalm: is <http://toripota.com/img/ru_shalm.png>
EOS
  end

  it do
    should eq <<EOS
<a href="http%3A%2F%2Ftoripota.com" class="mention">@ru_shalm</a> <b>SlackMessageMarkdown</b> is <code>text formatter</code> <i>gem</i> .<br>
<blockquote>
<img class="emoji" title=":ru_shalm:" alt=":ru_shalm:" src="http://toripota.com/img/ru_shalm.png" height="20" width="20" align="absmiddle"> is <a href="http://localhost/?url=http%3A%2F%2Ftoripota.com%2Fimg%2Fru_shalm.png">http://toripota.com/img/ru_shalm.png</a>
</blockquote>
EOS
  end
end
