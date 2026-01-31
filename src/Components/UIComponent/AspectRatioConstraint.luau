--[=[
    @class UIAspectRatioConstraintWrapper
]=]

local vide = require("../../../roblox_packages/vide")

local Types = require(".././Types")

local create = vide.create

export type AspectRatioConstraintProps = Types.props<{
	AspectRatio: number?,
	DominantAxis: Enum.DominantAxis?,
	AspectType: Enum.AspectType?,
}>

local function AspectRatioConstraint(props: AspectRatioConstraintProps)
	local constraintProps = table.clone(props)
	return create "UIAspectRatioConstraint"(constraintProps)
end

return AspectRatioConstraint
