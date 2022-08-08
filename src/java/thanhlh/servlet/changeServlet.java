/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package thanhlh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import thanhlh.dao.AccountDAO;
import thanhlh.dto.Account;

/**
 *
 * @author Lenovo
 */
public class changeServlet extends HttpServlet {

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
            String password = request.getParameter("txtpass");
            String email = request.getParameter("txtmail");
            System.out.println(email);
            String phone = request.getParameter("txtphone");
            String Fname = request.getParameter("txtname");
            Account acc = null;
            try {
                acc = AccountDAO.getAccount(email, password);
            } catch (Exception ex) {
                Logger.getLogger(changeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (acc != null) {
                if (AccountDAO.updateInformation(Fname, phone, email)) {
                    request.setAttribute("result", "Succeeded");
                    RequestDispatcher rd = request.getRequestDispatcher("changeProfile.jsp");
                    rd.forward(request, response);
                }
            } else {
                request.setAttribute("result", "wrong password");
                RequestDispatcher rd = request.getRequestDispatcher("changeProfile.jsp");
                rd.forward(request, response);
            }
            System.out.println(AccountDAO.checkPass(email, password));
            System.out.println(password);
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
