# Calculator Program

def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def multiply(x, y):
    return x * y

def divide(x, y):
    if y == 0:
        return "Error! Division by zero."
    return x / y

a= add(5.7, 3.2)
print("Addition:", a)

s= subtract(10, 4)
print("Subtraction:", s)

m= multiply(6, 7)
print("Multiplication:", m)

d= divide(8, 2)
print("Division:", d)

d= divide(8, 0)
print("Division:", d)
