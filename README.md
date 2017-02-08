RAILS API AND SIMPLE RAILS APP

Your can check all your rails API manipulations with browser with simple rails APP. Rails api situated in  namespace ‘API’. Login params are the same for API and simple rails APP, therefore you can login in browser and check your changes, when work with API. 


1.	API: CREATE USERS:

First: 

curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{"email":"user1@mail.com","password":"mypass","password_confirmation":"mypass"}' "http://localhost:3000/api/users"

Second: 

curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{"email":"user2@mail.com","password":"mypass","password_confirmation":"mypass"}'  "http://localhost:3000/api/users"


2. API: AUTHENTITHICATE  FIRST USER AND GET THE AUTH_TOKEN: 

curl -H "Content-Type: application/json" -X POST -d '{"email":"user1@mail.com","password":"mypass"}' "http://localhost:3000/api/authenticate"

GET AUTH_TOKEN:
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODY2NDM1NTR9.CsQ2isU_BNOsHa2JSFQMM0UKNArpRSnvW-9ov6pdr0w


3. API:  POST EVENT WITH AUTH_TOKEN IN HEADERS:

curl -v -H "Authorization:  eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODY2NDM1NTR9.CsQ2isU_BNOsHa2JSFQMM0UKNArpRSnvW-9ov6pdr0w" -H 'Content-Type: application/json' -H 'Accept: 	application/json' -X POST -d '{"place":"SOME_EVENT","time":"2017-02-12 17:43:00","description":"SOME EVENT DESCRIPTION","end_time":"2017-02-13 17:43:00"}'  "http://localhost:3000/api/events"


4. API: GET EVENTS WITH TOKEN:


curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODY2NDM1NTR9.CsQ2isU_BNOsHa2JSFQMM0UKNArpRSnvW-9ov6pdr0w" "http://localhost:3000/api/events"

5. API: CREATE INVITE_TOKEN FOR EVENT WITH AUTH_TOKEN IN HEADERS

curl -v -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0ODY2NDM1NTR9.CsQ2isU_BNOsHa2JSFQMM0UKNArpRSnvW-9ov6pdr0w" -H 'Content-Type: application/json' -H 'Accept: 	application/json' -X POST -d '{"email":"user2@mail.com"}'  "http://localhost:3000/api/events/1/invites"

GET INVITE_TOKEN(without percent symbol in the end)
bc948cb6e9302d3a64b5f7e83ff99c4e1906e910

6. API:  AUTHENTITHICATE  SECOND USER AND GET THE AUTH_TOKEN

curl -H "Content-Type: application/json" -X POST -d '{"email":"user2@mail.com","password":"mypass"}' "http://localhost:3000/api/authenticate"

GET AUTH_TOKEN:
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8



7. API: INSERT INVITE_TOKEN AND AUTH_TOKEN TO HEADERS FOR GET EVENTS WITH EVENT FROM INVITE_TOKEN 

curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8" -H "Invite: 	bc948cb6e9302d3a64b5f7e83ff99c4e1906e910" "http://localhost:3000/api/events"

8. API: CREATE COMMENTS  FOR EVENT(will show only last 3 comments and last 3 documents):

curl -v -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8" -H 'Content-Type: application/json' -H 'Accept: 	application/json' -X POST -d '{"body":"some comment "}'  "http://localhost:3000/api/events/1/comments"


9. API: GET SINGLE EVENT WITH COMMENTS AND DOCUMENTS :

curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8" "http://localhost:3000/api/events/1"

10. API: GET EVENT WITH FOLLOWING ENDPOINTS: 

DUE:
curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8" "http://localhost:3000/api/events?due=2017-02-12"

INTERVAL: 
curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE0ODY2NDQ2Mzl9.QjHHgRxiuGsOXAhOQCVwT55X_UvV3GfHs7nn92omnK8" "http://localhost:3000/api/events?interval=5d"



ABOUT 

Users can  access to show, create and show comments,  create and show documents  only in their own events or events in which they are member(Gem CanCanCan).

In Simple Rails APP you can check your changes due by Rails API. You can use your Simple Rails APP to create  events, comments, documents  and then show them in Rails API(email and password must be the same as in Rails APP as 	Rails API).

In Simple Rails APP, if user not registered, invite link will be sent(by EmailWorker(Gem Sidekiq) and RailsMailer(must be installed postfix for correct mailer work)) to email(which you type in events invite field), if user registered in 	APP,  he will receive event notification(in status bar), than can click to notification and then will be redirected to event, in which he has been invited.






GIT REPO:
https://github.com/Slippyjohny/uptech_events_system.git











.
