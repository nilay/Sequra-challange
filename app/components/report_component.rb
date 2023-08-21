# frozen_string_literal: true

# View component to generate report content to be shown in README.md file
class ReportComponent < ViewComponent::Base
  erb_template <<-ERB
| Year | Number of Disbursement | Amount disbursed to merchants | Amount of order fees | Number of monthly fees charged (From minimum monthly fee) | Amount of monthly fee charged (From minimum monthly fee) |
| :---: | ---: | ---: | ---: | ---: | ---: |
<% @report_data.each do |row| %>
| <%=row[:year].to_i%> | <%=row[:disbursed_count]%> | <%=row[:disbursed_amount_total]%> | <%=row[:order_fee]%> | <%=row[:monthly_fee_charged_count]%> | <%=row[:monthly_fee_charge_amount]%> | 
<% end %>
  ERB

  def initialize(report_data:)
    @report_data = report_data
  end
end
