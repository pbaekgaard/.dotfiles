return {
  "IronGeek/virt-column.nvim",
  branch = "fix/off-by-one",
  config = function(_, opts)
    -- Function to blend colors with alpha
    local function alpha(hl_group, alpha_value)
      -- alpha_value: 0-100, where 100 = full color, 0 = transparent (use Normal bg)

      -- Get colors using synIDattr which returns hex strings directly
      local source_fg_hex = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl_group)), "fg#")
      local normal_bg_hex = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")

      -- Fallback if colors aren't available
      if not source_fg_hex or source_fg_hex == "" then
        source_fg_hex = "#FFFFFF"
      end
      if not normal_bg_hex or normal_bg_hex == "" then
        normal_bg_hex = "#000000"
      end

      -- Convert hex to RGB
      local function hex_to_rgb(hex)
        if not hex or hex == "" then
          return nil
        end
        -- Remove # if present
        hex = hex:gsub("^#", "")
        -- Handle 6-digit hex
        if #hex == 6 then
          local r = tonumber(hex:sub(1, 2), 16)
          local g = tonumber(hex:sub(3, 4), 16)
          local b = tonumber(hex:sub(5, 6), 16)
          if r and g and b then
            return { r = r, g = g, b = b }
          end
        end
        -- Handle 3-digit hex
        if #hex == 3 then
          local r = tonumber(hex:sub(1, 1), 16) * 17
          local g = tonumber(hex:sub(2, 2), 16) * 17
          local b = tonumber(hex:sub(3, 3), 16) * 17
          if r and g and b then
            return { r = r, g = g, b = b }
          end
        end
        return nil
      end

      local function rgb_to_hex(rgb)
        return string.format("#%02X%02X%02X", rgb.r, rgb.g, rgb.b)
      end

      -- Convert to RGB
      local source_rgb = hex_to_rgb(source_fg_hex)
      local normal_rgb = hex_to_rgb(normal_bg_hex)

      if source_rgb and normal_rgb then
        -- alpha_value: 100 = 100% source, 0 = 100% normal
        local source_weight = alpha_value / 100
        local normal_weight = 1 - source_weight

        local blended_r = math.floor(source_rgb.r * source_weight + normal_rgb.r * normal_weight + 0.5)
        local blended_g = math.floor(source_rgb.g * source_weight + normal_rgb.g * normal_weight + 0.5)
        local blended_b = math.floor(source_rgb.b * source_weight + normal_rgb.b * normal_weight + 0.5)

        return rgb_to_hex({ r = blended_r, g = blended_g, b = blended_b })
      else
        -- Fallback if conversion fails
        if alpha_value >= 50 then
          return source_fg_hex
        else
          return normal_bg_hex
        end
      end
    end

    -- Create VirtColumnColor highlight group
    local virt_column_color = alpha("Identifier", 50) -- 50% blend
    vim.api.nvim_set_hl(0, "VirtColumnColor", {
      fg = virt_column_color,
    })

    -- Setup the plugin with the provided opts
    require("virt-column").setup(opts)
  end,
  opts = {
    virtcolumn = "+1,80",
    highlight = "VirtColumnColor",
    char = "│",
    virt_lines = true, -- Enable virt_lines to show on last line
    exclude = {
      filetypes = {
        "oil"
      }
    },
  },
}
