require "test_helper"

class AdvertisementTest < ActiveSupport::TestCase
  setup do
    # Prepares the advertisemetns with the values from the fixtures
    @advertisement = advertisements(:one)
    @advertisementTwo = advertisements(:two)

    # As a file cannot be added within the fixtures due to the yml format, I am adding it here using active storage
    #https://edgeguides.rubyonrails.org/active_storage_overview.html#configuring-services
    @advertisement.file.attach(io: File.open('test\fixtures\files\Advertisement_test.png'), filename: 'Advertisement_test.png', content_type: 'image/png')
    @advertisementTwo.file.attach(io: File.open('test\fixtures\files\BP_Poster_01.cuap'), filename: 'BP_Poster_01.cuap', content_type: 'cuap')
  end

  test "should check image is png" do
    assert_empty @advertisement.errors[:file], "There should be no errors on the file for a PNG image"
  end

  test "should check image is not accepted" do
    assert_not_empty @advertisementTwo.errors[:file]
  end

end
