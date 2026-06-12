local statements = {
  "wl-paste --type text --watch cliphist store", -- Stores only text data
  "wl-paste --type image --watch cliphist store", -- Stores only image data
  "wayle panel start",
}

hl.on("hyprland.start", function()
  for _, stmt in ipairs(statements) do
    hl.exec_cmd(stmt)
  end
end)
