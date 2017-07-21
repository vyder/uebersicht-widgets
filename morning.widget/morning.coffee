# Lovingly crafted by Rohan Likhite [rohanlikhite.com]

command: "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ // '"


#Refresh time (default: 1/2 minute 30000)
refreshFrequency: 30000


#Body Style
style: """
  bottom: 5px

  color: #fff
  font-family: Helvetica Neue, Arial
  font-size: 1em

  .container
   font-weight: lighter
   font-smoothing: antialiased
   text-align:center
   //margin-left: 45px
   margin-left: 0px
   text-shadow:0px 0px 20px rgba(0,0,0,0.3);

  //.container.double
  //  margin-left: 10px

  .time
   font-size: 4em
   color:#fff
   font-weight:700
   text-align:center
   width: 200px

  .half
   font-size:0.3em
   margin-left: -8%

  .text
   font-size: 1em
   color:#fff
   font-weight:700
   margin-top:-3%

  .hour
   margin-right:2%

  .min
   margin-left:-8%

  .salutation
   margin-right:-2%

"""

#Render function
render: -> """
<div class="container">
  <div class="time">
    <span class="hour"></span>:
    <span class="min"></span>
    <span class="half"></span>
  </div>
</div>

"""

  #Update function
update: (output, domEl) ->

  #Options: (true/false)
  showAmPm = true;
  showName = true;
  fourTwenty = true; #Smoke Responsibly
  militaryTime = false; #Military Time = 24 hour time

  #Time Segmends for the day
  segments = ["morning", "afternoon", "evening", "night"]

  #Grab the name of the current user.
  #If you would like to edit this, replace "output.split(' ')" with your name
  name = output.split(' ')


  #Creating a new Date object
  date = new Date()
  hour = date.getHours()
  minutes = date.getMinutes()

  #Quick and dirty fix for single digit minutes
  minutes = "0"+ minutes if minutes < 10

  #timeSegment logic
  timeSegment = segments[0] if 4 < hour <= 11
  timeSegment = segments[1] if 11 < hour <= 17
  timeSegment = segments[2] if 17 < hour <= 24
  timeSegment = segments[3] if  hour <= 4

  #AM/PM String logic
  if hour < 12
    half = "am"
  else
    half = "pm"

  #0 Hour fix
  hour= 12 if hour == 0;

  #420 Hour
  if hour == 16 && minutes == 20
    blazeIt = true
  else
    blazeIt = false

  #24 - 12 Hour conversion
  hour = hour%12 if hour > 12 && !militaryTime

  #DOM manipulation
  # if fourTwenty && blazeIt 
  #   $(domEl).find('.salutation').text("Blaze It")
  # else
  #   $(domEl).find('.salutation').text("Good #{timeSegment}") 
  # $(domEl).find('.name').text(" , #{name[0]}.") if showName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}")
  $(domEl).find('.half').text("#{half}") if showAmPm && !militaryTime

  if hour > 9
    $(".container").addClass('double')
  else
    $(".container").removeClass('double')
