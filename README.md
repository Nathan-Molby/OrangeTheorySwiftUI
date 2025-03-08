# Orange Theory Swiftui
I recreated the OrangeTheory workout UI entirely SwiftUI using [Swift Charts](https://developer.apple.com/documentation/charts), [Measurements](https://developer.apple.com/documentation/foundation/measurement), a custom workout simulator, and a comprehensive configuration allowing the customization of basically everything.


<img width="2064" alt="The UI" src="https://imgur.com/zpbfoXp" />

The highlights of this project include:
- Recreating the entire UI from scratch in SwiftUI
- Utilizing SwiftCharts to build the beautiful and customizable charts for both incline and speed
- Adding support for other units (like km, km/h, etc)
- Creating a workout simulation with a customizable "time speed" to allow you to play back the workout at 1x all the way up to 60x speed.

## Swift Charts


## Objectives
- Use [Swift Charts](https://developer.apple.com/documentation/charts) to create beautiful and organic maps
- Use [Measurements](https://developer.apple.com/documentation/foundation/measurement) to store unit-agnostic data and allow the user to change what unit they would like it to be displayed in.
- Completely localize the app using [String Catalog](https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog) and translate it to at least one other language
- Create a hyper-adaptable layout. Ideally, the display (shown below) will look good on an iPhone, iPad, and Mac.
- Create a generic data layer that would allow this display to support data from any hardware
    - Creating the actual adapter from the hardware layer is out of scope for this project. Instead, I intend to create a few different "mock" providers to showcase what it would look like.
- Support both dark and light mode
- Use environment to propogate data through the app

## The Treadmill Display (WIP)

![orangetheorytablet](https://github.com/user-attachments/assets/86288a70-52c4-425d-a3c7-2047af8825d6)

## The Rowing Display (TODO)

<img width="951" alt="Screenshot 2025-02-04 at 9 34 32 PM" src="https://github.com/user-attachments/assets/57a40849-412c-43c3-8a48-e96101a88b49" />
