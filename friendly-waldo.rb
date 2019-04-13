require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'dotenv'
require 'nokogiri'
require 'pp'

#load .env variables
Dotenv.load

SESSION_SECRET = ENV["SESSION_SECRET"]
PORT = ENV["PORT"]
FIRMWARE_AND_LICENSE_FOLDER = ENV["FIRMWARE_AND_LICENSE_FOLDER"]
SERVER_IP = ENV["SERVER_IP"]
FIRMWARE_TO_SERVE = ENV["FIRMWARE_TO_SERVE"]

File.open('server.pid', 'w') {|f| f.write Process.pid }

set :port, PORT
set :public_folder, FIRMWARE_AND_LICENSE_FOLDER
set :static, true
#set :session_secret, SESSION_SECRET
#enable :sessions
#fix for Chrome sessions

use Rack::Session::Cookie, :secret => SESSION_SECRET

configure do
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

get '/' do
  body "It works!"
end

get '/XMLDefault.cnf.xml' do
  content_type 'text/xml'
  
  formatted_no_declaration = Nokogiri::XML::Node::SaveOptions::AS_XML + Nokogiri::XML::Node::SaveOptions::NO_DECLARATION
  
  if(FIRMWARE_TO_SERVE == "Enterprise")
    xml_default_cnf = Nokogiri::XML::Builder.new do |xml|
      xml.send("Default") do
        xml.send("autoRegistrationName","AUTO-REG")
        xml.send("autoRegistration","")
        xml.send("selfProvisioningSecureMode","true")
        xml.send("adminProvisionMode","false")
        xml.send("ipAddressMode","0")
        xml.send("ipPreferenceModeControl","0")
        xml.send("ipMediaAddressFamilyPreference","0")
        xml.send("callManagerGroup") do
          xml.send("name","Default")
          xml.send("tftpDefault","true")
          xml.send("members") do
            xml.send("member","priority" => "0") do
              xml.send("callManager") do
                xml.send("name","#{SERVER_IP}")
                xml.send("description","#{SERVER_IP}")
                xml.send("ports") do
                  xml.send("ethernetPhonePort","2000")
                  xml.send("sipPort","5060")
                  xml.send("securedSipPort","5061")
                  xml.send("mgcpPorts") do
                    xml.send("listen","2427")
                    xml.send("keepAlive","2428")
                  end
                end
                xml.send("processNodeName","#{SERVER_IP}")
              end
            end
          
          end
        end
        xml.send("TVS") do
          xml.send("members") do
            xml.send("member","priority" => "0") do
              xml.send("port","2445")
              xml.send("address","#{SERVER_IP}")
            end
          end
        end
        xml.send("loadinformation36213","model" => "Cisco 7811") {
          xml.text("sip78xx.12-5-1SR2-2")
        }
        xml.send("loadinformation621","model" => "Cisco 7821"){
          xml.text("sip78xx.12-5-1SR2-2")
        }
        xml.send("loadinformation622","model" => "Cisco 7841"){
          xml.text("sip78xx.12-5-1SR2-2")
        }
        xml.send("loadinformation623","model" => "Cisco 7861"){
          xml.text("sip78xx.12-5-1SR2-2")
        }
        xml.send("loadinformation36247","model" => "Cisco 7832"){
          xml.text("sip7832.12-5-1SR2-2")
        }
        xml.send("loadinformation36258","model" => "Cisco 8832"){
          xml.text("sip8832.12-5-1SR2-2")
        }
        xml.send("loadinformation36217","model" => "Cisco 8811"){
          xml.text("sip88xx.12-5-1SR2-2")
        }
        xml.send("loadinformation683","model" => "Cisco 8841"){
          xml.text("sip88xx.12-5-1SR2-2")
        }
        xml.send("loadinformation684","model" => "Cisco 8851"){
          xml.text("sip88xx.12-5-1SR2-2")
        }
        xml.send("loadinformation685","model" => "Cisco 8861"){
          xml.text("sip88xx.12-5-1SR2-2")
        }
        xml.send("loadinformation36224","model" => "Cisco 8845"){
          xml.text("sip8845_65.12-5-1SR2-2")
        }
        xml.send("loadinformation36225","model" => "Cisco 8865"){
          xml.text("sip8845_65.12-5-1SR2-2")
        }
      end
    end
  
    body xml_default_cnf.to_xml(:save_with => formatted_no_declaration).strip
  elsif(FIRMWARE_TO_SERVE = "Transitional")
    xml_default_cnf = Nokogiri::XML::Builder.new do |xml|
      xml.send("Default") do
        xml.send("autoRegistrationName","AUTO-REG")
        xml.send("autoRegistration","")
        xml.send("selfProvisioningSecureMode","true")
        xml.send("adminProvisionMode","false")
        xml.send("ipAddressMode","0")
        xml.send("ipPreferenceModeControl","0")
        xml.send("ipMediaAddressFamilyPreference","0")
        xml.send("callManagerGroup") do
          xml.send("name","Default")
          xml.send("tftpDefault","true")
          xml.send("members") do
            xml.send("member","priority" => "0") do
              xml.send("callManager") do
                xml.send("name","#{SERVER_IP}")
                xml.send("description","#{SERVER_IP}")
                xml.send("ports") do
                  xml.send("ethernetPhonePort","2000")
                  xml.send("sipPort","5060")
                  xml.send("securedSipPort","5061")
                  xml.send("mgcpPorts") do
                    xml.send("listen","2427")
                    xml.send("keepAlive","2428")
                  end
                end
                xml.send("processNodeName","#{SERVER_IP}")
              end
            end
          
          end
        end
        xml.send("TVS") do
          xml.send("members") do
            xml.send("member","priority" => "0") do
              xml.send("port","2445")
              xml.send("address","#{SERVER_IP}")
            end
          end
        end
        xml.send("loadinformation36213","model" => "Cisco 7811") {
          xml.text("sip78xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation621","model" => "Cisco 7821"){
          xml.text("sip78xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation622","model" => "Cisco 7841"){
          xml.text("sip78xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation623","model" => "Cisco 7861"){
          xml.text("sip78xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation36247","model" => "Cisco 7832"){
          xml.text("sip7832.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation36258","model" => "Cisco 8832"){
          xml.text("sip8832.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation36217","model" => "Cisco 8811"){
          xml.text("sip88xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation683","model" => "Cisco 8841"){
          xml.text("sip88xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation684","model" => "Cisco 8851"){
          xml.text("sip88xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation685","model" => "Cisco 8861"){
          xml.text("sip88xx.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation36224","model" => "Cisco 8845"){
          xml.text("sip8845_65.TLexE2M-11-2-3C-4")
        }
        xml.send("loadinformation36225","model" => "Cisco 8865"){
          xml.text("sip8845_65.TLexE2M-11-2-3C-4")
        }
      end
    end
  
    body xml_default_cnf.to_xml(:save_with => formatted_no_declaration).strip
  else
    body "<Default />"
  end
  
  
end

get /.*(\d{4})-3PCC.xml/ do
  content_type 'text/xml'
  
  model = params['captures'].first
  case model
    
  when /\A78[1246]1\z/
    firmware_load_fragment = "sip78xx"
  when /\A7832\z/
    firmware_load_fragment = "sip7832"
  when /\A88[1456]1\z/
    firmware_load_fragment = "sip88xx"
  when /\A8832\z/
    firmware_load_fragment = "sip8832"
  when /\A88[46]5\z/
    firmware_load_fragment = "sip8845_8865"
  else
    firmware_load_fragment = "BAAAAD"
  end
  
  formatted_no_declaration = Nokogiri::XML::Node::SaveOptions::AS_XML + Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

  psn = Nokogiri::XML::Builder.new do |xml|
    xml.send("device") do
      xml.send("flat-profile") do
        xml.send("Trans_Auth_Rule", "ua" => "na"){
          xml.text("http://#{SERVER_IP}/$MAU.lic")
        }
        xml.send("Upgrade_Rule", "ua" => "na"){
          xml.text("http://#{SERVER_IP}/#{firmware_load_fragment}.11-2-3MPP-398.loads")
        }
      end
      
    end
    
  end

  body psn.to_xml
end

get "/:filename" do
  filename = params[:filename]
  send_file "#{settings.public_folder}/#{filename}", :filename => filename, :disposition => 'attachment', :type => 'application/octet-stream'
end




