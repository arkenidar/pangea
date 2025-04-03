
# default : English language
```
arkenidar@hp255g8:~$ rlwrap lua ~/pangea/src/pangea1/main.lua
pang version: 028 (PanGea:1.0.1)
? for help
print add 5 6
11
exit
bye
```

# specific and provided : Italian language ( an experiment )
```
arkenidar@hp255g8:~$ rlwrap lua ~/pangea/src/pangea1/main.lua italian
pang versione: 028 (PanGea:1.0.1)
? for help
stampa somma 5 6
11
esci
bye
```

# running files in both English and Italian ( \*.words or \*.parole )
```
arkenidar@hp255g8:~/pangea$ rlwrap lua ~/pangea/src/pangea1/main.lua tests/f
factorial.words    fattoriale.parole  fizzbuzz.parole    fizzbuzz.words     
arkenidar@hp255g8:~/pangea$ rlwrap lua ~/pangea/src/pangea1/main.lua tests/factorial.words 
pang version: 028 (PanGea:1.0.1)
? for help
6
bye
arkenidar@hp255g8:~/pangea$ rlwrap lua ~/pangea/src/pangea1/main.lua italian tests/fattoriale.parole 
pang versione: 028 (PanGea:1.0.1)
? for help
24
bye
arkenidar@hp255g8:~/pangea$ rlwrap lua ~/pangea/src/pangea1/main.lua italian tests/fizzbuzz.parole 
pang versione: 028 (PanGea:1.0.1)
? for help
1
2
Fizz ... multiplo di 3
4
Buzz ... multiplo di 5
Fizz ... multiplo di 3
7
8
Fizz ... multiplo di 3
Buzz ... multiplo di 5
11
Fizz ... multiplo di 3
13
14
FizzBuzz ... multiplo di 15
16
17
Fizz ... multiplo di 3
19
Buzz ... multiplo di 5
bye
arkenidar@hp255g8:~/pangea$ rlwrap lua ~/pangea/src/pangea1/main.lua tests/fizzbuzz.words 
pang version: 028 (PanGea:1.0.1)
? for help
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
bye
arkenidar@hp255g8:~/pangea$ 
```