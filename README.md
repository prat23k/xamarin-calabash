# Cross-platform Acceptance Testing Best Practices

Test automation is programming - hence, well-established practices of programming apply to test automation. Ruby is object-oriented, and most Calabash tests should also follow good object-oriented design (e.g., principles of abstraction, separation of concerns, modularity, reuse...).

A well-established pattern in test engineering is the *Page-Object Pattern* (POP). While originating in web testing, the ideas of POP apply equally well to native mobile. In this short article, we'll illustrate how to use the page object pattern to better architect test code and obtain better cross-platform code reuse.

We've created a sample project: [X-Platform-Example](https://github.com/calabash/x-platform-example) using the open source WordPress app. If you want to follow along and try things out, go to the project page [https://github.com/calabash/x-platform-example](https://github.com/calabash/x-platform-example) and follow install and run instructions. You can also choose to just read about the principles in this article and try to implement them in you own app.

# Page Objects

A *page object* is an object that represents a single screen (page) in your application. For mobile, "screen object" would possibly be a better word, but Page Object is an established term that we'll stick with.

A page object should abstract a single screen in your application. It should expose methods to query the state and data of the screen as well as methods to take actions on the screen. 

As a trivial example, a "login screen" consisting of username and password text fields and a "Login" button could expose a method `login(user,pass)` method that would abstract the details of entering username, password, touching the "Login" button, as well as 'transitioning' to another page (after login). A screen with a list of talks for a conference could expose a `talks()` method to return the visible talks and perhaps a `details(talk)` method to navigate to details for a particular talk.

The most obvious benefit of this is abstraction and reuse. If you have several steps needing to navigate to details, the code for `details(talk)` is reused. Also, callers of this method need not worry about the details (e.g. query and touch) or navigating to this screen.

# Cross-platform Core Idea


Let's go into more detail with this last example. Consider the following sketch of a class (don't do it exactly like this - read on a bit):

```ruby

    class TalksScreen
       def talks
       # query all talks...
       end
       
       def details(talk)
       #touch talk…
       end
    end
```


Suppose you're building the same app for iPhone and Android phones. Most likely the interface of the `TalksScreen` class makes complete sense on both platforms. This means that the calling code, which is usually in a step definition, is independent of platform - hence it can be reused across platforms. 

Working this way gets you complete reuse of Cucumber features as well as step definitions: the details of interacting with the screen is pushed to page object implementations.

The idea is that you provide an implementation of page objects for each platform you need to support (e.g. iPhone, iPad, Android phone, Android tablet, mobile web, desktop web,…).

# Cross-platform in practice

So… The idea and design looks good. The question now is how to implement this is practice. Here we describe the mechanics and below you'll find an example extracted from [X-Platform-Example](https://github.com/calabash/x-platform-example).

There are a couple of ingredients we need.

1. For each screen you want to automate, decide on an interface for a page object class (e.g. like `TalksScreen` above).
2. Use only custom steps, and in each step definition *only* use page objects and their methods (no direct calls to Calabash iOS or Calabash Android APIs).
3. For each supported platform, define a class with implementations of the page-object methods.
4. Create a Cucumber profile (`config/cucumber.yml`). Define a profile for each platform (e.g. `android` and `ios`), and ensure that the profile *only* loads the page object classes for the platform.
5. Rejoice and profit!

Let's see what these steps look like in a concrete example on the [X-Platform-Example](https://github.com/calabash/x-platform-example).

# Example

## Running the samples

Make sure you have Ruby 1.9 or above installed (Ruby 2.0+ recommended).

On OS X Mavericks and above Ruby is already installed.

If you've never used ruby before and just want to get started quickly you can run this script on OS X:

    ./install-calabash-local-osx.rb

This will install Calabash and gems in a `~/.calabash` directory.

On Windows we recommend: http://rubyinstaller.org/ and latest Ruby. Then follow the instructions below.

## Or do-it-yourself

Or if you're already a Ruby user, make sure you have bundler installed:

    gem install bundler

Install gems in the `Gemfile`:

    bundle install

### iOS

You need OS X with Xcode (6.1 recommended) installed with command-line tools.

To run the iOS tests run

    ./run.rb ios

or

    bundle exec cucumber -p ios

Calabash console

    ./console.rb ios
    
Run `start_test_server_in_background`.

### Android

To run the Android tests, ensure a recent Android SDK is installed, and that

* environment variable `ANDROID_HOME` is set to point to the sdk folder, for example `/Users/krukow/android/adt/sdk`

Run

    ./run.rb android

or

    bundle exec calabash-android run prebuilt/Android-debug.apk -p android
    
Calabash console

    ./console.rb android

Run `start_test_server_in_background`.

