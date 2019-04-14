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
        xml.send("autoRegistration","enabled")
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
        xml.send("autoRegistration","enabled")
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
          xml.text("sip78xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation621","model" => "Cisco 7821"){
          xml.text("sip78xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation622","model" => "Cisco 7841"){
          xml.text("sip78xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation623","model" => "Cisco 7861"){
          xml.text("sip78xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation36247","model" => "Cisco 7832"){
          xml.text("sip7832.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation36258","model" => "Cisco 8832"){
          xml.text("sip8832.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation36217","model" => "Cisco 8811"){
          xml.text("sip88xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation683","model" => "Cisco 8841"){
          xml.text("sip88xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation684","model" => "Cisco 8851"){
          xml.text("sip88xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation685","model" => "Cisco 8861"){
          xml.text("sip88xx.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation36224","model" => "Cisco 8845"){
          xml.text("sip8845_65.TLexE2M-11-2-3C-12")
        }
        xml.send("loadinformation36225","model" => "Cisco 8865"){
          xml.text("sip8845_65.TLexE2M-11-2-3C-12")
        }
      end
    end
  
    body xml_default_cnf.to_xml(:save_with => formatted_no_declaration).strip
  else
    body "<Default />"
  end
  
  
end


get /\/SEP([A-F0-9]{12})\.cnf\.xml/ do
  content_type 'text/xml'
  
  mac = params['captures'].first
  case mac
    
  when /\AC80084AA7A09\z/
    firmware_load_fragment = "sip78xx"
  when /\AC80084AA79C7\z/
    firmware_load_fragment = "sip78xx"
  when /\A706E6D10A338\z/
    firmware_load_fragment = "sip7832"
  when /\A706BB9247F28\z/
    firmware_load_fragment = "sip7832"
  when /\A706BB9247D58\z/
    firmware_load_fragment = "sip7832"
  when /\A706BB9248236\z/
    firmware_load_fragment = "sip7832"
  when /\AF87B20890826\z/
    firmware_load_fragment = "sip8832"
  when /\AC4B9CDD831FF\z/
    firmware_load_fragment = "sip88xx"
  when /\AF0B2E58E6814\z/
    firmware_load_fragment = "sip88xx"
  when /\AC4B9CDD84DEE\z/
    firmware_load_fragment = "sip88xx"
  when /\AC4B9CDD831C0\z/
    firmware_load_fragment = "sip88xx"
  when /\A74A02FC09C61\z/
    firmware_load_fragment = "sip8845_65"
  when /\A007686FD1C19\z/
    firmware_load_fragment = "sip8845_65"
  when /\A007686FD1C7D\z/
    firmware_load_fragment = "sip8845_65"
  when /\A007686FD1C49\z/
    firmware_load_fragment = "sip8845_65"
  when /\ACC9891548B24\z/
    firmware_load_fragment = "sip88xx"
  when /\ACC989154A1CC\z/
    firmware_load_fragment = "sip88xx"
  when /\ACC989154DD48\z/
    firmware_load_fragment = "sip88xx"
  when /\AB000B4BE5058\z/
    firmware_load_fragment = "sip88xx"
  when /\A2C3124C988D6\z/
    firmware_load_fragment = "sip88xx"
  when /\A2C3124C97D5A\z/
    firmware_load_fragment = "sip88xx"
  when /\AF8A5C5B2B055\z/
    firmware_load_fragment = "sip88xx"
  when /\A2C3124C9B519\z/
    firmware_load_fragment = "sip88xx"
  when /\A2C3124C98A77\z/
    firmware_load_fragment = "sip88xx"
  when /\A74A02FC0DE5F\z/
    firmware_load_fragment = "sip8845_65"
  else
    firmware_load_fragment = "BAAAAD"
  end
  
  
  xml_string = %q[<?xml version="1.0" encoding="UTF-8"?>
<device  xsi:type="axl:XIPPhone" ctiid="548" uuid="{7fe8bd6e-3d42-4ad5-1d1b-cfcb53bdc717}">
<fullConfig>true</fullConfig>
<portalDefaultServer>64.73.32.133</portalDefaultServer>
<deviceProtocol>SIP</deviceProtocol>
<sshUserId></sshUserId>
<sshPassword></sshPassword>
<ipAddressMode>0</ipAddressMode>
<allowAutoConfig>true</allowAutoConfig>
<dadEnable>true</dadEnable>
<redirectEnable>false</redirectEnable>
<echoMultiEnable>false</echoMultiEnable>
<ipPreferenceModeControl>0</ipPreferenceModeControl>
<ipMediaAddressFamilyPreference>0</ipMediaAddressFamilyPreference>
<tzdata>
<tzolsonversion>2018c</tzolsonversion>
<tzupdater>tzupdater.jar</tzupdater>
</tzdata>
<mlppDomainId>000000</mlppDomainId>
<mlppIndicationStatus>Off</mlppIndicationStatus>
<preemption>Disabled</preemption>
<executiveOverridePreemptable>false</executiveOverridePreemptable>
<devicePool  uuid="{c858bf9a-9a77-4961-9b76-ff209c886452}">
<revertPriority>0</revertPriority>
<name>BDK106 non-SRST Phones</name>
<dateTimeSetting  uuid="{5811a6e6-9a74-37cc-e03c-5eb7970e9a23}">
<name>Central</name>
<dateTemplate>M/D/YA</dateTemplate>
<timeZone>Central Standard/Daylight Time</timeZone>
<olsonTimeZone>America/Chicago</olsonTimeZone>
<ntps>
<ntp>
<name>10.89.174.1</name>
<nameV6></nameV6>
<ntpMode>Unicast</ntpMode>
</ntp>
<ntp>
<name>172.35.1.20</name>
<nameV6></nameV6>
<ntpMode>Unicast</ntpMode>
</ntp>
</ntps>
</dateTimeSetting>
<callManagerGroup>
<name>Prefer Sub then Pub</name>
<tftpDefault>false</tftpDefault>
<members>
<member  priority="0">
<callManager>
<name>64.73.32.133</name>
<description>democm02 (Subscriber)</description>
<ports>
<ethernetPhonePort>2000</ethernetPhonePort>
<sipPort>5060</sipPort>
<securedSipPort>5061</securedSipPort>
<mgcpPorts>
<listen>2427</listen>
<keepAlive>2428</keepAlive>
</mgcpPorts>
</ports>
<processNodeName>64.73.32.133</processNodeName>
</callManager>
</member>
</members>
</callManagerGroup>
<srstInfo  uuid="{cd241e11-4a58-4d3d-9661-f06c912a18a3}">
<name>Disable</name>
<srstOption>Disable</srstOption>
<userModifiable>false</userModifiable>
<ipAddr1></ipAddr1>
<port1>2000</port1>
<ipAddr2></ipAddr2>
<port2>2000</port2>
<ipAddr3></ipAddr3>
<port3>2000</port3>
<sipIpAddr1></sipIpAddr1>
<sipPort1>5060</sipPort1>
<sipIpV6Addr1></sipIpV6Addr1>
<sipIpAddr2></sipIpAddr2>
<sipPort2>5060</sipPort2>
<sipIpAddr3></sipIpAddr3>
<sipPort3>5060</sipPort3>
<isSecure>false</isSecure>
</srstInfo>
<connectionMonitorDuration>120</connectionMonitorDuration>
</devicePool>
<TVS>
<members>
<member  priority="0">
<port>2445</port>
<address>64.73.32.133</address>
</member>
</members>
</TVS>
<sipProfile>
<sipProxies>
<backupProxy>USECALLMANAGER</backupProxy>
<backupProxyPort>5060</backupProxyPort>
<emergencyProxy>USECALLMANAGER</emergencyProxy>
<emergencyProxyPort>5060</emergencyProxyPort>
<outboundProxy>USECALLMANAGER</outboundProxy>
<outboundProxyPort>5060</outboundProxyPort>
<registerWithProxy>true</registerWithProxy>
</sipProxies>
<sipCallFeatures>
<cnfJoinEnabled>true</cnfJoinEnabled>
<callForwardURI>x-cisco-serviceuri-cfwdall</callForwardURI>
<callPickupURI>x-cisco-serviceuri-pickup</callPickupURI>
<callPickupListURI>x-cisco-serviceuri-opickup</callPickupListURI>
<callPickupGroupURI>x-cisco-serviceuri-gpickup</callPickupGroupURI>
<meetMeServiceURI>x-cisco-serviceuri-meetme</meetMeServiceURI>
<abbreviatedDialURI>x-cisco-serviceuri-abbrdial</abbreviatedDialURI>
<rfc2543Hold>false</rfc2543Hold>
<callHoldRingback>2</callHoldRingback>
<URIDialingDisplayPreference>1</URIDialingDisplayPreference>
<localCfwdEnable>true</localCfwdEnable>
<semiAttendedTransfer>true</semiAttendedTransfer>
<anonymousCallBlock>2</anonymousCallBlock>
<callerIdBlocking>2</callerIdBlocking>
<dndControl>0</dndControl>
<remoteCcEnable>true</remoteCcEnable>
<retainForwardInformation>false</retainForwardInformation>
</sipCallFeatures>
<sipStack>
<sipInviteRetx>6</sipInviteRetx>
<sipRetx>10</sipRetx>
<timerInviteExpires>180</timerInviteExpires>
<timerRegisterExpires>3600</timerRegisterExpires>
<timerRegisterDelta>5</timerRegisterDelta>
<timerKeepAliveExpires>120</timerKeepAliveExpires>
<timerSubscribeExpires>120</timerSubscribeExpires>
<timerSubscribeDelta>5</timerSubscribeDelta>
<timerT1>500</timerT1>
<timerT2>4000</timerT2>
<maxRedirects>70</maxRedirects>
<remotePartyID>true</remotePartyID>
<userInfo>None</userInfo>
</sipStack>
<autoAnswerTimer>1</autoAnswerTimer>
<autoAnswerAltBehavior>false</autoAnswerAltBehavior>
<autoAnswerOverride>true</autoAnswerOverride>
<transferOnhookEnabled>false</transferOnhookEnabled>
<enableVad>false</enableVad>
<preferredCodec>none</preferredCodec>
<dtmfAvtPayload>101</dtmfAvtPayload>
<dtmfDbLevel>3</dtmfDbLevel>
<dtmfOutofBand>avt</dtmfOutofBand>
<kpml>3</kpml>
<phoneLabel></phoneLabel>
<stutterMsgWaiting>2</stutterMsgWaiting>
<callStats>true</callStats>
<offhookToFirstDigitTimer>15000</offhookToFirstDigitTimer>
<T302Timer>6000</T302Timer>
<silentPeriodBetweenCallWaitingBursts>10</silentPeriodBetweenCallWaitingBursts>
<disableLocalSpeedDialConfig>true</disableLocalSpeedDialConfig>
<poundEndOfDial>false</poundEndOfDial>
<startMediaPort>16384</startMediaPort>
<stopMediaPort>32766</stopMediaPort>
<startVideoPort>0</startVideoPort>
<stopVideoPort>0</stopVideoPort>
<organizationTopLevelDomain>ucalpha.com</organizationTopLevelDomain>
<sipLines>
<line  button="1" lineIndex="1">
<featureID>9</featureID>
<featureLabel>BDK106 7821 40361</featureLabel>
<proxy>USECALLMANAGER</proxy>
<port>5060</port>
<name>40361</name>
<displayName>BDK106 7821</displayName>
<autoAnswer>
<autoAnswerEnabled>2</autoAnswerEnabled>
</autoAnswer>
<callWaiting>3</callWaiting>
<sharedLine>true</sharedLine>
<messageWaitingLampPolicy>3</messageWaitingLampPolicy>
<messageWaitingAMWI>0</messageWaitingAMWI>
<messagesNumber>40600</messagesNumber>
<ringSettingIdle>4</ringSettingIdle>
<ringSettingActive>5</ringSettingActive>
<contact>6270f0fa-80fe-b49f-7ad3-e61eb3cf9a16</contact>
<forwardCallInfoDisplay>
<callerName>true</callerName>
<callerNumber>false</callerNumber>
<redirectedNumber>false</redirectedNumber>
<dialedNumber>true</dialedNumber>
</forwardCallInfoDisplay>
<maxNumCalls>4</maxNumCalls>
<busyTrigger>2</busyTrigger>
</line>
<line  button="2">
<featureID>2</featureID>
<featureLabel></featureLabel>
<speedDialNumber>40384</speedDialNumber>
<speedDialIndex>1</speedDialIndex>
</line>
</sipLines>
<externalNumberMask>7639719800</externalNumberMask>
<voipControlPort>5060</voipControlPort>
<dscpForAudio  tcl="conversational.audio.aq:admitted">184</dscpForAudio>
<dscpVideo  tcl="conversational.video.avconf.aq:admitted">136</dscpVideo>
<dscpAudioForVideo  tcl="conversational.audio.avconf.aq:admitted">136</dscpAudioForVideo>
<dscpForTelepresence  tcl="conversational.video.immersive.aq:admitted">136</dscpForTelepresence>
<dscpAudioForTelepresence  tcl="conversational.audio.immersive.aq:admitted">128</dscpAudioForTelepresence>
<dscpForPriorityAudio>180</dscpForPriorityAudio>
<dscpForImmediateAudio>176</dscpForImmediateAudio>
<dscpForFlashAudio>164</dscpForFlashAudio>
<dscpForFlashOverrideAudio>168</dscpForFlashOverrideAudio>
<dscpForExecutiveOverrideAudio>168</dscpForExecutiveOverrideAudio>
<dscpForPriorityVideo>156</dscpForPriorityVideo>
<dscpForImmediateVideo>148</dscpForImmediateVideo>
<dscpForFlashVideo>140</dscpForFlashVideo>
<dscpForFlashOverrideVideo>132</dscpForFlashOverrideVideo>
<dscpForExecutiveOverrideVideo>132</dscpForExecutiveOverrideVideo>
<ringSettingBusyStationPolicy>0</ringSettingBusyStationPolicy>
<dialTemplate></dialTemplate>
<softKeyFile>SKa9bea76c-2993-07f8-9c8f-07e996ec91d4.xml</softKeyFile>
<alwaysUsePrimeLine>false</alwaysUsePrimeLine>
<alwaysUsePrimeLineVoiceMail>false</alwaysUsePrimeLineVoiceMail>
</sipProfile>
<MissedCallLoggingOption>1</MissedCallLoggingOption>
<commonProfile>
<phonePassword></phonePassword>
<backgroundImageAccess>true</backgroundImageAccess>
<callLogBlfEnabled>3</callLogBlfEnabled>
</commonProfile>
<loadInformation>%FWLOAD%.12-5-1SR2-2</loadInformation>
<inactiveLoadInformation></inactiveLoadInformation>
<vendorConfig>
<disableSpeaker>false</disableSpeaker><disableSpeakerAndHeadset>false</disableSpeakerAndHeadset><pcPort>0</pcPort><garp>1</garp><voiceVlanAccess>0</voiceVlanAccess><spanToPCPort>1</spanToPCPort><loggingDisplay>1</loggingDisplay><recordingTone>0</recordingTone><recordingToneLocalVolume>100</recordingToneLocalVolume><recordingToneRemoteVolume>50</recordingToneRemoteVolume><recordingToneDuration></recordingToneDuration><moreKeyReversionTimer>5</moreKeyReversionTimer><lldpAssetId></lldpAssetId><powerPriority>0</powerPriority><LineKeyBarge>0</LineKeyBarge><minimumRingVolume>0</minimumRingVolume><ehookEnable>0</ehookEnable><headsetWidebandUIControl>0</headsetWidebandUIControl><headsetWidebandEnable>0</headsetWidebandEnable><recentsSoftkey>1</recentsSoftkey></vendorConfig>
<commonConfig>
<ciscoCamera>1</ciscoCamera><requireScreenLock>0</requireScreenLock><webAccess>1</webAccess><sshAccess>1</sshAccess><RingLocale>0</RingLocale><ice></ice><instantMessaging></instantMessaging><desktopClient></desktopClient></commonConfig>
<enterpriseConfig>
<ciscoCamera>1</ciscoCamera><requireScreenLock>0</requireScreenLock><webProtocol>0</webProtocol><webAccess>1</webAccess><appInstallFromAndroidMarket>true</appInstallFromAndroidMarket><enableCiscoUcmAppClient>true</enableCiscoUcmAppClient><presenceServerPri>10.89.174.16</presenceServerPri><presenceServerType>1</presenceServerType><vxcVpnOption>1</vxcVpnOption><softkeyControl>1</softkeyControl><ice></ice><instantMessaging></instantMessaging><desktopClient></desktopClient></enterpriseConfig>
<versionStamp>1555108264-18843a73-f9e1-4a3b-99bb-86295a710462</versionStamp>
<userLocale>
<name>English_United_States</name>
<uid>1</uid>
<langCode>en_US</langCode>
<version>11.0.0.0(1)</version>
<winCharSet>iso-8859-1</winCharSet>
</userLocale>
<networkLocale>United_States</networkLocale>
<networkLocaleInfo>
<name>United_States</name>
<uid>64</uid>
<version>11.0.0.0(1)</version>
</networkLocaleInfo>
<deviceSecurityMode>1</deviceSecurityMode>
<idleTimeout>0</idleTimeout>
<authenticationURL>http://democm01.ucalpha.com:8080/ccmcip/authenticate.jsp</authenticationURL>
<directoryURL>http://democm01.ucalpha.com:8080/ccmcip/xmldirectory.jsp</directoryURL>
<idleURL></idleURL>
<informationURL>http://democm01.ucalpha.com:8080/ccmcip/GetTelecasterHelpText.jsp</informationURL>
<messagesURL></messagesURL>
<proxyServerURL></proxyServerURL>
<servicesURL>http://democm01.ucalpha.com:8080/ccmcip/getservicesmenu.jsp</servicesURL>
<secureAuthenticationURL>https://democm01.ucalpha.com:8443/ccmcip/authenticate.jsp</secureAuthenticationURL>
<secureDirectoryURL>https://democm01.ucalpha.com:8443/ccmcip/xmldirectory.jsp</secureDirectoryURL>
<secureUDSUsersAccessURL>https://democm01.ucalpha.com:8443/cucm-uds/users</secureUDSUsersAccessURL>
<secureIdleURL></secureIdleURL>
<secureInformationURL>https://democm01.ucalpha.com:8443/ccmcip/GetTelecasterHelpText.jsp</secureInformationURL>
<secureMessagesURL></secureMessagesURL>
<secureServicesURL>https://democm01.ucalpha.com:8443/ccmcip/getservicesmenu.jsp</secureServicesURL>
<dscpForSCCPPhoneConfig>96</dscpForSCCPPhoneConfig>
<dscpForSCCPPhoneServices>0</dscpForSCCPPhoneServices>
<dscpForCm2Dvce>96</dscpForCm2Dvce>
<transportLayerProtocol>4</transportLayerProtocol>
<dialToneSetting>1</dialToneSetting>
<dndCallAlert>5</dndCallAlert>
<phonePersonalization>1</phonePersonalization>
<rollover>0</rollover>
<singleButtonBarge>0</singleButtonBarge>
<joinAcrossLines>0</joinAcrossLines>
<autoCallPickupEnable>false</autoCallPickupEnable>
<blfAudibleAlertSettingOfIdleStation>0</blfAudibleAlertSettingOfIdleStation>
<blfAudibleAlertSettingOfBusyStation>0</blfAudibleAlertSettingOfBusyStation>
<capfAuthMode>0</capfAuthMode>
<capfList>
<capf>
<phonePort>3804</phonePort>
<processNodeName></processNodeName>
</capf>
</capfList>
<certHash></certHash>
<encrConfig>false</encrConfig>
<advertiseG722Codec>0</advertiseG722Codec>
<mobility>
<handoffdn></handoffdn>
<dtmfdn></dtmfdn>
<ivrdn></ivrdn>
<dtmfHoldCode>*81</dtmfHoldCode>
<dtmfExclusiveHoldCode>*82</dtmfExclusiveHoldCode>
<dtmfResumeCode>*83</dtmfResumeCode>
<dtmfTxfCode>*84</dtmfTxfCode>
<dtmfCnfCode>*85</dtmfCnfCode>
</mobility>
<TLSResumptionTimer>3600</TLSResumptionTimer>
<userId  serviceProfileFile="SPDefault.cnf.xml">bdk106</userId>
<ownerId  serviceProfileFile="SPDefault.cnf.xml">bdk106</ownerId>
<phoneServices  useHTTPS="true">
<provisioning>0</provisioning>
<phoneService  type="1" category="0">
<name>Missed Calls</name>
<url>Application:Cisco/MissedCalls</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="2" category="0">
<name>Voicemail</name>
<url>Application:Cisco/Voicemail</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="1" category="0">
<name>Received Calls</name>
<url>Application:Cisco/ReceivedCalls</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="1" category="0">
<name>Placed Calls</name>
<url>Application:Cisco/PlacedCalls</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="1" category="0">
<name>Personal Directory</name>
<url>Application:Cisco/PersonalDirectory</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="1" category="0">
<name>Corporate Directory</name>
<url>Application:Cisco/CorporateDirectory</url>
<vendor></vendor>
<version></version>
</phoneService>
<phoneService  type="0" category="0">
<name>Extension Mobility</name>
<url>http://10.89.174.10:8080/emapp/EMAppServlet?device=#DEVICENAME#&amp;EMCC=#EMCC#</url>
<vendor></vendor>
<version></version>
</phoneService>
</phoneServices>
</device>]
  
  
  xml_string.sub!("%FWLOAD%",firmware_load_fragment)
  
  body xml_string
  
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
          xml.text("http://#{SERVER_IP}:6970/license/$MAU.lic")
        }
        xml.send("Upgrade_Rule", "ua" => "na"){
          if(model == "8832")
            xml.text("http://#{SERVER_IP}:6970/mpp/#{firmware_load_fragment}.11-2-3MPP-412.loads")
          else
            xml.text("http://#{SERVER_IP}:6970/mpp/#{firmware_load_fragment}.11-2-3MPP-398.loads")
          end
        }
      end
      
    end
    
  end

  body psn.to_xml
end

get "/:filename" do
  filename = params[:filename]
  if(FIRMWARE_TO_SERVE == "Enterprise")
    send_file "#{settings.public_folder}/enterprise/#{filename}", :filename => filename, :disposition => 'attachment', :type => 'application/octet-stream'
  elsif(FIRMWARE_TO_SERVE == "Transitional")
    send_file "#{settings.public_folder}/transitional/#{filename}", :filename => filename, :disposition => 'attachment', :type => 'application/octet-stream'
  end
end

get "/mpp/:filename" do
  filename = params[:filename]
  send_file "#{settings.public_folder}/mpp/#{filename}", :filename => filename, :disposition => 'attachment', :type => 'application/octet-stream'
end

get "/license/:filename" do
  filename = params[:filename]
  send_file "#{settings.public_folder}/license/#{filename}", :filename => filename, :disposition => 'attachment', :type => 'application/octet-stream'
end