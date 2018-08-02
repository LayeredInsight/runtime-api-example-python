[![Docker Pulls](https://img.shields.io/docker/pulls/layeredinsight/runtime-python-client.svg?style=plastic)](https://hub.docker.com/r/layeredinsight/runtime-python-client/)

# Runtime client API scripts
This is a collection of python scripts leveraging our Swagger library
to interact with the LI Witness/Control API server. They're intended
to be an example of what's possible, and a starting point...

## Usage
### We recommend using virtualenv with Python
We're fans of not polluting our systems to install python libraries. [Virtualenv](https://virtualenv.pypa.io/en/stable/) helps with this:
```
pip install virtualenv
```
`cd` to this source directory, or wherever you want to store a virtual environment and initialize a new virtual Python environment with...

```
virtualenv venv
. venv/bin/activate
```
Now any libraries you install with pip will be local to this environment, accessible only after sourcing `venv/bin/activate`

### Install the Runtime Python API library and dependencies
From this source directory, run

```
pip install layint-runtime-api
pip install -r requirements.txt
```

### Set environment variables for your installation
```
export LI_API_KEY=ApiKey:demo:setanapikey
export LI_API_HOST=http://localhost/v0.01
```

## Finally, run the scripts
```
li_add_registry --name test2 --url=internal-registry.corp --type dtr --verbose
```

## Examples
[Script and CI pipeline examples](examples/README.md)
