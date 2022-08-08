/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package thanhlh.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.Set;
import thanhlh.dto.Order;
import thanhlh.dto.OrderDetail;
import thanhlh.utills.DBUtills;

/**
 *
 * @author Lenovo
 */
public class OrderDAO {

    public static ArrayList<Order> getOrders(String email) {
        ArrayList<Order> list = new ArrayList<>();
        int AccID = 0;
        try {
            Connection cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select OrderID,OrdDate,shipdate,status,AccID\n"
                        + "from dbo.Orders\n"
                        + "where AccID = (select accID\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?\n"
                        + ")";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    int OrderID = rs.getInt("OrderID");
                    String OrdDate = rs.getString("OrdDate");
                    String ShipDate = rs.getString("shipdate");
                    int Status = rs.getInt("status");
                    int AccId = rs.getInt("AccID");
                    Order order = new Order(OrderID, OrdDate, ShipDate, Status, AccId);
                    list.add(order);
                }
                cn.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static ArrayList<OrderDetail> getOrderDetail(int orderID) throws Exception {
        Connection cn = null;
        ArrayList<OrderDetail> list = new ArrayList<>();
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select DetailId,OrderID,PID,PName,price,imgPath,quantity\n"
                        + "from OrderDetails, Plants\n"
                        + "where OrderID = ? and OrderDetails.FID=plants.PID";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int detailID = rs.getInt("DetailId");
                        int PlantID = rs.getInt("PID");
                        String PlanName = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");
                        OrderDetail orderdetail = new OrderDetail(detailID, orderID, PlantID, PlanName, price, imgPath, quantity);
                        list.add(orderdetail);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public static boolean checkCancel(int ordID) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "update dbo.Orders\n"
                        + "set status = '3'\n"
                        + "where OrderID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, ordID);
                int result = pst.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean checkOrdAgain(int ordID) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "update dbo.Orders\n"
                        + "set status = '1'\n"
                        + "where OrderID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, ordID);
                int result = pst.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                int accid = 0, orderid = 0;
                cn.setAutoCommit(false); //off autocomit
                //get account id by email
                String sql = "select accID from Accounts where Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    accid = rs.getInt("accID");
                }
                //insert a new order
                System.out.println("accountid: " + accid);
                Date d = new Date(System.currentTimeMillis());
                System.out.println("order date: " + d);
                sql = "insert Orders(OrdDate,status,AccID) values(?,?,?)";
                pst = cn.prepareStatement(sql);
                pst.setDate(1, d);
                pst.setInt(2, 1);
                pst.setInt(3, accid);
                pst.executeUpdate();
                //get order id that is the lagest number
                sql = "select top 1 orderID from Orders order by orderId desc ";
                pst = cn.prepareStatement(sql);
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    orderid = rs.getInt("orderID");
                }
                //insert order details
                System.out.println("orderid: " + orderid);
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    sql = "insert OrderDetails values(?, ?, ?)";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, orderid);
                    pst.setInt(2, Integer.parseInt(pid.trim()));
                    pst.setInt(3, cart.get(pid));
                    pst.executeUpdate();
                    cn.commit();
                    cn.setAutoCommit(true);
                }
                return true;
            } else {
                System.out.println("can not insert order");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static ArrayList<Order> getOrdersFilter(String email, int status) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            Connection cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select OrderID,OrdDate,shipdate,status,AccID\n"
                        + "from dbo.Orders\n"
                        + "where AccID = (select accID\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?\n"
                        + ") AND status = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setInt(2, status);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    int OrderID = rs.getInt("OrderID");
                    String OrdDate = rs.getString("OrdDate");
                    String ShipDate = rs.getString("shipdate");
                    int Status = rs.getInt("status");
                    int AccId = rs.getInt("AccID");
                    Order order = new Order(OrderID, OrdDate, ShipDate, Status, AccId);
                    list.add(order);
                }
                cn.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static ArrayList<Order> getOrdersFilterByDate(String email, String oFrom, String oTo) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            Connection cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select OrderID,OrdDate,shipdate,status,AccID\n"
                        + "from dbo.Orders\n"
                        + "where AccID = (select accID\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?\n"
                        + ") AND OrdDate between ? and ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, oFrom);
                pst.setString(3, oTo);
                ResultSet rs = pst.executeQuery();
                while (rs != null && rs.next()) {
                    int OrderID = rs.getInt("OrderID");
                    String OrdDate = rs.getString("OrdDate");
                    String ShipDate = rs.getString("shipdate");
                    int Status = rs.getInt("status");
                    int AccId = rs.getInt("AccID");
                    Order order = new Order(OrderID, OrdDate, ShipDate, Status, AccId);
                    list.add(order);
                }
                cn.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
