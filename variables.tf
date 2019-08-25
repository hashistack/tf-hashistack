variable "env_names" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "dev",
    tst = "test",
    stg = "staging",
    prd = "prod",
  }
}

variable "env_dns_zones_prefix" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "dev."
    tst = "test."
    stg = "staging."
    prd = ""
  }
}

variable "domain" {
  type = string

  default = "veber.cloud"
}

variable "application" {
  type = string

  default = "hashistack"
}

# VPC
variable "vpc-cidr_block" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "10.0.48.0/20",
    tst = "10.0.32.0/20",
    stg = "10.0.16.0/20",
    prd = "10.0.0.0/20",
  }
}

variable "vpc-az_redundancy" {
  type = object({ dev = number, tst = number, stg = number, prd = number })

  default = {
    dev = 3,
    tst = 3,
    stg = 3,
    prd = 3,
  }
}

# bastion
variable "bastion-public_key" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    tst = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    stg = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    prd = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
  }
}

variable "bastion-instance_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "t2.micro",
    tst = "t2.micro",
    stg = "t2.micro",
    prd = "t2.micro",
  }
}

variable "bastion-spot_price" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = 0.0040,
    tst = 0.0040,
    stg = 0.0040,
    prd = 0.0040,
  }
}

variable "bastion-root_block_device-delete_on_termination" {
  type = object({ dev = bool, tst = bool, stg = bool, prd = bool, })

  default = {
    dev = true,
    tst = true,
    stg = true,
    prd = true,
  }
}

variable "bastion-root_block_device-volume_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "gp2",
    tst = "gp2",
    stg = "gp2",
    prd = "gp2",
  }
}

variable "bastion-root_block_device-volume_size" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = 8,
    tst = 8,
    stg = 8,
    prd = 8,
  }
}

# scheduler
variable "scheduler-public_key" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    tst = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    stg = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    prd = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
  }
}

variable "scheduler-instance_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "t2.micro",
    tst = "t2.micro",
    stg = "t2.micro",
    prd = "t2.micro",
  }
}

variable "scheduler-spot_price" {
  type = object({ dev = number, tst = number, stg = number, prd = number })

  default = {
    dev = 0.0040,
    tst = 0.0040,
    stg = 0.0040,
    prd = 0.0040,
  }
}

variable "scheduler-root_block_device-delete_on_termination" {
  type = object({ dev = bool, tst = bool, stg = bool, prd = bool, })

  default = {
    dev = true,
    tst = true,
    stg = true,
    prd = true,
  }
}

variable "scheduler-root_block_device-volume_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "gp2",
    tst = "gp2",
    stg = "gp2",
    prd = "gp2",
  }
}

variable "scheduler-root_block_device-volume_size" {
  type = object({ dev = number, tst = number, stg = number, prd = number })

  default = {
    dev = 8,
    tst = 8,
    stg = 8,
    prd = 8,
  }
}

# node
variable "node-public_key" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    tst = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    stg = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
    prd = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPFiT+q+IcL0xlsas6UccTRzroBY0/IjbTG1Y3Uv1CUgShKiZlBhqcif3noKS1WK7qt5MjWZEaf8bU4ZxBPTHdkqYxFmoaKFwoYHieA5ozBj6oVi5KUxwGOKLHeLO75JNqSv4igEfrKaQvwuiih4pvSlHQiph/HHwJIU5h3Q7tO3Dcc2nd0I2sGDB3+KTiRTghN9oJOzVf5Qnb8KJ0IcAlk8ECUB3EqHrA9hmd/uHD3odqPhb6EK5Znyyq0zjY8uwZQn8A6ciabV6W7YWv/036bqwVqPCykWLJ4NQ52t82XYQ6kPlbl7gZkQ1nJM9gpZFFSDi7qOsTqez+CDzZ60z8pK97i2yml2PDT7w72DGnaLcPktcT0jrTp6F9qOxCZkFp83+92cQ8a+CETO+oiCJCdxXGLGU+L818swSkW+Bw1zKnDrfLpafTbpNTr34xxdbpECh+GNz04xIw9liIuvT26/6wX4enju9FXo19ExJ+++0ZNushEbf3k9NNGKpRM+WrfMi8sXWRFP2t2nnTMKKnG6LTDY2MfCEWw4w/2CKyhgOWMLSK/71bGO9n8q2W4e46ewWokY8RukXqyeySJjHO7iHgN5j7AS5gFHuUwr/45RM2DFOgkX1xaWcdLVvhUY6xlQjmF5WZEoeCUhBkVOFodVs2UJ7E4g6nGo1tWoAbPQ==",
  }
}

variable "node-instance_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "t2.micro",
    tst = "t2.micro",
    stg = "t2.micro",
    prd = "t2.micro",
  }
}

variable "node-spot_price" {
  type = object({ dev = number, tst = number, stg = number, prd = number })

  default = {
    dev = 0.0040,
    tst = 0.0040,
    stg = 0.0040,
    prd = 0.0040,
  }
}

variable "node-root_block_device-delete_on_termination" {
  type = object({ dev = bool, tst = bool, stg = bool, prd = bool, })

  default = {
    dev = true,
    tst = true,
    stg = true,
    prd = true,
  }
}

variable "node-root_block_device-volume_type" {
  type = object({ dev = string, tst = string, stg = string, prd = string })

  default = {
    dev = "gp2",
    tst = "gp2",
    stg = "gp2",
    prd = "gp2",
  }
}

variable "node-root_block_device-volume_size" {
  type = object({ dev = number, tst = number, stg = number, prd = number })

  default = {
    dev = 8,
    tst = 8,
    stg = 8,
    prd = 8,
  }
}
