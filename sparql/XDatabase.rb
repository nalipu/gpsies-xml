require 'rubygems'
require 'sparql/client'

require 'BaseXClient.rb'
require 'queryhelper.rb'

class XDatabase
  
  def initialize(host,port,username,password)
    @session = BaseXClient::Session.new(host, port, username, password)
  end
  
  def open(db)
    begin
      @session.execute("open #{db}")
      result = "DB #{db} successfully opened"
    rescue Exception => e
      # print exception
      puts e
      result = nil
    end      
  end
  
  def query(queryString)
    begin    
      query = @session.query(queryString)
      result = query.next      
      query.close()
    rescue Exception => e
      # print exception
      puts e
      result = nil
    end
    return result
  end
  
  def execute(queryString)
    begin
      query = @session.execute(queryString)
      result = "Execute successful"

    rescue Exception => e
    # print exception, return nil instead
      puts e
      result = nil
    end
    
    return result
  end
  
  def get_waypoints(id,db)
    begin 
      input = "for $x in track    
      where $x/uid = \"#{id}\"
      return $x/waypoints"
    
      if !self.open(db)
        raise "Error while opening database"
      end
      result = self.query(input)
    rescue Exception => e
      # print exception
      puts e
      result = nil
    end

    # close session
    #self.close
    return result
  end
  
  def insert_pois(id, pois, db)
    begin
      if !self.open(db)
        raise "Error while opening database"
      end
      
      queryString = "xquery for $x in track where $x/uid = \"#{id}\"
        return (            
          insert node <pois></pois>
          as last into $x
        )"
      
      if !self.execute(queryString)
        raise "Error while execetung query \"#{queryString}\""
      end
    
      pois.each do |point|
        queryString = "xquery for $x in track
        where $x/uid = \"#{id}\"
        return (            
          insert node #{point}
          as last into $x/pois
        )"
        if !self.execute(queryString)
          raise "Error while execetung query \"#{queryString}\""
        end
      end
      result = "Insert successful"

    rescue Exception => e
    # print exception, return nil instead
      puts e
      result = nil
    end

    # close session
    #self.close
    return result
  end
  
   #for a given ID gets waypoints from database,
   #fetches POIs from sparql
   #inserts them into our XML-database
   #returns POIs as XML string
   def fetch_POIs_from_SPARQL(id,db)
     
   points = get_waypoints(id, db)
   coords = create_coord_array(points,10)      
   result = get_POIs(coords)
      
   if !result.nil?
     res = insert_pois(id, result, db)
     #TODO: define what happens if insert into database is not successful
        
     pois = "<pois>#{result}</pois>"
     end
   end
  
  def close
    @session.close
  end
end 
  
  
    