-- pang: polish notation language

local pang_version="011"
print("pang version: "..pang_version)

local words={}

function print_function(arguments)
  local value=evaluate_word(arguments[1])
  print(value)
  return value
end
function add_function(arguments)
  return evaluate_word(arguments[1])+evaluate_word(arguments[2])
end
function multiply_function(arguments)
  return evaluate_word(arguments[1])*evaluate_word(arguments[2])
end

function true_function(arguments)
  return true
end
function false_function(arguments)
  return false
end
function if_function(arguments)
  if evaluate_word(arguments[1]) then
    return evaluate_word(arguments[2])
  else
    return evaluate_word(arguments[3])
  end
end
function while_function(arguments)
  while evaluate_word(arguments[1]) do
    evaluate_word(arguments[2])
  end
end
function not_function(arguments)
  return not evaluate_word(arguments[1])
end
function equal_function(arguments)
  local first=evaluate_word(arguments[1])
  local second=evaluate_word(arguments[2])
  return first==second
end
local variables={}
function get_function(arguments)
  return variables[words[arguments[1]]]
end
function set_function(arguments)
  local variable_name=words[arguments[1]]
  local variable_value=evaluate_word(arguments[2])
  variables[variable_name]=variable_value
end
function string_function(arguments)
  return words[arguments[1]]
end
function modulus_function(arguments)
  return evaluate_word(arguments[1])%evaluate_word(arguments[2])
end
function lesser_than_or_equal_function(arguments)
  return evaluate_word(arguments[1])<=evaluate_word(arguments[2])
end
function greater_function(arguments)
  return evaluate_word(arguments[1])>evaluate_word(arguments[2])
end
local word_definitions={["print"]={1,print_function},["add"]={2,add_function},["true"]={0,true_function},["false"]={0,false_function},["if"]={3,if_function},["while"]={2,while_function},["not"]={1,not_function},["equal"]={2,equal_function},["set"]={2,set_function},["get"]={1,get_function},["string"]={1,string_function},["modulus"]={2,modulus_function},["lesser_than_or_equal"]={2,lesser_than_or_equal_function},["greater"]={2,greater_function}}
word_definitions["multiply"]={2,multiply_function}

function phrase_length(word_index)
  local word=words[word_index]
  local length=1
  if word=="do" then
    while true do
      if words[word_index+length]=="end" then return length+1 end
      length=length+phrase_length(word_index+length)
    end
  end
  local number=tonumber(word)
  if number~=nil then return 1 end
  local word_definition=word_definitions[word]
  if word_definition==nil or word_index>1 and (words[word_index-1]=="string" or words[word_index-1]=="define_word" or words[word_index-1]=="set") then return 1 end
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
  if word=="do" then
    local do_word_index=word_index+1
    local evaluated
    while words[do_word_index]~="end" do
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
  
  for word_index=words_to_add+1,#words do
    io.write(words[word_index].."/"..phrase_length(word_index).." ")
  end
  print()
    
  evaluate_word(1+words_to_add)

end

function execute_words_file_function(arguments)
  local file_name=words[arguments[1]]
  local file=io.open(file_name,"r")
  execute_program(file:read())
  file:close()
end
word_definitions["execute_words_file"]={1,execute_words_file_function}

word_definitions["dont"]={1,function() end}

local call_stack={}
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
word_definitions["define_word"]={3,define_word_function}

function argument_function(arguments)
  local last=call_stack[#call_stack]
  local argument_index=evaluate_word(arguments[1])
  local returned=last[argument_index]
  return returned
end
word_definitions["argument"]={1,argument_function}

--execute_program("define_word square 1 multiply argument 1 argument 1")
--execute_program("print square 4") --> 16

-- test for recursion
--execute_program("define_word factorial 1 if equal 0 argument 1 1 multiply argument 1 factorial add -1 argument 1")
--execute_program("print factorial 0") --> 1
--execute_program("print factorial 4") --> 24

function read_execute_loop()
  while true do
    local program=io.read()
    execute_program(program)
  end
end
read_execute_loop() -- start REPL

-- execute_words_file fizzbuzz.words
-- print factorial 3