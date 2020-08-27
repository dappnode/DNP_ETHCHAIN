⚠️This repo has been deprecated since now the Ethereum clients can be installed independently⚠️

# DAppNode Package ETHCHAIN (Core)

[![Website dappnode.io](https://img.shields.io/badge/Website-dappnode.io-brightgreen.svg)](https://dappnode.io/)
[![Documentation Wiki](https://img.shields.io/badge/Documentation-Wiki-brightgreen.svg)](https://docs.dappnode.io)
[![GIVETH Campaign](https://img.shields.io/badge/GIVETH-Campaign-1e083c.svg)](https://donate.dappnode.io)
[![RIOT DAppNode](https://img.shields.io/badge/RIOT-DAppNode-blue.svg)](https://riot.dappnode.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/espadrine.svg?style=social&label=Follow)](https://twitter.dappnode.io)

Dappnode package responsible for providing the Ethereum blockchain service.

Actually based on version v1.9.8 of [Geth](https://github.com/ethereum/go-ethereum/releases/tag/v1.9.8) and version v2.5.11-stable of [Parity](https://github.com/paritytech/parity/releases/tag/v2.5.11)

It is an AragonApp whose repo is deployed at this address: [0x30a933d920bc4a71a446a0f15f0e80eaf2383fc9 ](https://etherscan.io/address/0x30a933d920bc4a71a446a0f15f0e80eaf2383fc9) and whose ENS address is: [ethchain.dnp.dappnode.eth](https://etherscan.io/enslookup?q=ethchain.dnp.dappnode.eth])

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- git

  Install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) commandline tool.

- docker

  Install [docker](https://docs.docker.com/engine/installation). The community edition (docker-ce) will work. In Linux make sure you grant permissions to the current user to use docker by adding current user to docker group, `sudo usermod -aG docker $USER`. Once you update the users group, exit from the current terminal and open a new one to make effect.

- docker-compose

  Install [docker-compose](https://docs.docker.com/compose/install)

**Note**: Make sure you can run `git`, `docker ps`, `docker-compose` without any issue and without sudo command.

### Building

```
$ git clone https://github.com/dappnode/DNP_ETHCHAIN.git
```

```
$ docker-compose build
or
$ docker build --rm -f build/Dockerfile -t dnp_ethchain:dev build
```

## Running

### Start

```
$ docker-compose up -d
```

### Stop

```
$ docker-compose down
```

### Status

```
$ docker-compose ps
```

### Logs

```
$ docker-compose logs -f
```

**Note**:
There is a time drift issue on Docker for Mac, to solve it try running [Fixing Time drift issue on Docker for Mac](https://blog.shameerc.com/2017/03/quick-tip-fixing-time-drift-issue-on-docker-for-mac):

```
$ docker run --rm --privileged alpine hwclock -s
```

## Generating a tar.xz image

[xz](https://tukaani.org/xz/) is required

```
$ docker save dnp_ethchain:dev | xz -e9vT0 > dnp_ethchain_dev.tar.xz
```

You can download the latest tar.xz version from here [releases](https://github.com/dappnode/DNP_ETHCHAIN/releases).

### Loading a Docker image

```
$docker load -i dnp_ethchain_dev.tar.xz
```

## Contributing

Please read [CONTRIBUTING.md](https://github.com/dappnode/DAppNode/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/dappnode/DNP_ETHCHAIN/tags).

## Authors

- **Eduardo Antuña Díez** - _Initial work_ - [eduadiez](https://github.com/eduadiez)

See also the list of [contributors](https://github.com/dappnode/DNP_ETHCHAIN/contributors) who participated in this project.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details

## References

[git](https://git-scm.com/)

[docker](https://www.docker.com/)

[docker-compose](https://docs.docker.com/compose/)

[Parity](https://www.parity.io/)
