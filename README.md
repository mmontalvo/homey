# README

## Homey code challenge

In this README I am going to explain the assumptions made duriong the development process and the questions I would have raised to my colleagues.

## Current design

The app contains the minimum list of elements to comply with the requirements.

Regarding `models`, it has:
- User: based on `Devise` gem. bare minimum setup e.g. no additional fields after installation
- Project: just `title` and `status` fields
- Message: `body` as the main attribute for this model
- Audit: to keep track of the changes. It has `project` as the principal reference, so all audits related to a project can be easily queried

On the `controllers` side, both `projects` and `messages` were scaffolded and specifically `messages` has been limited to only `new` and `create` actions to simplify the development.

## Event Driven approach

The main topic related to the development of this solutions was the aim to build an Event Driven application.

Every time an `event`we want to keep track happens in the app, we will create an `Audit` record and link it to the project it belongs, so we can easily build a trace of the events that happened related to a given project.

In this case it is achieved by using `RailsEventStore` defining the handling of the event in a background job that will take care of creating the relevant Audit and broadcasting that creation via ActionCable, performing live updates in client's browser.

## Questions to be made

- there is no UI / UX done due to the lack of instructions. It would be nice to get some designs or maybe define a frontend framework to use.
- the previous decision would also have an impact in how controllers and views behave e.g. it is decided to have everything (ability to post a comment and project status) on the same screen.

## Deployment

Application is deployed to Heroku and available at https://homey-36e96b9d1a4b.herokuapp.com/

To access the app you can simply login by using the following credentials:
- user: test@test.com
- password: admin123
