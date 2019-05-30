# FormBuilder iOS App #


## Setup ##

The app is written in Swift 5.0, which requires Xcode 10.2 to be installed.
[CocoaPods](http://cocoapods.org/) is used to manage third party dependencies. 
Ensure you have CocoaPods installed before proceeding.

1. Clone the repository `git clone https://github.com/CameronPorter95/FormBuilder.git`
2. Run `pod install`
3. Open  `FormBuilder.xcworkspace` with xcode

This will install the CocoaPod dependencies.

*note you will probably have to delete info.plist from the "NextResponderTextField" target inside the pods project.
This can be done through BuildPhases->CompileSources

## Stub Server ##

To enable quick local testing and automated UI testing that doesn't rely on a remote server, you can use StubServer project locally that serves
prepared static responses. The stub server uses [Vapor](http://vapor.codes) and is written
in Swift. Stub server dependencies are managed with 
[Swift Package Manager](https://docs.vapor.codes/3.0/getting-started/spm/).

To setup the stub server:
1. download "hschmidt/EnvPane" from: https://github.com/hschmidt/EnvPane/releases/tag/releases%2F0.6
2. add the environment variable key: PROJECT_DIR with value of the stubserver directory E.G. Documents/projects/app/ios/StubServer
3. install vapor by running 'brew install vapor/tap/vapor'
4. go to StubServer folder and run 'vapor xcode'
5. open the xcode "OrbitRemit" workspace
6. select the "run" scheme and choose to execute on "My Mac"
7. you should see:
  "Migrating sqlite DB
  Migrations complete
  Server starting on http://localhost:8080"
  in the console.
  go to: http://localhost:8080/messages.json and check that you're getting json response from the stub server to verify that it is working
8. run the "OrbitRemitStubs" scheme on your iPhone of choice.
9. success!

## About

Created by Cameron Porter on 30/05/19
