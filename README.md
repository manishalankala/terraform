

1.USE MODULES TO AVOID REPETITIVE WORK

Modules in Terraform allow you to reuse predefined resource structures. 
Using modules will decrease the snowflake effect and provide a great way to reuse existing infrastructure code.
Modules have some variables as inputs, which are located in different places (eg. A different folder, or even a different repository). 
They define elements from a provider and can define multiple resources in themselves.
Modules are called using the module block in our Terraform configuration file, variables are defined according to the desired requirement.

