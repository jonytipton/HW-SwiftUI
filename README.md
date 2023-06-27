#  P5-WordScramble

<p align="center">
  <img src="" width="25%">
</p>

## Summary
SwiftUI game that asks players to create words out of a random eight-letter word.

## Components, Frameworks & Modifiers (AKA Views)
- List
- NavigationView
- ToolbarItemGroup
<hr>

- Bundle (loading file from main app bundle)
- fatalError() (Force crash application, used for app entering state of inoperability - i.e. unable to load needed resources from Bundle)
- NSRange (Processing strings for misspellings, uses UIKit framework and Obj-C)
- SwiftUI
<hr>

- .alert (Alert notification on word submit)
- .onAppear (Start game on app load, similar to viewWillAppear() from UIKit)
- .onSubmit (Triggers action when keyboard is dismissed from Textfield)

## Discussion
This project and subsequent challenge went quickly as I am already familiar with app bundles, handling strings, and dispalying tableviews. I had completed a similiar project in the UIKit variant of this course and am surpised how quickly the same result (with an improved UI) can be achieved with SwiftUI in a fraction of the time. SwiftUI autocomplete suggestions seems to be unreliable in Xcode 14 as I frequently type modifiers or components that are compatible with the type I am referencing but I see alerts stating otherwise. However, this has led me to gain a deeper understanding of SwiftUI as it encourages me to think through my code and verify I am using the correct components instead of relying on code completion.
