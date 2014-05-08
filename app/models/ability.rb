class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user

    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :instructor
      #records points earned

      # can see a list of their students
      can :read, Camp do |camp|
        @camps = user.instructor.camps.map{|c| c.id}.flatten
        @camps.include?(camp.id)
        # @camps.each do |ecamp| 
        #   camp.id == ecamp
      end

      can :read, Student do |s|
        mystudents = user.instructor.camps.map{|c| c.students.map(&:id)}.flatten
        mystudents.include?(s.id)
      end
      #can see location details

      #can see camps and curriculums they are assigned to
      can :read, Camp
      can :read, Curriculum
      can :read, Instructor
      can :read, Location

      # they can read their own profile

      # they can update their own profile
      can :update, Instructor do |i|  
        i.id == user.instructor_id
      end
      

    else
      # guests can only read domains covered (plus home pages)
      #guests can see list of camps, view camp details, view instructor details, view location details
      can :read, Camp
      can :read, Curriculum
      can :read, Instructor
      can :read, Location
      can :read, Student
      #can :read, All
    end
  end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
end
