---
layout: post
title: Introduction to Python Matrices and NumPy
date: 2024-10-28 15:43 -0700
categories: [Math]
tags: [Linear Algebra, Systems of Linear Equation, Determinant, Ai, Machine Learning, Math, Matrices]
author: Diego Trazzi
---

Official [NumPy documentaion here](https://numpy.org/doc/stable/index.html). 

In this article, we'll use NumPy to create 2-D arrays and easily compute mathematical operations.

## Basics of NumPy

NumPy is the main package for scientific computing in Python. It performs a wide variety of advanced mathematical operations with high efficiency.

```python
import numpy as np
```

The array object in NumPy is called `ndarray` meaning 'n-dimensional array'.

There are several ways to create an array in NumPy. You can create a 1-D array by simply using the function `array()` which takes in a list of values as an argument and returns a 1-D array.

```python
# Create and print a NumPy array 'a' containing the elements 1, 2, 3.
a = np.array([1, 2, 3])
print(a)
```

    [1 2 3]


Another way to implement an array is using `np.arange()`.

```python
# Create an array with 3 integers, starting from the default integer 0.
b = np.arange(3)
print(b)
```

    [0 1 2]


```python
# Create an array that starts from the integer 1, ends at 20, incremented by 3.
c = np.arange(1, 20, 3)
print(c)
```

    [ 1  4  7 10 13 16 19]


What if you wanted to create an array with five evenly spaced values in the interval from 0 to 100? As you may notice, you have 3 parameters that a function must take. One paremeter is the starting number, in  this case 0, the final number 100 and the number of elements in the array, in this case, 5. NumPy has a function that allows you to do specifically this by using `np.linspace()`.


```python
lin_spaced_arr = np.linspace(0, 100, 5)
print(lin_spaced_arr)
```

    [  0.  25.  50.  75. 100.]


To specify the data type use `dtype`. If you access the built-in documentation of the functions, you may notice that most functions take in an optional parameter `dtype`. In addition to float, NumPy has several other data types such as `int`, and `char`. 

To change the type to integers, you need to set the dtype to `int`. You can do so, even in the previous functions. Feel free to try it out and modify the cells to output your desired data type. 


```python
lin_spaced_arr_int = np.linspace(0, 100, 5, dtype=int)
print(lin_spaced_arr_int)
```

    [  0  25  50  75 100]

One of the advantages of using NumPy is that you can easily create arrays with built-in functions such as: 
- `np.ones()` - Returns a new array setting values to one.
- `np.zeros()` - Returns a new array setting values to zero.
- `np.empty()` - Returns a new uninitialized array. 
- `np.random.rand()` - Returns a new array with values chosen at random.


```python
# Return a new array of shape 3, filled with ones. 
ones_arr = np.ones(3)
print(ones_arr)
```


```python
# Return a new array of shape 3, filled with zeroes.
zeros_arr = np.zeros(3)
print(zeros_arr)
```

```python
# Return a new array of shape 3, without initializing entries.
empt_arr = np.empty(3)
print(empt_arr)
```


```python
# Return a new array of shape 3 with random numbers between 0 and 1.
rand_arr = np.random.rand(3)
print(rand_arr)
```

### Multidimensional Arrays

![linear-dipendence](/assets/Math/2024-10-28-introduction-to-python-matrices-and-numpy/img/multidimensionalArray.png){: width="400"}

With NumPy you can also create arrays with more than one dimension. A multidimensional array has more than one column. Think of a multidimensional array as an excel sheet where each row/column represents a dimension.

```python
# Create a 2 dimensional array (2-D)
two_dim_arr = np.array([[1,2,3], [4,5,6]])
print(two_dim_arr)
```

An alternative way to create a multidimensional array is by reshaping the initial 1-D array. Using `np.reshape()` you can rearrange elements of the previous array into a new shape. 


```python
# 1-D array 
one_dim_arr = np.array([1, 2, 3, 4, 5, 6])

# Multidimensional array using reshape()
multi_dim_arr = np.reshape(
                    one_dim_arr, # the array to be reshaped
                    (2,3) # dimensions of the new array
                )
# Print the new 2-D array with two rows and three columns
print(multi_dim_arr)
```

### Finding size, shape and dimension.

In future assignments, you will need to know how to find the size, dimension and shape of an array. These are all attributes of a `ndarray` and can be accessed as follows:
- `ndarray.ndim` - Stores the number dimensions of the array. 
- `ndarray.shape` - Stores the shape of the array. Each number in the tuple denotes the lengths of each corresponding dimension.
- `ndarray.size` - Stores the number of elements in the array.

```python
# Dimension of the 2-D array multi_dim_arr
multi_dim_arr.ndim
```

```python
# Shape of the 2-D array multi_dim_arr
# Returns shape of 2 rows and 3 columns
multi_dim_arr.shape
```

```python
# Size of the array multi_dim_arr
# Returns total number of elements
multi_dim_arr.size
```
___
## Array math operations
NumPy allows you to quickly perform elementwise addition, substraction, multiplication and division for both 1-D and multidimensional arrays. The operations are performed using the math symbol for each '+', '-' and '*'.

```python
arr_1 = np.array([2, 4, 6])
arr_2 = np.array([1, 3, 5])

# Adding two 1-D arrays
addition = arr_1 + arr_2
print(addition)

# Subtracting two 1-D arrays
subtraction = arr_1 - arr_2
print(subtraction)

# Multiplying two 1-D arrays elementwise
multiplication = arr_1 * arr_2
print(multiplication)
```

##  Multiplying vector with a scalar (broadcasting)
This concept is called **broadcasting**, which allows you to perform operations specifically on arrays of different shapes. 

```python
vector = np.array([1, 2])
vector * 1.6
```

![linear-dipendence](/assets/Math/2024-10-28-introduction-to-python-matrices-and-numpy/img/broadcasting.png){: width="400"}

___
## Indexing and slicing
Indexing is very useful as it allows you to select specific elements from an array. It also lets you select entire rows/columns or planes

### Indexing
Let us select specific elements from the arrays as given. 
For multidimensional arrays of shape `n`, to index a specific element, you must input `n` indices, one for each dimension. There are two common ways to do this, either by using two sets of brackets, or by using a single bracket and separating each index by a comma. Both methods are shown here.

```python
# Indexing on a 2-D array
two_dim = np.array(([1, 2, 3],
          [4, 5, 6], 
          [7, 8, 9]))

# Select element number 8 from the 2-D array using indices i, j and two sets of brackets
print(two_dim[2][1])

# Select element number 8 from the 2-D array, this time using i and j indexes in a single 
# set of brackets, separated by a comma
print(two_dim[2,1])
```

### Slicing
Slicing gives you a sublist of elements that you specify from the array. The slice notation specifies a start and end value, and copies the list from start up to but not including the end (end-exclusive). 

The syntax is:

`array[start:end:step]`

If no value is passed to start, it is assumed `start = 0`, if no value is passed to end, it is assumed that `end = length of array - 1` and if no value is passed to step, it is assumed `step = 1`.

Note you can use slice notation with multi-dimensional indexing, as in `a[0:2, :5]`. This is the extent of indexing you'll need for this course but feel free to check out [the official NumPy documentation](https://numpy.org/doc/stable/user/basics.indexing.html) for extensive documentation on more advanced NumPy array indexing techniques.

```python
# Slice the array a to get the array [1,3,5]
sliced_arr = a[::2]
print(sliced_arr)
```

```python
# Note that a == a[:] == a[::]
print(f'a == a[:]: {a == a[:]}')
print(f'a[:] == a[::]: {a[:] == a[::]}')
```

```python
# Slice the two_dim array to get the first two rows
sliced_arr_1 = two_dim[0:2]
sliced_arr_1
```

```python
# Similarily, slice the two_dim array to get the last two rows
sliced_two_dim_rows = two_dim[1:3]
print(sliced_two_dim_rows)
```

```python
# This example uses slice notation to get every row, and then pulls the second column.
# Notice how this example combines slice notation with the use of multiple indexes
sliced_two_dim_cols = two_dim[:,1]
print(sliced_two_dim_cols)
```

### Stacking
__It means to join two or more arrays__, either horizontally or vertically, meaning that it is done along a new axis. 

- `np.vstack()` - stacks vertically
- `np.hstack()` - stacks horizontally
- `np.hsplit()` - splits an array into several smaller arrays

```python
a1 = np.array([[1,1], 
               [2,2]])
a2 = np.array([[3,3],
              [4,4]])
print(f'a1:\n{a1}')
print(f'a2:\n{a2}')
```

```python
# Stack the arrays vertically
vert_stack = np.vstack((a1, a2))
print(vert_stack)

```


```python
# Stack the arrays horizontally
horz_stack = np.hstack((a1, a2))
print(horz_stack)
```

```python
# Split the horizontally stacked array into 2 separate arrays of equal size
horz_split_two = np.hsplit(horz_stack,2)
print(horz_split_two)

# Split the horizontally stacked array into 4 separate arrays of equal size
horz_split_four = np.hsplit(horz_stack,4)
print(horz_split_four)

# Split the horizontally stacked array after the first column
horz_split_first = np.hsplit(horz_stack,[1])
print(horz_split_first)
```

```python
# Split the vertically stacked array into 2 separate arrays of equal size
vert_split_two = np.vsplit(vert_stack,2)
print(vert_split_two)

# Split the vertically stacked array into 4 separate arrays of equal size
vert_split_four = np.vsplit(vert_stack,4)
print(vert_split_four)

# Split the vertically stacked array after the first and third row
vert_split_first_third = np.vsplit(vert_stack,[1,3])
print(vert_split_first_third)
```$$