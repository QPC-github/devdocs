module Docs
  class Kubernetes
    class CleanHtmlFilter < Filter
      def call
        if root_page?
          css("#btn-concepts").remove
        end

        css('.highlight').each do |node|
          code = node.at_css('code')
          node['data-language'] = code['data-lang']
          node.content = code.content
          node.name = 'pre'
        end

        doc
      end
    end
  end
end
