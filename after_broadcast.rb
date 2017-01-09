require 'mechanize'

youtubeURL = "https://www.youtube.com/api/timedtext?caps=asr&sparams=asr_langs%2Ccaps%2Cv%2Cexpire&signature=9B5CBFE1D38B6C3A81C861BAD485AB6CEFDB6A93.463F9650F62C199A7174B6C893D387B4B840DE9A&v=buhz3kmtcWc&asr_langs=ru%2Ces%2Cde%2Cit%2Cko%2Cfr%2Cja%2Cnl%2Cen%2Cpt&hl=en_US&key=yttt1&expire=1464753909&lang=en&name=cc1&fmt=srv3"


agent = Mechanize.new
link = "#{youtubeURL}"

agent.get(link).save "captions.xml"

puts "xml saved"
