makeCacheMatrix <- function(x=numeric(), y, z){
	m <- NULL                                                                            ##initially set the inverse to NULL
	if( lapply(length(x), as.numeric) != y*z){                                           ##check whether it can form matrix or not
		message("can't make matrix")
		return() 
	}
	else if(y != z){                                                                     ##check whether the matrix have inverse or not
		message("can't make the matrix with inverse")
		return()
	}
	else{	
		set <- function(a, b, c){                                                      ##set matrix in parent env with the desired value, if inverse is already set, get rid of it!
			x <<- a
			y <<- b
			z <<- c
			m <<- NULL	
		}
		s <- matrix(x, y, z)                                                           ##make the matrix with value
		get <- function() s                                                            ##get the matrix, add it into get
		setinverse <- function(inverse) m <<- inverse                                  ##set the inverse for the matrix as m
		getinverse <- function() m                                                     ##get the inverse of matrix, add it into getinverse
		list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)   ##given the list variable from the first function, will first check to see if there's already a cached inverse and return
                                                                                           ##otherwise will attempt to solve its inverse and set/return it

	}
}



cachesolve <- function(s, ...){                                        
	m <- s$getinverse()                                                                  ##check if there's cached value there already

	if(!is.null(m)){                                                                     ##if there is cached inverse already, return it
		message("getting cached data")
		return(m)
	}
	data <- s$get()                                                                      ## else, get the matrix from get
	m <- solve(data, ...)                                                                ## make the inverse of matrix
	s$setinverse(m)                                                                      ## set the inverse into setinverse
	m                                                                                    ## show the result of inverse
}








