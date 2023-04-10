Terraform offers various methods to provide input variables, making it flexible and adaptable to different use cases. These methods include command-line flags, environment variables, variable definition files (including auto-loaded files), and default values in variable declarations.

Auto-loaded variable definition files:
Terraform automatically loads files with .auto.tfvars or .auto.tfvars.json extensions, without the need for the -var-file flag. They are loaded alphabetically, with later files potentially overwriting earlier ones.
Example: Two .auto.tfvars files (a.auto.tfvars and b.auto.tfvars) contain different values for project_id. When you run terraform apply, Terraform loads both files, and the final project_id value is taken from b.auto.tfvars.

Command-line flags:
Using the -var flag, you can pass variables directly to the terraform apply or terraform plan commands. This method is useful for passing sensitive data or for quick testing purposes.
Example:


terraform apply -var="project_id=variable-tf-demo" -var="region=us-central1"

Environment variables:
Set Terraform variables using environment variables by following the naming convention TF_VAR_variable_name. This method is useful for storing sensitive data or when using CI/CD pipelines.

Example:


```
export TF_VAR_project_id="variable-tf-demo"
export TF_VAR_region="us-central1"
terraform apply
```

Variable definition files (.tfvars):
Use .tfvars or .tfvars.json files to store variable values. Terraform loads all such files in the working directory by default, or you can specify a file using the -var-file flag.

Example (terraform.tfvars):

```
credentials_file = "credentials.json"
project_id       = "variable-tf-demo"
region           = "us-central1"
zone             = "us-central1-a"
image_name       = "debian-cloud/debian-11"
instance_type    = "n1-standard-1"
```
Default values in variable declarations:
Provide default values for variables directly in the variable declaration block in your .tf files. If a value is not provided through any other method, the default value will be used.

Example (variables.tf):

```
variable "project_id" {
  default = "variable-tf-demo"
}

variable "region" {
  default = "us-central1"
}
```
In summary, Terraform supports various methods to input variables, each with its own use case. You can choose the method that best suits your needs and preferences.