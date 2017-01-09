require 'mechanize'

# Needs the time at the end of the URL for first and last srt to download
startBroadcasting = 487
endBroadcasting = 685

youtubeURL = "https://manifest.googlevideo.com/api/manifest/webvtt?id=buhz3kmtcWc.1&itag=133&source=yt_live_broadcast&playlist_type=DVR&gcr=us&ratebypass=yes&cmbypass=yes&live=1&lang=en&signature=5E2BA172309B5C3673DFBA94DCA5F594F7739D88.6D677BCB236BD059EFB22E1FE7AA5D8489355273&sver=3&upn=LzxAVVWeAKc&key=dg_yt0&fexp=3300001,3300104,3300132,3300161,3312381,3312531,3312722,3313262,9412859,9412913,9416126,9416891,9416984,9422596,9428398,9428769,9431012,9433096,9433634,9433653,9433946,9434012,9434529,9435247,9435527,9435733,9435783,9435876,9436011,9436835,9437066,9437676,9437777&cpn=RjJH6Ok1cILwgc-5&mpd_version=4&pacing=0&ip=199.180.217.169&ipbits=0&expire=1464747397&sparams=ip,ipbits,expire,id,itag,source,playlist_type,gcr,ratebypass,cmbypass,live,lang&alr=yes&keepalive=yes&mime=text%2Fvtt&c=WEB&cver=1.20160525&sq="

########1.Looping through the srt segments to download them
for i in startBroadcasting..endBroadcasting
  print "downloading\tpage n #{i}\n"
agent = Mechanize.new
link = "#{youtubeURL}#{i.to_s}"

agent.get(link).save "page_#{i.to_s}.srt"
print "downloaded\tpage n #{i}\n"
end

print "images from #{startBroadcasting} to #{endBroadcasting} downloaded as srt\n"

########2. combine all of the srts into one file, removing 'noise'
result =[]

for j in  startBroadcasting..endBroadcasting

  File.open("page_#{j}.srt", "r") do |file|

    fileArray = file.read.split("\n")
    fileArray.delete_if {|x| x == "WEBVTT" }
    fileArray.delete_if {|x| x.include?"X-TIMESTAMP-MAP" }

    if(fileArray != [])
      result.push(fileArray)
    end# if
  end# FILE
end# for

srtResult =  result.join("\n")

srtFileName = "YoutubeLive_from_#{startBroadcasting}_to_#{endBroadcasting}.srt"

######3. Save to file
File.open(srtFileName, 'w') { |file| file.write(srtResult) }

puts "saved #{srtFileName}"
