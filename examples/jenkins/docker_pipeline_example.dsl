pipeline {
    agent {
        docker {
            // basic example requires only updated client example scripts (should work with current runtime-python-client release)
            // push  example requires api:develop server and updated runtime-python-client 
            image 'layeredinsight/runtime-python-client'

            // add-host only if necessary: e.g. the registy's public IP and port are not routable or open for jenkins slave/node
            args '--add-host api-demo.layeredinsight.net:172.31.3.119 --env LI_API_HOST=http://api-demo.layeredinsight.net/v0.01 --env LI_API_KEY=ApiKey:username:userapikey'
        }
    }
    stages {
        stage('Instrument') {
            steps {
                // precondition: add the image registry and credentials
		// docker.io run once: sh '/layint/li_add_registry -v --name docker.io    --type private --url ""'
                // DTR     - run once: sh '/layint/li_add_registry -v --name dockeree-dtr --type dtr --url "ec2-public-ip.compute-1.amazonaws.com" --username mydtr-user --password mydtr-passwd'
                // AWS ECR - run once: sh '/layint/li_add_registry -v --name aws-ecr      --type ecr --url "account_id.dkr.ecr.aws-region.amazonaws.com" --username aws_access_key_id --password aws_secret_access_key' 
                
                // 'li' wrapper checks for and uses 'ash' instead of 'bash' if necessary
                sh 'cd /layint && ./li ./li_instrument api-demo.layeredinsight.net/username/alpine:latest'

                // push example:  pull from public and push to private 
                //  - @param1 the imageName needs the 'docker.io' registry added to LI. 'alpine:latest' by itself will not work
                //  - @param2 the push-registry is the registry's LI-Name and not the registry's real FQDN
                //    We recommend using the FQDN for both the registry.name and registry.url to avoid ambiguity/bugs
                // sh 'cd /layint && ./li ./li_instrument docker.io/alpine:latest api-demo.layeredinsight.net username/alpine:latest'
            }
        }
    }
}
