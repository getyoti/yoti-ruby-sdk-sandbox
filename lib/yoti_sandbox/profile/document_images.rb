# frozen_string_literal: true

module Yoti
  module Sandbox
    module Profile
      class DocumentImages
        #
        # @param [Array<Image>] images
        #
        def initialize(images)
          Validation.assert_is_a(Array, images, 'images')
          @images = images
        end

        #
        # @return [DocumentImagesBuilder]
        #
        def self.builder
          DocumentImagesBuilder.new
        end

        #
        # @return [String]
        #
        def value
          @images
            .map(&:base64_content)
            .join('&')
        end
      end

      #
      # Builder for {DocumentImages}
      #
      class DocumentImagesBuilder
        def initialize
          @images = []
        end

        #
        # @param [bin] content
        #
        # @return [self]
        #
        def with_jpeg_content(content)
          @images << Yoti::ImageJpeg.new(content)
          self
        end

        #
        # @param [bin] content
        #
        # @return [self]
        #
        def with_png_content(content)
          @images << Yoti::ImagePng.new(content)
          self
        end

        #
        # @return [DocumentImages]
        #
        def build
          DocumentImages.new(@images)
        end
      end
    end
  end
end
