#!/bin/bash

read -p "Enter first number: " num1
read -p "Enter second number: " num2

basic_addition(){
 echo $((num1+num2))
}

basic_subtraction(){
 echo $((num1 - $num2))
}

basic_multiplication(){
 echo $((num1*num2))
}

basic_division(){
 echo $((num1/num2))
}

basic_arithmetic_calculator(){
    echo "num1 + num2 = $(basic_addition) "
    echo "num1 - num2 = $(basic_subtraction)"
    echo "num1 x num2 = $(basic_multiplication)"
    echo "num1 ÷ num2 = $(basic_division)"

}

basic_arithmetic_calculator

