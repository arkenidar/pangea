-- pang: polish notation language
-- pang: linguaggio a notazione polacca

local pang_version="017" -- versione
local language=nil --"italian" -- lingua
local translate_italian={
  ["pang version: "]="pang versione: ",
  ["print"]="stampa",
  ["define_word"]="definisci_parola",
  ["multiply"]="moltiplica",
  ["argument"]="argomento",
  ["do"]="fai",
  ["set"]="metti",
  ["while"]="mentre",
  ["not"]="non",
  ["greater"]="maggiore",
  ["get"]="prendi",
  ["if"]="se",
  ["equal"]="uguale",
  ["modulus"]="modulo",
  ["string"]="stringa",
  ["add"]="somma",
  ["end"]="fine",
  ["execute_words_file"]="esegui_file_parole"
}
function tr(string) -- translate / traduci
  if language=="italian" then -- italiano supportato
    local traduced=translate_italian[string]
    if traduced==nil then print("can't translate: "..string) return string end
    return traduced
  end
  return string
end
print(tr("pang version: ")..pang_version)

local words={}

-- print <printable>
function print_function(arguments)
  local value=evaluate_word(arguments[1])
  print(value)
  return value
end

-- add <number> <number>
function add_function(arguments)
  return evaluate_word(arguments[1])+evaluate_word(arguments[2])
end

-- multiply <number> <number>
function multiply_function(arguments)
  return evaluate_word(arguments[1])*evaluate_word(arguments[2])
end

function true_function(arguments)
  return true
end
function false_function(arguments)
  return false
end

-- if <condition> <if true> <if false>
function if_function(arguments)
  if evaluate_word(arguments[1]) then
    return evaluate_word(arguments[2])
  else
    return evaluate_word(arguments[3])
  end
end

-- while <condition> <do while true>
function while_function(arguments)
  while evaluate_word(arguments[1]) do
    evaluate_word(arguments[2])
  end
end

-- not <boolean>
function not_function(arguments)
  return not evaluate_word(arguments[1])
end

-- equal <first to compare> <second to compare>
function equal_function(arguments)
  local first=evaluate_word(arguments[1])
  local second=evaluate_word(arguments[2])
  return first==second
end

--local variables={}
local call_stack={{}}

-- get <variable name>
function get_function(arguments)
  local variables=call_stack[#call_stack]
  return variables[words[arguments[1]]]
end

-- set <variable name> <value to set>
function set_function(arguments)
  local variables=call_stack[#call_stack]
  local variable_name=words[arguments[1]]
  local variable_value=evaluate_word(arguments[2])
  variables[variable_name]=variable_value
end

-- string <word as string>
function string_function(arguments)
  return words[arguments[1]]
end

-- modulus <dividend> <divisor>
function modulus_function(arguments)
  return evaluate_word(arguments[1])%evaluate_word(arguments[2])
end
function lesser_than_or_equal_function(arguments)
  return evaluate_word(arguments[1])<=evaluate_word(arguments[2])
end
-- greater <lesser> <greater>
function greater_function(arguments)
  return evaluate_word(arguments[1])>evaluate_word(arguments[2])
end
local word_definitions={[tr("print")]={1,print_function},[tr("add")]={2,add_function},["true"]={0,true_function},["false"]={0,false_function},[tr("if")]={3,if_function},[tr("while")]={2,while_function},[tr("not")]={1,not_function},[tr("equal")]={2,equal_function},[tr("set")]={2,set_function},[tr("get")]={1,get_function},[tr("string")]={1,string_function},[tr("modulus")]={2,modulus_function},["lesser_than_or_equal"]={2,lesser_than_or_equal_function},[tr("greater")]={2,greater_function}}
word_definitions[tr("multiply")]={2,multiply_function}

function phrase_length(word_index)
  local word=words[word_index]
  local length=1
  if word==tr("do") then
    while true do
      if words[word_index+length]==tr("end") then return length+1 end
      length=length+phrase_length(word_index+length)
    end
  end
  local number=tonumber(word)
  if number~=nil then return 1 end
  local word_definition=word_definitions[word]
  if word_definition==nil or word_index>1 and (words[word_index-1]==tr("string") or words[word_index-1]==tr("define_word") or words[word_index-1]==tr("set")) then return 1 end
  local argument_length=word_definition[1]
  for argument_index=1,argument_length do
    length=length+phrase_length(word_index+length)
  end
  return length
end

function evaluate_word(word_index)
  local returned_value
  local word=words[word_index]
  returned_value=tonumber(word)
  if returned_value~=nil then return returned_value end
  local word_definition
  word_definition=word_definitions[word]
  if word==tr("do") then
    local do_word_index=word_index+1
    local evaluated
    while words[do_word_index]~=tr("end") do
      evaluated=evaluate_word(do_word_index)
      local current_phrase_length=phrase_length(do_word_index)
      do_word_index=do_word_index+current_phrase_length
    end
    return evaluated
  end
  if nil==word_definition then print("word:"..word.." definition not found") return end
  local arguments={}, arity, argument_word_index
  arity=word_definition[1]
  argument_word_index=word_index+1
  for argument_index=1,arity do
    table.insert(arguments,argument_word_index)
    argument_word_index=argument_word_index+phrase_length(argument_word_index)
  end
  returned_value=word_definition[2](arguments)
  return returned_value
end

function execute_program(pn_program)

  local words_to_add=#words
  
  for word in string.gmatch(pn_program, "%S+") do
    table.insert(words,word)
  end
  
  if #words==words_to_add then
    --print("empty program")
    return
  end
  
  for word_index=words_to_add+1,#words do
    io.write(words[word_index].."/"..phrase_length(word_index).." ")
  end
  print()
    
  evaluate_word(1+words_to_add)

end

-- execute_words_file <filename>
function execute_words_file_function(arguments)
  local file_name=words[arguments[1]]
  local file=io.open(file_name,"r")
  
  local program=""
  while true do
    local program_line=file:read()
    if program_line==nil then break end
    program=program..program_line.."\n"
  end
  
  file:close()
  
  --print(program)
  execute_program(program)
end
word_definitions[tr("execute_words_file")]={1,execute_words_file_function}

-- dont <skip this>
word_definitions["dont"]={1,function() end}

--local call_stack={{}}
-- define_word <name> <arity> <action>
function define_word_function(arguments)
  local arity=evaluate_word(arguments[2])
  local word_function=function(word_arguments)
    
    local value_arguments={}
    for argument_index,word_argument in pairs(word_arguments) do
      value_arguments[argument_index]=evaluate_word(word_argument)
    end
    
    local returned
    table.insert(call_stack,value_arguments)
    returned=evaluate_word(arguments[3])
    table.remove(call_stack)
    return returned
  end
  word_definitions[words[arguments[1]]]={arity,word_function}
end
word_definitions[tr("define_word")]={3,define_word_function}

-- argument <argument index>
function argument_function(arguments)
  local last=call_stack[#call_stack]
  local argument_index=evaluate_word(arguments[1])
  local returned=last[argument_index]
  return returned
end
word_definitions[tr("argument")]={1,argument_function}

-- TEST for word definition and use with arguments
-- porting to Italian added
--execute_program("define_word square 1 multiply argument 1 argument 1")  --> English
--execute_program("definisci_parola quadrato 1 moltiplica argomento 1 argomento 1") --> Italian
--execute_program("print square 4") --> 16 --> English
--execute_program("stampa quadrato 4") --> 16 --> Italian

-- TEST for recursion
--execute_program("define_word factorial 1 if equal 0 argument 1 1 multiply argument 1 factorial add -1 argument 1")
--execute_program("print factorial 0") --> 1
--execute_program("print factorial 4") --> 24

function read_execute_loop()
  while true do
    local program=io.read()
    if program==nil then break end
    execute_program(program)
  end
end
word_definitions["execute"]={0,read_execute_loop}
--read_execute_loop() -- start REPL (OPTIONAL)

-- EXAMPLES
-- execute_words_file fizzbuzz.words
-- print factorial 3

if false then
execute_program( [[ do
  execute_words_file fizzbuzz.words
  execute_words_file factorial.words
  print factorial 3
  execute
  end ]] )
end

execute_program("execute_words_file main001.words")
