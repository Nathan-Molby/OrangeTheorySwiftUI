# Orange Theory Swiftui
I recreated the OrangeTheory workout UI entirely SwiftUI using [Swift Charts](https://developer.apple.com/documentation/charts), [Measurements](https://developer.apple.com/documentation/foundation/measurement), a custom workout simulator, and a comprehensive configuration allowing the customization of basically everything.

<img width="2064" alt="The UI" src="https://i.imgur.com/zpbfoXp.png" />

## Swift Charts
My experience with Swift Charts is that it is great to get you 90% of the way to your goal, but the last 10% is made really difficult (which is perhaps true of most of SwiftUI 🤣).

### The Good Parts
For this project, I utilized an AreaMark with two LineMarks. The same underlying graph components is used for both the incline graph and the speed graph: [Graph View](/OrangeTheorySwiftUI/Shared%20Components/GraphView.swift).

This component takes in a `MetricBySecond` and a `AverageBySecond` array. The `MetricBySecond` represents the live value at a second (i.e. 4mph at second 200). The `AverageBySecond` represents the rolling average of the metric at that second (i.e 3.5 mph at second 200).

Throwing both of these into a `Chart` object with the correct formatting created Graphs that were incredibly close to what I was expecting with a very small amount of code. But, it wasn't _exactly_ what I was expected.

### The Bad Parts
There are three rough parts that I ran into using Swift Charts that I think are worth discussing. 

#### Charts Display _all_ The Data They Receive
If you input data from 0 seconds up to 5 minutes on a chart, but constraint the X Scale to 2 minutes to 5 minutes, what would you expect would happen? I would expect it would clip the chart at 2 minutes, but it doesn't do that. Instead, the values before 2 minutes just go outside of the frame of the chart 🤦. 

<img width="410" alt="Broken Chart" src="https://imgur.com/dI5IxV5.png" />

You would think this would be easily solved by filtering your values so that they are only inside your time frame, but this only works if you have "dense" values (i.e. every second is populated). If instead, you have this data:
- 1 minute: 4 mph
- 3 minute: 7 mph
- 4 minute: 10 mph
- 5 minute: 4 mph

Your graph won't look right because the first value will be at 3 minutes but there is data at 1 minute. As a result, you have to do interpolation to add a fake value into your chart at the beginning of your chart area. 

Alternatively, you could clip your chart (which is what I ended up doing), but that only works if you are ok with trailing axes. If you have leading axes, your line will run straight through them out of the frame of the chart.

#### They Get _Really_ Slow With a Modest Amount of Data
I didn't expect to reach the limits of Swift Charts by simulating data every second for 30 minutes, but I sure did. Swift Charts starts _really_ chugging around the 1000 data point mark. Here is the instruments data for a 300ms hang where Swift Charts is spending 267ms doing _something_. 

<img alt="Instruments Issue" src="https://imgur.com/upFDdSI.png" />

I initially had my data set up poorly so it was recomputing multiple dictionaries every second, which I thought was the culprate, but after some data refactoring, it appears Swift Charts just isn't very fast (see [this thread]("https://developer.apple.com/forums/thread/740314?answerId=802935022#802935022") as well).

So, in addition to having to add manual interpolation, you also have to manually downsample your data.

#### Chart Axes 

TODO
