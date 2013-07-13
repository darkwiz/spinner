module SpinsHelper

private


# Wraps the spin content in order to not breaking up the layout when 
# the user posts a very long string

def wrap_text(txt, col = 50) #:doc:
  txt.gsub(/(.{1,#{col}})( +|$)\n?|(.{#{col}})/, 
    "\\1\\3\n") 
end

end