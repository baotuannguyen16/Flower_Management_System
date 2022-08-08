/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package thanhlh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import thanhlh.dao.AccountDAO;
import thanhlh.dto.Account;
import thanhlh.dao.RandomDAO;

/**
 *
 * @author Lenovo
 */
public class loginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtemail");
            String password = request.getParameter("txtpassword");
            String save = request.getParameter("savelogin");
            Account acc = null;
            try {
                if (email == null || email.equals("") || password == null || password.equals("")) {
                    Cookie[] c = request.getCookies();
                    String token = "";
                    if (c != null) {
                        for (Cookie aCookie : c) {
                            if (aCookie.getName().equals("selector")) {
                                token = aCookie.getValue();
                            }
                        }
                    }

                    if (!token.equals("")) {
                        // chưa check equal token trong DB !!!!!!!!!!!!
                        if (AccountDAO.compareToken(token) == 1) {
                            response.sendRedirect("FilterOrder");
                        }
                    } else {
                        request.setAttribute("messLog", "You have not filled in the information completely");
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                    }
                } else {
                    acc = AccountDAO.getAccount(email, password);
                    if (acc != null) {
                        //admin
                        if (acc.getRole() == 1) {
                            //chuyen qua admin home page
                            HttpSession session = request.getSession(true);
                            if (session != null) {
                                session.setAttribute("name", acc.getFullName());
                                session.setAttribute("email", email);
                                //create a cookie and attach it to response object
                                if (save != null) {
                                    int numberOfCharactor = 12;
                                    RandomDAO rand = new RandomDAO();
                                    String token = rand.randomAlphaNumeric(numberOfCharactor);
                                    AccountDAO.updateToken(token, email);
                                    Cookie cookie = new Cookie("selector", token);
                                    cookie.setMaxAge(60 * 1); //1p
                                    response.addCookie(cookie);
                                }
                                response.sendRedirect("AdminIndex.jsp");
                            }

                        }//user
                        else {
                            if (acc.getStatus() == 0) {
                                request.setAttribute("messLog", "Your account has been block");
                                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                rd.forward(request, response);
                            } else {
                                HttpSession session = request.getSession(true);
                                if (session != null) {
                                    session.setAttribute("name", acc.getFullName());
                                    session.setAttribute("email", email);
                                    //create a cookie and attach it to response object
                                    if (save != null) {
                                        int numberOfCharactor = 12;
                                        RandomDAO rand = new RandomDAO();
                                        String token = rand.randomAlphaNumeric(numberOfCharactor);
                                        AccountDAO.updateToken(token, email);
                                        Cookie cookie = new Cookie("selector", token);
                                        cookie.setMaxAge(60 * 1); //1p
                                        response.addCookie(cookie);
                                    }
                                    response.sendRedirect("FilterOrder");
                                }
                            }
                        }
                    } else {
                        request.setAttribute("messLog", "The email or password you just entered is incorrect");
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

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
