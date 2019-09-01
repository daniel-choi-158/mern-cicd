// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = "${google_compute_network.vpc_network.self_link}"
  target_tags   = ["docker-node"]
  allow {
   protocol = "tcp"
   ports    = ["5000","22","80","2376"]
    }
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
  //count = 1
  //name = "webapp-${count.index}"
  name = "webapp-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  tags = ["docker-node"]

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-10"
   }
 }

 metadata = {
   ssh-keys = "dchoi5:${file("~/.ssh/google_compute_engine.pub")}"
   /*
   startup-script = <<SCRIPT
    ${file("scripts/install_dependencies.sh")}
    ${file("scripts/install_docker_mint_xenial.sh")}
    SCRIPT
    */
 }
/*
 metadata_startup_script = <<SCRIPT
    "${file("scripts/install_dependencies.sh")}"
    "${file("scripts/install_docker_mint_xenial.sh")}"
    SCRIPT
*/
 network_interface {
    # This will result in VM using custom network
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }

  // Make sure flask is installed on all new instances for later steps
 //metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; sudo apt-get install yum -y; sudo yum update -y"

provisioner "file" {
    source      = "apps"
    destination = "/tmp"
  }

provisioner "remote-exec" {
    scripts = [
      //"scripts/install_dependencies.sh",
      "scripts/install_docker_mint_xenial.sh",
      //"scripts/deploy_docker_nginx.sh",
      "scripts/deploy_docker_mern_cicd.sh"
    ]
}

connection {
      host = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
      type = "ssh"
      user = "dchoi5"
      private_key = "${file("~/.ssh/google_compute_engine")}"
      agent = "false"
  }
}


// A variable for extracting the external ip of the instance

output "ip" {
   value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"

}