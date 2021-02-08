<h1 align="center">Welcome to Flutter-Template-Generator 👋</h1>
<p>
  <a href="https://choosealicense.com/licenses/mit/" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> Template generator which you can use for start of your new Flutter project.

## Requirements
- ack >= 2.22
- perl >= 5
- bash >= 4.4.20
- flutter >= 1.20.0

## Install

```sh
git clone https://github.com/mjablecnik/Flutter-Template-Generator.git
export PATH=$PATH:$(pwd)/Flutter-Template-Generator/bin
```

## Usage

```sh
ftg run           # generate new project in interactive mode
ftg change        # generate new project in sandbox directory for change any template
ftg convert       # convert and save any existing Flutter project into new template
ftg clean         # clean sandbox
ftg help          # get help
```

## Example
![](examples/ftg-example.gif)


## Configuration
You can create your own config file where you can setup the most common informations.<br>
FTG will setup project automatically with informations from config.<br>
For find of your config you need setup `FTG_CONFIG` global variable with path to your config.<br>
Example of my configuration is [here](config_example).<br>


## Author

👤 **Martin Jablečník**

* Website: [martin-jablecnik.cz](https://www.martin-jablecnik.cz)
* Github: [@mjablecnik](https://github.com/mjablecnik)

## Show your support

Give a ⭐️ if this project helped you!

<a href="https://www.patreon.com/mjablecnik">
  <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

## 📝 License

Copyright © 2021 [Martin Jablečník](https://github.com/mjablecnik).<br />
This project is [MIT](LICENSE) licensed.

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_

