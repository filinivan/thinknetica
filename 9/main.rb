require_relative 'company'
require_relative 'validate'
require_relative 'instance_counter'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'interface'
require_relative 'accessors'

interface = Interface.new
interface.seed
interface.start
