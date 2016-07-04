require "spec_helper"
require "ramble/blog_post"

RSpec.describe Ramble::BlogPost do
  let(:all_files) do
    ["spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
     "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md"]
  end

  describe ".all" do
    it "returns all blog posts found in app/blog_posts" do
      all_files = [
        "spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
        "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md",
      ]

      allow(Dir).
        to receive(:glob).
        with("app/blog_posts/*").
        and_return(all_files)

      expect(described_class.all.size).to eq(2)
    end

    it "sorts them by written on ASC by default" do
      all_files = [
        "spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
        "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md",
      ]

      allow(Dir).
        to receive(:glob).
        with("app/blog_posts/*").
        and_return(all_files)

      blog_posts = described_class.all

      expect(blog_posts.first.title).to eq("Nulla sed justo imperdiet!")
      expect(blog_posts.last.title).to eq("Consectetur Adipiscing Elit!")
    end

    it "can accept sort_by and directional arguments" do
      all_files = [
        "spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
        "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md",
      ]

      allow(Dir).
        to receive(:glob).
        with("app/blog_posts/*").
        and_return(all_files)

      blog_posts = described_class.all(sort_by: :written_on, asc: false)

      expect(blog_posts.first.title).to eq("Consectetur Adipiscing Elit!")
      expect(blog_posts.last.title).to eq("Nulla sed justo imperdiet!")
    end
  end

  describe ".find_by_slug" do
    it "returns a Ramble::BlogPost if the slug is valid" do
      all_files = [
        "spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
        "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md",
      ]

      allow(Dir).
        to receive(:glob).
        with("app/blog_posts/*").
        and_return(all_files)

      expect(described_class.find_by_slug("nulla-sed-justo")).
        to be_a(Ramble::BlogPost)
    end

    it "raises a Ramble::BlogPost::NotFound exception if the slug is invalid" do
      all_files = [
        "spec/fixtures/blog_posts/20160101_nulla_sed_justo.md",
        "spec/fixtures/blog_posts/20160601_fusce_ligula_leo.md",
      ]

      allow(Dir).
        to receive(:glob).
        with("app/blog_posts/*").
        and_return(all_files)

      expect { described_class.find_by_slug("not-a-slug") }.
        to raise_error { Ramble::BlogPost::NotFound }
    end
  end

  describe "#slug" do
    it "can figure out the slug of the post" do
      file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")

      parser_double = double(
        "Ramble::BlogPost::MarkdownParser",
        title: "Nulla sed justo imperdiet!",
        body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
        preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )

      allow(Ramble::BlogPost::MarkdownParser).
        to receive(:new).
        with(file.read).
        and_return(parser_double)

      file.rewind

      blog_post = described_class.new(file)

      expect(blog_post.slug).to eq("nulla-sed-justo")
    end
  end

  describe "#written_on" do
    it "can figure out the timestamp of the post" do
      file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")

      parser_double = double(
        "Ramble::BlogPost::MarkdownParser",
        title: "Nulla sed justo imperdiet!",
        body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
        preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )

      allow(Ramble::BlogPost::MarkdownParser).
        to receive(:new).
        with(file.read).
        and_return(parser_double)

      file.rewind

      blog_post = described_class.new(file)

      expect(blog_post.written_on).to eq(Date.parse("20160101"))
    end
  end

  describe "#initialize" do
    it "sets title of the post" do
      file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")

      parser_double = double(
        "Ramble::BlogPost::MarkdownParser",
        title: "Nulla sed justo imperdiet!",
        body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
        preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )

      allow(Ramble::BlogPost::MarkdownParser).
        to receive(:new).
        with(file.read).
        and_return(parser_double)

      file.rewind

      blog_post = described_class.new(file)

      expect(blog_post.title).to eq("Nulla sed justo imperdiet!")
    end

    it "sets the body of the post" do
      file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")

      parser_double = double(
        "Ramble::BlogPost::MarkdownParser",
        title: "Nulla sed justo imperdiet!",
        body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
        preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )

      allow(Ramble::BlogPost::MarkdownParser).
        to receive(:new).
        with(file.read).
        and_return(parser_double)

      file.rewind

      blog_post = described_class.new(file)

      expect(blog_post.body).to eq("<p>Lorem ipsum dolor sit amet, consectetur"\
                                   " adipiscing elit.</p>")
    end

    it "sets the preview of the post" do
      file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")

      parser_double = double(
        "Ramble::BlogPost::MarkdownParser",
        title: "Nulla sed justo imperdiet!",
        body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>",
        preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )

      allow(Ramble::BlogPost::MarkdownParser).
        to receive(:new).
        with(file.read).
        and_return(parser_double)

      file.rewind

      blog_post = described_class.new(file)

      expect(blog_post.preview).to eq("Lorem ipsum dolor sit amet, consectetur"\
                                      " adipiscing elit.")
    end
  end
end
