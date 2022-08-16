package com.tech.daily.servlets;

import com.tech.daily.dao.UserDao;
import com.tech.daily.entities.Message;
import com.tech.daily.entities.User;
import com.tech.daily.helper.ConnectionProvider;
import com.tech.daily.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
//            fetch all data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();
//            get the user form session
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile = user.getProfile();
            user.setProfile(imageName);
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = dao.updateUser(user);
            if (ans) {
                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
                String pathdel = request.getRealPath("/") + "pics" + File.separator + oldFile;
                if (!oldFile.equals("Default.png")) {
                    Helper.deleteFile(pathdel);
                }
                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Updated");
                    Message msg = new Message("Profile Updated!", "success", "alert-success");

                    s.setAttribute("msg", msg);

                } else {
                    out.println("NotUpdated");
                    Message msg = new Message("Something went Wrong!", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }

            } else {

                out.println("Error");
                Message msg = new Message("Something went Wrong!", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }
            response.sendRedirect("profile.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
