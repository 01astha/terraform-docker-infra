//Docker network
resource "docker_network" "app_network" {
  name = "${var.network_name}-${terraform.workspace}"
}

resource "docker_volume" "db_data" {
  name = "db_data-${terraform.workspace}"
}

//PostgreSQL container
resource "docker_container" "db" {
  name  = "postgres-db-${terraform.workspace}"
  image = var.db_image

  restart = "unless-stopped"

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.db_user}"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

//Backend container
resource "docker_container" "backend" {
  name  = "backend-app-${terraform.workspace}"
  image = "nginxdemos/hello"

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.db]
}

//Nginx container
resource "docker_container" "web" {
  name  = "nginx-web-${terraform.workspace}"
  image = "nginx:latest"

  ports {
    internal = 80
    external = var.web_port
  }


  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.backend]
}
