namespace :report_generator do
  desc 'Append Report in Readme.md file'
  task update_readme: [:environment] do
    text = ''
    MARKER = '<!-- REPORT -->'
    readme_file = Rails.root.join('README.md')
    File.foreach(readme_file) do |line|
      break if line.strip == MARKER

      text << line
    end

    report_view_component = ReportComponent.new(
      report_data: Disbursement.report
    )
    File.open(readme_file, 'w') do |f|
      f.write text
      f.write "#{MARKER}\n"
      f.write ActionController::Base.new.render_to_string(report_view_component)
    end
  end
end
