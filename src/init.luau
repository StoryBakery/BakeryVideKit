local Modifier = require("@self/Modifier")
local Props = require("@self/Props")
local Types = require("@self/Types")
local Utils = require("@self/Utils")
local behavior = require("@self/Behaviors/behavior")
local behaviorReactive = require("@self/Behaviors/behaviorReactive")

local videKit = {}

export type props<Props = { [string]: any }> = Types.props<Props>

videKit.extractChildren = Utils.extractChildren
videKit.Modifier = Modifier
videKit.Props = Props
videKit.behavior = behavior
videKit.behaviorReactive = behaviorReactive

return videKit
