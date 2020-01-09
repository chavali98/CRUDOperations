package Servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(urlPatterns = {"/databaseservlet"})
public class DatabaseServlet extends HttpServlet {
    
    private Statement statement = null;
    private static Connection con;
    static String test="Here";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
            if(con!=null){
                test="Pass";
            }
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean createTable(HttpServletResponse response,String name, String[] cols,String[] type) {
        boolean flag = false;
        PrintWriter out=null;
        try {
            out = response.getWriter();
            
        } catch (IOException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String tablequery = "create table "+name+"(";
        for(int i=0;i<cols.length-1;i++){
            tablequery+=cols[i]+" "+type[i]+",";
        }
        tablequery+=cols[cols.length-1]+" "+type[type.length-1]+")";
        
        try {
            statement = con.createStatement();
            out.println("In statement creation ");
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            flag=statement.execute(tablequery);
            if(flag)
                out.println("Successfully created.");
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return flag;
    }
    
    public void retTable(HttpServletResponse response,String name, String[] cols,String where) {
        boolean flag = false;
        String tablequery = "";
        ResultSet rs=null;
        PrintWriter out=null;
        try {
            out = response.getWriter();
        } catch (IOException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        StringBuilder sb=new StringBuilder();
        for(int i=0;i<cols.length-1;i++){
            tablequery+="select "+cols[i]+",";
        }
        tablequery+=cols[cols.length-1]+" from "+name+where;
        try {
            statement = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            rs=statement.executeQuery(tablequery);
            while(rs.next()) {
                for(int j=0;j<cols.length;j++)
                    sb.append(rs.getString(j)+"  ");
                out.println(rs.getString(1)+"  "+rs.getInt(2)+"  "+rs.getInt(3));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void upTable(HttpServletResponse response,String name, String cols,String value,String where) {
        boolean flag = false;
        String tablequery = "UPDATE "+name+" set "+cols+"=\'"+value+"\' where "+where;
        ResultSet rs=null;
        PrintWriter out=null;
        try {
            out = response.getWriter();
        } catch (IOException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            statement = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            flag=statement.execute(tablequery);
            if(flag)
                out.println("Successfully updated.");
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void delTable(HttpServletResponse response,String name, String where) {
        boolean flag = false;
        String tablequery = "DELETE from "+name+" where "+where;
        ResultSet rs=null;
        PrintWriter out=null;
        try {
            out = response.getWriter();
             out.println("deleted 1");
        } catch (IOException ex) {
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            statement = con.createStatement();
        } catch (SQLException ex) {
            out.println("deleted 2");
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            flag=statement.execute(tablequery);
            if(flag)
                out.println("Successfully deleted.");
        } catch (SQLException ex) {
            out.println("deleted 3");
            Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DatabaseServlet</title>");
            out.println("</head>");
            out.println("<body>"); 
            out.println("<h1>Servlet DatabaseServlet at " + request.getContextPath() + "</h1>" +test);
            out.println("</body>");
            out.println("</html>");
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
            //delTable(response, test, test, test, test);
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
        //processRequest(request, response);
        PrintWriter out = response.getWriter();
        out.println(request.getParameter("tname"));
//        out.println(request.getParameterValues("mytext")[0]);
//        out.println(request.getParameterValues("mytext")[1]);
        //createTable(response, request.getParameter("tname"), request.getParameterValues("mytext"), request.getParameterValues("mytype"));
        delTable(response, request.getParameter("tname"), request.getParameter("clause"));
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
