Specs for the Ministry of Testing's Automation Week Web API challenge: https://club.ministryoftesting.com/t/automation-week-challenges-web-api/43667

The API in question is the [RESTful Booker Platform](https://github.com/mwinteringham/restful-booker-platform), an application that was intended for test automation practice.

Assumes you have Ruby and Bundler installed on your system.

To run the specs:
1. `bundle install`
2. copy `config/template.yml` over to `config/env.yml` and correct the values.
3. `bundle exec rspec`

If you aren't running the RESTful Booker Platform locally, you will need to set the environment variable `ENV=remote` before executing step 3.
