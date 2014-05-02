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

      # can see a list of all students
      can :index, Student
      #can see location details

      #can see camps and curriculums they are assigned to
      can :read, Camp do |camp|  
        camps = user.camps.map{|p| p.camp.map(&:id)}.flatten
        camps.include?(camp.id) 
      end


      # they can read their own profile
      can :show, Instructor do |i|  
        i.id == instructor.id
      end
      # they can update their own profile
      can :update, Instructor do |i|  
        i.id == instructor.id
      end
      
      # they can read their own projects' data
      can :read, Project do |this_project|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_project.id 
      end
      # they can create new projects for themselves
      can :create, Project
      
      # they can update the project only if they are the manager (creator)
      can :update, Project do |this_project|
        managed_projects = user.projects.map{|p| p.id if p.manager_id == user.id}
        managed_projects.include? this_project.id
      end
            
      # they can read tasks in these projects
      can :read, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can update tasks in these projects
      can :update, Task do |this_task|  
        project_tasks = user.projects.map{|p| p.tasks.map(&:id)}.flatten
        project_tasks.include? this_task.id 
      end
      
      # they can create new tasks for these projects
      can :create, Task do |this_task|  
        my_projects = user.projects.map(&:id)
        my_projects.include? this_task.project_id  
      end

    else
      # guests can only read domains covered (plus home pages)
      #guests can see list of camps, view camp details, view instructor details, view location details
      can :read, Domain
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
