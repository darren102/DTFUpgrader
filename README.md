# DTFUpgrader

DTFUpgrader is an iOS library built to assist with application upgrades. The library tries to be as unintrusive in its approach by allowing you to add extra classes conforming to a specified protocol that the library shall look for at runtime.

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like DTFUpgrader in your projects.

#### Podfile

```ruby
platform :ios, '7.0'

pod 'DTFUpgrader', '~> 1.0.0'

```

## Architecture
DTFUpgrader has been architected to provide a lightweight and simple upgrade for applications. It relies on the version formatting to be convertable for NSNumericString sorting so formats such as 1.0.0 or 1.2.3.4 will work without issue with the library. The main purpose for the library architecture is to avoid having to write code all over your application, by allowing classes to conform to the DTFUpgrader protocol the upgrader can determine what upgrades need to be run and from there determine whether it has already run the upgrade by looking in its storage file for the last version upgraded.

## Sample Project
There is a sample project that is available with this library and this sample project will show you the basic usage of DTFUpgrader. Usage in applications will be up to the individual developers since each applications architecture is different hence nothing is forced within the library it is a call when you wish type library.

### Maintainers

- [Darren Ferguson](http://github.com/darren102) ([@darren102](https://twitter.com/darren102))
