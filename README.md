## Yelp
This is a Yelp search app client using the [Yelp API].

Time spent: 20 hours spent in total

### Features

#### Required

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height
   - [X] Custom cells should have the proper Auto Layout constraints
   - [X] Search bar should be in the navigation bar 
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states. 
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want).

#### Optional

- [X] Search results page
   - [X] Infinite scroll for restaurant results
   - [X] Implement map view of restaurant results
- [ ] Filter page
   - [ ] Radius filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. 
   - [ ] Implement a custom switch

- [X] Implement the restaurant detail page.

### Walkthrough

Walkthrough of all user stories:

![Video Walkthrough](yelp.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

Libraries:
- SVProgressHUD
- AFNetworking 
- BDBOAuth1Manager
- SVPullToRefresh
- SevenSwitch