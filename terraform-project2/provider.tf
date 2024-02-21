terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws"{
  region = "us-east-1"
  access_key="ASIAVFPQX52OS4YSMD7K"
  secret_key="z7SwGx6/cNyvCGYnU1YUNlGOjYH+A6IFJVQHrIo1"
  token="FwoGZXIvYXdzEGwaDPpQS3hkBShWrHApDiKvAQT1czWE0Ng5Nd1mCZfmo2AjNPbdPxTTcx+dNyXXBpigsprAqxKJITMfmCkVg0ifIdTmtH3YRfCNfIbWP5BFkJmt+WdkvllxLjefOflu4bSiYTUFdOsQQbeJ2lXktVSmbZK13+9yu0KDVA97V4S0Lzc1tTRJGrC1ACjJamloxC1p3ztkAl6/qH98354NHPkIQTpXcDV6hv4nNDdYWd2qqjB1W+D/HI5aXCUhw84ne9Mogq/XrgYyLcJGoiJBHBWag4bMMe+yzUNQzZAO/5qOcQkxmF6hSf1NW682ncchPJUhuZOykg=="
}