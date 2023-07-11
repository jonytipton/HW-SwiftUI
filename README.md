#  P9-Drawing

<p align="center">

  <img src="https://github.com/jonytipton/HW-SwiftUI/assets/42556403/32c0d2a8-57ae-4664-a8ac-92cc6b2e2727" width="25%">
</p>

## Summary
Technical skills project learning about CoreGraphics and drawing tools in SwiftUI.

## Components, Frameworks/Protocols & Modifiers (AKA Views)
- AnimatableData
- AnimatablePair<T, T>
- CGPoint
- CGRect
- Path
<hr>

- CoreAnimation (CA)
- CoreGraphics (CG)
- Metal
- SwiftUI
<hr>

- .animation
- .closeSubpath (close shape from last to first CGPoint - alternative is .stroke and creating StrokeStyle with lineJoin)
- .drawingGroup (render view w/ metal instead of CoreAnimation - faster for complex graphics but should only be used when encountering performance issues)
- .onTapGesture
- .transition

## Discussion
I enjoyed working on this technique project over the last few days and found gaining further experience with animations and graphics in SwiftUI to be rewarding. Learning about AnimatableData and AnimatablePairs answered questions I had from attempting to animate view changes in previous projects and explained the behavior of why I saw no animation. I look forward to taking the knowledge gained from this assignment to my personal app projects and future HWSwiftUI challenges.
