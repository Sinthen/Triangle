#!/bin/sh

test_success() {
  output=$(echo "$1" "$2" "$3" | $APP 2>/dev/null)
  test "$output" = "$4" && { echo "Success;" "test_success("$1" "$2" "$3");"; } || { echo "Fail;" "test_success("$1" "$2" "$3"); \""$output\"" <> "$4";"; ErrorCount=$((ErrorCount+1)); }
}

test_fail() {
  output=$(echo "$1" "$2" "$3" | $APP 2>/dev/null)
  test $? -ne 0 && { echo "Success;" "test_fail("$1" "$2" "$3");"; } || { echo "Fail;" "test_fail("$1" "$2" "$3"); "$?" <> 0"; ErrorCount=$((ErrorCount+1)); }
}

APP='./triangle.sh'
ErrorCount=0

test_fail 1 1 1

test_fail -1 -1 1

test_fail d ss 0

test_success 1 1 1 "Равносторонний треугольник"

test_success 3 4 5 "Треугольник"

test_success 1 2 3 "Не треугольник"

if [ $ErrorCount -ne 0 ]; then
	echo "Количество тестов завершившихся ошибками: $ErrorCount"
else
	echo "Все тесты успешно прошли"
fi
