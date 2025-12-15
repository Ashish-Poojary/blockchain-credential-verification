/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blockchainServer;

import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Vector;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Lenovo
 */
public class readblockreq extends Thread
{
    public static ArrayList<Block> blockchain = new ArrayList<Block>();
    public static int difficulty = 0;
    public static String previousHash="0";
    
    readblockreq()
    {
        super();
        start();
    }
    
    public void run()
    {
        try
        {
            ServerSocket ss=new ServerSocket(3000);
            
            while (true)
            {
                Socket soc=ss.accept();
                ObjectOutputStream oos=new ObjectOutputStream(soc.getOutputStream());
                ObjectInputStream oin=new ObjectInputStream(soc.getInputStream());
                
                String req=(String)oin.readObject();
                
                if (req.equals("ADDBLOCK"))
                {
                    String usn=(String)oin.readObject();
                   String hash=(String)oin.readObject();
                   
                  
                                      
                   
                  // String opr=pid+"-->"+opr2+"-->"+opr3;
                   
                   blockcserver.jTextArea1.append("Hash value received for student "+usn+"\n");
                   
                  
                        
                        Block b=new Block(usn,hash,previousHash);
                        blockchain.add(b);
                        blockcserver.jTextArea1.append("Block Successfully added!\n");
                        blockchain.get(blockchain.size()-1).mineBlock(difficulty);
                        
                        // MINIMAL FIX: Update previousHash for next block
                        previousHash = blockchain.get(blockchain.size()-1).hash;
                        
                        oos.writeObject("SUCCESS");
                        System.out.println("reply sent..");
                       
                  
                }
               
                else
                if (req.equals("GETMYHASH"))
                {
                    String usn=(String)oin.readObject();
                    
                    blockcserver.jTextArea1.append(req+" request received from student "+usn+" \n");
                    
                    String shash=getmyhash(usn);
                    System.out.println("hash: "+shash);
                   
                        oos.writeObject(shash);
                    
                    
                    
                }
               else
                if (req.equals("GETALLHASH"))
                {
                    //String usn=(String)oin.readObject();
                    
                    blockcserver.jTextArea1.append(req+" request received from admin \n");
                    
                    Vector v=getallhash();
                   // System.out.println("hash: "+shash);
                   if (v.size()==0)
                   {
                       oos.writeObject("NOHASHFOUND");
                   }
                   else
                   {
                       oos.writeObject("SUCCESS");
                       oos.writeObject(v);
                       
                   }
                        
                    
                    
                    
                }
                else
                if (req.equals("VALIDATEHASH")) //admin
                {
                    String usn=(String)oin.readObject();
                    String hash=(String)oin.readObject();
                    
                    blockcserver.jTextArea1.append(req+" request received for student "+usn+" \n");
                    
                    String reply=validatehash(usn,hash);
                   
                    oos.writeObject(reply);
                  
                        
                            
                  
                }
                else
                if (req.equals("GETTIMESTAMP"))
                {
                    String usn=(String)oin.readObject();
                    
                    blockcserver.jTextArea1.append(req+" request received for student "+usn+" \n");
                    
                    String reply=getTimestamp(usn);
                   
                    oos.writeObject(reply);
                  
                        
                            
                  
                }
                    
                              
                oos.close();
                oin.close();
                soc.close();
                
            }
            
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }
    }    
    
    
    
    
    
    String getmyhash(String usn)
    {
        
        String reply="NOTFOUND";
        //String reply="";
        
        try
        {
            for (int i=0;i<blockchain.size();i++)
            {
                Block b=blockchain.get(i);
                
                if (b.usn.equals(usn))
                {
                   reply=b.chash+"$"+b.getFormattedDate(); // Return hash with timestamp
                   //reply="SUCCESS";
                     break;   
                    
                  
                   // System.out.println(v.get(0).toString().trim());
                    
                }
            }
            
           
            
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }

        return reply;
    }
    
    // New method to get timestamp for a specific USN
    String getTimestamp(String usn)
    {
        String reply="NOTFOUND";
        
        try
        {
            for (int i=0;i<blockchain.size();i++)
            {
                Block b=blockchain.get(i);
                
                if (b.usn.equals(usn))
                {
                   reply=b.getFormattedDate();
                   break;   
                }
            }
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }

        return reply;
    }
    
    String validatehash(String usn,String hash)
    {
        
        String reply="NOTFOUND";
        //String reply="";
        
        try
        {
            for (int i=0;i<blockchain.size();i++)
            {
                Block b=blockchain.get(i);
                
                if (b.usn.equals(usn))
                {
                    if (b.chash.equals(hash))
                    {
                   reply="SUCCESS";
                        
                   break;
                    }
                   // System.out.println(v.get(0).toString().trim());
                    
                }
            }
            
           
            
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }

        return reply;
    }
    
    
    Vector getallhash()
    {
        
        Vector v=new Vector();
        //String reply="";
        
        try
        {
            for (int i=0;i<blockchain.size();i++)
            {
                Block b=blockchain.get(i);
                
               // if (b.partner.equals(uname))
                {
                   String data=b.usn+"$"+b.chash+"$"+b.getFormattedDate(); // Added timestamp to data
                        
                   
                   v.add(data);
                   // System.out.println(v.get(0).toString().trim());
                    
                }
            }
            
           
            
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }

        return v;
    }
    
    
  
    
    
   
    
   
    
    
    void writelogs()
    {
        try
        {
            if (blockchain.size()>0)
            {
                JSONArray blockList = new JSONArray();
                
                for (int i=0;i<blockchain.size();i++)
                {
                    Block b=(Block)blockchain.get(i);
                    JSONObject blockdetails = new JSONObject();
                    blockdetails.put("usn", b.usn);
                    blockdetails.put("chash", b.chash);
                    blockdetails.put("previoushash", b.previousHash);
                    blockdetails.put("hash", b.hash);
                    blockdetails.put("timestamp", b.getTimestamp()); // Added timestamp
                    blockdetails.put("uploadDate", b.getFormattedDate()); // Added formatted date
                    
                    JSONObject blockObject = new JSONObject(); 
                    blockObject.put("block", blockdetails);
                    
                    blockList.add(blockObject);
                }
                
                FileWriter file = new FileWriter("userlogs.json");
                file.write(blockList.toJSONString()); 
                file.flush();
                file.close();
                
            }
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
    }
        
}
