# Wi-Fi Widget
# Vidur Murali, 2017
# 

# ------------------------------ CONFIG ------------------------------

# milliseconds
refreshFrequency: 3 * 1000

# icon
icon_img: "wifi.widget/glyphicons-74-wifi.svg"

# ---------------------------- END CONFIG ----------------------------

command: "wifi.widget/wifi_status"

render: (output) -> """
    <span id="wifi_info"></span>
    <div id="wifi_icon"></div>
"""

# Runs once after the render
afterRender: ->
    # Embed the SVG icon
    @get_icon (err, content) ->
        icon = $('#wifi_icon').hide()

        return if err

        parser = new DOMParser()
        format = "image/svg+xml"

        # Create svg element from content string
        svg = parser.parseFromString(content, format).documentElement

        # Clear existing content, and append the svg
        icon.show().html('').append svg

get_icon: (callback) ->
    @run("cat #{@icon_img}", callback)

update: (output) ->
    is_connected = (output.match(/disconnected/i) == null)

    # Add/remove 'disconnected' if network is not connected
    $('#wifi_icon').toggleClass('disconnected', !is_connected)

    # Slice to remove a random space that
    # shows up at the end of the output
    #
    message = ''
    message = output.slice(0, -1) if is_connected

    $('#wifi_info').text message

style: """
    bottom 206px
    right 10px
    font-family 'San Francisco Display'
    font-weight light
    font-size 14pt
    font-smooth always
    color #B7BCBE

    #wifi_info
        margin-right -7px

    #wifi_icon
        display inline-block
        width 30px
        margin-right -1px

        path
            fill #B7BCBE
        & > svg > g
            transform translate(3px,12px)

        &.disconnected
            margin-right -8px
            path
                fill #5A747F
"""
