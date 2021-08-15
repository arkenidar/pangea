-- pang: polish notation language

local pang_version="004"
print("pang version: "..pang_version)

local pn_program -- polish notation language adapted for algorithms program

-- previous programs
pn_program="do if false print 2 print add 1 2 print 4 end"
pn_program="do set n 1 while not equal get n 6 do print get n set n add get n 1 end end"
pn_program="do set n 5 while not equal get n 0 do print get n set n add get n -1 end end"

-- FizzBuzz demo/test
pn_program="do set i 1 while lesser_than_or_equal get i 20 do if equal 0 modulus get i 15 print string FizzBuzz if equal 0 modulus get i 3 print string Fizz if equal 0 modulus get i 5 print string Buzz print get i set i add get i 1 end end"

local words={}
for word in string.gmatch(pn_program, "%S+") do
  table.insert(words,word)
end

function print_function(arguments)
  print(evaluate_word(arguments[1]))
  return "(print returns no value)"
end
function add_function(arguments)
  return evaluate_word(arguments[1])+evaluate_word(arguments[2])
end
function true_function(arguments)
  return true
end
function false_function(arguments)
  return false
end
function if_function(arguments)
  if evaluate_word(arguments[1]) then
    evaluate_word(arguments[2])
  else
    evaluate_word(arguments[3])
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
  return evaluate_word(arguments[1])==evaluate_word(arguments[2])
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
local word_definitions={["print"]={1,print_function},["add"]={2,add_function},["true"]={0,true_function},["false"]={0,false_function},["if"]={3,if_function},["while"]={2,while_function},["not"]={1,not_function},["equal"]={2,equal_function},["set"]={2,set_function},["get"]={1,get_function},["string"]={1,string_function},["modulus"]={2,modulus_function},["lesser_than_or_equal"]={2,lesser_than_or_equal_function}}

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
  if word_definition==nil then return 1 end
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
    while words[do_word_index]~="end" do
      evaluate_word(do_word_index)
      do_word_index=do_word_index+phrase_length(do_word_index)
    end
    return
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

evaluate_word(1)
