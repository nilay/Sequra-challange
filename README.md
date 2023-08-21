### Introduction
This is sample Ruby and Rails app which runs as server component. We use Sidekiq for background job and Sidekiq-scheduler gem to runs the disbursement generation script everyday at 8am (UTC).


#### Installation
Requirements:  Ruby 3.2, PostgreSQL, Redis
```
$ cd <project dir>
$ bundle install
$ rails db:create db:migrate db:seed 
```
db seeder will put all the data from CSV files to database

### Generate Disbursements for all the orders which was there in provided CSV files
We have script to generate all disburdement based on CSV data. Use following Rake task:
```
$ rails disburser:disburse_for_past
```

### Use following rails command to append report into README.md file
```
$ rails report_generator:update_readme
```


* Deployment instructions


<!-- REPORT -->
| Year | Number of Disbursement | Amount disbursed to merchants | Amount of order fees | Number of monthly fees charged (From minimum monthly fee) | Amount of monthly fee charged (From minimum monthly fee) |
| :---: | ---: | ---: | ---: | ---: | ---: |
| 2023 | 519 | 8295012.62 | 75675.2 | 519 | 90.77 | 
| 2022 | 1435 | 16271646.34 | 149977.38 | 1435 | 181.08 | 
