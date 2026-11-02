-- Pandoc Lua Filter: AST Manipulation for Multi-File Scope, Page Breaks & Responsive Tables
-- Follows UPC Docs-as-Code Architecture (Phase 2: AST Filters)

local function make_pagebreak()
  if FORMAT:match("latex") or FORMAT:match("beamer") then
    return pandoc.RawBlock("latex", "\\newpage")
  elseif FORMAT:match("typst") then
    return pandoc.RawBlock("typst", "#pagebreak()")
  elseif FORMAT:match("html") then
    return pandoc.RawBlock("html", '<div class="page-break" style="page-break-after: always; break-after: page;"></div>')
  else
    return pandoc.HorizontalRule()
  end
end

local function gfm_slug(s)
  s = pandoc.text.lower(s)
  -- Remove punctuation except spaces, hyphens, underscores, and alphanumeric/unicode letters
  s = s:gsub("[%.%,%:%;%!%?%(%)%[%]%{%}%'\"%`%/%\\%*%~%&%#%+%=%<%>%|]", "")
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  s = s:gsub("%s", "-")
  return s
end

function Div(el)
  if el.identifier and el.identifier:find("__") then
    el.identifier = el.identifier:match("^.*__(.+)$") or el.identifier
  end
  return el
end

function RawBlock(el)
  if el.text:match("\\newpage") or el.text:match("\\pagebreak") then
    return make_pagebreak()
  end
  return el
end

function Para(el)
  if #el.content == 1 and el.content[1].t == "Str" then
    local txt = el.content[1].text
    if txt == "\\newpage" or txt == "\\pagebreak" then
      return make_pagebreak()
    end
  end
  return el
end

function RawInline(el)
  if el.format:match("html") then
    local lower = el.text:lower()
    if lower:match("^<br%s*/?>$") then
      return pandoc.LineBreak()
    end
  end
  return el
end

function Image(el)
  -- Allow Markdown files in report/ and report/front-matter/ to use file-relative paths
  -- (../assets/... or ../../assets/...) for IDE & GitHub preview while normalizing to
  -- repository-root assets/... when compiling the unified document via Pandoc.
  if el.src then
    el.src = el.src:gsub("^(%.%./)+assets/", "assets/")
  end
  return el
end

function Link(el)
  -- Convert relative cross-file Markdown links (e.g. ../11-startup-profile.md#section)
  -- into internal document anchors (#section) when compiling the unified PDF/HTML report.
  if not el.target:match("^[a-zA-Z][a-zA-Z0-9+.-]*:") then
    local md_anchor = el.target:match("%.md#(.+)$")
    if md_anchor then
      el.target = "#" .. md_anchor
    end
  end

  -- When --file-scope is enabled, Pandoc prefixes internal #anchor links with filepath__.
  -- Strip the filepath__ prefix on internal anchor links so cross-file TOC links resolve cleanly.
  if el.target:sub(1, 1) == "#" and el.target:find("__") then
    local anchor = el.target:match("^#.*__(.+)$")
    if anchor then
      el.target = "#" .. anchor
    end
  end
  return el
end

function Header(el)
  -- Restore clean GFM heading identifier so cross-file links in 04-table-of-contents.md resolve
  local explicit_id = el.identifier:match("^.*__(.+)$")
  local computed_slug = gfm_slug(pandoc.utils.stringify(el.content))
  if explicit_id and not computed_slug:find(explicit_id, 1, true) then
    el.identifier = explicit_id
  else
    el.identifier = computed_slug
  end

  if el.level == 1 then
    return { make_pagebreak(), el }
  end
  return el
end
