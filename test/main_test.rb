require "main.rb"
require "test/unit"
#require "rake/test"

set :environment, :test

class MainTest < Test::Unit::TestCase
   def app
       Sinatra::Application
   end
   
   def test_convert_name
       assert_equal(convert_name("Sega"),"sega")
       assert_equal(convert_name("ngmoco,Inc."),"ngmocoinc")
       assert_equal(convert_name("Chen's Photography & Software"),"chensphotographyandsoftware")
       assert_equal(convert_name("Ocarina"),"ocarina")
       assert_equal(convert_name("Watchmen: Justice is Coming"),"watchmenjusticeiscoming")
       assert_equal(convert_name("Brain Challenge™"),"brainchallenge")
       assert_equal(convert_name("Spanish Class 2 - Bueno, entonces... ¿qué pasó con el cinco?"),"spanishclass2buenoentoncesquepasoconelcinco")
   end
end