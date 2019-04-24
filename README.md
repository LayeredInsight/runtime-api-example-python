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

*Note:* Mac users can install pip by following https://pip.readthedocs.io/en/stable/installing/

### Install the Runtime Python API library and dependencies
From this source directory, run

```
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
* Add a rule to a policy.
```
# same rule, added as either a File or Syscall rule type, generated rule is the same
./li_add_rule_to_policy --policy-name 'Container 5a7b468efb212f000183a174 behavior' --name 'manual tail open httpd logs' --program '/usr/bin/tail'  --action allow --syscall 2 --arg1 '/var/log/httpd/*'
./li_add_rule_to_policy --policy-name 'Container 5a7b468efb212f000183a174 behavior' --name 'manual tail open httpd logs' --program '/usr/bin/tail'  --action allow --syscall 2 --arg1 '/var/log/httpd/*' --type syscall
```
* Add a set of CSV policy rules to an existing policy
```
./li_add_rule_to_policy --policy-name "Container 5a7b468efb212f000183a174 behavior" --rules-csv only-rules-section.csv --rules-csv-fixed-name 'all added rules have this fixed name'
```
* Remove all rules with a matching name from a policy
```
./li_delete_policy_rule --policy-name "Container 5a7b468efb212f000183a174 behavior" --name 'all added rules have this fixed name'
```
* Add a set of JSON policy rules to an existing policy
```
./li_get_policy -v --policyid 5babd028ebf86600018a4664 | tail -n1 | jq '.rules' > policy_rules.json
./li_add_rule_to_policy --rules-json policy_rules.json --policyid "5babd028ebf86600018a4665"
```
