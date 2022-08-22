package com.tech.daily.dao;

import com.tech.daily.entities.Category;
import com.tech.daily.entities.Post;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String q = "select * from categories";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(q);
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String des = rs.getString("description");
                Category c = new Category(cid, name, des);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into posts(pTitle,pContent,pCode,pPic,cid,userId) values(?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(q);
            pst.setString(1, p.getpTitle());
            pst.setString(2, p.getpContent());
            pst.setString(3, p.getpCode());
            pst.setString(4, p.getpPic());
            pst.setInt(5, p.getCid());
            pst.setInt(6, p.getUserId());
            pst.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

//    Get all post
    public List<Post> getAllPost() {
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("cid");
                int userId = rs.getInt("userId");

                Post post = new Post(pid, catId, userId, pTitle, pContent, pCode, pPic, pDate);
                list.add(post);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostById(int catId) {
        List<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from posts where cid=?");
            p.setInt(1, catId);
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");

                int userId = rs.getInt("userId");

                Post post = new Post(pid, catId, userId, pTitle, pContent, pCode, pPic, pDate);
                list.add(post);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostByPostId(int postId) {
        Post post = null;
        String q = "select * from posts where pid=?";
        try {
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, postId);
            ResultSet rs = p.executeQuery();
            if (rs.next()) {

                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int cid=rs.getInt("cid");
                int userId = rs.getInt("userId");

                post = new Post(pid, cid, userId, pTitle, pContent, pCode, pPic, pDate);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return post;
    }
}
