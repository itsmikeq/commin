# README

Open door, open ideas, open mind


## WHY

Commin was created to build a community with common interest.  

## Groups

These are differentiations of users based on the group.  If you want to be "Super Gamer" 
 
## Personas

These are your different "yous" when in different groups/communities

## Profile

Your real you.

## App Rules

* Reads come from elastic search
* Writes go to mysql, then to ES

## JS Routes

After routes change, sometimes you'll need to run `rake tmp:cache:clear` ro reset js routes

## TODO

* Personalized colors for responses
  * Color the box shadow -- selectable by user
* Add Chat
* Add Chat Groups
* Add ability for users to create private chats
* Add ability for 
  * private group chats
  * private direct chats
  * limit connection to rooms by users based on visibility levels and invites
* Allow for showing avatars in the chat (amorphous little creature-things)
  * see https://marvelapp.com/2gdjhgg/screen/7809390
* Allow for users to create avatars
* Add Elastic Search functionality so things are not so slow
  * https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-persistence
* Add pagination for post views
* Sign up flows that invite people to share their likes
* Image copy/paste/add