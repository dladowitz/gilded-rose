# Gilded Rose Refactor

## Process

1. Write tests
2. Come up with general rules
3. Come up with specialty rules
4. Implement code for general cases
5. Implement code for special cases
6. Continue to refactor

## Tests
I focused first on making sure there where tests for all the general and special cases. 
I needed to make sure everything I had tests for the working code before changing anthing.

## Rules

**General Rules**<br>

- quality and date drop everyday
- past date quality drops by x2
- quality never goes below 0
- quality never goes above 50


**Special items** <br>

- Brie increases as it gets older
- Cufras is never changes
- Backstage passes has funny things
- Conjured items degrade 2x

## Implementation
Since tests are in place I can delete all the crazy nesting without fear dropping functionality. 
Couple things I'd like to improve on. 

1. Case Statement - maybe a dynamic method
2. Do something about the oneoff for Sulfuras
3. Make the Backstage passes method cleaner
