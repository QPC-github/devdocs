module Docs
  class Vue
    class EntriesV3Filter < Docs::EntriesFilter
      def get_name
        if slug == 'api/' || slug == 'api/index'
          'API'
        elsif slug == 'style-guide/'
          'Style Guide'
        else
          name = at_css('.page h1').content.gsub! /\#/, ''
          node = at_css(".sidebar .sidebar-links a[href='#{File.basename(slug)}']")

          return name if node.nil?

          # index = node.parent.parent.css('> li > a').to_a.index(node)
          prefix = node.parent.parent.parent.css('.sidebar-heading')[0].inner_text.strip
          name.prepend "#{prefix}: " if prefix
          name
        end
      end

      def get_type
        if slug.start_with?('guide/migration')
          'Migration from Vue 2'
        elsif slug.start_with?('guide')
          'Guide'
        elsif slug == 'style-guide/'
          'Style Guide'
        else
          'API'
        end
      end

      def additional_entries
        return [] if slug.start_with?('guide')
        type = nil
        if slug.start_with?('api')
          current_type = at_css('.page h1').content.strip.gsub! /\#/, ''
          css('.page h2').each_with_object [] do |node, entries|
            if node.name == 'h2'
              name = node.content.strip.gsub! /\#/, ''
              entries << ["#{name} (#{current_type})", node['id'], 'API']
            end
          end
        elsif slug.start_with?('style-guide')
          css('.page h2, .page h3').each_with_object [] do |node, entries|
            if node.name == 'h2'
              type = node.content.strip.gsub! /\#/, ''
            else
              name = node.content.strip.gsub! /\#/, ''
              name.sub! %r{\(.*\)}, '()'
              name.sub! /(essential|strongly recommended|recommended|use with caution)\Z/, ''

              current_type = "Style Guide: "
              current_type += type.sub(/( Rules: )/, ': ').split('(')[0]

              entries << [name, node['id'], current_type]
            end
          end
        end
      end
    end
  end
end
