local function writeline(src, dst)
  local bytes = src:read("*all")
  for i=1,#bytes do
    dst:write(string.format("0x%02x,", string.byte(bytes, i)))
  end
  return #bytes
end

do
  local filename = arg[1]
  do
    local f = io.open(string.gsub(filename, "luac", "lua.h"), "w")
    local varname = string.gsub(string.sub(filename, 1, -6), "/", "_")
    f:write("#pragma once\n\nchar " .. varname .. "[]={")
    local len = writeline(assert(io.open(filename, "rb")), f)
    f:write("};\n");
    f:write("#define " .. varname .. "_len " .. len)
    return f:close()
  end
end
