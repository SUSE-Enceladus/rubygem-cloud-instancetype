require "cloud/instancetype/version"
require "json"

module Cloud
  # Describe a public cloud instance type
  class InstanceType
    attr_reader :name, :sort_value, :key, :category, :vcpu_count, :ram_bytes,
      :ram_si_units, :details

    def initialize(key, raw_data)
      @key = key
      @name = raw_data["name"]
      @sort_value = raw_data["sort_value"]
      @vcpu_count = raw_data["vcpu_count"]
      @ram_bytes = raw_data["ram_bytes"]
      @ram_si_units = raw_data["ram_si_units"]
      @details = raw_data["details"]
      return unless raw_data["category_key"]

      @category = Cloud::InstanceCategory.new(
        raw_data["category_key"], 
        raw_data["category"]
      )
    end

    def <=>(other)
      sort_value <=> other.sort_value
    end

    class << self
      def for(cloud)
        load(rails_vendor_path(cloud))
      rescue
        load(rails_config_path(cloud))
      end

      def load(data_path)
        raw_collection = get_raw_collection(data_path)
        instance_type_collection_factory(
          raw_collection["instance_types"],
          raw_collection["categories"]
        )
      end

      private

      def rails_config_path(cloud)
        Rails.root.join("config", "data", "#{cloud}-types.json")
      end

      def rails_vendor_path(cloud)
        Rails.root.join("vendor", "data", "#{cloud}-types.json")
      end

      def get_raw_collection(data_path)
        JSON.parse(File.read(data_path))
      end

      def instance_type_collection_factory(raw_types, raw_categories)
        raw_types.collect do |key, values|
          values["category_key"] = values["category"]
          values["category"] = raw_categories[values["category"]]
          InstanceType.new(key, values)
        end.sort!
      end
    end
  end

  # Describe a public cloud category
  class InstanceCategory
    attr_reader :key, :name, :description, :features

    def initialize(key, args)
      @key = key
      @name = args["name"]
      @description = args["description"]
      @features = args["features"]
    end
  end
end
