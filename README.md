# CareRev-events_app

## What does this app do?
This app can create event and can see the number of event_types that happen today.

### How to setup
Run the following commands to setup:

1. git clone git@github.com:jolouie7/CareRev-events-app.git
2. cd CareRev-events-app
3. bundle install

### Example of incoming data:
```
{
  "event": {
    "name": "test button",
    "event_type": "click"
  }
}
```

### Curl commands used
- curl -X POST --header 'Content-Type: application/json' --data '{"event" : {"name" : "test button", "event_type" : "click", "at" : "2020-06-12T00:00:01", "button_color" : "red" }}' http://localhost:3333/events
- curl -X GET http://localhost:3333/events/stats/