util = {}

function clamp(a,b,c) assert(a and b and c, "not very useful error message here") return math.min(math.max(a, b), c) end

math.clamp = clamp

return util