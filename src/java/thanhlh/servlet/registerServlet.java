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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import thanhlh.dao.AccountDAO;
import thanhlh.dao.RegexDAO;

/**
 *
 * @author Lenovo
 */
public class registerServlet extends HttpServlet {

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
            String fullname = request.getParameter("txtfullname");
            String password = request.getParameter("txtpassword");
            String phone = request.getParameter("txtphone");
            int status = 1; //default a new account' status is 1
            int role = 0; //defaul a new account's role is 0

            if (email.equals("") || email == null || fullname.equals("") || fullname == null || password.equals("") || password == null || phone.equals("") || phone == null) {
                request.setAttribute("checkExist", "You have not filled in the information completely");
                RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                rd.forward(request, response);
            } else {
                if (AccountDAO.checkExist(email)) {
                    request.setAttribute("checkExist", "This account already exists");
                    RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                    rd.forward(request, response);
                } else {
                    if (RegexDAO.checkMail(email) && RegexDAO.checkName(fullname) && RegexDAO.checkPass(password) && RegexDAO.checkPhone(phone)) {
                        if (AccountDAO.insertAccount(email, password, fullname, phone, status, role)) {
                            request.setAttribute("email_newAccount", email);
                            RequestDispatcher rd = request.getRequestDispatcher("sendOTP");
                            rd.forward(request, response);

                        } else {
                            response.sendRedirect("errorpage.html");
                        }
                    } else {
                        // print each error of user input to Login.jsp
                        if (RegexDAO.checkMail(email) == false) {
                            request.setAttribute("messMail", "The email you entered is not in the correct format");
                        }
                        if (RegexDAO.checkName(fullname) == false) {
                            request.setAttribute("messName", "Name length from 2 to 40 characters");
                        }
                        if (RegexDAO.checkPass(password) == false) {
                            request.setAttribute("messPass", "Password length from 8 to 20 characters");
                        }
                        if (RegexDAO.checkPhone(phone) == false) {
                            request.setAttribute("messPhone", "phone length from 8 to 12 and does not include letters");
                        }

                        RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
                        rd.forward(request, response);
                    }
                }
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
