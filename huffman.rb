$codes={}
def get_freq(input_str)
  freqs={}
  for ch in input_str.each_char do
    freqs[ch]=input_str.count(ch)
  end
  return freqs
end
def sort_freq(freqs)
  list=[]
  tuples=freqs.to_a
  for ch in tuples do
     list.push(ch.reverse)
  end
  return list.sort!
end
def build_tree(list)
  len=list.length
  while list.length > 1 do
    least_two=list[0,2]
    the_rest=list[2,len-1]
    comb_freq=least_two[0][0]+least_two[1][0]
    list=the_rest+[[comb_freq,least_two]]
    list=list.sort{|a,b|a[0] <=> b[0]}
  end
  return list[0]
end
def trim_tree(tree)
  p=tree[1]
  if p.class == "".class 
    return p
  else
    return [trim_tree(p[0]),trim_tree(p[1])]
  end
end
def assign_codes(node,pat="")
  if node.class == "".class 
    $codes[node]=pat
  else
    assign_codes(node[0],pat+"0")
    assign_codes(node[1],pat+"1")
  end
end
def encode(str)
  output=""
  for ch in  str.each_char do
    output=output+$codes[ch]
  end
  return output
end
def decode(tree,str)
  output=""
  tre=tree
  for bit in str.each_char do
    if bit == '0'
      tre=tre[0]
    else
      tre=tre[1]
    end
    if tre.class ==" ".class
      output=output+tre
      tre=tree
    end
  end
  return output
end

freq=get_freq("aaabccdeeeeeffg")
sor=sort_freq(freq)
tre=build_tree(sor)
c=trim_tree(tre)
assign_codes(c)
small=encode("aaabccdeeeeeffg")
puts "The encoded bit pattern :"+small.inspect
original=decode(c,small)
puts "The original string :"+original.inspect

