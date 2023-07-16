#  M3-TrackitHabit

<p align="center">

  <img src="https://github.com/jonytipton/HW-SwiftUI/assets/42556403/34baecf3-725d-4e4f-bb77-a5ac3619b123" width="25%">
</p>

## Summary
Daily habit tracking application.

## Components, Frameworks/Protocols & Modifiers (AKA Views)
- @Binding
- @ObservableObject
- GeometryReader (get the size of child views for proper alignment of ring Endcap)
- Form
- List
- HStack
- VStack
- ZStack

<hr>

- Core Graphics (CG)
- SwiftUI
<hr>

- .animation
- .offset (align ring Endcap over start/end of rings)
- .overlay
- onAppear
- .onChange
- .rotationEffect (spinning animation upon completion)
- .trim (animate stroke along ring path)


## Discussion
I became sidetracked at the start of the project and spent several days learning more about SwiftUI's animation modifiers in an attempt to recreate the Apple fitness activity rings. Through trial and error and online resources, I successfully recreated a ring view with the desired effects. I am most proud of the small animations added to the arrow icon of the ring and the spring effect for when progress is made by completing habits. Once I figured out how to properly animate child views and pass in @Binding variables, I was able to quickly put together the remainder of the app UI and logic for tracking habits. This is the first project I utilized the .onChange modifier which I believe will be heavily used in future projects (assuming I understand its purpose correctly). To this point, I continue to learn more about States and how to solve problems with an imperative mindset. 
