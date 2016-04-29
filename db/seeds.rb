# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
RecycleLocation.destroy_all

csv = CSVImport.new(File.expand_path("../seeds/recycle_locations.csv", __FILE__))
csv.import(:fti)

# Opening hours
RecycleLocation.find_by(name: "Norremark (ÅVC)").update_attribute(:opening_hours, [
  ['07:00', '20:00'],
  ['07:00', '20:00'],
  ['07:00', '20:00'],
  ['07:00', '20:00'],
  ['07:00', '16:00'],
  ['08:00', '14:00'],
  []
])

RecycleLocation.find_by(name: "Avfallsverket Häringetorp (ÅVC)").update_attribute(:opening_hours, [
  ['06:30', '16:00'],
  ['06:30', '16:00'],
  ['06:30', '16:00'],
  ['06:30', '16:00'],
  ['06:30', '16:00'],
  [],
  ['10:00', '16:00']
])

RecycleLocation.find_by(name: "Furuby (ÅVC)").update_attribute(:opening_hours, [
  ['14:00', '19:00'],
  [],
  [],
  ['14:00', '18:00'],
  [],
  [],
  []
])

RecycleLocation.find_by(name: "Åby (ÅVC)").update_attribute(:opening_hours, [
  [],
  ['14:00', '19:00'],
  [],
  [],
  ['14:00', '16:00'],
  [],
  []
])

RecycleLocation.find_by(name: "Ingelstad (ÅVC)").update_attribute(:opening_hours, [
  [],
  ['14:00', '19:00'],
  [],
  ['14:00', '18:00'],
  [],
  [],
  []
])

RecycleLocation.find_by(name: "Rottne (ÅVC)").update_attribute(:opening_hours, [
  ['14:00', '19:00'],
  [],
  [],
  ['14:00', '18:00'],
  [],
  [],
  []
])

RecycleLocation.find_by(name: "Braås Mästreda (ÅVC)").update_attribute(:opening_hours, [
  [],
  ['14:00', '19:00'],
  [],
  ['14:00', '18:00'],
  [],
  [],
  []
])
