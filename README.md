# Terrashine in Docker
A terraform provider mirror implemented as a caching proxy in Docker. [Terrashine](https://github.com/Isawan/terrashine) is a terraform provider mirror implementation that works by automatically caching dependencies as providers are requested.

Use cases:
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
make gen # Set domain name and 4 Tor bridges
make run
make seed
```

Set terraform configuration `~/.terraformrc`:
```
provider_installation {
  network_mirror {
    url = "https://tf.{{ domain_name }}/"
  }
}
```

Initialize your Terraform workspace:
```bash
terraform init
```
