
# Development
### Install and start

* Ruby version 2.7.3

* Rails version 6.1.3.2

* Database sqlite3

```
$ bundle install
$ rails db:migrate
$ rails db:seed
$ rails s
```

- to see a list of users
  > http://localhost:3000/api/v1/users

### Test environment
- run rspec
  > rspec spec/*


# Guideline for API
### Clock in operation
- create clock-in time
   * URI: /api/v1/clock_ins
   * action: POST
   * params: { sleep_at: datetime, wake_up_at: datetime }
   * response: a list of clock-in times order by created_at [{:id, :sleep_at_timestamp, :wake_up_at_timestamp, :sleep_time_in_second, :created_at_timestamp}]

- follow other user (receiver)
   * URI: /api/v1/follows
   * action: POST
   * params: { receiver_id: }
   * response: { :id, :sender_id, :receiver_id, :created_at_timestamp }

- unfollow other user
   * URI: /api/v1/follows/:id
   * action: DELETE
   * params: id is the receiver id
   * response: { :id, :sender_id, :receiver_id, :created_at_timestamp }

 - See the sleep records over the past week for their friends
   * URI: /api/v1/clock_in_by_friend/:id
   * action: GET
   * params: id is the friend id
   * response: [{:id, :sleep_at_timestamp, :wake_up_at_timestamp,
  	:sleep_time_in_second, :created_at_timestamp }] 
