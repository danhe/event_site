
# Events reservation

## Intro

We are building an event reservation application. For now we are building the simplest possible thing that can work.

There are two types of events:

* A Workshop, where during a time frame multiple people can attend (in parallel)
* An Office Hour, where during a time frame individual people can attend (in serial)

Events are not multi-day and can occur anytime in a 24hr day.

Backend API: Ruby on rails API
Frontend: VueJS

For more information, you can visit API doc [https://events-reservation-api.herokuapp.com/docs/index.html#introduction] here 
And you can also take a look to its front-end[https://events-reservation-frontend.danhe.now.sh] project.

## Getting started

### API

1. Clone the project and Change directory to `solution/events-reservation-api/`. Install all gems:
```
    $ cd solution/events-reservation-api/
    $ bundle install
```
2. Migration and seed the databse:
```
    $ rake db:migrate
    $ rake db:seed
```
3. Start the web server:
```
    $ rails s
```
