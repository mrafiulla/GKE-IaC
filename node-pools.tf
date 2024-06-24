# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
#resource "google_service_account" "kubernetes" {
#  account_id = "project-service-account@rafi-sandbox-rafi.iam.gserviceaccount.com"
#}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.test-cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"
    #service_account = "${file("./creds/serviceaccount.json")}"
    labels = {
      role = "general"
    }

   # service_account =  google_service_account.kubernetes.email
   # service_account = "${file("./creds/serviceaccount.json")}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name    = "spot"
  cluster = google_container_cluster.test-cluster.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    #service_account = "${file("./creds/serviceaccount.json")}"
    labels = {
      team = "devops"
    }

    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    #service_account = project-service-account@rafi-sandbox-rafi.iam.gserviceaccount.com
    # service_account = "${file("./creds/serviceaccount.json")}"
     oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}