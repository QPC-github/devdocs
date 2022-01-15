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
          name
        end
      end

      def get_type
        if slug.start_with?('setup/')
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
    end
  end
end
