
#### Ubuntu 16.04 ccminer Docker image and accompanying ansible deployment

The docker image contains a [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) base as well as the ccminer application (see [Dockerfile](./Dockerfile). NVIDIA CUDA drivers are 
included in the ansible deployment, as they are required on the host.

#### Caveats:
 - This bundle requires GPU instances on AWS to support ccminer.
 - Ubuntu 16.04 needs to be provisioned with python 2 in order to properly connect.

#### Prerequisites:
 Just make sure you have a provisioned server and an inventory set up correctly.

#### To Run:
```
ansible-playbook -i some_inventory deploy.yml -e "ccminer_user=<YOUR_USER> ccminer_password=x
```

#### ccminer Configuration:
Ccminer runtime configuration is set via the configuration template file in the ccminer ansible role [config file](./ansible/roles/ccminer/templates/ccminer.conf). You must specify the extra variables either through
modifying a local vars file and including it within the deploy.yml file, or else pass them through the command line as shown above. Not all settings are currently
configured. Pull requests are welcome.
