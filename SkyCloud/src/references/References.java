package references;

import java.net.InetAddress;

public class References {
	private String img_path;
	private String path = "http://70.12.113.155:8888/SkyCloud/";
	
	public void setPath(String ip) {
		img_path = "http://"+ip+"/SkyCloud/images/";
		path = "http://"+ip+"/SkyCloud/";
	}
	
	public String getImg_path() {
		return img_path;
	}
	
	public String getPath() {
		return path;
	}
}
