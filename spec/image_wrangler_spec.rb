require 'spec_helper'

describe Gatling::ImageWrangler do

  class Point
    attr_accessor :x, :y
  end

  class Size
    attr_accessor :width, :height
  end

  it 'should get the position of the css element' do

    #Overiding the stupid public method :y of YAML module

    location = Point.new
    location.x = 1
    location.y = 2

    size = Size.new
    size.width = 100
    size.height = 200

    mock_element = mock
    mock_element.stub(:native).and_return(mock_element)
    mock_element.stub(:location).and_return(location)
    mock_element.stub(:size).and_return(size)

    position = Gatling::ImageWrangler.get_element_position(mock_element)

    position[:x].should eql(1)
    position[:y].should eql(2)
    position[:width].should eql(100)
    position[:height].should eql(200)
  end

  it 'should return true if images match' do
    acutal_image_mock = mock(Magick::Image)  
    acutal_image = Gatling::Image.new
    acutal_image.rmagick_image = acutal_image_mock
    
    expected_image_mock = mock(Magick::Image)
    expected_image = Gatling::Image.new
    expected_image.rmagick_image = expected_image_mock
    
    acutal_image_mock.should_receive(:compare_channel).with(expected_image_mock,Magick::MeanAbsoluteErrorMetric).and_return([nil, 0.0])
    
    Gatling::ImageWrangler.compare(expected_image, acutal_image).should eql [nil, 0.0]
  end

  it 'should return false if images dont match' do
    acutal_image_mock = mock(Magick::Image)  
    acutal_image = Gatling::Image.new
    acutal_image.rmagick_image = acutal_image_mock
    
    expected_image_mock = mock(Magick::Image)
    expected_image = Gatling::Image.new
    expected_image.rmagick_image = expected_image_mock
    
    acutal_image_mock.stub(:compare_channel).and_return([nil, 0.1])

    Gatling::ImageWrangler.compare(expected_image, acutal_image).should eql [nil, 0.1]
  end


end