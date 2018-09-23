resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "MSR-test-Instance-1" {
  ami = "${var.AMIS}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"

  provisioner "remote-exec" {
    inline = [
      "echo '127.0.0.1 ${var.server_hostname1}' | sudo tee -a /etc/hosts",
      "sudo hostnamectl set-hostname ${var.server_hostname1}",
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_instance" "MSR-test-Instance-2" {
  ami = "${var.AMIS}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"

  provisioner "remote-exec" {
    inline = [
      "echo '127.0.0.1 ${var.server_hostname2}' | sudo tee -a /etc/hosts",
      "sudo hostnamectl set-hostname ${var.server_hostname2}",
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

