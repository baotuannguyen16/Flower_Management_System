/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package thanhlh.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import thanhlh.dto.Account;
import thanhlh.utills.DBUtills;

/**
 *
 * @author Lenovo
 */
public class AccountDAO {
//    normalChallenge

    public static Account getAccount(String email, String password) throws SQLException, Exception {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select accID, email, password, fullname, phone, status, role\n"
                        + "from dbo.Accounts\n"
                        + "where email = ? and password = ?  COLLATE latin1_General_CS_AS ";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return acc;
    }

//    1stChallenge
    public static ArrayList<Account> getAccounts() {
        ArrayList<Account> list = new ArrayList<>();
        try {
            //buoc 1: mo ket noi
            Connection cn = DBUtills.makeConnection();

            //buoc 2: viet query va execute
            if (cn != null) {
                String sql = "select accID, email, password, fullname, phone, status, role\n"
                        + "from dbo.Accounts";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);

                //buoc 3: doc ket qua cua buoc 2
                while (rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    Account acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                    list.add(acc);
                }
                //buoc 4: dong ket noi
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//    2ndChallenge - update status
    public static boolean updateAccountStatus(String email, int status) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "update Accounts set status = ? where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setString(2, email);
                int result = pst.executeUpdate();
                if (result > 0) {
                    return true;
                } else {
                    return false;
                }
            }

        } catch (Exception e) {
//            e.printStackTrace();
        }
        return false;
    }

//    3rdChallenge
    public static boolean updateAccount(String email, String newPassword, String newFullname, String newPhone) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select email\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                rs.next();
                if (rs != null && rs.getString(1).equals(email)) {
                    String sqlU = "update Accounts set password = ?, fullname = ?, phone = ? where email = ?";
                    PreparedStatement pstU = cn.prepareStatement(sqlU);
                    pstU.setString(1, newPassword);
                    pstU.setString(2, newFullname);
                    pstU.setString(3, newPhone);
                    pstU.setString(4, email);
                    pstU.executeUpdate();
                    return true;

                } else {
                    return false;
                }
            }

        } catch (Exception e) {
//            e.printStackTrace();
        }
        return false;
    }

//    4thChallenge
    public static boolean insertAccount(String newEmail, String newPassword, String newFullname, String newPhone, int newSatus, int newRole) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Accounts (email, password, fullname, phone, status, role)"
                        + " VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newEmail);
                pst.setString(2, newPassword);
                pst.setString(3, newFullname);
                pst.setString(4, newPhone);
                pst.setInt(5, newSatus);
                pst.setInt(6, newRole);
                pst.execute();
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
//            e.printStackTrace();
        }
        return false;
    }

//    check exist email
    public static boolean checkExist(String email) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select email\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                rs.next();
                if (rs != null && rs.getString(1).equals(email)) {
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

//    check correct pass
    public static boolean checkPass(String email, String password) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select password\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                rs.next();
                if (rs != null && rs.equals(password)) {
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

//    update information
    public static boolean updateInformation(String fullname, String phone, String email) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "update dbo.Accounts\n"
                        + "set fullname = ?, phone = ?\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, fullname);
                pst.setString(2, phone);
                pst.setString(3, email);
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

//    update token
    public static void updateToken(String token, String email) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "update dbo.Accounts\n"
                        + "set token = ?\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                pst.setString(2, email);
                pst.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

//    compare token
    public static int compareToken(String token) {
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select token\n"
                        + "from dbo.Accounts";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs != null & rs.next()) {
                    if (rs.getString("token").equalsIgnoreCase(token)) {
                        return 1;
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

//    get account by token
    public static Account getAccountByToken(String token) throws SQLException, Exception {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select accID, email, password, fullname, phone, status, role\n"
                        + "from dbo.Accounts\n"
                        + "where token = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return acc;
    }

//    search account by name or by email
    public static ArrayList<Account> getAccounts(String keyword, String searchby) {
        ArrayList<Account> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null && searchby != null) {
                String sql = "select accID,email,password,fullname,phone,status,role\n"
                        + "from dbo.Accounts\n";
                if (searchby.equalsIgnoreCase("byname")) {
                    sql = sql + "where fullname like ?";
                } else {
                    sql = sql + "where email like ?";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int AccID = rs.getInt("accID");
                        String Email = rs.getString("email");
                        String Password = rs.getString("password");
                        String Fullname = rs.getString("fullname");
                        String Phone = rs.getString("phone");
                        int Status = rs.getInt("status");
                        int Role = rs.getInt("role");
                        Account acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                        list.add(acc);
                    }

                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//    get account by email
    public static Account getAccountByEmail(String email) {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtills.makeConnection();
            if (cn != null) {
                String sql = "select accID, email, password, fullname, phone, status, role\n"
                        + "from dbo.Accounts\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int AccID = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccID, Email, Password, Fullname, Status, Phone, Role);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return acc;
    }

}
