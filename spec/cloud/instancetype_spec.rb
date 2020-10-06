require "spec_helper"

RSpec.describe Cloud::InstanceType do
  it "has a version number" do
    expect(Cloud::InstanceType::VERSION).not_to be nil
  end

  # use a known sample to verify attribute relationships
  context "sample data" do
    let(:collection) { described_class.load('spec/fixtures/sample.json') }

    it "sorts by sort_value" do
      expect(collection.collect(&:sort_value)).to eq(['01', '10', '20'])
    end

    it "creates a key attribute from the dictionary key" do
      expect(collection.first.key).to eq('type_2')
    end

    it "maps known attributes to the instance type" do
      instance_type = collection.find{ |t| t.key == 'type_1' }
      expect(instance_type.name).to eq("Type #1")
      expect(instance_type.sort_value).to eq("10")
      expect(instance_type.vcpu_count).to eq(1)
      expect(instance_type.ram_bytes).to eq(1)
      expect(instance_type.ram_si_units).to eq(true)
      expect(instance_type.details).to be_empty
      expect(instance_type.category.key).to eq('category_2_key')
    end

    it "maps the category attributes into the instance" do
      category = collection.first.category
      expect(category.key).to eq('category_1_key')
      expect(category.name).to eq('Category 1')
      expect(category.description).to eq('Description of category 1.')
      expect(category.features).to eq(['Feature 1', 'Feature 2'])
    end
  end

  # the InstanceType is basically a convenience class for accessing data
  # in the relevant config files... so the tests center around verifying that
  # the config files load properly and the expected attributes are available.
  frameworks = ["azure", "ec2", "gce"]
  frameworks.each do |framework|
    describe "framework: #{framework}" do
      described_class.load("spec/fixtures/#{framework}-types.json").each do |instance_type|
        describe "instance_type: #{instance_type.key}" do
          it "has a key" do
            expect(instance_type.key).not_to be_blank
          end
          it "has a name" do
            expect(instance_type.name).not_to be_blank
          end
          it "has a sort value" do
            expect(instance_type.sort_value).not_to be_blank
          end
          it "has a vCPU count" do
            expect(instance_type.vcpu_count).not_to be_blank
          end
          it "has a RAM size in bytes" do
            expect(instance_type.ram_bytes).not_to be_blank
          end
          it "defines a unit scale for RAM" do
            expect(instance_type.ram_si_units).to be_truthy.or be_falsey
          end
          it "may have a list of details" do
            expect(instance_type.details).to be_an(Enumerable)
          end
          it "has a category" do
            expect(instance_type.category).not_to be_blank
          end
          it "has a category name" do
            expect(instance_type.category.name).not_to be_blank
          end
          it "has a category description" do
            expect(instance_type.category.description).not_to be_blank
          end
          it "has a list of category features" do
            expect(instance_type.category.features).to be_an(Enumerable)
          end
        end
      end
    end
  end
end
