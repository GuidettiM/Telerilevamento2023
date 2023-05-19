# function that adds 2 to the number in input
add_two <- function(num=0) {
n_plus_two <- num + 2
return(n_plus_two)
}

# if
n <- 3
if(n<10) {
print("n è minore di 10")
} else if(n > 10) {
print("n è maggiore di 10")
} else {
ptint("n è uguale a 10")
}

# let's create a function the function
isten <- function(num=0) {
 if(n<10) {
 print("n è minore di 10")
 } else if(num > 10) {
 print("n è maggiore di 10")
 } else {
 print("n è uguale a 10")
 }
}

#then you write ex isten(4)

add_two <- function(num=0) {
 if(!is.numeric(num)) stop("Errore: non è numerico")
 n_plus_two <- num + 2
 return(n_plus_two)
}

# !is.numeric means is NOT numeric
# if you write ex. add_two("s"), it gives an error message


add_two <- function(num=0) {
 #if(!is.numeric(num)) stop("Errore: non è numerico")
 if(is.na(num)) warning("num ha valore NA")
 n_plus_two <- num + 2
 return(n_plus_two)
}

# What happens inside the function, stays inside the function. 

# FOR CYCLE
# similar to what l.apply does
# (but cycles are not very well implemented in R)

for(i in 1:5) { # repeat the cycle 5 times
 print(i)
}
 
 # multiplication without using the *. It's like doing 5*3 (5+5+5)
 num <- 0
 for(i in 1:3) {
  num <- num + 5
  }
  
  num
  
 # let's do a function that multiplies the 2 numbers in input ( multiply(a, b) )
 multiply <- function(n1 = 1, n2 = 1) {
  if(!is.numeric(n1) || !is.numeric(n2)) stop("n1 e n2 non sono numerici")
   num <- 0
   for(i in 1 : n1) {
     num <- num + n2
    } 
   return(num)
 } 
 
 multiply(4,3)
 
