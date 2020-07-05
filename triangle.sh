#!/bin/sh -e

read a b c

re='^[\+-]?([0-9]+$)'
if ! [[ "$a" =~ $re && "$b" =~ $re && "$c" =~ $re ]]; then
		echo "Вводимые параметры должны быть числами" >&2;
		exit 2
fi

a_gt_0=$(echo "$a > 0" | bc)
b_gt_0=$(echo "$b > 0" | bc)
c_gt_0=$(echo "$c > 0" | bc)

if [ $a_gt_0 -eq 0 -o $b_gt_0 -eq 0 -o $c_gt_0 -eq 0 ]; then
		echo "Длина стороны не может быть меньше либо равна 0" >&2;
		exit 2
fi

bc_gt_a=$(echo "$b + $c > $a" | bc)
ac_gt_b=$(echo "$a + $c > $b" | bc)
ab_gt_c=$(echo "$a + $b > $c" | bc)

if [ $bc_gt_a -eq 0 -o $ac_gt_b -eq 0 -o $ab_gt_c -eq 0 ]; then
		echo "Не треугольник" >&2;
		exit 2
fi

if [ $a = $b -a $b = $c ]; then
		echo "Равносторонний треугольник"
		exit 0
fi

if [ $a = $b -o $b = $c -o $a = $c ]; then
		echo "Равнобедренный трегольник"
		exit 0
fi

echo "Треугольник"
