#  Flex Jet Interview
## Jonathan Kovach

Initial implementation notes: https://www.notion.so/FlexJet-Take-Home-Notes-2d668ea15b4f80cb820fcc386355e108

### Time Breakdown

- Login screen: 1 hour
- Flights screen: 2.5 hours
- Flight Details Screen: 1 hour
- Loading States + Error handling: 0.5 hours
- Models + Service Classes: 1 hour
- View Models: 1 hour
- Add ProximaNova Font + Font Utility Class: 1 hours

### Approach
- I started with an empty Xcode project with the SwiftUI Template. SwiftUI is the latest UI Framework from Apple. I chose to use SwiftUI over UIKit because SwiftUI makes quickly building and refining views much faster, and simpler, with less boiler plate code.
- There are Login and Flight Model classes for integrating with the backend. There is a Flights type for the flights request, and the Login Request and Response type for encoding and decoding the Login request/response.
- In the app you will see 4 views. A Login View, FlightMainView, FlightDetailView, and FlightCardView. FlightCardView is a subview shown on FlightMainView. Most of these views have a view model. These ViewModels may require a Model to be initialized. This essentially creates a mapping from the backend types to the types and data that is used in the app. These approaches help to improve code readability, organization, and separation of concerns.
- There are also 3 main service classes. APIService, AuthenticationService, and the FlightFetcher Service. 
    - The APIService handles networking. It has a reference to the vercel API endpoint, and formats the requests and responses.
    - The AuthenticationService handles keeping track of the user login state and interfaces with the Keychain
    - The Flight Fetcher combines the AuthenticationService with the APIService to make the flight request with the authentication token.
    - Having these 3 service classes helps to separate concerns and increases the ability to make the app more modular if ever necessary. For instance, the API Service could be replaced with a different API Service without affecting the details of the AuthenticationService or the FlightFetcher service.

### Future Enhancements (If I had more time this is what I'd do)
- [ ] Implement caching properly for requests. Possibly add a networking library that automatically handles caching.
- [ ] Skeleton Preview for main flight page initial loading state.
- [ ] Handle API errors on Flight main screen. redirect to login if user is not logged in.
- [ ] Fix UI Bug on Tab Bar (Currently shows filled SFSymbols)
- [ ] Use static String variables for any strings that are displayed in the app
- [ ] Replace magic numbers with descriptive variables.
- [ ] Fix any broken Preview Views.
- [ ] Add Unit tests for Models, ViewModels, and Services. Add protocols and minor refactoring so that services can be mocked as necessary, and add any needed mocks.
- [ ] Add delightful animations as fit
- [ ] Add an app icon
- [ ] Fix main flights page disappearing cards when refreshing. This is because 