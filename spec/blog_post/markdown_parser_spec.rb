require "ramble/blog_post/markdown_parser"
require "spec_helper"

RSpec.describe Ramble::BlogPost::MarkdownParser do
  it "can figure out what should be the title" do
    file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")
    parser = described_class.new(file.read)
    expected_title = "Nulla sed justo imperdiet!"

    expect(parser.title).to eq(expected_title)
  end

  it "returns the body with HTML tags" do
    file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")
    parser = described_class.new(file.read)

    expect(parser.body.include?("<p>")).to eq(true)
    expect(parser.body.include?("<br>")).to eq(true)
  end

  it "removes the title from the body" do
    file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")
    parser = described_class.new(file.read)

    expect(parser.body.include?("<h1>Nulla sed justo imperdiet!</h1?")).
      to eq(false)
  end

  it "can figure out what should be the preview" do
    file = File.open("spec/fixtures/blog_posts/20160101_nulla_sed_justo.md")
    parser = described_class.new(file.read)

    expected_preview = "Lorem ipsum dolor sit amet, consectetur adipiscing "\
                       "elit. Nulla sed justo\nimperdiet, fringilla ex "\
                       "suscipit, ullamcorper tortor. Etiam consectetur "\
                       "dolor\nsed auctor sodales. Proin interdum vitae orci "\
                       "in tristique. Praesent imperdiet\nut mi ac rutrum. "\
                       "Nullam orci lacus, molestie non laoreet vestibulum, "\
                       "lobortis\nnec neque. Nam massa ligula, venenatis sed "\
                       "nibh eget, scelerisque lobortis\nipsum. Nam luctus, "\
                       "sem quis tristique sollicitudin, arcu libero auctor "\
                       "metus, et\ntincidunt enim erat eget metus. Duis vitae "\
                       "odio bibendum nisi fringilla\npharetra. Vestibulum "\
                       "neque tellus, placerat in tellus ut, pellentesque "\
                       "commodo\nest."

    expect(parser.preview).to eq(expected_preview)
  end
end
