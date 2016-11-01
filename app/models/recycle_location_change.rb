class RecycleLocationChange < ApplicationRecord
  KINDS = %i(recycle_center recycle_station).freeze
  MATERIALS = %w(glass cardboard plastic magazines metal).freeze
  COMPARABLE_ATTRIBUTES = %w(kind materials latitude longitude street_name zip_code city opening_hours).freeze
  WEEKDAYS = %w(mon tue wed thu fri sat sun)
  enum kind: KINDS

  reverse_geocoded_by :latitude, :longitude

  def apply(params)
    change = RecycleLocationChange.find(id)
    location = RecycleLocation.find(location_id)

    params.each do |param_key, param_value|
      # Filter out invalid keys
      if is_comparable? param_key
        # Handle indexed keys. Ex. 'opening_hours_mon'
        if is_indexed? param_key
          # Fetch value from database if checkbox is checked
          value = param_value != "" ? change[remove_index_name(param_key)][get_index(param_key)] : nil

          # If checkbox isn't checked continue to next entry
          next if value.nil?

          # Set key
          location.attributes[remove_index_name(param_key)][get_index(param_key)] = value
        # Handle single keys
        else
          # Fetch value from database if checkbox is checked
          value = param_value != "" ? change[param_key] : nil

          # If checkbox isn't checked continue to next entry
          next if value.nil?

          # Set key
          location.attributes = { param_key => value }
        end
      end
    end

    location.save
    change.destroy
  end

  def import_from_params(params)
    raise "No such record" if !RecycleLocation.find(params[:recycle_location_id])

    # Get relevant attributes from parameters
    change_params = params.slice( :name,
                                  :kind,
                                  :materials,
                                  :latitude,
                                  :longitude,
                                  :street_name,
                                  :zip_code,
                                  :city,
                                  :created_at,
                                  :updated_at,
                                  :opening_hours)

    self.location_id = params[:recycle_location_id]

    # For each patched parameter add to change entry
    change_params.each do |k, v|
      # If is single value replace key
      if !v.is_a? (Array)
        self[k] = v
      # If is array replace respective value
      elsif v.is_a? (Array)
        v.each_with_index do |v, i|
          self[k][i] = v
        end
      end
    end
  end

  def compare
    location = RecycleLocation.find(location_id)
    diffs = {}

    # Info about the change gets its reserved key
    diffs[:info] = { name: location[:name], change_id: id, created_at: attributes['created_at'] }

    # No need to compare info
    comparable = attributes.slice(*COMPARABLE_ATTRIBUTES)

    comparable.inject(location) do |diff, (key, value)|
      if value.is_a?(Array)
        diffs.merge!(array_diffs(value, location[key], key))
      else
        suggestion = single_diffs(value, location[key])
        diffs[key] = suggestion if suggestion
      end
    end

    diffs
  end

  private

  # Return nicely formatted individual_changes
  def array_diffs(array, reference, key)
    diff = {}

    if !array.empty?
      array.each_with_index do |v, i|
        if v && !v.empty?
          diff[make_indexed_key(key, i)] = [reference[i], v]    # If is array, get own change
        end
      end
    end

    diff
  end

  # Return changes on indivual key
  def single_diffs(value, reference)
    value != reference ? [reference, value] : nil
  end

  # Make key from array item
  # Ex. opening_hours[0] => opening_hours_mon
  def make_indexed_key(key, index)
    if key == "opening_hours"
      return key + "_" + WEEKDAYS[index]
    elsif key == "materials" + "_" + MATERIALS[index]
      return
    end
  end

  # Get array index from formatted key
  # Ex. opening_hours_mon => 0
  def get_index(key)
    if key.include? "opening_hours"
      index_name = key.sub("opening_hours_", "")
      index = WEEKDAYS.index(index_name)
    else
      index_name = key.sub("materials_", "")
      index = MATERIALS.index(index_name)
    end
    index
  end

  # Get non indexed key
  # Ex. opening_hours_mon => opening_hours
  def remove_index_name(k)
    key = k.include?("opening_hours") ? 'opening_hours' : 'materials'
  end

  # Filter out irrelevant keys
  def is_comparable?(key)
    COMPARABLE_ATTRIBUTES.any? {|word| key.include? word }
  end

  # Check if key is indexed
  # Ex. opening_hours_mon => true
  def is_indexed?(key)
    key.include?('materials') && key.length > 9 || key.include?('opening_hours') && key.length > 13
  end
end
