-- This Lua filter modifies the LaTeX output for links with text "article" or "rule"
function Link(el)
    -- Convert the link text to a string
    local link_text = pandoc.utils.stringify(el.content)
    local target_url = el.target
    
    -- Check if the link text is "article" or "rule"
    if link_text == "article" then
      -- Custom format for "article"
      return pandoc.RawInline("latex", "\\customref{Article}{" .. target_url .. "}")
    elseif link_text == "rule" then
      -- Custom format for "rule"
      return pandoc.RawInline("latex", "\\customref{Rule}{" .. target_url .. "}")
    end
    
    -- For other links, use the original link formatting
    return el
  end
  