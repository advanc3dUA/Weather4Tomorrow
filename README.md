### 🙈 What it does:
Weather4Tomorrow displays the weather for a predefined list of coordinates (hardcoded in the Constants file). Yes, it’s as unexpected as it sounds!

### Data Looping:
The app cycles through the list of coordinates, updating the weather data every X seconds (default is 10 seconds; configurable in Constants).
### Architecture:
Built using the MVVM (Model-View-ViewModel) pattern—at least, that’s how I understand it!
### Interactive Background:
The background dynamically changes based on the current weather at the active location (e.g., a sunny day might show a warm yellow, while a cloudy day could display a cool blue).
### Data Layout:
* Top: Current day’s weather.
* Middle: A horizontally scrollable view displaying the forecast for the next 24 hours.
* Bottom: A forecast for the next 7 days.
### City Names via Reverse Geocoding:
Instead of displaying raw coordinates, the app uses Apple’s reverse geocoding to show the name of the city. After all, who really remembers their city’s latitude and longitude?
### Animations:
The app features smooth transitions between different locations and a playful animation for the current weather icon.
### Background Updates:
When the app moves to the background, it stops consuming data (and your precious internet bandwidth). Weather updates resume from the next location when you return to the foreground. Restarting the app resets the location list back to the beginning.
### Error & Loading States:
During data loading or if an error occurs, the app overlays a faded view on top of the last successfully loaded content.
