# Assignment 2

# Create a list of tuples, where each tuple represents a point with (x,y) coordinates. For example, points[(1, 2), (5, 8), (3, 4)).
# Write a for loop to iterate through this list. For each tuple, unpackthe x and y values into separate variables. 
# Use a conditionalstatement to check if the x coordinate is greater than the ycoordinate 
# If x>y, print "The X coordinate is greater than the Y coordinate for point (x, y).". 
# Otherwise, print "The Y coordinate is greater than or equal to the Xcoordinate for point (x, y).".

# Create a list of tuples (points with x and y coordinates)
points = [(1, 2), (5, 8), (3, 4), (7, 2), (6, 6)]

# Iterate through the list of points
for x, y in points:
    if x > y:
        print(f"The X coordinate is greater than the Y coordinate for point ({x}, {y}).")
    else:
        print(f"The Y coordinate is greater than or equal to the X coordinate for point ({x}, {y}).")