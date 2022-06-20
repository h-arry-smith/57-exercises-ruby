require 'fileutils'
require_relative '../website_generator'

DIR = 'awesomeco'
AUTHOR = 'Max Power'

RSpec.describe '#generate_website' do
  after do
    FileUtils.rm_rf DIR
  end

  it 'generates the default folder structure and files' do
    generate_website(DIR, AUTHOR)

    expect(Dir.exist? DIR).to be(true)
    expect(File.exist? "#{DIR}/index.html").to be(true)
  end

  it 'generates additional directories based on provided optional object' do
    generate_website(DIR, AUTHOR, ['css', 'js'])

    expect(Dir.exist? "#{DIR}/css").to be(true)
    expect(Dir.exist? "#{DIR}/js").to be(true)
  end

  it 'index file contains correctly formatted default html' do
    expected = <<OUTPUT
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="author", content="Max Power" />
        <title>awesomeco</title>
    </head>
    <body>
    </body>
</html>
OUTPUT

    generate_website(DIR, AUTHOR)

    contents = File.read("#{DIR}/index.html")

    expect(contents).to eq(expected)
  end
end

RSpec.describe '#generate_html' do
  it 'returns a default html template' do
    expected = <<OUTPUT
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="author", content="default" />
        <title>default</title>
    </head>
    <body>
    </body>
</html>
OUTPUT

    expect(generate_html).to eq(expected)
  end

  it 'fills in title tag and author tag when supplied' do
    expected = <<OUTPUT
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="author", content="Max Power" />
        <title>awesomeco</title>
    </head>
    <body>
    </body>
</html>
OUTPUT

    expect(generate_html(DIR, AUTHOR)).to eq(expected)
  end
end
