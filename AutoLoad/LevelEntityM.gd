extends Node

var DesktopIconDic: Dictionary = {}

func Register(nm: String, ins: DesktopIcon) -> void:
	if not DesktopIconDic.has(nm):
		DesktopIconDic[nm] = ins
	else:
		push_warning("图标已存在: %s" % nm)
