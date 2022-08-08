/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package thanhlh.dto;

import java.util.ArrayList;
import thanhlh.dao.AccountDAO;

/**
 *
 * @author Lenovo
 */
public class testConnection {

    public static void main(String[] args) throws Exception {
//        firstDemo-------------
//        Account acc = AccountDAO.getAccount("bachlx@gmail.com", "09052001");
//        if (acc != null) {
//            if (acc.getRole() == 1) {
//                System.out.println("i am an admin.");
//            } else {
//                System.out.println("i am an user.");
//            }
//        } else {
//            System.out.println("login fail");
//        }

//        firstChallenge-------
//        ArrayList<Account> list = AccountDAO.getAccounts();
//        for(Account account : list){
//            System.out.println(account.getAccID()+","+ account.getEmail() +"," + account.getFullName() +"," + account.getPassword());
//        }

//        secondChallenge-------
//          if(AccountDAO.updateAccountStatus("bachlx@gmail.com", 1)){
//              System.out.println("update status succesfully.");
//          }else{
//              System.out.println("cannot update status.");
//          }

//        thirdChallenge------
//            if(AccountDAO.updateAccount("bachlx@gmail.com", "chuahe", "chuahe", "chuahe")){
//                System.out.println("updated profile.");
//            }else{
//                System.out.println("update profile fail.");
//            }

//        fourChallenge------
//               if(AccountDAO.insertAccount("khanhvv@gmail", "123456", "Vo Vy KHANG", "999999", 1, 1)){
//                   System.out.println("added new account.");
//               }else{
//                   System.out.println("insert new account fail.");
//               }
    }

}
