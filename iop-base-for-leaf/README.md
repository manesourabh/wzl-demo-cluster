# WZLAPP README

This application will serve as a base application for many future applications.
It will have user authorization functionalities. It is expected that all the data
of users will be saved on this application and this data can be accessed by
other applications by using OAuth2.0 protocol.

This application is developed using Rails(ruby on rails) framework. Development
and test database is sqlite3 and for production we postgresql. We use bootstrap
as a front end library.

## Link to API documentation
https://www.getpostman.com/collections/63e0fe205991e4991f7d

## Basic requirements version
  - ruby 2.6.5
  - rails 5.2.1
  - for other dependencies please refer gemfile


## System dependencies
  We recommend using linux OS as it is much easier to do install and manage
  above dependencies compared to windows. If you want to use windows, we
  refer following link to install these dependencies on windows 10 using
  windows subsystem for linux (WSL):
  Link: https://gorails.com/setup/windows/10 )

## Configuration

## Setting up:
  clone the project using:
  ```
  git clone https://git.rwth-aachen.de/crd-b3/wzlapp.git
  ```
  install all other dependencies
  cd wzlapp
  ```
  bundle install
  ```
  make sure all dependencies were installed properly
  ```
  rails db:migrate
  ```
  start server
  ```
  rails server
  ```



## Database Connection
  Database connection credentials are saved in credentials.yml.enc file, which
  is an encrypted file.
  To edit theses credentials you will need a master key which you have to save
  in file named config/master.key . Then run the following command in terminal
  to edit the encrypted file:
    'EDITOR="atom --wait" rails credentials:edit'

## Deployment instructions:
  Database related secrets are stored in 'credentials.yml.enc'
  use elasticbeacnstalk's cli for deployment
  ```
  rails server
  ```  ```
  rails server
  ```  ```
  rails server
  ```
## ...
