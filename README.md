#  P4-BetterRest

<p align="center">
  <img src="https://github.com/jonytipton/HW-SwiftUI/assets/42556403/deca0a21-8605-4f07-8eda-f093420a3634" width="25%">
</p>

## Summary
SwiftUI app that determines the ideal bedtime based on the user's desired wake-up time, desired amount of sleep, and daily coffee intake. The app utilizes CoreML, Apple's machine learning framework, to provide recommendations for a restful night's sleep.

## Components, Frameworks & Modifiers (AKA Views)
- DateComponents
- DateFormatter
- DatePicker
- Form
- Stepper
- HStack/VStack
- NavigationView
<hr>

- CoreML
- CreateML (Utilized to create trained model from .CSV)
- SwiftUI
<hr>

- .alert (Alert notification on button action)
- .font
- .frame (Align on trailing edge)
- .labelsHidden (Hide label on DatePicker while maintaining compatibility with Accessibility/VoiceOver)

## Discussion
As I learn more about SwiftUI and declarative programming, I continue to be amazed by how easy it can be to iterate on a design by swapping components or adding view modifiers. Step 3 of this challenge is to change the interface so that the recommended bedtime is continuously calculated and displayed (as opposed to on button press). I initially struggled with how to link the UI and programming logic when not implemented with a Button action. My original solution was to implement logic within the struct body but I quickly realized my UIKit mindset was guiding me in the wrong direction. After modifying my getBedtime() function to return a value, I was able to simply add a Text() view with this function that would be called anytime another view in the struct body was updated.
