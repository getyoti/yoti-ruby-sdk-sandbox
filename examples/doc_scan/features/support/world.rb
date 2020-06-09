# frozen_string_literal: true

require 'selenium-webdriver'

module Yoti
  module Demo
    module DocScan
      #
      # Doc Scan World
      #
      module World
        #
        # @return [Selenium::WebDriver]
        #
        def driver
          @driver ||= create_driver
        end

        #
        # @return [Selenium::WebDriver]
        #
        def create_driver
          driver = Selenium::WebDriver.for(
            :chrome,
            url: 'http://localhost:4444/wd/hub',
            options: Selenium::WebDriver::Chrome::Options
                       .new(
                         args: [
                           '--no-sandbox',
                           '--disable-dev-shm-usage',
                           '--disable-gpu',
                           '--window-size=1280,2000',
                           '--ignore-certificate-errors'
                         ]
                       )
          )
          driver.manage.timeouts.implicit_wait = 5000
          driver
        end

        #
        # Configure Session Response
        #
        def configure_session_response
          iframe_uri = URI.parse(driver.find_element(tag_name: 'iframe').attribute('src'))
          session_id = CGI.parse(iframe_uri.query)['sessionID'].first

          response_config = Yoti::Sandbox::DocScan::Request::ResponseConfig
                            .builder
                            .with_check_reports(
                              Yoti::Sandbox::DocScan::Request::CheckReports
                              .builder
                              .with_async_report_delay(5)
                              .with_document_authenticity_check(
                                Yoti::Sandbox::DocScan::Request::DocumentAuthenticityCheck
                                .builder
                                .with_breakdown(
                                  Yoti::Sandbox::DocScan::Request::Breakdown
                                  .builder
                                  .with_sub_check('security_features')
                                  .with_result('NOT_AVAILABLE')
                                  .with_detail('some_detail', 'some_detail_value')
                                  .build
                                )
                                .with_recommendation(
                                  Yoti::Sandbox::DocScan::Request::Recommendation
                                    .builder
                                    .with_value('NOT_AVAILABLE')
                                    .with_reason('PICTURE_TOO_DARK')
                                    .with_recovery_suggestion('BETTER_LIGHTING')
                                    .build
                                )
                                .build
                              )
                              .with_document_text_data_check(
                                Yoti::Sandbox::DocScan::Request::DocumentTextDataCheck
                                .builder
                                .with_breakdown(
                                  Yoti::Sandbox::DocScan::Request::Breakdown
                                  .builder
                                  .with_sub_check('document_in_date')
                                  .with_result('PASS')
                                  .build
                                )
                                .with_recommendation(
                                  Yoti::Sandbox::DocScan::Request::Recommendation
                                  .builder
                                  .with_value('APPROVE')
                                  .build
                                )
                                .with_document_fields(
                                  full_name: 'John Doe',
                                  nationality: 'GBR',
                                  date_of_birth: '1986-06-01',
                                  document_number: '123456789'
                                )
                                .build
                              )
                              .build
                            )
                            .with_task_results(
                              Yoti::Sandbox::DocScan::Request::TaskResults
                              .builder
                              .with_document_text_data_extraction_task(
                                Yoti::Sandbox::DocScan::Request::DocumentTextDataExtractionTask
                                .builder
                                .with_document_fields(
                                  full_name: 'John Doe',
                                  nationality: 'GBR',
                                  date_of_birth: '1986-06-01',
                                  document_number: '123456789'
                                )
                                .build
                              )
                              .build
                            )
                            .build

          sandbox_client = Yoti::Sandbox::DocScan::Client.new
          sandbox_client.configure_session_response(session_id, response_config)
        end

        #
        # @return [String]
        #
        def base_url
          ENV['YOTI_APP_BASE_URL']
        end

        #
        # @param [String] path
        #
        def visit(path)
          driver.navigate.to("#{base_url}#{path}")
        end

        #
        # Switch to iframe
        #
        def switch_to_iframe
          driver.switch_to.frame(0)
        end

        #
        # @param [String] selector
        #
        def click_on(selector)
          driver.find_element(css: selector).click
        end

        #
        # @param [String] selector
        #
        # @return [String]
        #
        def element_text(selector)
          driver.find_element(css: selector).text
        end

        #
        # @param [Integer] seconds
        #
        def wait(seconds)
          sleep(seconds)
        end

        #
        # Upload a document image
        #
        def upload_document
          element = driver.find_element(css: "input[data-qa='change-photo']")
          element.send_keys('/usr/src/resources/image.jpg')
        end
      end
    end
  end
end

World(Yoti::Demo::DocScan::World)
