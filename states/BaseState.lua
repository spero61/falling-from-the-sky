--[[
    Falling from the Sky

    -- BaseState Class --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    BaseState is super class of other state Classes.
    This class defines empty methods, so do not have to define
    all of these functions in each actual classes regarding StateMachine.
]]
BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end