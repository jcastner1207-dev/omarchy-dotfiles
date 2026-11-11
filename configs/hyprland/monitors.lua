-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
-- undefined output for catch all
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale }) 

-- Configured monitors
hl.monitor({
  output = "DP-1", mode = "3440x1440@174.96Hz", position = "0x0", scale = 1
})
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "3440x0", scale = 1, transform = 3 })


-- Keep the ultrawide primary for X11 games after startup and monitor hotplug.
-- Xwayland can reorder outputs when DP-1 disconnects during display sleep.
local function restore_xwayland_primary()
  hl.exec_cmd([[bash -c '
    sleep 1
    for attempt in 1 2 3 4 5; do
      if xrandr --query 2>/dev/null | rg -q "^DP-1 connected"; then
        xrandr --output DP-1 --primary && exit 0
      fi
      sleep 1
    done
  ']])
end

hl.on("hyprland.start", restore_xwayland_primary)
hl.on("config.reloaded", restore_xwayland_primary)
hl.on("monitor.added", restore_xwayland_primary)
