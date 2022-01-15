module Docs
  class Kubernetes < UrlScraper
    self.name = 'Kubernetes'
    self.slug = 'kubernetes'
    self.type = 'kubernetes'
    self.release = '1.23'
    self.base_url = 'https://kubernetes.io/docs/'

    self.root_path = 'home/'

    self.links = {
      home: 'https://kubernetes.io/'
    }

    html_filters.push 'kubernetes/clean_html', 'kubernetes/entries'

    options[:container] = ->(filter) { filter.root_page? ? '#mainContent' : '.td-content'}


    options[:skip_patterns] = [
      /contribute/,
      /home/,
      /reference\/glossary/,
      /admin/,
      /user-guide/,
      /reference\/generated\/kubectl\/kubectl/,
      /reference\/generated\/kubectl\/kubectl-commands/,
      /reference\/generated\/kubernetes-api/
    ]

    options[:attribution] = <<-HTML
      &copy; 2022 The Kubernetes Authors<br>
      Documentation Distributed under CC BY 4.0.
    HTML

    def get_latest_version(opts)
      doc = fetch_doc('https://kubernetes.io/releases/', opts)
      doc.at_css('.td-content > h3:first-child').content
    end
  end
end
