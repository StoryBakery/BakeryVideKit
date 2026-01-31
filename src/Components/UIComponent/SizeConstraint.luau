--[=[
    @class UISizeConstraintWrapper
]=]

local vide = require("../../../roblox_packages/vide")

local Types = require(".././Types")

local create = vide.create

export type SizeConstraintProps = Types.props<{
	MaxSize: Vector2?,
	MinSize: Vector2?,
}>

local function SizeConstraint(props: SizeConstraintProps)
	return create "UISizeConstraint"(props)
end

return SizeConstraint
