module Docs
  class Kubernetes
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        if slug == 'setup/'
          'Getting started'
        elsif slug == 'concepts/'
          'Concepts'
        elsif slug == 'tasks/'
          'Tasks'
        elsif slug == 'tutorials/'
          'Tutorials'
        elsif slug == 'reference/'
          'Reference'
        else
          name = at_css('h1').content.strip
          if api_page?
            if title = slug.match(/reference\/kubernetes-api\/(.*?)\/(.*?)\//)
              title = title[1].gsub!('-', ' ').capitalize
              "#{title}: #{name}"
            end
          end
          name
        end
      end

      def get_type
        if api_page?
          if title = slug.match(/reference\/kubernetes-api\/(.*?)\/(.*?)\//)
            title = title[1].gsub!('-', ' ').capitalize
            "API: #{title}"
          else
            'Kubernetes API'
          end
        elsif slug.start_with?('setup/')
          'Getting started'
        elsif slug.start_with?('concepts/')
          'Concepts'
        elsif slug.start_with?('tasks/')
          'Tasks'
        elsif slug.start_with?('tutorials/')
          'Tutorials'
        elsif slug.start_with?('reference/')
          'Reference'
        end
      end

      def additional_entries
        return [] unless slug.include?('kubectl-commands')
        entries = []
        type = 'Kubectl Commands'
        cmd = nil
        css('h1, h2').each do |node|
          # cmd
          if node.name == 'h1' && !node.content.match(/[A-Z]/)
            cmd = node.content.strip
            entries << [cmd, node['id'], type]
            next
          end

          # subcmd
          if node.name == 'h2'
            name = node.content.strip
            name.prepend(cmd + ' ')
            entries << [name, node['id'], type]
          end
        end
        entries
      end

      def api_page?
        slug.start_with?('reference/kubernetes-api/')
      end
    end
  end
end
