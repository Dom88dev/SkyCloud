package model;

public class Message {
	private int msg_id;
	private long msg_datetime;
	private String msg_href;
	private String msg_content;
	private int msg_check;
	private String reciever;
	private String sender;
	
	public int getMsg_id() {
		return msg_id;
	}
	public void setMsg_id(int msg_id) {
		this.msg_id = msg_id;
	}
	public long getMsg_datetime() {
		return msg_datetime;
	}
	public void setMsg_datetime(long msg_datetime) {
		this.msg_datetime = msg_datetime;
	}
	public String getMsg_href() {
		return msg_href;
	}
	public void setMsg_href(String msg_href) {
		this.msg_href = msg_href;
	}
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public int getMsg_check() {
		return msg_check;
	}
	public void setMsg_check(int msg_check) {
		this.msg_check = msg_check;
	}
	public String getReciever() {
		return reciever;
	}
	public void setReciever(String reciever) {
		this.reciever = reciever;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
}
