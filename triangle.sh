#!/bin/sh

read a b c

re='^[\+-]?([0-9]+$)'
if ! [[ "$a" =~ $re && "$b" =~ $re && "$c" =~ $re ]]; then
		echo "Вводимые параметры должны быть числами" >&2;
		exit 2
fi

if [ $a -le 0 -o $b -le 0 -o $c -le 0 ]; then
		echo "Длина стороны не может быть меньше либо равна 0" >&2;
		exit 2
fi

ab=$(($a + $b))
ac=$(($a + $c))
bc=$(($b + $c))

if ! ([ $ab -gt $c -a $ac -gt $b -a $bc -gt $a ]); then

		echo "Не треугольник" >&2;
		exit 2
fi

if [ $a -eq $b -a $b -eq $c ]; then
		echo "Равносторонний треугольник"
		exit 0
fi

if [ $a -eq $b -o $b -eq $c ]; then
		echo "Равнобедренный трегольник"
		exit 0
fi

echo "Треугольник"