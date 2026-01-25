[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![tests](https://github.com/rpkoller/ddev-drupal-contribution/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/rpkoller/ddev-drupal-contribution/actions/workflows/tests.yml?query=branch%3Amain)
[![last commit](https://img.shields.io/github/last-commit/rpkoller/ddev-drupal-contribution)](https://github.com/rpkoller/ddev-drupal-contribution/commits)
[![release](https://img.shields.io/github/v/release/rpkoller/ddev-drupal-contribution)](https://github.com/rpkoller/ddev-drupal-contribution/releases/latest)

# DDEV Drupal Contribution

## Overview

This add-on integrates Drupal Contribution into your [DDEV](https://ddev.com/) project.

## Installation

```bash
ddev add-on get rpkoller/ddev-drupal-contribution
ddev restart
```

After installation, make sure to commit the `.ddev` directory to version control.

## Usage

| Command | Description |
| ------- | ----------- |
| `ddev describe` | View service status and used ports for Drupal Contribution |
| `ddev logs -s drupal-contribution` | Check Drupal Contribution logs |

## Advanced Customization

To change the Docker image:

```bash
ddev dotenv set .ddev/.env.drupal-contribution --drupal-contribution-docker-image="ddev/ddev-utilities:latest"
ddev add-on get rpkoller/ddev-drupal-contribution
ddev restart
```

Make sure to commit the `.ddev/.env.drupal-contribution` file to version control.

All customization options (use with caution):

| Variable | Flag | Default |
| -------- | ---- | ------- |
| `DRUPAL_CONTRIBUTION_DOCKER_IMAGE` | `--drupal-contribution-docker-image` | `ddev/ddev-utilities:latest` |

## Credits

**Contributed and maintained by [@rpkoller](https://github.com/rpkoller)**
