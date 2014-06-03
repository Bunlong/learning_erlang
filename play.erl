-module(play).
-export([double/1, fac/1, convert/2, convert_length/1, list_length/1, list_max/1, reverse/1, duplicate/2, delete/2, filter/2, append/1, compare/2, month_length/2, map/2, foreach/2, sum/1, max/2, mul/1, sum_list/1, increase/1, member/2, look_up_key/2, look_up_key_and_update_if_integer/3]).

%%double(10)
double(X) -> X * 2.

%%factorialof 4 is 4*3*2*1
%%fac(4)
fac(1) -> 1;
fac(N) -> N * fac(N - 1).

%%convert(3, inch)
%%convert(7, centimeter).
convert(M, inch) -> M / 2.54;
convert(N, centimeter) -> N * 2.54.

%%convert_length({inch, 5})
%%convert_length(play:convert_length({inch, 5}))
convert_length({centimeter, X}) -> {inch, X / 2.54};
convert_length({inch, Y}) -> {centimeter, Y * 2.54}.

%%list_length([1, 2, 3, 4, 5, 6, 7])
list_length([]) -> 0;
list_length([_|T]) -> 1 + list_length(T).

%%list_max([1, 3, 5, 6, 8, 2])
list_max([H|T]) -> list_max(T, H).
list_max([], T) -> T;
list_max([H|T], Result_so_far) when H > Result_so_far -> 
    list_max(T, H);
list_max([_|T], Result_so_far) -> 
    list_max(T, Result_so_far).

%%reverse([1, 2, 3])
reverse(List) -> reverse_list(List, []).
reverse_list([], Reversed_List) -> Reversed_List;
reverse_list([H|T], Reversed_List) -> reverse_list(T, [H|Reversed_List]).

%duplicate(5, water)
duplicate(0, _Element) -> [];
duplicate(Times, Element) ->
    [Element|duplicate(Times - 1, Element)].

%%delete(a, [a, b, c])
delete(_Element, []) -> [];
delete(Element, [H|T]) ->
    case Element =/= H of
	true ->
	    [H|delete(Element, T)];
	false ->
	    delete(Element, T)
    end.

%%append([[1, 2, 3], [a, b], [4, 5, 6]])
append([]) -> [];
append([H|T]) -> H ++ append(T).

%%filter(fun(X) -> X rem 2 == 0 end, [1, 2, 3, 4, 5])
filter(_F, []) -> [];
filter(F, [H|T]) -> 
    case F(H) of
	true ->
	    [H|filter(F, T)];
	false ->
	    filter(F, T)
    end.

%%compare(33, 33)
compare(A, B) ->
    if
	A == 5 ->
	    io:format("A == 5~n", []),
	    a_equals_5;
	B == 6 ->
	    io:format("B == 6~n", []),
	    b_equals_6;
	A == 2, B ==3 ->
	    io:format("A == 2, B == 3~n", []),
	    a_equals_2_and_b_equals_3;
	A == 1; B == 7 ->
	    io:format("A == 1; B == 7~n", []),
	    a_equals_1_or_b_equals_7;
	true ->
	    io:format("nothing~n")
    end.

%%month(sep, 2014)
month_length(Month, Year) ->
    Leap = if
	       trunc(Year / 400) * 400 == Year -> leap;
	       trunc(Year / 100) * 100 == Year -> not_leap;
	       trunc(Year / 4) * 4 == Year -> leap;
	       true -> not_leap
	   end,
    case Month of
	sep -> 30;
	apr -> 30;
	jun -> 30;
	nov -> 30;
	feb when Leap == leap -> 29;
	feb -> 28;
	jan -> 31;
	mar -> 31;
	may -> 31;
	jul -> 31;
	aug -> 31;
	oct -> 31;
	dec -> 31
    end.

%%map(fun(X) -> X + 3 end, [1, 2, 3])
map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

%%Print_City = fun({City, {Temp, Value}}) -> io:format("~w ~w ~w~n", [City, Temp, Value]) end.
%%foreach(Print_City,[{Phnom Penh, {t, 10}}, {moscow, {c, -10}}]).
foreach(_, []) -> ok;
foreach(F, [H|T]) -> 
    F(H), 
    foreach(F, T). 

%%sum(10)
sum(1) -> 1;
sum(N) when N > 1 ->  N + sum(N-1).

%%max(1, 2)
max(X, Y) ->
    if
	X > Y ->
	    X;
	true ->
	    Y
    end.

%%mul(10)
mul(1) -> 1;
mul(M) when M > 1 -> M * mul(M-1).

%%sum([1, 2, 3, 4, 5])
sum_list([]) -> 0;
sum_list([H|T]) -> H + sum_list(T).

%%increase([1, 2, 3, 4]) => increase([2, 3, 4, 5])
increase([]) -> [];
increase([H|T]) -> [H + 1|increase(T)].

%%member(a, [a, b, c])
member(_, []) -> false;
member(Element, [Element|_]) -> true;
member(Element, [_|T]) -> member(Element, T).

%%look_up_key(age, [{name, "Bunlong", {age, 30}])
look_up_key(_, []) -> "Undefined";
look_up_key(Key, [{Key, Value}|_]) -> Value;
look_up_key(Key, [_|T]) -> look_up_key(Key, T).

%%look_up_key_and_update_if_integer(age, [{name, "Bunlong"}, {age, 30}], 2)
look_up_key_and_update_if_integer(Key, [H|T], Number) when is_list(Number) -> look_up_key_and_update_if_integer(Key, [H|T], list_to_integer(Number));
look_up_key_and_update_if_integer(_, [], _) -> "Undefined";
look_up_key_and_update_if_integer(Key, [{Key, Value}|_], Number) -> Value + Number;
look_up_key_and_update_if_integer(Key, [_|T], Number) -> look_up_key_and_update_if_integer(Key, T, Number).
