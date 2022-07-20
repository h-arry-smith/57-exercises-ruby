require 'erb'

class HTMLReporter
  def self.render(database, template_path, report_path)
    @items = database.items
    template = File.read(template_path)

    File.write(report_path, ERB.new(template, trim_mode: '<>').result(binding))
  end
end
