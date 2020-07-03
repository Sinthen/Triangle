#!/bin/sh

test_success() {
  output=$(echo "$1" "$2" "$3" | $APP 2>/dev/null)
  test "$output" = "$4" && { echo "Success;" "test_success("$1" "$2" "$3");"; } || { echo "Fail;" "test_success("$1" "$2" "$3"); \""$output\"" <> "$4";"; ErrorCount=$((ErrorCount+1)); }
}

test_fail() {
  output=$(echo "$1" "$2" "$3" | $APP 2>/dev/null)
  test $? -ne 0 && { echo "Success;" "test_fail("$1" "$2" "$3");"; } || { echo "Fail;" "test_fail("$1" "$2" "$3"); "$?" <> 0"; ErrorCount=$((ErrorCount+1)); }
}

APP="$1"

ErrorCount=0

test_fail -1 1 1

test_fail 1 -1 1

test_fail 1 1 -1

test_fail d ss 0

test_success 1 1 1 "Равносторонний треугольник"

test_success 3 4 5 "Треугольник"

test_success 1 2 3 "Не треугольник"

max_int32=$(echo 2^32 | bc)
max_int64=$(echo 2^64 | bc)

test_success $max_int32 $max_int32 $max_int32 "Равносторонний треугольник"

test_success $max_int64 $max_int64 $max_int64 "Равносторонний треугольник"

if [ $ErrorCount -ne 0 ]; then
	echo "Количество тестов завершившихся ошибками: $ErrorCount"
	exit 1
else
	echo "Все тесты успешно прошли"
fi
