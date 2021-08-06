//
//  Constant.swift
//  Saloni
//
//  Created by Ankur Verma on 26/03/21.
//

import Foundation
import UIKit
let ACCENT_COLOR = "AccentColor"

let APP_DELEGATE = UIApplication.shared.delegate! as! AppDelegate

//let BASE_URL = "https://salonii.com/api/"

let BASE_URL = "https://femmesalons.com/api/"


let REGISTER_API = "user/register"
/* Params of Registration
 name, email, phone_no, password, image, address, device_token, liked_salon
 */

let LOGIN_API = "user/login"
/* Params of Login
 email,password
 */

let REGISTER_WITH_PHONE = "user/register_with_phone"
/* Params of Reg with Phone
 
 */

let LOGIN_WITH_PHONE = "user/login_with_phone"
/* Param of Login with Phone
 phone_no
 */

let OTP_VERIFICATION = "user/otp_verify"
/* Params of OTP Verification
 phone_no, otp
 */

let PROFILE_PIC_UPDATE = "profile/picture/update"
/* Params of Profile Pic Update
 image
 */

let PROFILE_UPDATE = "profile/update"
/* Params of Profile Update
 name, address, email, phone_no
 */
let CHANGE_PASSWORD = "profile/password/update"
/* Params of Change Password
 old_password,password,password_confirmation
 */


let GET_NEARBY_SALON = "getnearby"
let GET_TOP_SERVICES = "v1/salonCategory"
let GET_OFFERS = "v1/offers"


// KEYS
let IS_LOGGED_IN = "IS_LOGGED_IN"
let IS_FIRST_TIME_LOGGED_IN = "IS_FIRST_TIME_LOGGED_IN"
let UPDATE_PROFILE = "UPDATE_PROFILE"
let UPDATE_LOCATION = "UPDATE_LOCATION"
