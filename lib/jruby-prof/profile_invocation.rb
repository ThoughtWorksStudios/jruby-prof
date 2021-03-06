
class JRubyProf
  java_import org.jruby.prof.Invocation
  class Invocation
    alias :method_name  :methodName
    alias :class_name   :className
    
    def name
      "#{class_name}#{static? ? "." : "#"}#{method_name}"
    end
      
    def childrens_duration
      children.inject(0) {|m, inv| m + inv.duration}
    end
    
    def static?
      false
    end
    
    def to_method
      method = Method.new(class_name, method_name, static?)
      method.add_invocation(self)
      method
    end
    
    def id
      @id ||= Invocation.new_id
    end
    
    def self.new_id
      @id ||= 0
      @id += 1
      @id
    end
    
    def get_methods
      h = {}
      ThreadSet.add_methods(h, self)
      h
    end
  end
end

