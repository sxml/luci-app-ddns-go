local m, s, o

m = Map("ddns-go", translate("DDNS-GO"),
	translate("DDNS-GO automatically obtains your public IPv4 or IPv6 address and resolves it to the corresponding domain name service.") ..
	translate("</br>For specific usage, see:") ..
	translate("<a href='https://github.com/sirpdboy/luci-app-ddns-go' target='_blank'>GitHub @sirpdboy/luci-app-ddns-go</a>"))

m:section(SimpleSection).template = "ddns-go/ddns-go_status"

s = m:section(TypedSection, "basic", translate("Global Settings"))
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable"))
o.default = 0

o = s:option(Value, "port", translate("Set the DDNS-TO access port"))
o.datatype = "port"
o.default = 9876

o = s:option(Value, "time", translate("Update interval"))
o.datatype = "uinteger"
o.default = 600

o = s:option(Value, "ctimes", translate("Compare with service provider N times intervals"))
o.datatype = "uinteger"
o.default = 5

o = s:option(Flag, "skipverify", translate("Skip verifying certificates"))
o.default = 0

o = s:option(Value, "dns", translate("Specify DNS resolution server"))
o:value("223.5.5.5", translate("Ali DNS (223.5.5.5)"))
o:value("223.6.6.6", translate("Ali DNS (223.6.6.6)"))
o:value("119.29.29.29", translate("Tencent DNS (119.29.29.29)"))
o:value("1.1.1.1", translate("CloudFlare DNS (1.1.1.1)"))
o:value("8.8.4.4", translate("Google DNS (8.8.4.4)"))
o:value("8.8.8.8", translate("Google DNS (8.8.8.8)"))
o.default = "223.5.5.5"

o = s:option(Flag, "noweb", translate("Do not start web services"))
o.default = 0

o = s:option(Value, "delay", translate("Delayed Start (seconds)"))
o.datatype = "uinteger"
o.default = 60

return m