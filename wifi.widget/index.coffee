# Wi-Fi Widget
# Vidur Murali, 2017
# 

# ------------------------------ CONFIG ------------------------------

# milliseconds
refreshFrequency: 3 * 1000

# icon
connected_icon:    "wifi.widget/glyphicons-74-wifi_white.svg"
disconnected_icon: "wifi.widget/glyphicons-74-wifi_gray.svg"

# ---------------------------- END CONFIG ----------------------------

command: "wifi.widget/wifi_status"

render: (output) -> """
    <span id="info"></span>
    <img class="icon" id="connected" src="#{@connected_icon}">
    <img class="icon" id="disconnected" src="#{@disconnected_icon}">
"""

update: (output) ->
    connected_icon    = $('#connected')
    disconnected_icon = $('#disconnected')

    info = $('#info')

    is_connected = (output.match(/disconnected/i) == null)

    connected_icon.toggle(is_connected)
    disconnected_icon.toggle(!is_connected)

    message = output
    message = '' if !is_connected

    info.text message

style: """
    bottom 205px
    right 10px
    font-family Helvetica
    font-weight 300
    font-smooth always
    color #B7BCBE

    #info
        margin-right -4px

    .icon
        width 30px
        margin-bottom -8px

    #connected
        margin-right -1px

    #disconnected
        margin-right -4px
"""
