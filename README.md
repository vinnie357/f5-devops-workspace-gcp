# gce-devops-workspace-tf-cloud
On demand Workspace for Terraform and Ansible in Google Cloud Platform on Ubuntu

# terraform cloud
terraform cloud account
# create project in terraform cloud

# fork this repo for your edits and builds.
link terraform cloud to the repo for githooks

# create gcp service account and key for terraform cloud
login to gcp and issue a service account with permissions to your project

# set project variables for terraform cloud project
! mark items as sensitive for write only access
- projectPrefix
    - project prefix/tag for all object names
    
        example: "mydeployment-"

- serviceAccountFile
    - your json service account [ sensitive]
        
        example: ""

- gcpProjectId
    - the project ID you want to deploy in
        
        example: ""

- gcpRegion
    - the gcp region you want to deploy in
        example: "us-east1"

- gcpZone
    - the gcp zone you want to deploy in
        
        example: "us-east1-b"

- adminSrcAddr
    - ip/mask in cidr formatt for admin access
        
        example: "myexternalip/32"

- adminAccount
    - admin account name ( not admin)

            example: "myuser"
        
- adminPass [ sensitive]
    - your temp password
        
        example: "MysuperPass"
        
- gceSshPubKeyFile [ sensitive]
    - contents of the admin ssh public key file
        
        example: ""

- InstanceCount
    - number of running machines desired default is 1
        
         example: 1
            
- terraformVersion
    - installed terraform version
        
        example: "0.12.23"
        
- terragruntVersion
    - version of terragrunt installed
        
        example: "0.23.4"
        
- repositories
    - Comma seperated list of repositories to clone
        
        example: "https://github.com/f5devcentral/terraform-aws-f5-sca.git,https://github.com/f5devcentral/terraform-aws-bigip.git"
        
# queue a run of the project