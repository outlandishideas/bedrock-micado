# Bedrock / WordPress / Docker

This project contains the files required to produce an out of the box version of the Bedrock boilerplate
for WordPress in a Docker image. This could then be used as the starting point to produce docker images
for customised Bedrock projects by cloning this project and changing what plugins and themes are installed, and
updating the `config/application.php` to support additional environment variables for additional configuration
options. 

## Building a Docker Image

To build a docker image using the the Bedrock boilerplate as is simply run 

    docker build -t <tag> .
    
This will create a docker image using a multi-stage build. Firstly it will copy in the composer.json and 
composer.lock file and run composer.install. If the composer.json and composer.lock files have not changed
then a cached version of a previous build will be used reducing build time where vendor libraries have 
not changed. The contents of the vendor folder are then copied to a new Docker image without Composer
installed to reduce image size, and then the rest of the project files are copied as well.

## Environment

When using the built docker image in a docker setup, you will also need a web server for the PHP FPM 
to sit behind and a database, which can be run in Docker or on another service.

To run the Docker Image you will need to set some Environment variables in order for it to respond to 
web requests and connect to the database. For full information about the Environment variables, read the 
`roots/bedrock` documentation, but you can use the `.env.example` as a starting point, but you will need 
to set 

    DB_NAME
    DB_USER
    DB_PASSWORD
    DB_HOST
    WP_HOME
    
The `DB_` prefixed environment variables should be self-explanatory, but the `WP_HOME` should be set 
as the URL that the site should be available at, e.g. `https://example.com`.

## Adding new plugins/themes

### Wpackagist

The Bedrock boilerplate comes set up to be able to install plugins and themes from Wpackagist. WPackagist is
a listing of all WordPress plugins and themes that mirrors the listings found on the official WordPress.org
website. To install a plugin run the following command

    composer require wpackagist-plugin/some-plugin
    
    or 
    
    composer require wpackagist-theme/some-theme
    
> If you don't have Composer or PHP installed on your laptop, you can run the `composer` command in a 
docker container using the following command

    docker run --rm --interactive --tty \
        --volume $PWD:/app \
        composer require wpackagist-plugin/some-plugin --ignore-platform-reqs --no-scripts
        
## MICADO

Launching on micado is as simple as running `bin/deploy.sh`, however you will need to update the settings
in `micado/_settings` in order to set the right MICADO_HOST and MICADO_PORT. If not running on AWS you will
also need to update the TOSCA description in order to set the right credentials for running on a different cloud.
If changing the MICADO_HOST, you will also have to change the WP_HOME and NGINX_HOST and NGINX_PORT env vars
in the TOSCA description file.

After launching the app, you will find that the app is available at MICADO_HOST:32349 and the NGINX VTS plugin
output is available at MICADO_HOST:32348/status. The output here will be used for scaling based on the performance
of the NGINX virtualhost under strain