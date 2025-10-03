function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "-", time))
end

function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line({})
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end

require("folder-rules"):setup()
require("full-border"):setup()

require("augment-command"):setup({
	prompt = true,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = true,
	enter_archives = true,
	extract_retries = 3,
	must_have_hovered_item = false,
	skip_single_subdirectory_on_enter = false,
	skip_single_subdirectory_on_leave = true,
	wraparound_file_navigation = true,
})

require("relative-motions"):setup({ show_numbers = false, show_motion = true })
require("custom-shell"):setup({
	history_path = "default",
	save_history = true,
})

-- Show the status of Git file changes as linemode in the file list.
require("git"):setup()
