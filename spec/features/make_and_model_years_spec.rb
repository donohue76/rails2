require 'rails_helper'

RSpec.feature "MakeAndModelYears", type: :feature do
  it "should show the welcome page" do
    visit '/cars/new_car'
    expect(page).to have_content("Welcome to the Car Simulator")
  end

  it "should have input fields for 'make' and 'model_year' to be simulated." do
    visit '/cars/new_car'
    expect(page).to have_field("make")
    expect(page).to have_field("model_year")
  end

  it "should remain on the current page if fields are empty after submit is clicked" do
    visit_welcome_and_blank_fields
    expect(page).to have_field("make", with:'')
    expect(page).to have_field("model_year", with:'')

    click_button 'Simulate Car'

    expect(page.current_path).to eq('/cars/new_car')
  end

  it "after entering make and model_year, and clicking on a button labeled 'Simulate Car', I am taken to a status page." do
    visit_welcome_and_fill_in_make_and_model
    expect(page).to have_field("make", with:'Ferrari')
    expect(page).to have_field("model_year", with:'1968')

    click_button 'Simulate Car'

    expect(page.current_path).to eq('/simulator/do')
  end

  it "should display the make and model year from the welcome page" do
    visit_welcome_and_fill_in_make_and_model
    expect(page).to have_field("make", with:'Ferrari')
    expect(page).to have_field("model_year", with:'1968')

    click_button 'Simulate Car'

    expect(page.current_path).to eq('/simulator/do')

    expect(page).to have_content("1968 Ferrari")
  end

  it "should have a description text area on the welcome page" do
    visit '/cars/new_car'
    expect(page).to have_field("desc")
  end

  it "should display the make, model year, and desc from the welcome page" do
    visit_welcome_and_fill_in_make_model_desc
    expect(page).to have_field("make", with:'Ferrari')
    expect(page).to have_field("model_year", with:'1968')
    expect(page).to have_field("desc", with:'This car friggin rules. Go get one! The debt is worth it!')

    click_button 'Simulate Car'

    expect(page.current_path).to eq('/simulator/do')

    expect(page).to have_content("1968 Ferrari")
    expect(page).to have_selector("p[id='desc']", :text =>"This car friggin rules. Go get one! The debt is worth it!")
  end

  it "should have a color input type on the welcome page" do
    visit '/cars/new_car'
    expect(page).to have_field("color")
  end

  it "should display the make, model year, color, and desc from the welcome page" do
    visit_welcome_and_fill_in_make_model_desc
    expect(page).to have_field("make", with:'Ferrari')
    expect(page).to have_field("model_year", with:'1968')
    expect(page).to have_field("desc", with:'This car friggin rules. Go get one! The debt is worth it!')
    # expect(page).to have_field("color", with: '#0000FF')

    click_button 'Simulate Car'
    expect(page.current_path).to eq('/simulator/do')

    expect(page).to have_content("1968 Ferrari")
    expect(page).to have_selector("p[id='desc']", :text =>"This car friggin rules. Go get one! The debt is worth it!")
    expect(page).to have_color(color: '#0000FF')
  end

  def visit_welcome_and_fill_in_make_and_model
    visit '/cars/new_car'

    within("form#make_model") do
      fill_in("make", with: 'Ferrari')
      fill_in("model_year", with: '1968')
    end
  end

  def visit_welcome_and_fill_in_make_model_desc
    visit '/cars/new_car'

    within("form#make_model") do
      fill_in("make", with: 'Ferrari')
      fill_in("model_year", with: '1968')
      fill_in("desc", with: 'This car friggin rules. Go get one! The debt is worth it!')
    end
  end

  def visit_welcome_and_fill_in_make_model_desc_color
    visit '/cars/new_car'

    within("form#make_model") do
      fill_in("make", with: 'Ferrari')
      fill_in("model_year", with: '1968')
      fill_in("desc", with: 'This car friggin rules. Go get one! The debt is worth it!')
      fill_in("color", with: '#0000FF')
    end
  end

  def visit_welcome_and_blank_fields
    visit '/cars/new_car'

    within("form#make_model") do
      fill_in("make", with: '')
      fill_in("model_year", with: '')
    end
  end

  it "should display that the lights are off" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'
    expect(page).to have_selector("input[id=lights][type=submit][value='Lights are off!']")
  end

  it "should display that the lights are on when the light button is pressed" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'
    click_button 'Lights are off!'
    expect(page).to have_selector("input[id=lights][type=submit][value='Lights are on!']")
  end

  it "should display the current speed" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'
    #only tests if the tag includes the given text, not exact match
    expect(page).to have_selector("p[id='speed']", :text => /\A0mph\Z/)
  end

  it "should press the accelerate button and bring speed to 10mph" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'
    click_button 'Accelerate'
    #only tests if the tag includes the given text, not exact match
    expect(page).to have_selector("p[id='speed']", :text =>/\A10mph\Z/)
  end

  it "should press the accelerate button and and then the brake button to bring speed to 2mph" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'
    click_button 'Accelerate'
    click_button 'Brake'
    #only tests if the tag includes the given text, not exact match
    expect(page).to have_selector("p[id='speed']", :text =>/\A2mph\Z/)
  end

  it "should show that the parking brake is off" do
    visit_welcome_and_fill_in_make_and_model
    click_button 'Simulate Car'


end
