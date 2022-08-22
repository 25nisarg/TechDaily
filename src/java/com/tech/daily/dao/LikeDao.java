package com.tech.daily.dao;

import java.sql.*;
import java.util.*;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean doLike(int pid, int uid) {
        boolean f = false;
        try {
            String q = "insert into liked(pid,uid) values(?,?)";
            PreparedStatement pst = this.con.prepareStatement(q);
            pst.setInt(1, pid);
            pst.setInt(2, uid);
            pst.executeUpdate();
            
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public int countLikeOnPost(int pid) {
        int count = 0;
        String q = "select count(*) from liked where pid=?";
        PreparedStatement p;
        try {
            p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet rs = p.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public boolean isLikedByUSer(int pid, int uid) {
        boolean f = false;
        try {
            PreparedStatement p = this.con.prepareStatement("select * from liked where pid=? and uid=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
            ResultSet rs = p.executeQuery();
            if (rs.next()) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteLike(int pid, int uid) {
        boolean f = false;
        try {
            PreparedStatement p = this.con.prepareStatement("delete from liked where pid=? and uid=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
