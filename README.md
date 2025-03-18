# Orange Theory Swiftui
I recreated the OrangeTheory workout UI entirely SwiftUI using [Swift Charts](https://developer.apple.com/documentation/charts), [Measurements](https://developer.apple.com/documentation/foundation/measurement), a custom workout simulator, and a comprehensive configuration allowing the customization of basically everything.

<img width="2064" alt="The UI" src="https://i.imgur.com/zpbfoXp.png" />

## Demo
https://github.com/user-attachments/assets/bc1a396a-4043-4e9c-a840-d7987ab3a40c

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

#### Chart Axis Labels

Creating chart axis labels has more of a learning curve that I expected. In my case, I wanted to accept an optional "suffix" value, which would get appended after the value on the y-axis. In order to do this, you create a `AxisMarks` object in the `chartYAxis` view modifier. `AxisMarks` takes a closure that provides you with an `AxisValue` which you are expected to convert to a string for your label. However, `AxisValue` has no meaningful properties (like a `label` or `value` property) which you can use to display. Instead, it has a `.as(P) -> P? where P: Plottable` function which you use to convert the value into a type that you can handle (Double in my case). Based on a cursory search of SwiftUI, Swift, and Swift Charts documentation, this is the _only_ `as` function across all of those codebases, and it's not obvious without finding a relevant forum post _how_ to get a String from an AxisValue for display because the Swift Chart docs only use Formatters for formatting. However, once you figure out how to do it, it's not difficult to implement.

### Conclusion

Swift charts seems to work well if you have good control over your data, don't want _too_ much customization, and don't have too much data. Unfortunately, for even moderate production applications, those three requirements aren't possible. As a result, you will have to do data processing to massage your data into a format acceptable by Swift Charts and you likely won't be able to get the designs exactly right. However, it does make creating charts very easy, so if you have these requirements met, it's basically plug and play.

## Measurements
I used the Measurements SDK for the foundation of this app and I would highly recommend it if you need to support multiple units in your app. It makes it incredibly easy to convert between units and add new units, which gives you the flexibility to either display the measurement in the user's locale or in their desired measurement.

In my case, I allowed the user to configure their desired speed unit (mph, kph, m/s), length unit (mile, km, etc.), and incline unit (incline, degrees, radians, etc.). When I wanted to display a measurement, I converted it to their desired unit, formatted the value, and displayed it. 

My most interesting use of Measurements was my need to create an "incline" unit for angle. Typically, on a treadmill, you will see your angle as an incline percentage (this is also how road grades are displayed). However, Measurements doesn't come with `Incline` as an angle unit. For new units that are converted linearly, you can use `UnitConverterLinear`, but in my case the conversion requires some trigonometry. 

Accordingly, I created [InclineUnitConverter](/OrangeTheorySwiftUI/Extensions/UnitAngle+Ext.swift), which uses `tan` and `atan` to provide functions to convert `Incline` _to_ and _from_ `Degrees`. Since this is important business logic (and I messed it up like 5 times), I also created unit tests for this converter at [UnitAngleTests](/OrangeTheorySwiftUITests/UnitAngleTests.swift). These unit tests take advantage of Swift Tests parameterized tests to run 460 tests in 13 lines of code that gives me great confidence in the conversion. I also got to make a custom operator (~==) to compare two doubles, which probably isn't something I would add to the _main_ app but is a nice helper in the unit test target.

## Conclusion
This was a very fun and visual app to make, and I'm glad to have learned a lot about Swift Charts and Measurements!
