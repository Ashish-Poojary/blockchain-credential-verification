/*
 * JSON Processing Utility
 * Handles JSON operations for blockchain data
 */
package blockchainServer;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
 
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
 
public class readJSON {

public readJSON()
{
    //JSON parser object to parse read file
        JSONParser jsonParser = new JSONParser();
         
        try (FileReader reader = new FileReader("userlogs.json"))
        {
            //Read JSON file
            Object obj = jsonParser.parse(reader);
 
            JSONArray blockList = (JSONArray) obj;
            System.out.println(blockList);
             
            //Iterate over block chain array
            blockList.forEach( blockobject -> parseLogObject( (JSONObject) blockobject ) );
 
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    
}
        
        

   
 
    private static void parseLogObject(JSONObject blockobject) 
    {
        //Get employee object within list
        JSONObject blockdetails = (JSONObject) blockobject.get("block");
         
        //Get user name
        String usn =  blockdetails.get("usn").toString();    
        System.out.println(usn);
        
        
                
        String chash = (String) blockdetails.get("chash");  
        System.out.println(chash);
        
      
        
        
        String prev = (String) blockdetails.get("previoushash");  
        System.out.println(prev);
        
       
        
        String hash = (String) blockdetails.get("hash");  
        System.out.println(hash);
        
        Block b=new Block();
        
        b.usn=usn;
        b.chash=chash;
        b.previousHash=prev;
        b.hash=hash;
        
        // Load timestamp from JSON if available
        if (blockdetails.containsKey("timestamp")) {
            try {
                Long timestamp = (Long) blockdetails.get("timestamp");
                if (timestamp != null && timestamp > 0) {
                    b.setTimestamp(timestamp);
                    System.out.println("Loaded timestamp for USN " + usn + ": " + timestamp);
                } else {
                    // If timestamp is 0 or null, don't set it - let it remain 0
                    System.out.println("WARNING: Invalid timestamp for USN " + usn + ": " + timestamp);
                }
            } catch (Exception e) {
                System.out.println("Error loading timestamp for USN " + usn + ": " + e.getMessage());
                // Don't set timestamp on error - let it remain 0
            }
        } else {
            // If no timestamp in JSON, don't set it - let it remain 0
            System.out.println("No timestamp found for USN " + usn + " in JSON");
        }
        
        readblockreq.blockchain.add(b);
         
        
    }
}
