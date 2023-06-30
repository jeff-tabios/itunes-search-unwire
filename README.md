# itunes-search-unwire
## Description
Downloads and displays song data. 
Allows searching and view details
Built with example unit test with mock data.

Used UIKit, MVVM and Combine

## Approach
The approach taken for this demo to separate the dependencies like network service and search client from the view model. The search box has a debounce time of 1 second before it calls on the search function. State handles the storage of latest results and is defined in the view model. All constraints are handled via auto layout and data binding is in Combine.


## Video
