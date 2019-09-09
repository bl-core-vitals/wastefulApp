# WastefulApp
For reproduce the didReceiveMemoryWarning()

## Threshold each of app based on memory capacity
when the app reach the threshold, OS will be killed immediately.
percent range to crash :
* 256MB: 49% - 51%
* 512MB: 53% - 63%
* 1024MB: 57% - 68%
* 2048MB: 68% - 69%
* 3072MB: 66%
* 4096MB: 77%
* 6144MB: 81%

## Special cases
* iPhone X (3072MB): 50%
* iPhone XS/XS Max (4096MB): 55%