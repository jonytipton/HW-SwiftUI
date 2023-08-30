#  M4-FriendList

<p align="center">

  <img src="https://github.com/jonytipton/HW-SwiftUI/assets/42556403/40c1aae5-73a5-4922-ac7f-f2a329d47b1b" width="25%">
</p>

## Summary
Friend list application that utilizes Codable, URLSession, and Core Data.

## Components, Frameworks/Protocols & Modifiers (AKA Views)
- Await Task { }
- @Environment(\.managedObjectContext)
- @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
- HorizontalScrollView
- List
- HStack
- VStack

<hr>

- Codable
- Core Data
- JSON
- SwiftUI
<hr>

- .task
- .background(in: RoundedRectangle())

## Discussion
With the work completed leading up to this project, implementing caching via Core Data was a straight forward process. I have become more comfortable with parsing JSON and now understand a simple method of caching decoded data. Creating the UI was a quick process, with the main view utilizing a List and the detail view utilizing a Form. I experimented with a horizontal scroll view that dispalys tags as individual elements. I continue to enjoy how easy it is to experiment and rapidly iterate with SwiftUI views.
