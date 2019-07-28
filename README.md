# Netcasts OSS

> Simple podcasts (netcasts) management powered by open source software

<a href='https://play.google.com/store/apps/details?id=io.eemp.netcastsOSS&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
  <img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png'/>
</a>

|Homepage|Drawer|Explore|Discover|
|-----|-----|-----|-----|
|![Homepage](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-home.png)|![Drawer](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-drawer.png)|![Explore](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-explore.png)|![Discover](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-explore-with-results.png)

|Podcast|Episodes|Player|Settings|
|-----|-----|-----|-----|
|![Podcast](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-podcast.png)|![Episodes](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-episodes.png)|![Player](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-episode.png)|![Settings](android/fastlane/metadata/android/en-US/images/phoneScreenshots/Nexus%205X-settings.png)

## Why another podcast app?

* You want an ad-free app for your podcasts consumption
* You want an app powered by open source software
* You want an app you can clone, tinker with, and add functionality to
  * You have always had an idea that's been missing from your podcast app that you would like to see
  * We aren't designers :( - perhaps you can design a better theme for you
* You want to learn more about Flutter which powers this app

## Supported Features

* Find and subscribe to podcasts
* Download and play podcast episodes
* Share podcasts
* Favorite and share podcast episodes
* Limit data usage / download only when wifi is available
* Customize look and feel via themes

## Roadmap

* Better local notifications
* Chromecast support
* Allow development without requiring a datastore

## Contributing

The repo might seem like an odd mix of the flutter stack and the npm world.
In part, it's laziness and reliance of convenience/experience with node/npm.

### Development in Docker

There is no support for developing via an emulator.  A priviledge docker
container is used in conjunction with an usb-connected device.

* Build the docker image via `npm run build:docker` (it will be called flutter-dev - it's a generic image to allow flutter development)
* Start developing via `npm run start:docker`

By default, this will trigger `flutter run` within the container.  However, to
use another entrypoint, try `npm run start:docker -- lib/main_prod.dart`.

### Caveats

Currently, I maintain a datastore with popular podcast data.  In order to
contribute, you would need information about this datastore.  As a substitute,
you are able to reproduce
this datastore using the [podcasts-fetcher](/packages/podcasts-fetcher) work.

## App Releases

I have not made what's required to release this app in the play store
(keys, release settings, etc) available via github.  It's essentially
what's in the flutter docs guiding developers through the release process.

## Getting Started

For help getting started with Flutter, view the official
[documentation](https://flutter.io/).

Find out more about the flutter developer experience
while [building this app](https://eemp.io/2019/02/04/first-serious-flutter-app/).
