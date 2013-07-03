;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: USBUART_1_descr.asm
;;   Version: 1.60, Updated on 2013/5/19 at 10:44:50
;;  Generated by PSoC Designer 5.4.2946
;;
;;  DESCRIPTION: USBUART User Module Descriptors
;;
;;  NOTE: User Module APIs conform to the fastcall convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API
;;        function returns. Even though these registers may be preserved now,
;;        there is no guarantee they will be preserved in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2013. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "USBUART_1.inc"
include "USBUART_1_macros.inc"

;----------------------------------------------------------------------
; Device Dispatch Table  for User Module: (USBUART)
;----------------------------------------------------------------------
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF

EXPORT USBUART_1_DEVICE_LOOKUP
.LITERAL
USBUART_1_DEVICE_LOOKUP:
  LT_START    1                       ; Number of devices defined for USBUART
  LT_ENTRY    USBUART_1_D0_CONFIG_LOOKUP, USBUART_1_D0_CONFIG_DESCR_TABLE
.ENDLITERAL

;----------------------------------------------------------------------
; Configuration Dispatch Table
;   for Device: (USBUART_D0)
;----------------------------------------------------------------------
EXPORT USBUART_1_D0_CONFIG_LOOKUP
.LITERAL
USBUART_1_D0_CONFIG_LOOKUP:
  LT_START    1                       ; Number of configurations
  LT_ENTRY    USBUART_1_D0_C1_EP_SETUP, NULL_PTR      ; No Class Descriptors
.ENDLITERAL

;----------------------------------------------------------------------
; Endpoint Setup Table
;
; This table provides the data to configure the endpoint mode registers
; for IN/OUT direction.
;----------------------------------------------------------------------
.LITERAL
USBUART_1_D0_C1_EP_SETUP:
  DB    USB_DIR_IN                    ; Endpoint EP1(IN)
  DB    USB_DIR_IN                    ; Endpoint EP2(IN)
  DB    USB_DIR_OUT                   ; Endpoint EP3(OUT)
  DB    USB_DIR_UNUSED                ; Endpoint EP4 not used for this configuration
.ENDLITERAL

;----------------------------------------------------------------------
; Interface Lookup Table
;
; This table is indexed by interface number.
;----------------------------------------------------------------------
EXPORT USBUART_1_D0_C1_INTERFACE_RPT_LOOKUP
.LITERAL
USBUART_1_D0_C1_INTERFACE_RPT_LOOKUP:
  DW    0                               ; Class Reports not defined for this interface
  DW    0                               ; Class Reports not defined for this interface
.ENDLITERAL

;----------------------------------------------------------------------
; HID Class Descriptor transfer descriptor table
;----------------------------------------------------------------------
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF
EXPORT USBUART_1_D0_C1_HID_CLASS_DESCR_TABLE
.LITERAL
USBUART_1_D0_C1_HID_CLASS_DESCR_TABLE:
  TD_START_TABLE 2                     ; Number of interfaces/HID Class Descriptors
  TD_ENTRY       USB_DS_ROM, 0, NULL_PTR, NULL_PTR
  TD_ENTRY       USB_DS_ROM, 0, NULL_PTR, NULL_PTR
.ENDLITERAL

;----------------------------------------------------------------------
; Configuration Descriptor Table  for (USBUART_D0)
;
;	This table provides transfer descriptors for each USB Configuration Descriptor
;----------------------------------------------------------------------
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF
.LITERAL
USBUART_1_D0_CONFIG_DESCR_TABLE:                     ;
  TD_START_TABLE 1                               ; Number of configurations
  TD_ENTRY       USB_DS_ROM, USBUART_1_D0_C1_DESCR_SIZE, USBUART_1_D0_C1_DESCR_START, NULL_PTR
.ENDLITERAL

;----------------------------------------------------------------------
; Device Descriptor Table
;
;	This table provides transfer descriptors for each USB Device Descriptor
;----------------------------------------------------------------------
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF
EXPORT USBUART_1_DEVICE_DESCR_TABLE
.LITERAL
USBUART_1_DEVICE_DESCR_TABLE:
  TD_START_TABLE 1                               ; Number of devices
  TD_ENTRY       USB_DS_ROM, USBUART_1_D0_DESCR_SIZE, USBUART_1_D0_DESCR_START, NULL_PTR
.ENDLITERAL

;----------------------------------------------------------------------
; Device Descriptor (USBUART_1_D0)
; This marks the beginning of the Device Descriptor.  This descriptor
; concatenates all of the descriptors in the following format:
;	Device Descriptor
;		Configuration Descriptor (1)
;	  	Interface 1 Descriptor
;				Class specific descriptors
;			  	Endpoint Descriptor
;		Interface 2 Descriptor
;				Endpoints Descriptor(s)
;----------------------------------------------------------------------
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF
.LITERAL
USBUART_1_D0_DESCR_START:
  DB    18                                       ; Device Descriptor Length (18)
  DB    1                                        ; bDescriptorType: DEVICE
  DWL   0200H                                    ; bcdUSB (ver 2.0)
  DB    2                                        ; bDeviceClass
  DB    0                                        ; bDeviceSubClass
  DB    0                                        ; bDeviceProtocol
  DB    8                                        ; bMaxPacketSize0
  DWL   04B4H 							 ; idVendor
  DWL   1234H                            ; idProduct
  DWL   0000H                                    ; bcdDevice
  DB    STR_HASH_2                               ; iManufacturer
  DB    STR_HASH_3                               ; iProduct
IF USBUART_1_bSerialNumberType            ; if serial number exists
  DB    STR_HASH_5                               ; iSerialNumber
ELSE
  DB    STR_HASH_0                               ; iSerialNumber
ENDIF
  DB    1                                        ; bNumConfigurations
USBUART_1_D0_DESCR_END:
USBUART_1_D0_DESCR_SIZE:  EQU    USBUART_1_D0_DESCR_END - USBUART_1_D0_DESCR_START

;----------------------------------------------------------------------
; Configuration Descriptor (USBUART_1_D0_C1)
; This marks the beginning of the Configuration Descriptor.  This descriptor
; concatenates all of the descriptors in the following format:
; Configuration Descriptor
;	Interface 1 Descriptor
;		HID Descriptor 1
;			Endpoint Descriptor(s)
;	Interface 2 Descriptor
;		HID Descriptor 2
;			Endpoint Descriptor(s)
;----------------------------------------------------------------------
USBUART_1_D0_C1_DESCR_START:                         ;
  DB    9                                        ; Configuration Descriptor Length (9)
  DB    2                                        ; bDescriptorType: CONFIGURATION
  DWL   USBUART_1_D0_C1_DESCR_SIZE                   ; wTotalLength
  DB    2                                        ; bNumInterfaces
  DB    1                                        ; bConfigurationValue
  DB    STR_HASH_4                               ; iConfiguration
  DB    80H | (0H << 6) | (0 << 5)                ; bmAttributes >
  DB    (64h/2)                          ; bMaxPower
;----------------------------------------------------------------------
; Interface Descriptor (USBUART_1_D0_C1_I0)
;----------------------------------------------------------------------
  DB    9                                        ; Interface Descriptor Length (9)
  DB    4                                        ; bDescriptorType: INTERFACE
  DB    0                                        ; bInterfaceNumber (zero based)
  DB    0                                        ; bAlternateSetting
  DB    1                                        ; bNumEndpoints
  DB    2                                        ; bInterfaceClass: Communication Interface
  DB    2                                        ; bInterfaceSubClass: Abstract Control Model
  DB    1                                        ; bInterfaceProtocol: V.25ter
  DB    STR_HASH_0                               ; iInterface
;----------------------------------------------------------------------
; CDC Class-Specific Descriptors
; Header Functional Descriptor
;----------------------------------------------------------------------
  DB    5                                        ; Descriptors Length (5)
  DB    24H                                      ; bDescriptorType: CS_INTERFACE
  DB	0                                        ; bDescriptorSubType :Header Functional Descriptor
  DWL	0110H                                    ; bcdCDC: CDC Release Number
;----------------------------------------------------------------------
; CDC Class-Specific Descriptors
; Abstract Control Management Functional Descriptor
;----------------------------------------------------------------------
  DB    4                                        ; Descriptors Length (4)
  DB    24H                                      ; bDescriptorType: CS_INTERFACE
  DB	2                                        ; bDescriptorSubType: Abstract Control Model Functional Descriptor
  DB	2                                    	 ; bmCapabilities: Supports the request combination of Set_Line_Coding, Set_Control_Line_State, Get_Line_Coding and the notification Serial_State
;----------------------------------------------------------------------
; CDC Class-Specific Descriptors
; Union Functional Descriptor
;----------------------------------------------------------------------
  DB    5                                        ; Descriptors Length (5)
  DB    24H                                      ; bDescriptorType: CS_INTERFACE
  DB	6                                        ; bDescriptorSubType: Union Functional Descriptor
  DB	0                                    	 ; bMasterInterface
  DB	1                                    	 ; bSlaveInterface
;----------------------------------------------------------------------
; CDC Class-Specific Descriptors
; Call Management Functional Descriptor
;----------------------------------------------------------------------
  DB    5                                        ; Descriptors Length (5)
  DB    24H                                      ; bDescriptorType: CS_INTERFACE
  DB	1                                        ; bDescriptorSubType: Call Management Functional Descriptor
  DB	0                                    	 ; bmCapabilities: Device sends/receives call management information only over the Communication Class Interface.
  DB	1                                    	 ; Interface Number of Data Class interface
;----------------------------------------------------------------------
; Endpoint Descriptor (USBUART_1_D0_C1_I0_E0)
;----------------------------------------------------------------------
  DB    7                                        ; Endpoint Descriptor Length (7)
  DB    5                                        ; bDescriptorType: ENDPOINT
  DB    (EP1 | USB_DIR_IN)                       ; bEndpointAddress
  DB    3                                        ; bmAttributes: Interrupt
  DWL   8                                        ; wMaxPacketSize
  DB    2                                        ; bInterval
;----------------------------------------------------------------------
; Interface Descriptor (USBUART_1_D0_C1_I1)
;----------------------------------------------------------------------
  DB    9                                        ; Interface Descriptor Length (9)
  DB    4                                        ; bDescriptorType: INTERFACE
  DB    1                                        ; bInterfaceNumber (zero based)
  DB    0                                        ; bAlternateSetting
  DB    2                                        ; bNumEndpoints
  DB    AH                                       ; bInterfaceClass: Data Interface
  DB    0                                        ; bInterfaceSubClass
  DB    0                                        ; bInterfaceProtocol
  DB    STR_HASH_0                               ; iInterface
;----------------------------------------------------------------------
; Endpoint Descriptor (USBUART_1_D0_C1_I1_E0)
;----------------------------------------------------------------------
  DB    7                                        ; Endpoint Descriptor Length (7)
  DB    5                                        ; bDescriptorType: ENDPOINT
  DB    (EP2 | USB_DIR_IN)                       ; bEndpointAddress
  DB    2                                        ; bmAttributes: Bulk
  DWL   64                                       ; wMaxPacketSize
  DB    0                                        ; bInterval
;----------------------------------------------------------------------
; Endpoint Descriptor (USBUART_1_D0_C1_I1_E1)
;----------------------------------------------------------------------
  DB    7                                        ; Endpoint Descriptor Length (7)
  DB    5                                        ; bDescriptorType: ENDPOINT
  DB    (EP3 | USB_DIR_OUT)                      ; bEndpointAddress
  DB    2                                        ; bmAttributes: Bulk
  DWL   64                                       ; wMaxPacketSize
  DB    0                                        ; bInterval
;----------------------------------------------------------------------
USBUART_1_D0_C1_DESCR_END:
USBUART_1_D0_C1_DESCR_SIZE:	EQU	(USBUART_1_D0_C1_DESCR_END - USBUART_1_D0_C1_DESCR_START)
.ENDLITERAL

;----------------------------------------------------------------------
; USB String Descriptors
;
; This section contains the USB String Descriptors generated
; by the USB User Module Descriptor Generator
;
; Note:  The string labels are internally generated by the
; descriptor generator
;
; Descriptors that reference string descriptors, use a hashed
; symbol that is set in an EQU directive with each string
; descriptor.
;----------------------------------------------------------------------
STR_HASH_0:  EQU    0                            ; String Hash for the null string
IF	(TOOLCHAIN & HITECH)
  AREA lit (ROM,REL,CON)
ELSE
  AREA lit (ROM,REL,CON,LIT)
ENDIF
EXPORT USBUART_1_StringTable
.LITERAL
USBUART_1_StringTable:
IF USBUART_1_bSerialNumberType   ;if serial number exists
  TD_START_TABLE 5                               ; Number of USB Strings
ELSE
  TD_START_TABLE 4                               ; Number of USB Strings
ENDIF
  TD_ENTRY       USB_DS_ROM, LANGID_DESCR_SIZE, LANGID_DESCR_START, NULL_PTR
  TD_ENTRY       USB_DS_ROM, STRING_2_DESCR_SIZE, STRING_2_DESCR_START, NULL_PTR
  TD_ENTRY       USB_DS_ROM, STRING_3_DESCR_SIZE, STRING_3_DESCR_START, NULL_PTR
  TD_ENTRY       USB_DS_ROM, STRING_4_DESCR_SIZE, STRING_4_DESCR_START, NULL_PTR
IF (USBUART_1_bSerialNumberType & USBUART_1_SERIAL_AUTO)  ;if serial number automatic
  TD_ENTRY       USB_DS_RAM, 26, USBUART_1_SerialString, NULL_PTR
ENDIF
IF (USBUART_1_bSerialNumberType & USBUART_1_SERIAL_MANUAL)   ;if serial number manual
  TD_ENTRY       USB_DS_ROM, STRING_5_DESCR_SIZE, STRING_5_DESCR_START, NULL_PTR
ENDIF

;----------------------------------------------------------------------
; LANGID Descriptor
;----------------------------------------------------------------------
LANGID_DESCR_START:
  DB    ((1 * 2) + 2)                            ; bLength (N+2)
  DB    3                                        ; bDescriptorType (STRING)
  DWL   1033
LANGID_DESCR_END:
LANGID_DESCR_SIZE:  EQU    (LANGID_DESCR_END - LANGID_DESCR_START)
;----------------------------------------------------------------------
; Vendor String Descriptor
;----------------------------------------------------------------------
STR_HASH_2:  EQU    1                            ; String Hash
STRING_2_DESCR_START:
  DB    STRING_2_DESCR_SIZE                      ; bLength
  DB    3                                        ; bDescriptorType (STRING)
  DSU   "Cypress"
STRING_2_DESCR_END:
STRING_2_DESCR_SIZE:  EQU    (STRING_2_DESCR_END - STRING_2_DESCR_START)
;----------------------------------------------------------------------
; Product String Descriptor
;----------------------------------------------------------------------
STR_HASH_3:  EQU    2                            ; String Hash
STRING_3_DESCR_START:
  DB    STRING_3_DESCR_SIZE                      ; bLength
  DB    3                                        ; bDescriptorType (STRING)
  DSU   ""Encore3 UNO""
STRING_3_DESCR_END:
STRING_3_DESCR_SIZE:  EQU    (STRING_3_DESCR_END - STRING_3_DESCR_START)
;----------------------------------------------------------------------
; Configuration String Descriptor
;----------------------------------------------------------------------
STR_HASH_4:  EQU    3                            ; String Hash
STRING_4_DESCR_START:
  DB    STRING_4_DESCR_SIZE                      ; bLength
  DB    3                                        ; bDescriptorType (STRING)
  DSU   "USB-UART Configuration"
STRING_4_DESCR_END:
STRING_4_DESCR_SIZE:  EQU    (STRING_4_DESCR_END - STRING_4_DESCR_START)

IF USBUART_1_bSerialNumberType   ;if serial number exist
  ;----------------------------------------------------------------------
  ; Serial String Descriptor
  ;----------------------------------------------------------------------
  STR_HASH_5:  EQU    4                          ; String Hash
ENDIF
IF (USBUART_1_bSerialNumberType & 2)   ;if serial number manual
; descriptor is located in the RAM
ENDIF
IF (USBUART_1_bSerialNumberType & 2)   ;if serial number manual
  STRING_5_DESCR_START:
    DB    STRING_5_DESCR_SIZE                    ; bLength
    DB    3                                      ; bDescriptorType (STRING)
    DSU   "0000"
  STRING_5_DESCR_END:
  STRING_5_DESCR_SIZE:  EQU    (STRING_5_DESCR_END - STRING_5_DESCR_START)
ENDIF

.ENDLITERAL

   ;---------------------------------------------------
   ;@PSoC_UserCode_BODY_1@ (Do not change this line.)
   ;---------------------------------------------------
   ; Redefine your descriptor table below. You might
   ; cut and paste code from the WIZARD descriptor
   ; above and then make your changes.
   ;---------------------------------------------------


   ;---------------------------------------------------
   ; Insert your custom code above this banner
   ;---------------------------------------------------
   ;@PSoC_UserCode_END@ (Do not change this line.)
; End of File USBUART_1_descr.asm
