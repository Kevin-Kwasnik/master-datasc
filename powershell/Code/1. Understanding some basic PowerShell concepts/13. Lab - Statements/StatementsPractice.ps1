##Control Flow Statements Practice

#if statement
$NumberOfVideos=30

if($NumberOfVideos -ge 20)
{
    "Greater or equal to 20"
}
else{
    "Less than 20"
}

#while loop
$i=1
while($i -le 10)
{
   $i #show the value of i
    ++$i #increment i 
}

# for statement
for($i=1; $i -le 10; ++$i) #for(initialization; condition; increment)
{
    $i
}

#foreach statement
#foreach($item in $collection)
#the point of this is to iterate through a collection

$collection = 'a','b','c'
foreach($item in $collection)
{
    $item + ' is a letter'
}

#switch statement
$number = 2
switch($number)
{
    1 {"One"}
    2 {"Two"}
    3 {"Three"}
    default {"Not a number"}
}

#break statement
for($i=1; $i -le 10; ++$i) #for(initialization; condition; increment)
{
    if($i -eq 5) #if i is equal to 5
    {
        break #break out of the loop
    }
    $i #show the value of i
}

#continue statement
for($i=1; $i -le 10; ++$i) #for(initialization; condition; increment)
{
    if($i -eq 5) #if i is equal to 5
    {
        continue #skip the rest of the code and go to the next iteration
    }
    $i #show the value of i
}

#return statement
#return is used to return a value from a function
function Get-Number
{
    return 5 #return the value 5 if the function is called 
}

Get-Number

#throw statement
#throw is used to throw an error message
function Get-Number
{
    throw "Error" #throw an error message if the function is called 
}

Get-Number

#trap statement
#trap is used to catch errors and handle them in a certain way
function Get-Number
{
    trap {"Error"} #trap the error message if the function is called 
    throw "Error"
}

Get-Number

#try/catch/finally statement
#try is used to try a certain code
#catch is used to catch errors and handle them in a certain way
#finally is used to execute a certain code no matter what happens

try
{
    throw "Error"
}
catch
{
    "Error"
}
finally
{
    "Finally"
}

#do/while statement
#do is used to execute a certain code
#while is used to check a condition
#the point of this is to execute a certain code at least once

$i=1
do
{
    $i
    ++$i
}
while($i -le 10)


#do/until statement
#do is used to execute a certain code
#until is used to check a condition
#the point of this is to execute a certain code at least once

$i=1
do
{
    $i
    ++$i
}
until($i -gt 10)


