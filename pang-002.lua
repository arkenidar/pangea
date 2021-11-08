-- pang: polish notation language

local pang_version="002"
print("pang version: "..pang_version)

local pn="do print 2 print add 1 2 print 4 end"

local words={}
for word in string.gmatch(pn, "%S+") do
  table.insert(words,word)
end

function print_function(arguments)
  print(evaluate_word(arguments[1]))
  return "(print returns no value)"
end
function add_function(arguments)
  return evaluate_word(arguments[1])+evaluate_word(arguments[2])
end
local word_definitions={["print"]={1,print_function},["add"]={2,add_function}}

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
  local argument_length=word_definitions[word][1]
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
