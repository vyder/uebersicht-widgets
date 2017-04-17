# Forecast.IO Weather widget
# Vidur Murali, 2017
# 
# Code forked from:
# Authentic Weather for Übersicht
# reduxd, 2015

# ------------------------------ CONFIG ------------------------------

# forecast.io api key
apiKey: '2ad874468647cf21764b9cad5db438a1'

# degree units; 'c' for celsius, 'f' for fahrenheit
unit: 'c'

# icon set; 'black', 'white', and 'blue' supported
icon: 'white'

# weather icon above text; true or false
showIcon: true

# temperature above text; true or false
showTemp: true

# refresh every '(60 * 1000)  * x' minutes
refreshFrequency: (60 * 1000) * 20

# ---------------------------- END CONFIG ----------------------------

exclude: "minutely,hourly,alerts,flags"

command: "echo {}"

makeCommand: (apiKey, location) ->
  "curl -sS 'https://api.forecast.io/forecast/#{apiKey}/#{location}?units=si&exclude=#{@exclude}'"

render: (o) -> """
    <article id="content">
        <img  id="icon" src="">
        <span id="temperature"></span>
    </article>
"""

afterRender: (domEl) ->
    coords     = {
        latitude:  19.076,
        longitude: 72.878
    }
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand(@apiKey, "#{lat},#{lon}")

    @refresh()

update: (o, dom) ->
    # parse command json
    data = JSON.parse(o)

    return unless data.currently?
    # get current temp from json
    t = data.currently.temperature

    # process condition data (1/2)
    s1 = data.currently.icon
    s1 = s1.replace(/-/g, "_")

    # snippet control

    icon = $('#icon')
    temperature = $('#temperature')

    # icon dump from android app
    if @showIcon
        icon.attr('src', "weather.widget/icon/#{ @icon }/#{ s1 }.png")

    if @showTemp
        if @unit == 'f'
            temperature.text "#{ Math.round(t * 9 / 5 + 32) } °F"
        else
            temperature.text "#{ Math.round(t) } °C"

# adapted from authenticweather.com
style: """
    width 120px
    bottom 10px
    margin-left 210px
    font-family 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, 'Open Sans', sans-serif
    font-smooth always
    color #ffffff

    #content
        width  100px
        margin 0 auto

    #temperature
        margin-left 10px
        margin-top  5px
        font-size 2em
        font-weight 500
        display block

    #icon
        font-size 2em
        font-weight 500
        vertical-align middle
        max-width 100px
        margin-bottom -3px
"""
