require "ramble/blog_post/markdown_parser"

module Ramble
  class BlogPost
    class NotFound < StandardError; end

    attr_reader :file, :title, :body, :preview

    class << self
      # TODO: Refactor this shit to be better. Currently 47.8 flog score.
      def all(options = { sort_by: :written_on, asc: true })
        Dir.glob("app/blog_posts/*").map do |file_path|
          new(File.open(file_path))
        end.sort do |a, b|
          if options[:asc]
            a.send(options[:sort_by]) <=> b.send(options[:sort_by])
          else
            b.send(options[:sort_by]) <=> a.send(options[:sort_by])
          end
        end
      end

      def find_by_slug(slug)
        post = all.detect { |blog_post| blog_post.slug == slug }

        unless post
          raise Ramble::BlogPost::NotFound
        end

        post
      end
    end

    def initialize(file)
      @file = file
      @title = parsed_markdown.title
      @body = parsed_markdown.body
      @preview = parsed_markdown.preview
    end

    def slug
      underscored_slug = file_name.match(/\d+_(.*)/)[1]
      underscored_slug.gsub("_", "-")
    end

    def written_on
      timestamp = file_name.match(/(\d+)_/)[1]
      Date.parse(timestamp)
    end

    private

    def file_name
      @file_name ||= File.basename(file, ".md")
    end

    def parsed_markdown
      @parsed_markdown ||= BlogPost::MarkdownParser.new(file.read)
    end
  end
end
