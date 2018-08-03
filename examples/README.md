# Runtime client API scripts examples
This is a collection of example usages of the python scripts leveraging our Swagger library

## Registries
* Self signed registry certificate 
```
./li_add_registry --url api-demo.layeredinsight.net --username username --certificate "`cat /etc/docker/certs.d/registry-hostname/ca.crt`" --tls-verify ...
```
* docker private registry
```
./li_add_registry -v --name my-registry  --type private --url IPorFQDN --username user --password passwd
```
* docker.io public (pull only)
```
./li_add_registry -v --name docker.pull  --type docker.io --url "" --username "" --password ""
```
* docker.io private
```
./li_add_registry -v --name docker.io    --type docker.io --url "" --username dockeruser --password dockerpasswd
```
* Docker Trusted Registry 
```
./li_add_registry -v --name dockeree.dtr --type dtr --url ec2-public-ip.compute-1.amazonaws.com --username mydtr-user --password mydtr-passwd
```
* AWS ECR
```
./li_add_registry -v --name aws.ecr      --type ecr --url account_id.dkr.ecr.aws-region.amazonaws.com --username aws_access_key_id --password aws_secret_access_key
```

## Images
* Private registry
```
docker tag alpine:latest api-demo.layeredinsight.net/username/alpine:latest
docker push api-demo.layeredinsight.net/username/alpine:latest

./li_add api-demo.layeredinsight.net/username/alpine:latest
```
* Pull from public, push to private registry
```
./li_add docker.io/alpine:latest api-demo.layeredinsight.net username/alpine:latest
```

## Policies
* Build a behavioral policy from container logs
```
./li_build_policy --containerid 5a7b468efb212f000183a174
```
* Add a rule to a policy
```
\# Add a rule to a container policy (behavior policies by default deny unexpected behavior).
./li_add_rule_to_policy --policy-name 'Container 5a7b468efb212f000183a174 behavior' --name 'allow tail to open httpd logs' --program '/usr/bin/tail'  --action allow --syscall "sys_open" --arg1 '/var/log/httpd/*'
```
* FIXME: broken due to syscall name migration. Add a set of rules from another policy.csv to an existing policy
```
\# echo FIXME ./li_add_rule_to_policy --policy-name "Container 5a7b468efb212f000183a174 behavior" --rules-csv only-rules-section.csv --rules-csv-fixed-name 'all added rules have this fixed name'
```
* Remove all rules with a matching name from a policy
```
./li_delete_policy_rule --policy-name "Container 5a7b468efb212f000183a174 behavior" --name 'all added rules have this fixed name'
```
