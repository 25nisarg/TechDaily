package com.tech.daily.dao;
import com.tech.daily.entities.Category;
import com.tech.daily.entities.Post;
import java.sql.*;
import java.util.*;


public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getCategories(){
        ArrayList<Category> list=new ArrayList<>();
        
        try{
            String q="select * from categories";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(q);
            while(rs.next()){
                int cid=rs.getInt("cid");
                String name=rs.getString("name");
                String des=rs.getString("description");
                Category c=new Category(cid,name,des);
                list.add(c);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f=false;
        try{
            String q="insert into posts(pTitle,pContent,pCode,pPic,cid,userId) values(?,?,?,?,?,?)";
            PreparedStatement pst= con.prepareStatement(q);
            pst.setString(1,p.getpTitle());
            pst.setString(2,p.getpContent());
            pst.setString(3,p.getpCode());
            pst.setString(4,p.getpPic());
            pst.setInt(5,p.getCid());
            pst.setInt(6,p.getUserId());
            pst.executeUpdate();
            f=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
}
