module Docs
  class Kubernetes
    class CleanHtmlFilter < Filter
      def call
        if root_page?
          css("#btn-concepts").remove
          return doc
        end


        css('.highlight .copy-code-icon').each do |node|
          node.at_css('img').remove
          node.before(node.children).remove
        end

        css('.highlight > pre').each do |node|
          code = node.at_css('code')
          node['data-language'] = code['data-lang']
          node.content = code.content
          node.name = 'pre'
        end

        css('pre.code-block').each do |node|
          code = node.at_css('code')
          node['data-language'] = code['class'].strip.split('-')[1]
          node.content = code.content
          node.name = 'pre'
        end
        # @todo demo code move to after the description
        # if slug.include?('kubectl-commands')
        #   nodes = Nokogiri::XML::NodeSet.new(Nokogiri::XML::Document.new, list = [])
        #   css('h1, h2').each do |node|
        #     next unless node.next_element.name == 'blockquote'
        #     while test = node.next
        #       break unless (test.name == 'blockquote' || test.name == 'pre')
        #       nodes.push(test)
        #       node = test
        #     end
        #     while test = node.next
        #       break unless test.name == 'hr'
        #       node = test
        #     end
        #     node.before(nodes)
        #   end
        # end
        doc
      end
    end
  end
end
