# Step 1 Create a VPC

resource "aws_instance" "name" {
  
}
resource "aws_vpc"  myvpc {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyterraformVPC"
    }

}
# Step 2 Create a Public subnet
resource "aws_subnet" "PublicSubnet" {
   vpc_id = aws_vpc.myvpc.id
   cidr_block = "10.0.1.0/24"
}
#step 3 Create a Private Subnet
resource "aws_subnet" "PrivateSubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
}
# Step 4 Create a IGw
    resource "aws_internet_gateway" "MyIGw" {
      vpc_id = aws_vpc.myvpc.id
    }

# Step 5 Route tables for public subnet
    resource "aws_route_table" "PublicRt" {
      vpc_id = aws_vpc.myvpc.id
      route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.MyIGw.id
      }
    }

# Step 6 Route table associate with public subnet
    resource "aws_route_table_association" "PublicRtAssociation" {
        subnet_id = aws_subnet.PublicSubnet.id
        route_table_id =aws_route_table.PublicRt.id
}