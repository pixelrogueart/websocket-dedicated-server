extends Node

signal CHANGE_SCREEN(newScreen)
signal UPDATE_AWAIT_LABEL(value)
signal SEND_NOTIFICATION(text)
signal CHANGE_PLAYER_STATE(value)
signal CHANGE_PLAYER_CONTROL_STATE(value)
signal CHANGE_BUTTON_STATE(value)
#client-signals
signal SEND_TEXT(text)

#database-signals
signal DISPLAY_INFO(type,data)

#server-signals
signal RECEIVE_TEXT(peerID,text)
signal LOAD_PLAYER_STATE(state)
