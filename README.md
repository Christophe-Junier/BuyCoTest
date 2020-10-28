# BuyCoTest

Test in order to integrate BuyCo

## Prerequisites

- docker et docker-compose [Installation help](https://docs.docker.com/compose/install/)

## Installation steps

- firsty, build the app with the command:

```bash
  docker-compose build
```

- secondly, run the app with the command:

```bash
  docker-compose up
```

## How to use the app
In order to communicate with the application, you must be able to do some post request at any endpoint of the application.

Some applications that do the job:
- Postman (Chrome browser )
- RESTClient (Firefox browser )
- AdvancedRestClient (Linux Application)

You can also use 'curl', an unix package that can do request.



## API documentation

In order to communicate with the application, your request will need to follow the requirements given below:

### HEADER

Only 'application/json' post request are accepted.

So your request will need to have:

Header-name: Content-type -> Header value: application/json

### BODY

only json datas are accepted, with the following sets of datas:

{
  "id": number,
  "type": (cardboard|wood|metal),
  "locked": boolean,
  "height": number,
  "width": number,
  "depth": number,
  "contents": string,
  "origin": {
    "line1": string,
    "line2": string,
    "city": string,
    "state": string,
    "postal_code": string,
    "country": ISO_3166_alpha3
  }
}

### Exemple

exemple with curl:

```bash
curl -d '{"id": 2, "type": "metal", "locked": true, "height": 1, "width": 1, "depth":2.25, "contents":"some fishs", "origin": {"line1": "27 rue du general foy", "line2": "place de la republique", "city": "Saint Etienne", "state": "france", "postal_code": "42000", "country": "fra"}}' -H "Content-Type: application/json" -X POST http://localhost:8000
```
