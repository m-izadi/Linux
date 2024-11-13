# sudo apt-get install python3-tk

from turtle import *


speed(10)      # Set the speed of the turtle
color('white')  # Set the color of the turtle
bgcolor('black')  # Set the background color

b = 200  # Initial value for the loop

while b > 0:
    left(b)         # Turn the turtle left by 'b' degrees
    forward(b * 3)  # Move the turtle forward by 'b * 3' units
    b = b - 1       # Decrease the value of 'b' by 1

done()  # Finish the turtle graphics program
