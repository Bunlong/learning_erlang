-module(timeouts).
-export([start_ping/1, start_pong/0, ping/2, pong/0]).

ping(0, _Pong_Node) ->
    io:format("ping finished~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()},
    receive
	pong ->
	    io:format("ping received pong~n", [])
    end,
    ping(N - 1, Pong_Node).

pong() ->
    receive
	{ping, Ping_Pid} ->
	    io:format("pong received ping~n", []),
	    Ping_Pid ! pong,
	    pong()
    after 5000 ->
	    io:format("pong timed out~n", [])
    end.

start_pong() ->
    register(pong, spawn(timeouts, pong, [])).

start_ping(Pong_Node) ->
    spawn(timeouts, ping, [3, Pong_Node]).
