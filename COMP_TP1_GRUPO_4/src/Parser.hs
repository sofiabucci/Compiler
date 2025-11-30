{-# OPTIONS_GHC -w #-}
module Parser where

import AST
import Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,181) ([512,0,0,4,0,0,0,512,0,0,16384,0,0,0,0,16,2,0,0,0,64,0,16,0,0,256,0,0,0,3081,1024,256,0,0,12324,4096,0,4508,36,14336,18467,0,0,16,0,32768,0,8192,0,0,64,2,26368,2308,0,0,0,39936,9233,0,0,0,28672,36934,0,49180,31,49152,16665,2,0,0,0,0,0,0,0,0,0,0,14336,18467,0,18032,144,0,0,0,32817,63,0,0,0,0,2048,0,0,8,24648,8192,0,9016,72,28672,36934,0,36064,288,49152,16665,2,13184,1154,0,1127,9,52736,4616,0,4508,36,14336,18467,0,57356,47,0,0,0,0,0,2304,12,4,192,766,32768,64513,9,768,5112,0,0,0,0,0,0,0,128,64,0,0,0,0,49152,7680,0,384,60,0,30723,0,0,0,0,0,0,0,768,0,0,6,8192,3840,0,0,30,4608,0,0,0,0,4096,0,0,33056,32769,0,4,0,0,0,0,0,512,256,0,0,0,2048,0,0,0,16,0,0,0,0,0,32768,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","Declarations","Declaration","Statements","Statement","Expression","procedure","is","begin","end","if","then","else","while","loop","and","or","not","true","false","putline","getline","int","string","':='","':'","'+'","'-'","'*'","'/'","'='","'<'","'>'","'('","')'","';'","id","%eof"]
        bit_start = st Prelude.* 41
        bit_end = (st Prelude.+ 1) Prelude.* 41
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..40]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (10) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (10) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (40) = happyShift action_4
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (41) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (11) = happyShift action_5
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (40) = happyShift action_8
action_5 (5) = happyGoto action_6
action_5 (6) = happyGoto action_7
action_5 _ = happyReduce_2

action_6 (12) = happyShift action_11
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (40) = happyShift action_8
action_7 (5) = happyGoto action_10
action_7 (6) = happyGoto action_7
action_7 _ = happyReduce_2

action_8 (29) = happyShift action_9
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (40) = happyShift action_19
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_3

action_11 (14) = happyShift action_14
action_11 (17) = happyShift action_15
action_11 (24) = happyShift action_16
action_11 (25) = happyShift action_17
action_11 (40) = happyShift action_18
action_11 (7) = happyGoto action_12
action_11 (8) = happyGoto action_13
action_11 _ = happyReduce_6

action_12 (13) = happyShift action_36
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (14) = happyShift action_14
action_13 (17) = happyShift action_15
action_13 (24) = happyShift action_16
action_13 (25) = happyShift action_17
action_13 (40) = happyShift action_18
action_13 (7) = happyGoto action_35
action_13 (8) = happyGoto action_13
action_13 _ = happyReduce_6

action_14 (21) = happyShift action_26
action_14 (22) = happyShift action_27
action_14 (23) = happyShift action_28
action_14 (26) = happyShift action_29
action_14 (27) = happyShift action_30
action_14 (31) = happyShift action_31
action_14 (37) = happyShift action_32
action_14 (40) = happyShift action_33
action_14 (9) = happyGoto action_34
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (21) = happyShift action_26
action_15 (22) = happyShift action_27
action_15 (23) = happyShift action_28
action_15 (26) = happyShift action_29
action_15 (27) = happyShift action_30
action_15 (31) = happyShift action_31
action_15 (37) = happyShift action_32
action_15 (40) = happyShift action_33
action_15 (9) = happyGoto action_25
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (37) = happyShift action_24
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (39) = happyShift action_23
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (28) = happyShift action_22
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (28) = happyShift action_20
action_19 (39) = happyShift action_21
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (21) = happyShift action_26
action_20 (22) = happyShift action_27
action_20 (23) = happyShift action_28
action_20 (26) = happyShift action_29
action_20 (27) = happyShift action_30
action_20 (31) = happyShift action_31
action_20 (37) = happyShift action_32
action_20 (40) = happyShift action_33
action_20 (9) = happyGoto action_54
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_4

action_22 (21) = happyShift action_26
action_22 (22) = happyShift action_27
action_22 (23) = happyShift action_28
action_22 (26) = happyShift action_29
action_22 (27) = happyShift action_30
action_22 (31) = happyShift action_31
action_22 (37) = happyShift action_32
action_22 (40) = happyShift action_33
action_22 (9) = happyGoto action_53
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_13

action_24 (21) = happyShift action_26
action_24 (22) = happyShift action_27
action_24 (23) = happyShift action_28
action_24 (26) = happyShift action_29
action_24 (27) = happyShift action_30
action_24 (31) = happyShift action_31
action_24 (37) = happyShift action_32
action_24 (40) = happyShift action_33
action_24 (9) = happyGoto action_52
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (18) = happyShift action_51
action_25 (19) = happyShift action_39
action_25 (20) = happyShift action_40
action_25 (30) = happyShift action_41
action_25 (31) = happyShift action_42
action_25 (32) = happyShift action_43
action_25 (33) = happyShift action_44
action_25 (34) = happyShift action_45
action_25 (35) = happyShift action_46
action_25 (36) = happyShift action_47
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (21) = happyShift action_26
action_26 (22) = happyShift action_27
action_26 (23) = happyShift action_28
action_26 (26) = happyShift action_29
action_26 (27) = happyShift action_30
action_26 (31) = happyShift action_31
action_26 (37) = happyShift action_32
action_26 (40) = happyShift action_33
action_26 (9) = happyGoto action_50
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_17

action_28 _ = happyReduce_18

action_29 _ = happyReduce_15

action_30 _ = happyReduce_16

action_31 (21) = happyShift action_26
action_31 (22) = happyShift action_27
action_31 (23) = happyShift action_28
action_31 (26) = happyShift action_29
action_31 (27) = happyShift action_30
action_31 (31) = happyShift action_31
action_31 (37) = happyShift action_32
action_31 (40) = happyShift action_33
action_31 (9) = happyGoto action_49
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (21) = happyShift action_26
action_32 (22) = happyShift action_27
action_32 (23) = happyShift action_28
action_32 (26) = happyShift action_29
action_32 (27) = happyShift action_30
action_32 (31) = happyShift action_31
action_32 (37) = happyShift action_32
action_32 (40) = happyShift action_33
action_32 (9) = happyGoto action_48
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_14

action_34 (15) = happyShift action_38
action_34 (19) = happyShift action_39
action_34 (20) = happyShift action_40
action_34 (30) = happyShift action_41
action_34 (31) = happyShift action_42
action_34 (32) = happyShift action_43
action_34 (33) = happyShift action_44
action_34 (34) = happyShift action_45
action_34 (35) = happyShift action_46
action_34 (36) = happyShift action_47
action_34 _ = happyFail (happyExpListPerState 34)

action_35 _ = happyReduce_7

action_36 (40) = happyShift action_37
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (39) = happyShift action_70
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (14) = happyShift action_14
action_38 (17) = happyShift action_15
action_38 (24) = happyShift action_16
action_38 (25) = happyShift action_17
action_38 (40) = happyShift action_18
action_38 (7) = happyGoto action_69
action_38 (8) = happyGoto action_13
action_38 _ = happyReduce_6

action_39 (21) = happyShift action_26
action_39 (22) = happyShift action_27
action_39 (23) = happyShift action_28
action_39 (26) = happyShift action_29
action_39 (27) = happyShift action_30
action_39 (31) = happyShift action_31
action_39 (37) = happyShift action_32
action_39 (40) = happyShift action_33
action_39 (9) = happyGoto action_68
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (21) = happyShift action_26
action_40 (22) = happyShift action_27
action_40 (23) = happyShift action_28
action_40 (26) = happyShift action_29
action_40 (27) = happyShift action_30
action_40 (31) = happyShift action_31
action_40 (37) = happyShift action_32
action_40 (40) = happyShift action_33
action_40 (9) = happyGoto action_67
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (21) = happyShift action_26
action_41 (22) = happyShift action_27
action_41 (23) = happyShift action_28
action_41 (26) = happyShift action_29
action_41 (27) = happyShift action_30
action_41 (31) = happyShift action_31
action_41 (37) = happyShift action_32
action_41 (40) = happyShift action_33
action_41 (9) = happyGoto action_66
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (21) = happyShift action_26
action_42 (22) = happyShift action_27
action_42 (23) = happyShift action_28
action_42 (26) = happyShift action_29
action_42 (27) = happyShift action_30
action_42 (31) = happyShift action_31
action_42 (37) = happyShift action_32
action_42 (40) = happyShift action_33
action_42 (9) = happyGoto action_65
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (21) = happyShift action_26
action_43 (22) = happyShift action_27
action_43 (23) = happyShift action_28
action_43 (26) = happyShift action_29
action_43 (27) = happyShift action_30
action_43 (31) = happyShift action_31
action_43 (37) = happyShift action_32
action_43 (40) = happyShift action_33
action_43 (9) = happyGoto action_64
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (21) = happyShift action_26
action_44 (22) = happyShift action_27
action_44 (23) = happyShift action_28
action_44 (26) = happyShift action_29
action_44 (27) = happyShift action_30
action_44 (31) = happyShift action_31
action_44 (37) = happyShift action_32
action_44 (40) = happyShift action_33
action_44 (9) = happyGoto action_63
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (21) = happyShift action_26
action_45 (22) = happyShift action_27
action_45 (23) = happyShift action_28
action_45 (26) = happyShift action_29
action_45 (27) = happyShift action_30
action_45 (31) = happyShift action_31
action_45 (37) = happyShift action_32
action_45 (40) = happyShift action_33
action_45 (9) = happyGoto action_62
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (21) = happyShift action_26
action_46 (22) = happyShift action_27
action_46 (23) = happyShift action_28
action_46 (26) = happyShift action_29
action_46 (27) = happyShift action_30
action_46 (31) = happyShift action_31
action_46 (37) = happyShift action_32
action_46 (40) = happyShift action_33
action_46 (9) = happyGoto action_61
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (21) = happyShift action_26
action_47 (22) = happyShift action_27
action_47 (23) = happyShift action_28
action_47 (26) = happyShift action_29
action_47 (27) = happyShift action_30
action_47 (31) = happyShift action_31
action_47 (37) = happyShift action_32
action_47 (40) = happyShift action_33
action_47 (9) = happyGoto action_60
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (19) = happyShift action_39
action_48 (20) = happyShift action_40
action_48 (30) = happyShift action_41
action_48 (31) = happyShift action_42
action_48 (32) = happyShift action_43
action_48 (33) = happyShift action_44
action_48 (34) = happyShift action_45
action_48 (35) = happyShift action_46
action_48 (36) = happyShift action_47
action_48 (38) = happyShift action_59
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_29

action_50 _ = happyReduce_28

action_51 (14) = happyShift action_14
action_51 (17) = happyShift action_15
action_51 (24) = happyShift action_16
action_51 (25) = happyShift action_17
action_51 (40) = happyShift action_18
action_51 (7) = happyGoto action_58
action_51 (8) = happyGoto action_13
action_51 _ = happyReduce_6

action_52 (19) = happyShift action_39
action_52 (20) = happyShift action_40
action_52 (30) = happyShift action_41
action_52 (31) = happyShift action_42
action_52 (32) = happyShift action_43
action_52 (33) = happyShift action_44
action_52 (34) = happyShift action_45
action_52 (35) = happyShift action_46
action_52 (36) = happyShift action_47
action_52 (38) = happyShift action_57
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (19) = happyShift action_39
action_53 (20) = happyShift action_40
action_53 (30) = happyShift action_41
action_53 (31) = happyShift action_42
action_53 (32) = happyShift action_43
action_53 (33) = happyShift action_44
action_53 (34) = happyShift action_45
action_53 (35) = happyShift action_46
action_53 (36) = happyShift action_47
action_53 (39) = happyShift action_56
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (19) = happyShift action_39
action_54 (20) = happyShift action_40
action_54 (30) = happyShift action_41
action_54 (31) = happyShift action_42
action_54 (32) = happyShift action_43
action_54 (33) = happyShift action_44
action_54 (34) = happyShift action_45
action_54 (35) = happyShift action_46
action_54 (36) = happyShift action_47
action_54 (39) = happyShift action_55
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_5

action_56 _ = happyReduce_8

action_57 (39) = happyShift action_74
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (13) = happyShift action_73
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_30

action_60 (19) = happyShift action_39
action_60 (20) = happyShift action_40
action_60 (30) = happyShift action_41
action_60 (31) = happyShift action_42
action_60 (32) = happyShift action_43
action_60 (33) = happyShift action_44
action_60 (34) = happyFail []
action_60 (35) = happyFail []
action_60 (36) = happyFail []
action_60 _ = happyReduce_25

action_61 (19) = happyShift action_39
action_61 (20) = happyShift action_40
action_61 (30) = happyShift action_41
action_61 (31) = happyShift action_42
action_61 (32) = happyShift action_43
action_61 (33) = happyShift action_44
action_61 (34) = happyFail []
action_61 (35) = happyFail []
action_61 (36) = happyFail []
action_61 _ = happyReduce_24

action_62 (19) = happyShift action_39
action_62 (20) = happyShift action_40
action_62 (30) = happyShift action_41
action_62 (31) = happyShift action_42
action_62 (32) = happyShift action_43
action_62 (33) = happyShift action_44
action_62 (34) = happyFail []
action_62 (35) = happyFail []
action_62 (36) = happyFail []
action_62 _ = happyReduce_23

action_63 _ = happyReduce_22

action_64 _ = happyReduce_21

action_65 (32) = happyShift action_43
action_65 (33) = happyShift action_44
action_65 _ = happyReduce_20

action_66 (32) = happyShift action_43
action_66 (33) = happyShift action_44
action_66 _ = happyReduce_19

action_67 (19) = happyShift action_39
action_67 (30) = happyShift action_41
action_67 (31) = happyShift action_42
action_67 (32) = happyShift action_43
action_67 (33) = happyShift action_44
action_67 _ = happyReduce_27

action_68 (30) = happyShift action_41
action_68 (31) = happyShift action_42
action_68 (32) = happyShift action_43
action_68 (33) = happyShift action_44
action_68 _ = happyReduce_26

action_69 (13) = happyShift action_71
action_69 (16) = happyShift action_72
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_1

action_71 (14) = happyShift action_77
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (14) = happyShift action_14
action_72 (17) = happyShift action_15
action_72 (24) = happyShift action_16
action_72 (25) = happyShift action_17
action_72 (40) = happyShift action_18
action_72 (7) = happyGoto action_76
action_72 (8) = happyGoto action_13
action_72 _ = happyReduce_6

action_73 (18) = happyShift action_75
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_12

action_75 (39) = happyShift action_80
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (13) = happyShift action_79
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (39) = happyShift action_78
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_9

action_79 (14) = happyShift action_81
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_11

action_81 (39) = happyShift action_82
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_10

happyReduce_1 = happyReduce 9 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Program happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_0  5 happyReduction_2
happyReduction_2  =  HappyAbsSyn5
		 ([]
	)

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happyReduce 4 6 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_1, happy_var_3)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_1, happy_var_3)
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_0  7 happyReduction_6
happyReduction_6  =  HappyAbsSyn7
		 ([]
	)

happyReduce_7 = happySpecReduce_2  7 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1 : happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 4 8 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Assignment happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 8 happyReduction_9
happyReduction_9 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (If happy_var_2 happy_var_4 Nothing
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 9 8 happyReduction_10
happyReduction_10 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (If happy_var_2 happy_var_4 (Just happy_var_6)
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 7 8 happyReduction_11
happyReduction_11 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (While happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 8 happyReduction_12
happyReduction_12 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (ExpressionStmt (Call "Put_Line" [happy_var_3])
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_2  8 happyReduction_13
happyReduction_13 _
	_
	 =  HappyAbsSyn8
		 (ExpressionStmt (Call "Get_Line" [])
	)

happyReduce_14 = happySpecReduce_1  9 happyReduction_14
happyReduction_14 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn9
		 (Var happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn9
		 (IntLit happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  9 happyReduction_16
happyReduction_16 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn9
		 (StrLit happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  9 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn9
		 (BoolLit True
	)

happyReduce_18 = happySpecReduce_1  9 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn9
		 (BoolLit False
	)

happyReduce_19 = happySpecReduce_3  9 happyReduction_19
happyReduction_19 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Add happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Sub happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  9 happyReduction_21
happyReduction_21 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Mul happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  9 happyReduction_22
happyReduction_22 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Div happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  9 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Eq happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  9 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Lt happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  9 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Gt happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  9 happyReduction_26
happyReduction_26 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp And happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  9 happyReduction_27
happyReduction_27 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Or happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  9 happyReduction_28
happyReduction_28 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (UnOp Not happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  9 happyReduction_29
happyReduction_29 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (UnOp Neg happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  9 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 41 41 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenProcedure -> cont 10;
	TokenIs -> cont 11;
	TokenBegin -> cont 12;
	TokenEnd -> cont 13;
	TokenIf -> cont 14;
	TokenThen -> cont 15;
	TokenElse -> cont 16;
	TokenWhile -> cont 17;
	TokenLoop -> cont 18;
	TokenAnd -> cont 19;
	TokenOr -> cont 20;
	TokenNot -> cont 21;
	TokenTrue -> cont 22;
	TokenFalse -> cont 23;
	TokenPutLine -> cont 24;
	TokenGetLine -> cont 25;
	TokenInt happy_dollar_dollar -> cont 26;
	TokenString happy_dollar_dollar -> cont 27;
	TokenAssign -> cont 28;
	TokenColon -> cont 29;
	TokenPlus -> cont 30;
	TokenMinus -> cont 31;
	TokenTimes -> cont 32;
	TokenDiv -> cont 33;
	TokenEq -> cont 34;
	TokenLt -> cont 35;
	TokenGt -> cont 36;
	TokenLParen -> cont 37;
	TokenRParen -> cont 38;
	TokenSemicolon -> cont 39;
	TokenId happy_dollar_dollar -> cont 40;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 41 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError tokens = error ("Parse error at: " ++ show (take 10 tokens))
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
