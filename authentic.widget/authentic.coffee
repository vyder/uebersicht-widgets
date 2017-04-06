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

        <!-- snippet -->
        <div id="snippet">
        </div>

        <!--phrase text box -->
        <h1>
        </h1>
    </article>
"""

afterRender: (domEl) ->
    coords     = {
        latitude:  19.076,
        longitude: 72.878
    }
    console.log(coords)
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

    snippetContent = []

    # icon dump from android app
    if @showIcon
        snippetContent.push "<img src='authentic.widget/icon/#{ @icon }/#{ s1 }.png'></img>"

    if @showTemp
        if @unit == 'f'
            snippetContent.push "#{ Math.round(t * 9 / 5 + 32) } °F"
        else
            snippetContent.push "#{ Math.round(t) } °C"

    $(dom).find('#snippet').html snippetContent.join '  '

# adapted from authenticweather.com
style: """
    width 500px
    bottom 10px
    margin-left: 240px
    font-family 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', Helvetica, 'Open Sans', sans-serif
    font-smooth always
    color #ffffff

    #snippet
        font-size 2em
        font-weight 500

        img
            max-width 100px
            margin-bottom -3px

    h1
        font-size 3.3em
        font-weight 600
        line-height 1em
        letter-spacing -0.04em
        margin 0 0 0 0

    h2
        font-weight 500
        font-size 1em

    i
        font-style normal
"""
