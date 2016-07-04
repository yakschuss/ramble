require "nokogiri"
require "redcarpet"

module Ramble
  class BlogPost
    class MarkdownParser
      attr_reader :title, :body, :preview

      def initialize(contents_of_file)
        @contents_of_file = contents_of_file
        @title = parsed_title
        @body = parsed_body
        @preview = parsed_preview
      end

      private

      attr_reader :contents_of_file

      def document
        @document ||= Nokogiri::HTML.parse(raw_html)
      end

      def parsed_title
        return @parsed_title if @parsed_title
        heading = document.search("//h1").first.remove
        @parsed_title = heading.to_html.match(/<h1>(.*)<\/h1>/)[1]
      end

      def parsed_body
        document.search("//body").children.to_html
      end

      def parsed_preview
        document.search("//p").first.text
      end

      def raw_html
        Redcarpet::Markdown.new(renderer, extensions).
          render(contents_of_file)
      end

      def render_options
        { hard_wrap: true }
      end

      def renderer
        @renderer ||= Redcarpet::Render::HTML.new(render_options)
      end

      def extensions
        { fenced_code_blocks: true }
      end
    end
  end
end
