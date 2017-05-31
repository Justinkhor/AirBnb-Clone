require 'test_helper'

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = listings(:one)
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    assert_difference('Listing.count') do
      post listings_url, params: { listing: { address: @listing.address, bed_number: @listing.bed_number, city: @listing.city, country: @listing.country, description: @listing.description, guest_number: @listing.guest_number, place_type: @listing.place_type, price_per_night: @listing.price_per_night, property_type: @listing.property_type, room_number: @listing.room_number, state: @listing.state, user_id: @listing.user_id, zipcode: @listing.zipcode } }
    end

    assert_redirected_to listing_url(Listing.last)
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    patch listing_url(@listing), params: { listing: { address: @listing.address, bed_number: @listing.bed_number, city: @listing.city, country: @listing.country, description: @listing.description, guest_number: @listing.guest_number, place_type: @listing.place_type, price_per_night: @listing.price_per_night, property_type: @listing.property_type, room_number: @listing.room_number, state: @listing.state, user_id: @listing.user_id, zipcode: @listing.zipcode } }
    assert_redirected_to listing_url(@listing)
  end

  test "should destroy listing" do
    assert_difference('Listing.count', -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end
end
