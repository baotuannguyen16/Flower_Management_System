/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package thanhlh.dao;

import java.util.regex.Pattern;

/**
 *
 * @author lehon
 */
public class RegexDAO {

    public static boolean checkMail(String email) {
        Pattern pattern = Pattern.compile("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$");
        return pattern.matcher(email).matches();
    }

    public static boolean checkName(String fullName) {
        if (fullName.length() < 2 || fullName.length() > 40) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean checkPass(String password) {
        if (password.length() < 8 || password.length() > 20) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean checkPhone(String phone) {
        if (phone.length() < 8 || phone.length() > 12 || phone.matches("[a-zA-Z]")) {
            return false;
        } else {
            return true;
        }
    }

}
