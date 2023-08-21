namespace :disburser do
  desc 'Generate Disbursement for past date'
  task disburse_for_past: [:environment] do
    (Date.new(2022, 9, 4)..Date.new(2023, 01, 22)).each do |date|
      # Do stuff with date
    end
  end
end
