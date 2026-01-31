--[=[
    @class UIScaleWrapper
]=]

local vide = require("../../../roblox_packages/vide")

local Types = require(".././Types")

local create = vide.create

export type ScaleProps = Types.props<{
	Scale: number,
}>

local function Scale(props: ScaleProps)
	return create "UIScale"(props)
end

return Scale
