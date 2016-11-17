# Public subnets in VPC Terraform Module
========================================

A Terraform module to create public subnets in VPC in AWS.

If you want to create public and private subnets using single module you can use [tf_aws_vpc module](https://github.com/terraform-community-modules/tf_aws_vpc).


Module Input Variables
----------------------

- `name` - Name (optional)
- `vpc_id` - VPC id
- `igw_id` - Internet gateway id
- `cidrs` - List of VPC CIDR blocks
- `azs` - List of availability zones
- `map_public_ip_on_launch` - Should be true or false (optional, default is true)

Usage
-----

```js
module "public_subnet" {
  source = "github.com/terraform-community-modules/tf_aws_public_subnet"

  name   = "production-public"
  cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  azs    = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_id = "vpc-12345678"
  igw_id = "igw-12345678"
}
```

Outputs
=======

- `subnet_ids` - Lst of subnet ids
- `public_route_table_ids` - List of route table ids

Authors
=======

Originally created and maintained by [hashicorp/atlas-examples](https://github.com/hashicorp/atlas-examples/tree/master/infrastructures/terraform/aws/network/public_subnet).
Hijacked by [Anton Babenko](https://github.com/antonbabenko).

License
=======

Apache 2 Licensed. See LICENSE for full details.