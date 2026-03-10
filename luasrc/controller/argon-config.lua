module("luci.controller.argon-config", package.seeall)

function index()
	if not nixio.fs.access('/www/luci-static/argon/css/cascade.css') then
		return
	end

        entry({"check_sysinfo"}, call("action_check_sysinfo"), nil).sysauth = false

	local page = entry({"admin", "system", "argon_config"}, form("argon-config"), _("Argon Config"), 90)
	page.acl_depends = { "luci-app-argon-config" }
end

function action_check_sysinfo()
        local sysinfo = luci.util.ubus("system", "info") or { }

        luci.http.status(200, "OK")
	luci.http.header("Cache-Control", "no-cache, must-revalidate")
	luci.http.header("Access-Control-Allow-Origin", "*")
        luci.http.prepare_content("application/json")
        luci.http.write_json(sysinfo)

	return
end

