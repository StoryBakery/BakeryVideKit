local DynamicTween = require("../roblox_packages/DynamicTween")
local TableUtil = require("../roblox_packages/TableUtil")
local vide = require("../roblox_packages/vide")

local Types = require("./Types")

local AspectRatioConstraint = require("./UIComponent/AspectRatioConstraint")
local Frame = require("./Frame")
local GridLayout = require("./UIComponent/GridLayout")
local SizeConstraint = require("./UIComponent/SizeConstraint")
local TextLabel = require("./TextLabel")

local create = vide.create
local effect = vide.effect
local source = vide.source

local StepButton = require("StepButton")

export type PageStepperProps =
	Types.props<{

		CurrentPage: number,

		Pages: { any },

		PageTweenDuration: number?,

		OnChangingPage: (pageDelta: number) -> (),
	}>
	& Frame.FrameProps

local function PageStepper(props: PageStepperProps)
	local frameProps = table.clone(props)

	local currentPage = props.CurrentPage
	frameProps.CurrentPage = nil

	local pages = props.Pages
	frameProps.Pages = nil

	local pageTweenDuration = props.PageTweenDuration
	frameProps.PageTweenDuration = nil

	local onChangingPage = props.OnChangingPage
	frameProps.OnChangingPage = nil

	local scrollPos = source(0)
	local scrollTween: DynamicTween.DynamicTween?

	effect(function()
		if scrollTween then
			scrollTween:Destroy()
		end

		local paddingTween = DynamicTween.new({
			Start = scrollPos(),
			Goal = currentPage - 1,
			Duration = pageTweenDuration or 0.2,
			Callback = function(value)
				scrollPos(value)
			end,
		})
		paddingTween:Play()
		scrollTween = paddingTween
	end)

	local scrollingFrameInstance

	local scrollingFrameProps = {
		Size = UDim2.fromScale(1, 1),
		Transparency = 1,
		ScrollBarThickness = 0,
		ScrollingEnabled = false,

		CanvasPosition = function()
			if scrollingFrameInstance == nil then
				return Vector2.zero
			end

			return Vector2.new(scrollPos() * scrollingFrameInstance.AbsoluteSize.X, 0)
		end,
		CanvasSize = UDim2.fromScale(#pages, 1),
	}
	scrollingFrameProps = TableUtil.merge(scrollingFrameProps, pages)
	scrollingFrameProps.GridLayout = GridLayout {
		CellSize = UDim2.fromScale(1 / #pages, 1),
		CellPadding = UDim2.fromScale(0, 0),
		VerticalAlignment = Enum.VerticalAlignment.Top,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
	}

	local scrollingFrameInstance = create "ScrollingFrame"(scrollingFrameProps)
	local pagesFolder = create "Folder" { scrollingFrameInstance }

	local pageDisplayProps = {
		Size = UDim2.fromScale(0.1, 0.1),
		Position = UDim2.new(1, -5, 0, 2),
		AnchorPoint = Vector2.new(1, 0),
		StrokeEnabled = false,
		BackgroundTransparency = 1,
		Text = `{currentPage}/{#pages}`,
		TextXAlignment = Enum.TextXAlignment.Right,
	}
	pageDisplayProps.SizeConstraint = SizeConstraint({
		MaxSize = Vector2.new(70, 15),
	})
	pageDisplayProps.AspectRatioConstraint = AspectRatioConstraint({
		AspectRatio = 4,
	})

	frameProps.LeftStep = StepButton({
		Text = "◀",
		Position = UDim2.new(0, 5, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		OnClick = function()
			onChangingPage(-1)
		end,
	})
	frameProps.RightStep = StepButton({
		Text = "▶",
		Position = UDim2.new(1, -5, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		OnClick = function()
			onChangingPage(1)
		end,
	})
	frameProps.PageDisplay = TextLabel(pageDisplayProps)
	frameProps.Pages = pagesFolder

	return Frame(frameProps)
end

return PageStepper
