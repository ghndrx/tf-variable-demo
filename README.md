In Terraform, there are several ways to input variables: through command-line flags, environment variables, or files. 

Command-line flags:
You can pass variables directly to the terraform apply or terraform plan command using the -var flag. This method is useful for passing sensitive data or for quick testing purposes.
Example:


terraform apply -var="project_id=variable-tf-demo" -var="region=us-central1"
Environment variables:
You can use environment variables to set Terraform variables by following the naming convention TF_VAR_variable_name. This method is useful for storing sensitive data or when using CI/CD pipelines.
Example:


```export TF_VAR_project_id="variable-tf-demo"
export TF_VAR_region="us-central1"```

terraform apply

Variable definition files (.tfvars):
You can use .tfvars or .tfvars.json files to store variable values. By default, Terraform loads all files with the .tfvars or .tfvars.json extension in the working directory. You can also specify a file using the -var-file flag.

Example (terraform.tfvars):


```credentials_file = "credentials.json"
project_id       = "variable-tf-demo"
region           = "us-central1"
zone             = "us-central1-a"
image_name       = "debian-cloud/debian-11"
instance_type    = "n1-standard-1"```

Default values in variable declarations:
You can provide default values for variables directly in the variable declaration block in your .tf files. If a value is not provided through any other method, the default value will be used.
Example (variables.tf):


```variable "project_id" {
  default = "variable-tf-demo"
}

variable "region" {
  default = "us-central1"
}```

In summary, Terraform provides flexibility in how you input variables by supporting command-line flags, environment variables, variable definition files, and default values in variable declarations. Each method has its own use case and can be chosen based on your needs and preferences.

Terraform automatically loads variable definition files if their filenames end with either .auto.tfvars or .auto.tfvars.json. You don't need to use the -var-file flag to load these files. They are loaded in alphabetical order, and the values defined in later files will overwrite those from earlier files if there's any overlap.

Here's an example:

Let's say you have two .auto.tfvars files in your working directory:

a.auto.tfvars:

```project_id = "variable-tf-demo-a"
region     = "us-central1"
b.auto.tfvars:

project_id = "variable-tf-demo-b"
zone       = "us-central1-a"```

When you run terraform apply, Terraform will automatically load both files in alphabetical order. The final variable values will be:

```project_id: "variable-tf-demo-b" (from b.auto.tfvars, as it overwrites the value from a.auto.tfvars)
region: "us-central1" (from a.auto.tfvars)
zone: "us-central1-a" (from b.auto.tfvars)```

Using auto-loaded .tfvars files can be helpful for organizing your variable values and keeping your Terraform configurations clean and modular.