-- pang: polish notation language

local pang_version="007"
print("pang version: "..pang_version)

local words={}

function print_function(arguments)
  print(evaluate_word(arguments[1]))
  return "(print returns no value)"
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
  if word_definition==nil or word_index>1 and words[word_index-1]=="string" then return 1 end
  local argument_length=word_definition[1]
  word_index=word_index+length
  for argument_index=1,argument_length do
    length=length+phrase_length(word_index)--(word_index+length)
  end
  return length
end

function evaluate_word(word_index)
  local returned_value
  local word=words[word_index]
  --print("wi:"..word_index..":"..word)
  if word==nil then print("nil word error:"..word_index)
    return end
    --print(word..")")
  returned_value=tonumber(word)
  if returned_value~=nil then return returned_value end
  local word_definition
  word_definition=word_definitions[word]
  if word=="do" then
    local do_word_index=word_index+1
    local evaluated
    while words[do_word_index]~="end" do
      print(do_word_index..")")
      evaluated=evaluate_word(do_word_index)
      
        for index,word in pairs(words) do
          io.write(word.."/"..phrase_length(index).." ")
        end
        print()
        
      local current_phrase_length=phrase_length(do_word_index)
      do_word_index=do_word_index+current_phrase_length
      --print(do_word_index.."]")
    end
    --print("end)")
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

  --words={}
  local words_to_add=#words
  for word in string.gmatch(pn_program, "%S+") do
    table.insert(words,word)
    --words_to_add=words_to_add+1
  end
  
  -- for index,word in pairs(words) do io.write(word.."/"..phrase_length(index).." ") end print()
  
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

-- define_word square 1 multiply argument 1 argument 1
function define_word_function(arguments)
  --print()
  local arity=evaluate_word(arguments[2])
  local word_function=function(arguments)
    local returned
    --print(evaluate_word(arguments[1]),"first argument")
    returned=evaluate_word(arguments[3])
    return returned
  end
  word_definitions[evaluate_word(arguments[1])]={arity,word_function}
end
word_definitions["define_word"]={3,define_word_function}

--execute_program("define_word square 1 multiply argument 1 argument 1")
--execute_program("do define_word string square 1 multiply 3 3 print string after_define print square 3 end")
execute_program("define_word string square 1 multiply 3 3") -- TODO with argument access
execute_program("print square 3")
---print(phrase_length(2).."#")
-- add factorial operator test for recursion

function read_execute_loop()
  while true do
    local program=io.read()
    execute_program(program)
  end
end
