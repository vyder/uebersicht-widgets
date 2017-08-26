command: "ps axo \"rss,pid,ucomm\" | sort -nr | tail +1 | head -n3 | awk '{printf \"%8.0f MB,%s,%s\\n\", $1/1024, $3, $2}'"

refreshFrequency: 5000

style: """
  bottom: 10px
  right: 10px
  color: #B7BCBE
  font-family: 'HelveticaNeue-Light'

  table
    border-collapse: collapse
    table-layout: fixed

    &:before
      content: 'mem'
      position: absolute
      right: 0
      top: -15px
      font-size: 10pt

  td
    border: 1px solid #fff
    font-size: 22px
    font-weight: 100
    width: 120px
    max-width: 120px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    background: rgba(#fff, 0.2)

  .col2
    background: rgba(#fff, 0.1)

  p
    padding: 0
    margin: 0
    font-family: San Francisco Display
    font-size: 8pt
    font-weight: 500
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-family: San Francisco Display
    font-size: 8pt
    font-weight: 400

"""


render: ->
  """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

