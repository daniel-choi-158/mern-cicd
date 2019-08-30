// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 //zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

 metadata = {
   ssh-keys = "dchoi5:${file("~/.ssh/google_compute_engine.pub")}"
 }

 network_interface {
    # This will result in VM using custom network
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
    // Include this section to give the VM an external ip address
    }
  }

  // Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

provisioner "file" {
    source      = "app/app.py"
    destination = "/tmp/app.py"
    connection {
      host = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
      type     = "ssh"
      user = "dchoi5"
      private_key = "${file("~/.ssh/google_compute_engine")}"
      timeout = "5m"
      agent = "false"
    }  
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/app.py",
      "nohup /tmp/app.py & > /tmp/app.txt"
    ]

      connection {
      host = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
      type     = "ssh"
      user = "dchoi5"
      private_key = "${file("~/.ssh/google_compute_engine")}"
      timeout = "5m"
      agent = "false"
    }  
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
 name    = "terraform-firewall"
 network = "${google_compute_network.vpc_network.self_link}"

 allow {
   protocol = "tcp"
   ports    = ["5000","22"]
    }
}

// A variable for extracting the external ip of the instance
output "ip" {
 value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}