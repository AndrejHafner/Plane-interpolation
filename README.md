# Plane interpolation
Plane interpolation algorithm using the principle [partition of unity][1] implemented in Octave. 
##  Usage
    interpolation(V,len)
    V... matrix of Z values of a certain unknown function
    len... number of points to be interpolated inside a unit square

## Example
        | 1   2   1 |
    z = | 2   3   2 |
        | 1   2   1 |

    interpolation(z,20);

Normal plane
![alt text](https://github.com/AndrejHafner/Plane-interpolation/blob/master/planes/interpolated.jpeg)

Interpolated plane
![alt text](https://github.com/AndrejHafner/Plane-interpolation/blob/master/planes/normal.jpeg)

  [1]: https://en.wikipedia.org/wiki/Partition_of_unity
