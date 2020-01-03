# Application Architecture

The server-info-app application consistes of a UI component and an API component. The UI component is a static website hosted on an Nginx server. The API is a Python Flask API packaged as a WSGI app hosted on the same Nginx server.

## `server-info-app-ui`

* web-based UI built with React.js
* packaged as a static zip
* deployed to an Nginx server
* retrieves dynamic data from the RESTful API exposed by `server-info-app-api`
* see **https://github.com/briandesousa/server-info-app-ui**

## `server-info-app-api`

* RESTful API built with Python and the Flask framework
* packaged as a WSGI app
* deployed to an Nginx server
* see **https://github.com/briandesousa/server-info-app-api**