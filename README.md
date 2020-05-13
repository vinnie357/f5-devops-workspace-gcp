# gce-devops-workspace-tf-cloud
On demand Workspace for Terraform and Ansible in Google Cloud Platform on Ubuntu

# Prerequisites:

- ## Terraform Cloud
    [Terraform Cloud Account](https://app.terraform.io/)

- ## GCE service Account
    [GCP Service account with key](https://console.cloud.google.com/iam-admin/serviceaccounts/)

# Overview:
 
## Create project in Terraform Cloud
## Create workspace in Terraform Cloud
## Fork this repo for your edits and builds.
## Link Terraform Cloud to the repo for githooks
## Create gcp service account and key for Terraform Cloud
 - login to gcp and issue a service account with permissions to your project

## set project variables for Terraform Cloud project
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

- repositories
    - Comma seperated list of repositories to clone
        
        example: "https://github.com/f5devcentral/terraform-aws-f5-sca.git,https://github.com/f5devcentral/terraform-aws-bigip.git"
- onboardScript
    - url for onboard script

        example: "https://raw.githubusercontent.com/vinnie357/workspace-onboard-bash-templates/master/terraform/gcp/sca/onboard.sh"
        
## queue a run of the project


## Connect with VS Code Remote Development
- https://code.visualstudio.com/docs/remote/remote-overview

    Open Extensions menu: 

    ![alt text][vscodeExtensions]

    [vscodeExtensions]: images/vscodeExtensions.PNG "vscode extensions"

    Add Remote Devpack Extensions: 

    ![alt text][devPack]

    [devPack]: images/remoteDevPack.PNG "Remote Dev Pack"

    Configure Remote SSH extension: 

    ![alt text][remoteExt] ![alt text][remoteConfig]

    ![alt text][sshConfig]

    [remoteExt]: images/remoteIcon.PNG "Remote SSH icon"

    [remoteConfig]: images/remoteConfig.PNG "Remote SSH config"

    [sshConfig]: images/sshConfigGCE.PNG "SSH config"

## Optional Extensions
- https://marketplace.visualstudio.com/items?itemName=mauve.terraform

## Known issues
- ssh ids on reapply
    ```bash
        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    ```
    win:
        
        ssh-keygen -f "c:\\Users\\user/.ssh/known_hosts" -R 18.210.163.252
    linux:

        ssh-keygen -f "/root/.ssh/known_hosts" -R 18.210.163.252
- VScode Remote
     
     settings
     
     extensions installed