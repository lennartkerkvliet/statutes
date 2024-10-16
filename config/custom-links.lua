function Link(el)
  local link_text = pandoc.utils.stringify(el.content)
  local target_url = el.target:gsub("#", "")

  -- Check if the link text is "article" or "rule"
  if link_text == "article" or link_text == "rule" then
    -- Use \customref, but escape special characters properly
    -- Double braces {{ and }} are used to prevent interpretation issues
    return pandoc.RawInline("latex", "\\customref{" .. link_text:gsub("^%l", string.upper) .. "}{" .. target_url .. "}")
  end
  
  -- Check if the link text is "article" or "rule"
  if link_text == "short-article" or link_text == "short-rule" then
    -- Use \customref, but escape special characters properly
    -- Double braces {{ and }} are used to prevent interpretation issues
    return pandoc.RawInline("latex", "\\shortcustomref{" .. link_text:gsub("^%l", string.upper) .. "}{" .. target_url .. "}")
  end

  -- Return the original link for any other text
  return el
end
