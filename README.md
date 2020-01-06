<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-5.1-brightgreen.svg" alt="Swift 5.1">
    </a>
</p>


## Notes

*Currently a WIP* not ready for consumption

## Getting Started

1. Install Vapor CLI [https://docs.vapor.codes/3.0/install/macos/](https://docs.vapor.codes/3.0/install/macos/)
1. `git clone git@github.com:mschmulen/appAnalyticsServer.git`
1. `cd appAnalyticsServer`
1. vapor build
1. vapor run
1. or with xcode user `vapor xcode`
1. `open http://localhost:8080/devices`

Local endpoints:

API endpoints:

- [http://localhost:8080/devices](http://localhost:8080/devices)
- [http://localhost:8080/apps](http://localhost:8080/apps)
- [http://localhost:8080/events](http://localhost:8080/events)
- [http://localhost:8080/users](http://localhost:8080/users)

- [http://localhost:8080/dailyActiveDevices](http://localhost:8080/dailyActiveDevices)

Web endpoints:
- [http://localhost:8080/metricsMinute](http://localhost:8080/metricsMinute)
- [http://localhost:8080/metricsDay](http://localhost:8080/metricsDay)
- [http://localhost:8080/metricsMonth](http://localhost:8080/metricsMonth)


## Companion SDK

Companion framework can be found at: [https://github.com/mschmulen/appAnalytics-iOS](https://github.com/mschmulen/appAnalytics-iOS)

`git clone git@github.com:mschmulen/appAnalytics-iOS.git`


## Address already in use

`sudo lsof -i :8080`
`kill 50111`

## Huroku deployment

1. Install heoku cli: `brew tap heroku/brew && brew install heroku`
1. `vapor heroku init` + n, n, n ?? maybe a y on customExecutable name ???
1. optional: may need to define a Procfile
1. optional: `heroku git:remote -a llit-oasis-57526`
1. `git push heroku master` or `vapor heroku push`


- whats up with your `Procfile` ? https://devcenter.heroku.com/articles/procfile

examples: 

- `web: Run serve --env production --port $PORT --hostname 0.0.0.0`
- `web: ./ExampleApp`


- ?? build-pack ... in this article https://medium.com/@VojacekJan/deploying-swift-application-to-heroku-with-ease-2b81cdd07e6

https://git.heroku.com/llit-oasis-57526.git

Misc heroku commands:

- `heroku logs -n 200`
- `heroku logs --tail`
- `heroku apps:info`

reference doc: https://dev.to/leogdion/a-vapor-guide-setup-and-deployment-with-heroku-and-ubuntu-49jn

https://forums.raywenderlich.com/t/server-side-swift-with-vapor-deploying-to-heroku-ray-wenderlich/22692/3


### Misc Curl Commands

```
curl http://localhost:8080/devices
```

get events:
```
curl http://localhost:8080/events
```

Post to events:
```
curl -X POST -H "Content-Type: application/json" -d '{"title": "example"}' http://localhost:8080/events
```


### Misc notes 

Upgrading vapor Toolbox : `brew upgrade vapor` or possibly `vapor self update`

`vapor update`



```
==> openssl@1.1
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /usr/local/etc/openssl@1.1/certs

and run
  /usr/local/opt/openssl@1.1/bin/c_rehash

openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
because openssl/libressl is provided by macOS so don't link an incompatible version.

If you need to have openssl@1.1 first in your PATH run:
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"' >> ~/.bash_profile

For compilers to find openssl@1.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

For pkg-config to find openssl@1.1 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

==> libressl
A CA file has been bootstrapped using certificates from the SystemRoots
keychain. To add additional certificates (e.g. the certificates added in
the System keychain), place .pem files in
  /usr/local/etc/libressl/certs

and run
  /usr/local/opt/libressl/bin/openssl certhash /usr/local/etc/libressl/certs

libressl is keg-only, which means it was not symlinked into /usr/local,
because LibreSSL is not linked to prevent conflict with the system OpenSSL.

If you need to have libressl first in your PATH run:
  echo 'export PATH="/usr/local/opt/libressl/bin:$PATH"' >> ~/.bash_profile

For compilers to find libressl you may need to set:
  export LDFLAGS="-L/usr/local/opt/libressl/lib"
  export CPPFLAGS="-I/usr/local/opt/libressl/include"

For pkg-config to find libressl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"

```

