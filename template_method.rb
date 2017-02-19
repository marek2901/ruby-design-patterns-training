## OO way
## ONly plain text -> req change (we want HTML as well xD)
class Report
  attr_reader :title, :lines
  def initialize
    @title = 'Good'
    @lines = %w(those are example things to be found in report)
  end

  def output_report
    output_head
    lines.each { |line| output_line(line) }
    output_footer
  end

  def output_head; end

  def output_line(line); end

  def output_footer; end
end

# Plain Text
#==================
# == Good report:
#   - line

class PlainTextReport < Report
  def output_head
    puts '=================='
    puts "== #{title} report:"
  end

  def output_line(line)
    puts "  - #{line}"
  end
end

# HTML
# <!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN">
# <html>
#    <head>
#       <title>
#          Good report
#       </title>
#    </head>
# <body>
#    <h1>Good report</h1>
#    <ul>
#   <li>line</li>
# </ul>
# </body>
# </html>

class HTMLReport < Report
  attr_reader :file

  def initialize
    super
    open_file
  end

  def open_file
    @file = File.new('./report.html', 'a')
  end

  def close_file
    @file.close
  end

  def output_head
    file.puts %(
      <!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN">
      <html>
         <head>
            <title>
               #{title} report
            </title>
         </head>
      <body>
         <h1>#{title} report</h1>
         <ul>
    )
  end

  def output_line(line)
    file.puts "<li>#{line}</li>"
  end

  def output_footer
    file.puts <<-EOF
      </ul>
    </body>
    </html>
    EOF
    close_file
  end
end

PlainTextReport.new.output_report
HTMLReport.new.output_report
