# Terrashine in Docker
[Terrashine](https://github.com/Isawan/terrashine) is a Terraform provider mirror implementation that works by automatically caching dependencies as providers are requested.

This project allows you to run Terrashine with a couple of commands and solves the following tasks:
* Bypassing [Hashicorp locks](https://github.com/hashicorp/terraform/issues/30620#issuecomment-1061200339)
* Avoid rate-limits when actively developing in ephemeral CI environments (github has a 60 request per hour rate limit)
* Faster downloads of terraform providers, particularly in CI environments
* Ensuring that terraform providers don't disappear if the source has been deleted

### Requirements
- make
- Docker
- git

### Launch
Get Tor bridges from the Telegram bot [@GetBridgesBot](https://t.me/GetBridgesBot).

Go to the server and execute the commands:
```bash
make gen # Set {{ domain_name }} and 4 Tor bridges
make run
make seed
```

The mirror will be available at `https://tf.{{ domain_name }}/`.

### Use
Go to your work computer.

Set terraform configuration `~/.terraformrc`:
```
provider_installation {
  network_mirror {
    url = "https://tf.{{ domain_name }}/"
  }
}
```

Initialize the Terraform workspace in the project folder:
```bash
terraform init
```
