module Docs
  class Vue
    class CleanHtmlV3Filter < Filter
      def call
        @doc = at_css('.page')


        # css('.page-edit').remove

        at_css('h1').content = 'Vue.js' if root_page?
        doc.child.before('<h1>Vue.js API</h1>') if slug == 'api/' || slug == 'api/index'

        css('.demo', '.guide-links', '.line-numbers-wrapper', '.footer', '.header-anchor', '.page-edit', '#ad').remove

        # Remove code highlighting
        css('figure').each do |node|
          node.name = 'pre'
          node.content = node.at_css('td.code pre').css('.line').map(&:content).join("\n")
          node['data-language'] = node['class'][/highlight (\w+)/, 1]
        end

        css('pre').each do |node|
          node.content = node.content.strip
          node['data-language'] = node.parent['class'][/language-(\w+)/, 1] if node.parent['class']
        end

        css('iframe').each do |node|
          node['sandbox'] = 'allow-forms allow-scripts allow-same-origin'
        end
        css('.page-nav').each do |node|
          node['style'] = 'text-align: center; margin-bottom: 1rem;'
        end

        css('.page-nav span.prev').each do |node|
          node['style'] = 'text-align: left; float: left;'
        end

        css('.page-nav span.next').each do |node|
          node['style'] = 'text-align: right; float: right;'
        end



        css('details').each do |node|
          node.name = 'div'
        end

        doc
      end
    end
  end
end
