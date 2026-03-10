-- pang: polish notation language

local pang_version="000"
print("pang version: "..pang_version)

local pn="print 1 do print add 1 2 print 4 end"

local words={}
for word in string.gmatch(pn, "%S+") do
  table.insert(words,word)
end

local definitions={["print"]={1},add={2}}

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
  local argument_length=definitions[word][1]
  for argument_index=1,argument_length do
    length=length+phrase_length(word_index+length)
  end
  return length
end

print(phrase_length(3))
