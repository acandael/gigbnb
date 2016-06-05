class ApplicationPolicy
  attr_reader :current_member, :record

  def initialize(current_member, record)
    @member = current_member
    @record = record
  end
  

end
