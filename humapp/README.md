# IIOT Case Study - Humidity Application

The case study:
- 
This application is a sample template of an application which connects with [IOP-PPC](https://www.production-control-center.de/). It consists of a user module which takes its values from ioppcc.

Before you use it to build a new application make sure to generate new credentials for new application and save them in credentials.yml.enc. Sample instructions to update the credentials can be found here [link](https://stackoverflow.com/questions/48372338/create-fresh-rails-5-credentials-on-clone)

Following are the values should be there in credentials:
```
# omniauth credentials
DOORKEEPER_APP_ID: *get_from_iopppc_admin* # ID for your app registered at the provider
DOORKEEPER_APP_SECRET: *get_from_iopppc_admin* # Secret
DOORKEEPER_APP_URL: https://www.production-control-center.de/ # URL to the provider

# rails secret
secret_key_base: *it_will_be_included_in_new_generated_credentials*
```
