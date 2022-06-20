def generate_website(dir, author, optional_dirs = [])
  Dir.mkdir(dir)

  optional_dirs.each { |optional| Dir.mkdir("#{dir}/#{optional}") }

  File.open("#{dir}/index.html", 'w') { |file| file.write(generate_html(dir, author)) }
end

def generate_html(dir = "default", author = "default")
  <<OUTPUT
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="author", content="#{author}" />
        <title>#{dir}</title>
    </head>
    <body>
    </body>
</html>
OUTPUT
end
