10 Steps to Deploy and Configure Jenkins on AWS with Terraform

Think of how cool it would be to have a Jenkins Server in your own AWS Account!
Jenkins.io has a great tutorial on how to stand up a Jenkins on AWS — but it requires manual configuration through the console.

In this article, I’ll demonstrate how to use Terraform to automate the deployment of your Jenkins services with a single command. The code is also available on Github as a template!

If you’re interested in using the template repository, configuring 3 or 4 variables, and deploying, then head over to the Github template repository and complete the steps in the README.md.

If you’re still following, I’ll proceed with details of how you can build the Terraform solution by hand.

Step 1: Set Up your Repository
Initialize a new repository and create a main.tf , variables.tf , outputs.tf , and a vars/dev-east.tfvars file, or use this Terraform starter repository here: https://github.com/gsweene2/terraform-starter-repo

Your directory should look like this:


Directory Structure
Step 2: Define your Security Group
You’ll need to create a Security Group with:

Inbound SSH access over port 22 from your personal machine’s IP
Inbound TCP access over port 8080 from your personal machine’s IP
Outbound access anywhere to download Jenkins packages
This equates to the following resource block in your main.tf file:


Terraform Resource Block for the AWS Security Group
Step 3: Use the Data Source to determine AMI
Next, you’ll want an automated solution to find the latest Amazon Linux hvm AMI. To do this, you can utilize the aws_ami data block and filters to find the latest AMI from Amazon we want to use for your EC2 Instance.

You can use the filter to filter on name, virtualization type, and root-device-type, and specify the owner.

This equates to the following data block in your main.tf file:


Terraform Resource Block for the AMI
Step 4: Define an EC2 Instance
In this case, you’ll be deploying a single Jenkins server (no Autoscaling Group, etc.), so you can use terraform’s aws_instance resource.

This needs to be configured with:

The AMI determined from the Data Source
The instance type
A keypair that you already own (to ssh)
The Security Group already created
A User Data script that will be defined in a later step
This equates to the following resource block in your main.tf file:


Terraform Resource Block for the AWS Instance
Step 5: Write the User Data Script to install Jenkins
User Data can be executed on the AWS Instance upon startup. This can save time and the manual effort of installing and configuring Jenkins. These steps are directly from the Jenkins.io article, but altogether it looks like this:

You can add this as a file called install_jenkins.sh in the root of your repository.

This equates to the following in your install_jenkins.sh file:


Install Jenkins on Amazon Linux script
Step 6: Apply the Terraform!
Now that everything is configured, you can run the init , plan , and apply commands.

terraform init
terraform plan -var-file="vars/dev-east.tfvars"
terraform apply -var-file="vars/dev-east.tfvars"
Step 7: SSH onto Jenkins and get the Initial Admin Password
When the instance is up, you can go to http://<public_instance_dns>:8080 and you should see a screen to unlock Jenkins.


The Unlock Jenkins screen
chmod 400 <keypair>
ssh -i <keypair> ec2-user@<public_dns>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Paste in the admin password, and you should be presented with a screen to begin customizing Jenkins.

Step 8: Customing Jenkins and adding an Admin User

Customize Jenkins Screen
I chose to Install the suggested plugins.


Jenkins installing the recommended plugins.
When the process is finished, you can create an admin user.


The screen to create an admin user
Finally, your Jenkins should be ready to use!


Jenkins is ready!
And from this screen, you can hook it up to a repo with a Jenkinsfile!


The Jenkins Homepage
Step 9: Configure Plugin for EC2 Agents
Navigate to the Plugin Manager and search for the Amazon EC2 Plugin. Select the checkbox, and select “Install without Restart.”


Step 10: Configure Cloud Credentials for Agents
Finally, navigate to Configure Clouds and select Amazon EC2. You’ll need to fill out the appropriate fields based on your credentials.

Provide the following for the Amazon EC2 Cloud configuration:

A Name to identify your cloud
Add Credentials, and specify AWS Credentials
The region of your choice
The desired keypair
AMI for Agents
