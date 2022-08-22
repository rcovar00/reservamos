# Reservamos REST API

API that provides the weather forecast for the following days of a given city.

This API connects to Reservamos service to find the coordinates of a place and returns the weather information using OpenWeather's API.

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

## Built With

* [Ruby on Rails](https://rubyonrails.org/)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Copy of the project on your local computer

### Installation

Navigate to the application directory and execute: `docker compose up`

## Documentation

The documentation is in the following [Postman Collection](https://documenter.getpostman.com/view/3768095/VUqptHi3#8045b147-7701-400a-97a9-b44365b834a6).

## Features
- Encrypted credentials
- Logging of request exceptions
- Easy integration of new services to get locations and weather forecast
- Handling service interruptions of third-party services
- API versioning
- Tests
- Linter (RuboCop)
- Env variables

## Roadmap
- [ ] Implement cache
- [ ] Return the weather forecast of top cities by default
- [ ] Include optional parameters to modify temperature units and max number of days for weather forecast
- [ ] Rate limiting requests per IP address

