module("luci.controller.ddns-go", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ddns-go") then
		return
	end

	local page = entry({"admin", "services", "ddns-go"}, alias("admin", "services", "ddns-go", "setting"), _("DDNS-GO"), 58)
	page.dependent = false
	page.acl_depends = { "luci-app-ddns-go" }
	
	entry({"admin", "services", "ddns-go", "setting"}, cbi("ddns-go/ddns-go"), _("Base Setting"), 20).leaf = true
	entry({"admin", "services", "ddns-go", "ddns-go"}, template("ddns-go/ddns-go"), _("DDNS-GO Control panel"), 30).leaf = true
	entry({"admin", "services", "ddns-go", "log"}, template("ddns-go/ddns-go_log"), _("Log"), 40).leaf = true
	
	entry({"admin", "services", "ddns-go", "status"}, call("act_status")).leaf = true
	entry({"admin", "services", "ddns-go", "fetch_log"}, call("fetch_log")).leaf = true
	entry({"admin", "services", "ddns-go", "clear_log"}, call("clear_log")).leaf = true
end

function act_status()
	local sys = require "luci.sys"
	local e = {}
	e.running = sys.call("pgrep -f ddns-go >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function fetch_log()
	local fs = require "nixio.fs"
	local log_file = "/var/log/ddns-go.log"
	local log_content = fs.readfile(log_file) or "No Log."
	luci.http.write(log_content)
end

function clear_log()
	local fs = require "nixio.fs"
	local log_file = "/var/log/ddns-go.log"
	fs.writefile(log_file, "")
	luci.http.status(200, "OK")
	luci.http.prepare_content("application/json")
	luci.http.write_json({result = "success"})
end