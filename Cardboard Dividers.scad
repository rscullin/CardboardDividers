// Cardboard Divider Template
// Copyright Robert Scullin, 2018
// Released under the MIT License

// See https://github.com/rscullin/CardboardDividers for more info

// This assumes a "landscape" arrangement of items

// Consts
Inch = 25.4; // Inches to mm

// **********
// Definitions
// **********

// Total dimmensions of final cut cardboard area
totalWidth = 21 * Inch;
totalDepth = 16.25 * Inch;
totalHeight = 10 * Inch;

// Width and depth of the space for the items
itemDepth = 2.5 * Inch;
itemWidth = 9 * Inch;

// Number of items
// Total usable items is (deep * wide)
numItemsDeep = 5;
numItemsWide = 2; // Currently hardcoded in the code to only support 2 wide. PR welcome if you want to change this!

// Slot width / Cardboard thickness
slotWidth = 0.25 * Inch;

// Hand tab width
handTabWidth = 4 * Inch;

// **********
// Options
// **********

// Optionally cut a triangle out of the wide cardboard to accomidate case wheels. 0 disables.
wheelTriangleSize = 2 * Inch;


// **********
// Code
// **********

// Dividers, Depth
difference()
{
    square([totalDepth,totalHeight]);
    AssembleVerticalSlots();
}

// Dividers, Width
translate([0, totalHeight + 2*Inch, 0])
{
    difference()
    {
        square([totalWidth,totalHeight]);
        assembleWidthSlots();
        assembleHandTabs();
        polygon(points=[[0,0],[wheelTriangleSize,0],[0,wheelTriangleSize]]);
    }
}



// Vertical slots 
module AssembleVerticalSlots()
{
    
    totalItemDepth = (itemDepth * numItemsDeep) + (slotWidth * (numItemsDeep));
    
    for(i = [0:numItemsDeep])
    {        
        startingX = ((totalDepth - totalItemDepth) / 2) + ((itemDepth + slotWidth) * i);
        echo(startingX);
        makeVerticalSlots(startingX, 0);
        
        
    } 
};

// Make the vertical slots that the opposite cardboard will go into
module makeVerticalSlots(startingX)
{
    translate([startingX - (slotWidth/2),totalHeight-(5*Inch),0])
    {
        union()
        {
            square([0.25*Inch, 5*Inch]);
            translate([(slotWidth)/2,0,0])
            {
                circle(d=slotWidth, $fn=20);
            };
            
            translate([slotWidth/2,5*Inch,0])
            {
                polygon(points=[[0,0],[0,-0.5*Inch],[0.5*Inch,0]]);
                polygon(points=[[0,0],[0,-0.5*Inch],[-0.5*Inch,0]]);
            };
        }
        
    };
}

 
    
    


// Wide slots 
module assembleWidthSlots()
{
    for(i = [0:2])
    {
        
        startingX = 0;
        
        // Left
        if(i == 0)
        {
            startingX = (totalWidth / 2) - (itemWidth);
            makeWidthSlots(startingX, 0);
        }
        // Middle
        else if (i == 1)
        {
            startingX = (totalWidth / 2);
            makeWidthSlots(startingX, 0);
        }
        // Right
        else if (i == 2)
        {
            startingX = (totalWidth / 2) + (itemWidth);
            makeWidthSlots(startingX, 0);
        } 
    } 
};

// Make the wide slots that the opposite cardboard will go into
module makeWidthSlots(startingX)
{
    translate([startingX - (slotWidth/2),totalHeight-(5*Inch),0])
    {
        union()
        {
            square([0.25*Inch, 5*Inch]);
            translate([(slotWidth)/2,0,0])
            {
                circle(d=slotWidth, $fn=20);
            };
        }
        
        translate([slotWidth/2,5*Inch,0])
        {
            polygon(points=[[0,0],[0,-0.5*Inch],[0.5*Inch,0]]);
            polygon(points=[[0,0],[0,-0.5*Inch],[-0.5*Inch,0]]);
        };
        
    };
}

 
// Assemble notches to make it easier to grab gear
module assembleHandTabs()
{
    for(i = [0:1])
    {
        // Left
        if(i == 0)
        {
            startingX = (totalWidth - (itemWidth))/2;
            makeHandTabs(startingX, 0);
        }
        // Right
        else if (i == 1)
        {
            startingX = (totalWidth + (itemWidth))/2;
            makeHandTabs(startingX, 0);
        }
    } 
}


 // Make hand notches
module makeHandTabs(startingX)
{
    tabHeight = 1.5*Inch;
    
    translate([startingX - (handTabWidth/2),totalHeight-tabHeight,0])
    {
        union()
        {
            square([handTabWidth, tabHeight]);
            translate([0.5*Inch,0,0])
            {
                circle(d=1*Inch, $fn=20);
            };
            translate([handTabWidth-(0.5*Inch),0,0])
            {
                circle(d=1*Inch, $fn=20);
            };
            translate([0.5*Inch,-0.5*Inch,0])
            {
                 square([handTabWidth-1*Inch, 2*Inch]);
            };
        }
    };
}
