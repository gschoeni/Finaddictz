authorization do
  
  role :guest do
    has_permission_on :user_sessions, :to => :manage
    has_permission_on :users, :to => [:create, :confirm]

  end


  role :guide do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => [:update, :delete] do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => [:create, :flag_as_abused, :book_trip, :remove_user_from_trip]
    has_permission_on [:property_posts], :to => [:read, :flag_as_abused]
    has_permission_on :conversations, :to => [:read, :create]
    has_permission_on :messages, :to => [:read, :create]
    has_permission_on :map, :to => :read
    has_permission_on :notifications, :to => :read

  end

  role :angler do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => [:update, :delete] do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:guide_posts, :angler_posts], :to => [:create, :flag_as_abused, :book_trip, :remove_user_from_trip]
    has_permission_on [:property_posts], :to => [:read, :flag_as_abused]
    has_permission_on :conversations, :to => [:read, :create]
    has_permission_on :messages, :to => [:read, :create]
    has_permission_on :map, :to => :read
    has_permission_on :notifications, :to => :read
  end

  role :property_owner do
    includes :guest
    has_permission_on :users, :to => :change_role
    has_permission_on [:users, :fish_species, :fishing_methods, :guide_posts, :angler_posts], :to => :read
    has_permission_on :users, :to => [:create, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on [:property_posts], :to => [:update, :delete] do
      if_attribute :user_id => is { user.id }
    end
    has_permission_on [:property_posts], :to => [:read, :create, :flag_as_abused]
    has_permission_on :conversations, :to => [:read, :create]
    has_permission_on :messages, :to => [:read, :create]
    has_permission_on :map, :to => :read
    has_permission_on :notifications, :to => :read
  end

  role :admin do
    includes :guest
    includes :guide
    includes :angler
    includes :property_owner
    has_permission_on :users, :to =>  [:manage, :toggle_enabled]
    has_permission_on [:fish_species, :fishing_methods, :guide_posts, :property_posts, :angler_posts, :env_prefs, :locations, :ratings], :to => :manage
    has_permission_on :conversations, :to => :manage
    has_permission_on :rivers, :to => :manage
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => :destroy
end 