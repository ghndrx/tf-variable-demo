Terraform offers various methods for providing input variables, each with a specific priority that determines the final value assignment. Understanding these priorities can help you choose the most suitable method for your needs and preferences.

Here is a summary of the variable input methods in order of priority, from highest to lowest:

Command-line flags (-var):
These flags have the highest priority, meaning that values provided using -var will override any other method.
Example:

```terraform apply -var="project_id=$PROJECT_ID" -var="region=us-central1" -var="zone=us-central1-f" -var="image_name=debian-cloud/debian-10" -var="instance_type=n1-standard-4"```

Environment variables (TF_VAR_):
This method takes precedence over auto-loaded variable definition files, variable definition files specified with the -var-file flag, and default values in variable declarations.

Example:

```
export TF_VAR_credentials_file="credentials.json"
export TF_VAR_project_id="$PROJECT_ID"
export TF_VAR_region="us-central1"
export TF_VAR_zone="us-central1-a"
export TF_VAR_image_name="debian-cloud/debian-11"
export TF_VAR_instance_type="n1-standard-1"
terraform apply
```

Auto-loaded variable definition files (.auto.tfvars or .auto.tfvars.json):
Auto-loaded files have priority over variable definition files specified with the -var-file flag and default values in variable declarations.
Example: Two .auto.tfvars files (a.auto.tfvars and b.auto.tfvars) contain different values for project_id. When you run terraform apply, Terraform loads both files, and the final project_id value is taken from b.auto.tfvars.

Variable definition files specified with the -var-file flag (.tfvars or .tfvars.json):
This method has a lower priority than auto-loaded variable definition files but takes precedence over default values in variable declarations.
Example (terraform.tfvars.json):

```
{
  "credentials_file": "credentials.json",
  "project_id": "$PROJECT_ID",
  "region": "us-central1",
  "zone": "us-central1-a",
  "image_name": "debian-cloud/debian-11",
  "instance_type": "n1-standard-1"
}
```

Example (terraform.tfvars):

```
credentials_file = "credentials.json"
project_id       = "$PROJECT_ID"
region           = "us-central1"
zone             = "us-central1-a"
image_name       = "debian-cloud/debian-11"
instance_type    = "n1-standard-1"
```
Default values in variable declarations (within .tf files):
These values have the lowest priority and will only be used if no value is provided through any other method.
Example (variables.tf):

```
variable "project_id" {
  default = "$PROJECT_ID"
}

variable "region" {
  default = "us-central1"
}
```
In summary, Terraform supports various methods for inputting variables, each with a unique priority that determines the final value assignment. When working with Terraform, it's essential to consider these priorities to ensure the correct values are used during the execution of your Terraform configuration.
