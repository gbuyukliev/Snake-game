require "spec_helper"

describe Apple do
	it "is random" do
		apple = Apple.new
		apple.x.should and apple.y.should == random
	end
end	