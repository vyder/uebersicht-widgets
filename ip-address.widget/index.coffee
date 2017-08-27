# IP Address Widget
# Vidur Murali, 2017
# 

# ------------------------------ CONFIG ------------------------------

# milliseconds
refreshFrequency: 10 * 1000

# ---------------------------- END CONFIG ----------------------------

command: "ip-address.widget/get_ip"

get_local_ip: (cb) ->
    @run("ifconfig | grep inet | grep broadcast | cut -d' ' -f2", cb)

render: (output) -> """
    <span id="local_toggle" class="hidden">
        LOCAL&nbsp;<span id="local"></span> EXT&nbsp;
    </span>
    <span id="ext"></span>
"""

update: (output) ->
    $('#ext').text output.slice(0, -1)
    $('#ext').click ->
        $('#local_toggle').toggleClass 'hidden'

    @get_local_ip (err, ip) ->
        $('#local').text ip.slice(0, -1)

style: """
    bottom 10px
    right 390px
    
    font-family 'San Francisco Display'
    font-weight 500
    font-size 9pt
    font-smooth always
    
    color #B7BCBE

    #local, #ext
        font-size 14pt
        font-family 'Ubuntu Mono'

    #local
        padding-right 10px

    .hidden
        display none
"""
