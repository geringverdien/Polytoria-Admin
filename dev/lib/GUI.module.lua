local open = false
local openPosition = Vector2.New(0.99, 0)
local closedPosition = Vector2.New(0.99, -0.33)


-- Instance2Lua (github.com/geringverdien/Polytoria-Instance2Lua) --
local AdminGUI = Instance.New("GUI");
AdminGUI.Name = "AdminGUI";
AdminGUI.Visible = true;
local HolderFrame = Instance.New("UIView");
HolderFrame.Name = "HolderFrame";
HolderFrame.PivotPoint = Vector2.New(1, 0);
HolderFrame.PositionOffset = Vector2.New(0, 0);
HolderFrame.PositionRelative = closedPosition;
HolderFrame.Rotation = 0;
HolderFrame.SizeOffset = Vector2.New(0, 0);
HolderFrame.SizeRelative = Vector2.New(0.175, 0.375);
HolderFrame.Visible = true;
HolderFrame.ClipDescendants = false;
HolderFrame.Color = Color.New(1.000, 1.000, 1.000, 0.000);
HolderFrame.BorderColor = Color.New(0.133, 0.133, 0.133, 0.898);
HolderFrame.BorderWidth = 0;
HolderFrame.CornerRadius = 0;
HolderFrame.Parent = AdminGUI;
local UIVerticalLayout = Instance.New("UIVerticalLayout");
UIVerticalLayout.Name = "UIVerticalLayout";
UIVerticalLayout.PivotPoint = Vector2.New(0, 0);
UIVerticalLayout.PositionOffset = Vector2.New(0, 0);
UIVerticalLayout.PositionRelative = Vector2.New(0, 0);
UIVerticalLayout.Rotation = 0;
UIVerticalLayout.SizeOffset = Vector2.New(0, 0);
UIVerticalLayout.SizeRelative = Vector2.New(1, 1);
UIVerticalLayout.Visible = true;
UIVerticalLayout.ClipDescendants = false;
UIVerticalLayout.ChildAlignment = TextAnchor.UpperLeft;
UIVerticalLayout.ChildControlHeight = false;
UIVerticalLayout.ChildControlWidth = false;
UIVerticalLayout.ChildForceExpandHeight = false;
UIVerticalLayout.ChildForceExpandWidth = false;
UIVerticalLayout.ChildScaleHeight = false;
UIVerticalLayout.ChildScaleWidth = false;
UIVerticalLayout.PaddingBottom = 0;
UIVerticalLayout.PaddingLeft = 5;
UIVerticalLayout.PaddingRight = 0;
UIVerticalLayout.PaddingTop = 5;
UIVerticalLayout.ReverseAlignment = false;
UIVerticalLayout.Spacing = 5;
UIVerticalLayout.Parent = HolderFrame;
local CMDInput = Instance.New("UITextInput");
CMDInput.Name = "CMDInput";
CMDInput.PivotPoint = Vector2.New(0, 1);
CMDInput.PositionOffset = Vector2.New(0, 0);
CMDInput.PositionRelative = Vector2.New(0, 0);
CMDInput.Rotation = 0;
CMDInput.SizeOffset = Vector2.New(-10, 0);
CMDInput.SizeRelative = Vector2.New(1, 0.1);
CMDInput.Visible = true;
CMDInput.ClipDescendants = false;
CMDInput.Color = Color.New(0.264, 0.264, 0.264, 1.000);
CMDInput.BorderColor = Color.New(0.000, 0.000, 0.000, 1.000);
CMDInput.BorderWidth = 0;
CMDInput.CornerRadius = 0;
CMDInput.Text = "";
CMDInput.Placeholder = "; or click here to enter commands";
CMDInput.PlaceholderColor = Color.New(0.500, 0.500, 0.500, 1.000);
CMDInput.TextColor = Color.New(0.870, 0.870, 0.870, 1.000);
CMDInput.FontSize = 10;
CMDInput.Font = TextFontPreset.RobotoMono;
CMDInput.AutoSize = true;
CMDInput.MaxFontSize = 10;
CMDInput.JustifyText = TextJustify.Left;
CMDInput.VerticalAlign = TextVerticalAlign.Middle;
CMDInput.IsReadOnly = false;
CMDInput.IsMultiline = false;
CMDInput.Parent = UIVerticalLayout;
local SuggestionHolder = Instance.New("UIView");
SuggestionHolder.Name = "SuggestionHolder";
SuggestionHolder.PivotPoint = Vector2.New(0, 0);
SuggestionHolder.PositionOffset = Vector2.New(0, 0);
SuggestionHolder.PositionRelative = Vector2.New(0.5, 0.5);
SuggestionHolder.Rotation = 0;
SuggestionHolder.SizeOffset = Vector2.New(-10, 0);
SuggestionHolder.SizeRelative = Vector2.New(1, 0.87);
SuggestionHolder.Visible = true;
SuggestionHolder.ClipDescendants = false;
SuggestionHolder.Color = Color.New(0.263, 0.263, 0.263, 1.000);
SuggestionHolder.BorderColor = Color.New(0.000, 0.000, 0.000, 1.000);
SuggestionHolder.BorderWidth = 0;
SuggestionHolder.CornerRadius = 0;
SuggestionHolder.Parent = UIVerticalLayout;
local CommandsLabel = Instance.New("UILabel");
CommandsLabel.Name = "CommandsLabel";
CommandsLabel.PivotPoint = Vector2.New(0, 0);
CommandsLabel.PositionOffset = Vector2.New(10, 10);
CommandsLabel.PositionRelative = Vector2.New(0, 0);
CommandsLabel.Rotation = 0;
CommandsLabel.SizeOffset = Vector2.New(-20, -20);
CommandsLabel.SizeRelative = Vector2.New(1, 1);
CommandsLabel.Visible = true;
CommandsLabel.ClipDescendants = false;
CommandsLabel.Color = Color.New(1.000, 1.000, 1.000, 0.000);
CommandsLabel.BorderColor = Color.New(0.000, 0.000, 0.000, 0.000);
CommandsLabel.BorderWidth = 0;
CommandsLabel.CornerRadius = 0;
CommandsLabel.Text = "";
CommandsLabel.TextColor = Color.New(0.000, 0.000, 0.000, 1.000);
CommandsLabel.FontSize = 12;
CommandsLabel.Font = TextFontPreset.RobotoMono;
CommandsLabel.AutoSize = false;
CommandsLabel.MaxFontSize = 100;
CommandsLabel.JustifyText = TextJustify.Left;
CommandsLabel.VerticalAlign = TextVerticalAlign.Top;
CommandsLabel.Parent = SuggestionHolder;


local function SetOpen(isOpen)
    open = isOpen
    local targetPosition = isOpen and openPosition or closedPosition
    Tween:TweenVector2(HolderFrame.PositionRelative, targetPosition, 0.1, 
    function(value)
        HolderFrame.PositionRelative = value
    end,
    TweenType.easeOutQuad,
    function()
        if isOpen then
            CMDInput:Focus()
        end
    end)
end

local function GetGUI()
    return {
        AdminGUI = AdminGUI;
        HolderFrame = HolderFrame;
        CMDInput = CMDInput;
        CommandsLabel = CommandsLabel;
    }
end

return {
    GetGUI = GetGUI;
    SetOpen = SetOpen;
}