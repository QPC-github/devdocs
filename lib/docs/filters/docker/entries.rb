module Docs
  class Docker
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        return 'Engine' if subpath == 'engine/'

        name = nav_link.content.strip
        name.capitalize! if name == 'exoscale'

        if name =~ /\A[a-z\-\s]+\z/
          name.prepend 'docker ' if subpath =~ /engine\/reference\/commandline\/./
          name.prepend 'docker-compose  ' if subpath =~ /compose\/reference\/./
          name.prepend 'docker-machine ' if subpath =~ /machine\/reference\/./
        else
          name << " (#{product})" if name !~ /#{product}/i
        end

        name
      end

      def get_type
        return 'Engine' if subpath == 'engine/'

        type = nav_link.ancestors('.menu-open').to_a.reverse.to_a[0..1].map do |node|
          node.at_css('> a').content.strip
        end.join(': ')

        type = self.name if type.empty?
        type.remove! %r{\ADocker }
        type.remove! %r{ Engine}
        type.sub! %r{Command[\-\s]line reference}i, 'CLI'
        type = 'Engine: Reference' if type == 'Engine: reference'
        type
      end

      def nav_link
        return @nav_link if defined?(@nav_link)
        @nav_link = at_css('.currentPage')

        unless @nav_link
          link = at_css('#DocumentationText li a')
          return unless link
          link = at_css(".docsidebarnav_section a[href='#{link['href']}']")
          return unless link
          @nav_link = link.ancestors('.menu-closed').first.at_css('a')
        end

        @nav_link
      end

      def product
        @product ||= subpath.split('/').first.capitalize
      end
    end
  end
end
