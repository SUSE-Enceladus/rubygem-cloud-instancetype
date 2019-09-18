require "cloud/instancetype/version"
require "json"

module Cloud
  # Describe a public cloud instance type
  class InstanceType
    attr_reader :sort_value, :key, :category, :vcpu_count, :ram_bytes,
      :ram_si_units, :details

    def initialize(key, raw_data)
      @key = key
      @sort_value = raw_data["sort_value"]
      @category = Cloud::InstanceCategory.new(raw_data["category"])
      @vcpu_count = raw_data["vcpu_count"]
      @ram_bytes = raw_data["ram_bytes"]
      @ram_si_units = raw_data["ram_si_units"]
      @details = raw_data["details"]
    end

    def <=>(other)
      sort_value <=> other.sort_value
    end

    class << self
      def for(cloud)
        load(rails_data_path(cloud))
      end

      def load(data_path)
        raw_collection = get_raw_collection(data_path)
        instance_type_collection_factory(
          raw_collection["instance_types"],
          raw_collection["categories"]
        )
      end

      private

      def rails_data_path(cloud)
        Rails.root.join("config", "data", "#{cloud}-types.json")
      end

      def get_raw_collection(data_path)
        JSON.parse(File.read(data_path))
      end

      def instance_type_collection_factory(raw_types, raw_categories)
        raw_types.collect do |key, values|
          values["category"] = raw_categories[values["category"]]
          InstanceType.new(key, values)
        end.sort!
      end
    end
  end

  # Describe a public cloud category
  class InstanceCategory
    attr_reader :name, :description, :features

    def initialize(args)
      @name = args["key"]
      @description = args["description"]
      @features = args["features"]
    end
  end
end
