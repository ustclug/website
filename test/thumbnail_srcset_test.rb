# frozen_string_literal: true

module Jekyll
  module Hooks
    def self.register(*)
      # Jekyll is not needed for unit-testing the HTML rewrite.
    end
  end
end

require_relative '../_plugins/thumbnail_srcset'

class ThumbnailSrcsetTest
  CONFIG = {
    'widths' => [640, 1024],
    'formats' => %w[jpg png]
  }.freeze

  def self.run
    tests = instance_methods(false).grep(/^test_/).sort
    tests.each { |test| new.public_send(test) }
    puts "#{tests.length} tests passed"
  end

  def assert(condition, message = 'assertion failed')
    raise message unless condition
  end

  def assert_equal(expected, actual)
    assert expected == actual, "Expected #{expected.inspect}, got #{actual.inspect}"
  end

  def assert_includes(value, substring)
    assert value.include?(substring), "Expected #{value.inspect} to include #{substring.inspect}"
  end

  def test_rewrites_eligible_image_and_preserves_attributes
    input = '<img class="photo" src="https://ftp.lug.ustc.edu.cn/photos/a.JPG" alt="A > B">'

    assert_equal(
      '<img class="photo" src="https://ftp.lug.ustc.edu.cn/photos/a.JPG" alt="A > B" ' \
      'srcset="https://ftp.lug.ustc.edu.cn/photos/a.JPG@640w.JPG 640w, ' \
      'https://ftp.lug.ustc.edu.cn/photos/a.JPG@1024w.JPG 1024w">',
      Jekyll::ThumbnailSrcset.rewrite(input, CONFIG)
    )
  end

  def test_places_parameters_before_query_and_fragment
    input = '<img src="http://ftp.lug.ustc.edu.cn/a.png?download=1#preview" />'
    output = Jekyll::ThumbnailSrcset.rewrite(input, CONFIG)

    assert_includes output, 'http://ftp.lug.ustc.edu.cn/a.png@640w.png?download=1#preview 640w'
    assert output.end_with?(' />')
  end

  def test_does_not_replace_existing_srcset
    input = '<img src="https://ftp.lug.ustc.edu.cn/a.jpg" srcset="custom.jpg 1x">'

    assert_equal input, Jekyll::ThumbnailSrcset.rewrite(input, CONFIG)
  end

  def test_does_not_treat_data_src_as_src
    input = '<img data-src="https://ftp.lug.ustc.edu.cn/a.jpg">'

    assert_equal input, Jekyll::ThumbnailSrcset.rewrite(input, CONFIG)
  end

  def test_ignores_ineligible_sources
    inputs = [
      '<img src="https://example.com/a.jpg">',
      '<img src="https://ftp.lug.ustc.edu.cn/a.svg">',
      '<img src="https://ftp.lug.ustc.edu.cn/.yatex/a.jpg">',
      '<img src="/a.jpg">'
    ]

    inputs.each do |input|
      assert_equal input, Jekyll::ThumbnailSrcset.rewrite(input, CONFIG)
    end
  end
end

ThumbnailSrcsetTest.run
