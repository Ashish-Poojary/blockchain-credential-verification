package blockchainServer;

import blockchainServer.blockcserver;
import blockchainServer.readblockreq;
import java.util.Date;

public class Block {

	public String hash;
	 String previousHash; 
         String usn;
         String chash;
	 private long timestamp; // Added timestamp field
	
	 
	 int nonce;

         
         public Block()
         {
             
         }
         
	//Block Constructor.
	public Block(String usn,String chash,String previousHash ) {
            this.usn=usn;
            this.chash=chash;
            this.previousHash = previousHash;
            this.timestamp = System.currentTimeMillis(); // Set current timestamp
            this.hash = calculateHash(); //Making sure we do this after we set the other values.
            System.out.println("Block created with timestamp: " + this.timestamp + " for USN: " + usn);
	
	}
        
        //Calculate new hash based on blocks contents
	public String calculateHash() {
		String calculatedhash = StringUtil.applySha256( 
				previousHash +
				usn +  chash + timestamp  // Include timestamp in hash calculation
				);
                System.out.println("calculated hash: "+calculatedhash);
		return calculatedhash;
	}
        
        // Getter for timestamp
        public long getTimestamp() {
            return timestamp;
        }
        
        // Setter for timestamp
        public void setTimestamp(long timestamp) {
            this.timestamp = timestamp;
        }
        
        // Getter for formatted date
        public String getFormattedDate() {
            System.out.println("Getting formatted date for timestamp: " + timestamp);
            if (timestamp == 0) {
                System.out.println("WARNING: Timestamp is 0! This block was created before timestamp feature was added.");
                return "Timestamp not available (pre-timestamp feature)";
            }
            return new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(timestamp));
        }
        
        public void mineBlock(int difficulty) {
		String target = new String(new char[difficulty]).replace('\0', '0'); //Create a string with difficulty * "0" 
		while(!hash.substring( 0, difficulty).equals(target)) {
			nonce ++;
			hash = calculateHash();
		}
		blockcserver.jTextArea1.append("Block Mined!!! : " + hash+"\n");
	}
}