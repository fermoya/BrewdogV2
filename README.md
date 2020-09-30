# BrewdogV2
App is designed for an _iPhone_, not for an _iPad_.
 
### Architecture
For the architecture, I chose _MVVM_. The app is modularized in reusable layers:

- APIKit
- Challenge

More modules could have been created. For example, to hold to the Business Entities or the Business Logic

#### Why MVVM
I'm very interested in _Redux_ and _MVVM_. I nonetheless favor MVVM as more used to it and more documentation is available. Both architectures work really well with Combine and Reactive approaches as both are based in the _Observer Pattern_.

### SwiftUI and Combine
SwiftUI and Combine are the future of iOS Development. I've been closely following updates and doing thorough research over the last year to assimilate the new paradigm. This is why these two frameworks were chosen to implement this challenge.

### Unit Testing
I've added some tests to test some of the functionality. This is just a way of me saying "I know how to write Unit Tests and what an App should aim to test". For the purpose of the challenge, I believe I've created enough tests. They are devided in different Unit Test Bundles:

- APIKitTests
- BreweryUnitTests
- ChallengeTests

### Known issues**

- The App is coupled to APIKit and its models. The App should have its own models (not just view models, but business models) that could potentially be reused for extensions or other Apps/projects. The reason why I haven't implemented this was to keep this simple.
- _Challenge_ might not perform as best as it could. I've favored readability vs speed and performance as these last two weren't mentioned as goals.