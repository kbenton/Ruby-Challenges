#!/usr/bin/ruby

require 'optparse'
require 'time'

DEBUG = TRUE;

def formatTime(time)
  "#{time.strftime('%H:%M:%S')},#{sprintf("%.3d",time.usec/1000)}"
end

# first, get the command line options...
options = {}

options[:operation] = :add
options[:time] = 0

parser = OptionParser.new do |opts|
  opts.banner = 'Usage:  ruby shift_subtitle.rb [options] <source file name> <destination file name>'

  opts.separator ""
  opts.separator "Options:"

  opts.on("-o [add|sub]", "--operation [add|sub]", "Either add or sub[tract] time") do |o|
    if ["add", "sub"].include?(o)
      options[:operation] = o
    else
      puts "::: ERROR ::: Operation must be either 'add' or 'sub'tract."
      puts parser
      exit
    end
  end

  opts.on("-t", "--time [TIME]", "Time to shift the subtitle") do |t|
    if t =~ /\d{2},\d{3}/
      options[:time] = t.gsub(',','').to_i      # now we have the interval in milliseconds...
    else
      puts "::: ERROR ::: Time must be in the format ss,mmm."
      puts parser
      exit
    end
  end


  opts.on("-h", "--help", "Show this message") {
    puts parser; exit
  }
end

# run the options parser...
parser.parse!(ARGV)

# options were validated as parsed, above, but make sure we have both an input and output file and no more left in the arguments...
if ARGV.length != 2
  puts "::: ERROR ::: You must specify both an input and output .srt file."
  puts parser
  exit
end

if DEBUG
  puts ARGV.inspect

  puts options[:operation]
  puts options[:time]
end


# open up our files...
begin
  inputFile = File.open(ARGV[0], 'r')
  outputFile = File.open(ARGV[1], 'w')
rescue => FOPEN_ERR
  puts "Error opening files: #{FOPEN_ERR}"
  FOPEN_ERR
end

# now let's get it done...
while (line = inputFile.gets)
  if line =~ /(\d{2}:\d{2}:\d{2},\d{3})[ ->]*(\d{2}:\d{2}:\d{2},\d{3})/
    interval = options[:time] / 1000.0
    if DEBUG
      puts "#{$1} --> #{$2}"
      puts interval
    end

    (shiftedBegin, shiftedEnd) = Time.parse($1) + interval, Time.parse($2) + interval
    line = "#{formatTime(shiftedBegin)} --> #{formatTime(shiftedEnd)}"
    if DEBUG
      puts line
    end
    outputFile.puts line
  else
    outputFile.puts line
  end
end
