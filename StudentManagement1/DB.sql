USE [MobileAttendanceSystemDB]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[User_Id] [uniqueidentifier] NOT NULL,
	[User_Name] [varchar](100) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[Password_Salt] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Attendance]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Attendance](
	[Attendance_Id] [int] IDENTITY(1,1) NOT NULL,
	[Session_Id] [int] NOT NULL,
	[Student_Id] [varchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
	[Total_Present] [int] NULL,
	[Total_Absent] [int] NULL,
	[Leaves] [int] NULL,
 CONSTRAINT [PK_tbl_Attendance] PRIMARY KEY CLUSTERED 
(
	[Attendance_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Course]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Course](
	[Course_Id] [varchar](50) NOT NULL,
	[Course_Name] [varchar](100) NOT NULL,
	[Credit_Hours] [int] NOT NULL,
	[Degree_Id] [varchar](50) NOT NULL,
	[Semester_Id] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Course] PRIMARY KEY CLUSTERED 
(
	[Course_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Degree]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Degree](
	[Degree_Id] [varchar](50) NOT NULL,
	[Degree_Name] [varchar](100) NOT NULL,
	[Dept_Id] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Degree] PRIMARY KEY CLUSTERED 
(
	[Degree_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Department]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Department](
	[Dept_Id] [varchar](50) NOT NULL,
	[Dept_Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_Department] PRIMARY KEY CLUSTERED 
(
	[Dept_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Semester]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Semester](
	[Semester_Id] [int] IDENTITY(1,1) NOT NULL,
	[Degree_Id] [varchar](50) NOT NULL,
	[Semester_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Semester] PRIMARY KEY CLUSTERED 
(
	[Semester_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Session]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Session](
	[Session_Id] [int] IDENTITY(1,1) NOT NULL,
	[Course_Id] [varchar](50) NOT NULL,
	[Teacher_Id] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[SessionTime_Id] [int] NOT NULL,
	[Total_Session] [int] NULL,
 CONSTRAINT [PK_tbl_Session] PRIMARY KEY CLUSTERED 
(
	[Session_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SessionTime]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SessionTime](
	[SessionTime_Id] [int] IDENTITY(1,1) NOT NULL,
	[Session_Time] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_SessionTime] PRIMARY KEY CLUSTERED 
(
	[SessionTime_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Student]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Student](
	[Student_Id] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[Password_Salt] [varchar](200) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Sur_Name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[Badge_No] [int] NOT NULL,
	[Semester_Id] [int] NOT NULL,
	[Degree_Id] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Student] PRIMARY KEY CLUSTERED 
(
	[Student_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_StudentCourse]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_StudentCourse](
	[StudentCourse_Id] [int] IDENTITY(1,1) NOT NULL,
	[Student_Id] [varchar](50) NOT NULL,
	[Course_Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_StudentCourse] PRIMARY KEY CLUSTERED 
(
	[StudentCourse_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_StudentCreditHours]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_StudentCreditHours](
	[StudentCreditHours_Id] [int] IDENTITY(1,1) NOT NULL,
	[Student_Id] [varchar](50) NOT NULL,
	[CreditHours] [int] NOT NULL,
 CONSTRAINT [PK_tbl_StudentCreditHours] PRIMARY KEY CLUSTERED 
(
	[StudentCreditHours_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Teacher]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Teacher](
	[Teacher_Id] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[Password_Salt] [varchar](200) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Sur_Name] [varchar](100) NOT NULL,
	[Designation] [varchar](100) NOT NULL,
	[Dept_Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_Teacher] PRIMARY KEY CLUSTERED 
(
	[Teacher_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_TeacherCourse]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_TeacherCourse](
	[TeacherCourse_Id] [int] IDENTITY(1,1) NOT NULL,
	[Teacher_Id] [varchar](50) NOT NULL,
	[Course_Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_TeacherCourse] PRIMARY KEY CLUSTERED 
(
	[TeacherCourse_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_TeacherCourseStudent]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_TeacherCourseStudent](
	[TeacherCourseStudent_Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherCourse_Id] [int] NOT NULL,
	[Student_Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_TeacherCourseSemeter] PRIMARY KEY CLUSTERED 
(
	[TeacherCourseStudent_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_TeacherCreditHours]    Script Date: 28-Oct-14 1:44:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_TeacherCreditHours](
	[TeacherCreditHours_Id] [int] IDENTITY(1,1) NOT NULL,
	[Teacher_Id] [varchar](50) NOT NULL,
	[CreditHours] [int] NOT NULL,
 CONSTRAINT [PK_tbl] PRIMARY KEY CLUSTERED 
(
	[TeacherCreditHours_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Admin] ([User_Id], [User_Name], [Password], [Password_Salt]) VALUES (N'27be231c-5fb3-4569-8104-0b7c6f12ccbb', N'mujtaba', N'NkHQX1rCQqA09vXcch+zZTiaKt4UP3M2TTkVGrPEj3XBb7pNGc/XM+NZ6D/3n8XlUmd+p1x3L6xlvFmqdPfyig==', N'100000.11UBcg+YMZfh03Am42/2uJS5o/9zgGPhr8cz2Dzn84usDg==')
INSERT [dbo].[Admin] ([User_Id], [User_Name], [Password], [Password_Salt]) VALUES (N'5743b7fa-a3a6-443d-be98-9f0ef35062c8', N'waqas', N'qYL3s5h6OD1ftxZi9MidUAWmbrT6ipBUHkwuAGaMoAjCa6H8oerC1pJjspMhmBQDSY+iYTZA2bg1/IWVuPW+aQ==', N'100000.PIVJQ2n1D27M3ehLMKDVsPmxZ9vck2PpuDgzlBmikxwFkw==')
INSERT [dbo].[Admin] ([User_Id], [User_Name], [Password], [Password_Salt]) VALUES (N'5ed91c77-61e8-41c3-ade6-ba6eac969b26', N'admin', N'L66bQHidumM3PP25HO82U4KZ5zdUbHstx/D4xzZzIktLMdUPKHuTQjYHcO8Re848SRO/a4/e1o3NX2fEDBwtbQ==', N'100000.qJCsSIvXmVaSNVRDcKihdL2hZOk/NzjN906XMXYan5/PnA==')
SET IDENTITY_INSERT [dbo].[tbl_Attendance] ON 

INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (69, 32, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (70, 32, N'1151', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (71, 32, N'1153', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (72, 32, N'1154', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (73, 32, N'1160', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (74, 32, N'1163', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (75, 33, N'1139', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (76, 33, N'1146', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (77, 33, N'1152', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (78, 33, N'1161', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (79, 34, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (80, 34, N'1151', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (81, 34, N'1153', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (82, 34, N'1154', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (83, 34, N'1160', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (84, 34, N'1163', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (85, 35, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (86, 35, N'1151', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (87, 35, N'1153', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (88, 35, N'1154', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (89, 35, N'1160', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (90, 35, N'1163', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (91, 36, N'1145', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (92, 36, N'1151', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (93, 36, N'1153', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (94, 36, N'1154', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (95, 36, N'1160', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (96, 36, N'1163', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (97, 37, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (98, 37, N'1151', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (99, 37, N'1153', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (100, 37, N'1154', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (101, 37, N'1160', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (102, 37, N'1163', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (103, 38, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (104, 38, N'1151', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (105, 38, N'1153', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (106, 38, N'1154', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (107, 38, N'1160', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (108, 38, N'1163', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (109, 39, N'1145', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (110, 39, N'1151', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (111, 39, N'1153', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (112, 39, N'1154', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (113, 39, N'1160', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (114, 39, N'1163', 0, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (115, 40, N'1152', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (116, 40, N'1161', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (117, 41, N'1152', 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_Attendance] ([Attendance_Id], [Session_Id], [Student_Id], [Status], [Total_Present], [Total_Absent], [Leaves]) VALUES (118, 41, N'1161', 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Attendance] OFF
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'CSC-1071', N'Problem Solving Using C', 4, N'D-3', 2)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'CSC-1072', N'Discrete Structure', 3, N'D-3', 2)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'CSF-1071', N'Fundamentals of Computing', 4, N'D-3', 1)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'ENG-1091', N'Functional English', 3, N'D-3', 1)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'HU-1091', N'Pakistan Studies', 4, N'D-3', 2)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'HU-1092', N'Islamic Studies', 2, N'D-3', 1)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'MA-1001', N'Calculus', 3, N'D-3', 1)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'MA-1005', N'Linear Algebra', 8, N'D-3', 2)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'PH-1003', N'Applied Physics', 4, N'D-3', 1)
INSERT [dbo].[tbl_Course] ([Course_Id], [Course_Name], [Credit_Hours], [Degree_Id], [Semester_Id]) VALUES (N'PH-1004', N'Basic Electronics', 4, N'D-3', 2)
INSERT [dbo].[tbl_Degree] ([Degree_Id], [Degree_Name], [Dept_Id]) VALUES (N'D-1', N'BBA', N'6')
INSERT [dbo].[tbl_Degree] ([Degree_Id], [Degree_Name], [Dept_Id]) VALUES (N'D-2', N'BS-Textile', N'4')
INSERT [dbo].[tbl_Degree] ([Degree_Id], [Degree_Name], [Dept_Id]) VALUES (N'D-3', N'BSCS', N'1')
INSERT [dbo].[tbl_Degree] ([Degree_Id], [Degree_Name], [Dept_Id]) VALUES (N'D-4', N'Textile Designing', N'4')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'2', N'Applied Sciences')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'6', N'Business Administration')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'1', N'Computer  Science')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'5', N'Humanities')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'3', N'Polymer Engineering')
INSERT [dbo].[tbl_Department] ([Dept_Id], [Dept_Name]) VALUES (N'4', N'Textile Engineering')
SET IDENTITY_INSERT [dbo].[tbl_Semester] ON 

INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (1, N'D-3', N'First Semester')
INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (2, N'D-3', N'Second Semester')
INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (4, N'D-3', N'Third Semester')
INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (5, N'D-3', N'Fourth Semester')
INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (6, N'D-3', N'Fifth Semester')
INSERT [dbo].[tbl_Semester] ([Semester_Id], [Degree_Id], [Semester_Name]) VALUES (7, N'D-3', N'Seventh Semeter')
SET IDENTITY_INSERT [dbo].[tbl_Semester] OFF
SET IDENTITY_INSERT [dbo].[tbl_Session] ON 

INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (31, N'CSC-1071', N'ntu-1', CAST(0x26390B00 AS Date), 9, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (32, N'CSC-1072', N'ntu-1', CAST(0x20390B00 AS Date), 10, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (33, N'HU-1092', N'ntu-1', CAST(0x26390B00 AS Date), 8, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (34, N'CSC-1072', N'ntu-1', CAST(0x26390B00 AS Date), 10, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (35, N'CSC-1072', N'ntu-1', CAST(0x25390B00 AS Date), 9, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (36, N'CSC-1072', N'ntu-1', CAST(0x2F390B00 AS Date), 10, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (37, N'CSC-1072', N'ntu-1', CAST(0x26390B00 AS Date), 11, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (38, N'CSC-1072', N'ntu-1', CAST(0x26390B00 AS Date), 9, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (39, N'CSC-1072', N'ntu-1', CAST(0x30390B00 AS Date), 13, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (40, N'HU-1092', N'ntu-1', CAST(0x27390B00 AS Date), 9, NULL)
INSERT [dbo].[tbl_Session] ([Session_Id], [Course_Id], [Teacher_Id], [Date], [SessionTime_Id], [Total_Session]) VALUES (41, N'HU-1092', N'ntu-1', CAST(0x27390B00 AS Date), 13, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Session] OFF
SET IDENTITY_INSERT [dbo].[tbl_SessionTime] ON 

INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (8, N'08:30 AM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (9, N'09:30 AM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (10, N'10:30 AM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (11, N'11:30 AM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (12, N'12:30 PM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (13, N'02:10 PM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (14, N'03:00 PM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (15, N'03:50 PM')
INSERT [dbo].[tbl_SessionTime] ([SessionTime_Id], [Session_Time]) VALUES (16, N'04:40 PM')
SET IDENTITY_INSERT [dbo].[tbl_SessionTime] OFF
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1139', N'MIj5CKefCASmsP56g0PQXElY+V2A4aK5J3LdrsICzsF5vVNm76Y6m9BAym0yqZqL9zI4VLOoDzf2uCaU4kqHeg==', N'100000.2plXAv9/cbElRpQJY2XUXpd7kZMYrEmZWpKLlOJiOV8ASQ==', N'Ahmad', N'Ali', N'mujtaba11msn@yahoo.com', 10, 1, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1145', N'Gg0WRLMHbx1pwL27Bd9fslHdKvfhmSduN1ypc0Re57Ep5RHG3PC2OPVPpeiFibh6RFLGDWbtqbXK2GwgpM1soA==', N'100000.Dn3c7dG2Xek1uBft6W4uvt6f1TZE0XUqwqAJK6gpwuZQBw==', N'waqas', N'younus', N'ads@hotmail.com', 10, 2, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1146', N'261TD+vmKdt9YzH4Cn/L1kb8qYDhArenMDavGe1hKikNU+JJGEpb4FIAtuyzcwR8AOBsBFwjhIRx7LTLIpCzug==', N'100000.YVahDyG2vHx9tjmV2d5PlTxsns6KBB4s6lmTET3RFLE8/g==', N'Ahmad', N'Mujtaba', N'abc@gmail.com', 10, 1, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1151', N'LVdKtPWESHOSNK+B1sjzM76p3x76I774VI3HUASxqxoxADNbvQgZU3JYxYCgF9dHfVNNXgVkpWYZ/bZrU0qyFg==', N'100000.QdFzd5ulYgpR6rljhqDnkjPDMyNBLsKsdsR45+xh4kn9nQ==', N'majid', N'akhtar', N'abc@gmail.com', 11, 2, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1152', N'N9SS7Y9CQhbgyHF0ssvTCx5h5ejCchI7t71stIglEA+zkhzwsedjYyyxBNb1d+NQj95+toDscePP3A9zN/X4KA==', N'100000.+WG6YJ2TJdIssixG3HFaRQAKK4Prfz5mIbsGKN2XFbDZYw==', N'Waseem', N'Saleem', N'abc@gmail.com', 11, 1, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1153', N'mkbDFnytBgJTkxboPsBDSfNtGwVQ/X/Tqt5IyXmVCcQBeJFRc+Kl8hjFgEhV/XwfTew4Xp0wZosdS1BiOLg4Ww==', N'100000.r4hMCBu27fNq2FwKqsJ8An6Ov3ci9O/Ai4qHrodwAOA/hg==', N'Hussnain', N'Saleem', N'abc@gmail.com', 11, 2, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1154', N'/nFznXFTE63Wz2wYE4kbCHe2P10+OLhed8PAWMUFmorZlllMjoTgZVdY1ijoU5mYQ2+cv/kQLRkM+LClyLD+ag==', N'100000.XTeK2kz47F8AzdkBvC6oiCqTLIqCppRX9f52W13XciVlqQ==', N'Muhammad', N'Farooq', N'abc@gmail.com', 11, 2, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1160', N'wKlef7yFRYsDzruDDAeZjqQwmcnJnRctwayyIilx4LZIGni2AfNONIwJD1KG88L0uunAwwkH0FOq2eQ+i4ZB2Q==', N'100000.d2V8eypUfLF/laSeKfDCkyNKk84Uvf8WRESBb1f6xRROSQ==', N'Muneeb', N'Nadeem', N'abc@gmail.com', 12, 2, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1161', N's+NupxPAmuKsvyZxi/Y2v6hLOfF5LAk5a8lDxHSaVdzv/y0R3hyjHpMjvkq6FwQUuA7lpVMrM7rlQHjfZbTUwA==', N'100000.tZkS2E2MCioxyoZctqlh6JES/PyKMh0GdIIaPgP0AEBpZg==', N'Yaseen', N'Malik', N'abc@gmail.com', 12, 1, N'D-3')
INSERT [dbo].[tbl_Student] ([Student_Id], [Password], [Password_Salt], [Name], [Sur_Name], [email], [Badge_No], [Semester_Id], [Degree_Id]) VALUES (N'1163', N'T/kNEYpoLsBRHOaSxfHurWzIFjZFP+fBrJElJvLNOygEhsyFL9XWGP0GjHYRXTvOMNmqLPz7XBexHjweb/LPLw==', N'100000.V+4d36eijpmWo+HS1cTlj9H0qJ4sfS0qfNZ0LRbqL1Q1rw==', N'Faisal', N'Abid', N'abc@gmail.com', 12, 2, N'D-3')
SET IDENTITY_INSERT [dbo].[tbl_StudentCourse] ON 

INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (84, N'1139', N'CSF-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (85, N'1139', N'ENG-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (86, N'1139', N'HU-1092')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (87, N'1139', N'MA-1001')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (88, N'1139', N'PH-1003')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (95, N'1146', N'CSF-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (96, N'1146', N'ENG-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (97, N'1146', N'HU-1092')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (98, N'1146', N'MA-1001')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (99, N'1146', N'PH-1003')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (101, N'1151', N'CSC-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (102, N'1151', N'CSC-1072')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (103, N'1151', N'HU-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (104, N'1151', N'MA-1005')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (105, N'1151', N'PH-1004')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (106, N'1152', N'CSF-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (107, N'1152', N'ENG-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (108, N'1152', N'HU-1092')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (109, N'1152', N'MA-1001')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (110, N'1152', N'PH-1003')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (112, N'1153', N'CSC-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (113, N'1153', N'CSC-1072')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (114, N'1153', N'HU-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (115, N'1153', N'MA-1005')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (116, N'1153', N'PH-1004')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (118, N'1154', N'CSC-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (119, N'1154', N'CSC-1072')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (120, N'1154', N'HU-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (121, N'1154', N'MA-1005')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (122, N'1154', N'PH-1004')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (123, N'1161', N'CSF-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (124, N'1161', N'ENG-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (125, N'1161', N'HU-1092')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (126, N'1161', N'MA-1001')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (127, N'1161', N'PH-1003')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (129, N'1160', N'CSC-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (130, N'1160', N'CSC-1072')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (131, N'1160', N'HU-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (132, N'1160', N'MA-1005')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (133, N'1160', N'PH-1004')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (135, N'1163', N'CSC-1071')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (136, N'1163', N'CSC-1072')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (137, N'1163', N'HU-1091')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (138, N'1163', N'MA-1005')
INSERT [dbo].[tbl_StudentCourse] ([StudentCourse_Id], [Student_Id], [Course_Id]) VALUES (139, N'1163', N'PH-1004')
SET IDENTITY_INSERT [dbo].[tbl_StudentCourse] OFF
SET IDENTITY_INSERT [dbo].[tbl_StudentCreditHours] ON 

INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (17, N'1139', 16)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (18, N'1145', 0)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (19, N'1146', 16)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (20, N'1151', 15)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (21, N'1152', 16)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (22, N'1153', 15)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (23, N'1154', 15)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (24, N'1161', 16)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (25, N'1160', 15)
INSERT [dbo].[tbl_StudentCreditHours] ([StudentCreditHours_Id], [Student_Id], [CreditHours]) VALUES (26, N'1163', 15)
SET IDENTITY_INSERT [dbo].[tbl_StudentCreditHours] OFF
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-1', N'ec7Ou/h0W3cdm2utf/jljA30wdXw82K09ZtQlJn2VQQJad+b7cB5jS1iKrswgmwF8l9eHxN2G2vLiN6SSK+eeQ==', N'100000.HKvY8d+xBSp7pjUxyjI+WEbrr1SQcKrVRJeQEYlhA72lxg==', N'Shahbaz', N'Ahmed', N'Assistance Professor', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-10', N'zdLGL0/5H3tbSGXAxT0IBHwmthJFS2ZQaa5AxEYo5T6s4Q/SxiI356QhwdaLhvE9Toym6PDkbGCVEqTfgYQQqQ==', N'100000.oe85kswOBUEnzvJk9z9Czk80sd+KC5rrVVQjG0i6zYWCIA==', N'Zahid', N'Rizwan', N'Associate Professor', N'2')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-11', N'pyJf4ZKtwHcFoY2kLUpBvLno7AmOeA4CtnDHS5jXnz4YU4bowhUpZ5wtoCi+Id+Yo741qA4G4+QQUhuu8CpPcg==', N'100000.cjsvD4+MeMQ3KgsXlHTU3lYct+Tl87LZys8cEHdQa9Uecw==', N'Tahir', N'Hussain', N'Professor', N'2')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-12', N'LhjG3X1B4MKJEG8Jup4dDUETQKQdmbx8W9fNLr2YEBASxebta18iW6sFOvQvF+SGSzwndtZQvXxUjNDnlu/xlg==', N'100000.TfLlc3eCKysnHMCMj7ab0HJZ1VDchmwyZuIQ27XedPAzBw==', N'Mahreen', N'Ahsan', N'Lecturer', N'5')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-2', N'QAlUNIyuCz2+/vx00qMjE4f/rvzGCVtKjsMVa4YBmRjZvzz1+umH1Oq64GFVFx/ToZndERuNX7cuGmtrZB4O7Q==', N'100000.7Qd/agGyhhowm7t+lOEVM4L23Qazj1EZLK6JpSRLaXtauQ==', N'Waqar', N'Ahmad', N'Assistance Professor', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-3', N'BMFdmcx1GTOqhLELH0vhvyjuKOVYgJeILip3Z7Vgb12wrEOU2tJ0FcWyH5N0E6oSnDZ+BqL7eN3zqSelTWqF3g==', N'100000.UJm/Tn2ENH9BKH27wSWkquqy7rketIMredtmMex/xfBY+g==', N'Asif', N'Habib', N'Associate Professor', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-4', N'Qo7qVT1Bkdbh674xHkgToVW7aBRRXRrIv+LSHudejWmZxOQ/2hIwJATNXjTc11Vtfap9HJXkmOWvQb+c+HYGkQ==', N'100000.dEPj3CmFxKi6FN8JW+Hdu7sS6Ue8GsItgTlHVpFTKm4s0Q==', N'Muhammad', N'Asif', N'Assistance Professor', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-5', N'NYiRAho/JUR0a1TCCAUxQZNSxz1WXCj3CvcMUceZGh5b4qPQZggF+lvMxt8pw87PUMgclLokAcjyMnoaDr18KA==', N'100000.0033jvyRFnwfST1L9LU3BD5dDIeuhI+vWHqfHADfREmyMg==', N'Muhammad', N'Shahid', N'Lecturer', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-6', N'qNjvZn0ENUzytuA/N/RfxZhgeZNAjssH8XDdNjhJ5bMR7bIt1sYEy6BLVj4iAOJC//xAiCKUeeopJCnkCH18xg==', N'100000.CTnWDvBPemNE447n1B0Dj/Gh9hlf9yXeLATuHY1Al7NOQA==', N'Muhammad', N'Adeel', N'Lecturer', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-7', N'qEboHly4iWLFLgHQ0K63koBjPhoaWCAaMnNw8RK3+69rqZzs1AeAFb9ARiWUhEk4EdB4MB3awzpxWG0PUOujoQ==', N'100000.wt8VW1F8U0tJukV9WDpE59C4rmJw4FkLX36od7vZuq0F8g==', N'Nasir', N'Mahmood', N'Lecturer', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-8', N'YSct6sfhJWd4UF0FVxFSonKRxJYCTV2/wskuSg4pyw/KBvD722+mxKIO1HqPU9gX9g+lmC/rw9vv0ZM3Si5+UQ==', N'100000.yE1eaysJn30fhdAGFOD6ZeU8MGt6zE18ReZ4sXszi5BrYg==', N'Nadeem', N'Faisal', N'Lecturer', N'1')
INSERT [dbo].[tbl_Teacher] ([Teacher_Id], [Password], [Password_Salt], [Name], [Sur_Name], [Designation], [Dept_Id]) VALUES (N'ntu-9', N'LEF3Um1J148+sCOP623XSrvcyekffeRglEwcFnKSnb+FgtsLVK1JPGDgJIzIIu0iEGk0+RTC6kyZ5yV+dWKtyQ==', N'100000.ovyGZjwqJTx8on81rhYw0utwRVW2iqzJZ+JCiZ5uh7Mqjg==', N'Yasir', N'Nadeem', N'Lecturer', N'2')
SET IDENTITY_INSERT [dbo].[tbl_TeacherCourse] ON 

INSERT [dbo].[tbl_TeacherCourse] ([TeacherCourse_Id], [Teacher_Id], [Course_Id]) VALUES (47, N'ntu-1', N'CSC-1072')
INSERT [dbo].[tbl_TeacherCourse] ([TeacherCourse_Id], [Teacher_Id], [Course_Id]) VALUES (48, N'ntu-1', N'HU-1092')
INSERT [dbo].[tbl_TeacherCourse] ([TeacherCourse_Id], [Teacher_Id], [Course_Id]) VALUES (49, N'ntu-1', N'MA-1001')
SET IDENTITY_INSERT [dbo].[tbl_TeacherCourse] OFF
SET IDENTITY_INSERT [dbo].[tbl_TeacherCourseStudent] ON 

INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (98, 47, N'1145')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (99, 47, N'1151')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (100, 47, N'1153')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (101, 47, N'1154')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (102, 47, N'1160')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (103, 47, N'1163')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (106, 48, N'1152')
INSERT [dbo].[tbl_TeacherCourseStudent] ([TeacherCourseStudent_Id], [TeacherCourse_Id], [Student_Id]) VALUES (107, 48, N'1161')
SET IDENTITY_INSERT [dbo].[tbl_TeacherCourseStudent] OFF
SET IDENTITY_INSERT [dbo].[tbl_TeacherCreditHours] ON 

INSERT [dbo].[tbl_TeacherCreditHours] ([TeacherCreditHours_Id], [Teacher_Id], [CreditHours]) VALUES (21, N'ntu-1', 8)
SET IDENTITY_INSERT [dbo].[tbl_TeacherCreditHours] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Admin]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[Admin] ADD  CONSTRAINT [IX_Admin] UNIQUE NONCLUSTERED 
(
	[User_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_Course]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_Course] ADD  CONSTRAINT [IX_tbl_Course] UNIQUE NONCLUSTERED 
(
	[Course_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_Degree]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_Degree] ADD  CONSTRAINT [IX_tbl_Degree] UNIQUE NONCLUSTERED 
(
	[Degree_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_Department]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_Department] ADD  CONSTRAINT [IX_tbl_Department] UNIQUE NONCLUSTERED 
(
	[Dept_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_Semester]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_Semester] ADD  CONSTRAINT [IX_tbl_Semester] UNIQUE NONCLUSTERED 
(
	[Semester_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_StudentCreditHours]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_StudentCreditHours] ADD  CONSTRAINT [IX_tbl_StudentCreditHours] UNIQUE NONCLUSTERED 
(
	[Student_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_TeacherCreditHours]    Script Date: 28-Oct-14 1:44:39 PM ******/
ALTER TABLE [dbo].[tbl_TeacherCreditHours] ADD  CONSTRAINT [IX_tbl_TeacherCreditHours] UNIQUE NONCLUSTERED 
(
	[Teacher_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Attendance]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Attendance_tbl_Session] FOREIGN KEY([Session_Id])
REFERENCES [dbo].[tbl_Session] ([Session_Id])
GO
ALTER TABLE [dbo].[tbl_Attendance] CHECK CONSTRAINT [FK_tbl_Attendance_tbl_Session]
GO
ALTER TABLE [dbo].[tbl_Attendance]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Attendance_tbl_Student] FOREIGN KEY([Student_Id])
REFERENCES [dbo].[tbl_Student] ([Student_Id])
GO
ALTER TABLE [dbo].[tbl_Attendance] CHECK CONSTRAINT [FK_tbl_Attendance_tbl_Student]
GO
ALTER TABLE [dbo].[tbl_Course]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Course_tbl_Degree1] FOREIGN KEY([Degree_Id])
REFERENCES [dbo].[tbl_Degree] ([Degree_Id])
GO
ALTER TABLE [dbo].[tbl_Course] CHECK CONSTRAINT [FK_tbl_Course_tbl_Degree1]
GO
ALTER TABLE [dbo].[tbl_Course]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Course_tbl_Semester] FOREIGN KEY([Semester_Id])
REFERENCES [dbo].[tbl_Semester] ([Semester_Id])
GO
ALTER TABLE [dbo].[tbl_Course] CHECK CONSTRAINT [FK_tbl_Course_tbl_Semester]
GO
ALTER TABLE [dbo].[tbl_Degree]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Degree_tbl_Department] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[tbl_Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[tbl_Degree] CHECK CONSTRAINT [FK_tbl_Degree_tbl_Department]
GO
ALTER TABLE [dbo].[tbl_Semester]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Semester_tbl_Degree1] FOREIGN KEY([Degree_Id])
REFERENCES [dbo].[tbl_Degree] ([Degree_Id])
GO
ALTER TABLE [dbo].[tbl_Semester] CHECK CONSTRAINT [FK_tbl_Semester_tbl_Degree1]
GO
ALTER TABLE [dbo].[tbl_Session]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Session_tbl_Course] FOREIGN KEY([Course_Id])
REFERENCES [dbo].[tbl_Course] ([Course_Id])
GO
ALTER TABLE [dbo].[tbl_Session] CHECK CONSTRAINT [FK_tbl_Session_tbl_Course]
GO
ALTER TABLE [dbo].[tbl_Session]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Session_tbl_SessionTime] FOREIGN KEY([SessionTime_Id])
REFERENCES [dbo].[tbl_SessionTime] ([SessionTime_Id])
GO
ALTER TABLE [dbo].[tbl_Session] CHECK CONSTRAINT [FK_tbl_Session_tbl_SessionTime]
GO
ALTER TABLE [dbo].[tbl_Session]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Session_tbl_Teacher] FOREIGN KEY([Teacher_Id])
REFERENCES [dbo].[tbl_Teacher] ([Teacher_Id])
GO
ALTER TABLE [dbo].[tbl_Session] CHECK CONSTRAINT [FK_tbl_Session_tbl_Teacher]
GO
ALTER TABLE [dbo].[tbl_Student]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Student_tbl_Degree] FOREIGN KEY([Degree_Id])
REFERENCES [dbo].[tbl_Degree] ([Degree_Id])
GO
ALTER TABLE [dbo].[tbl_Student] CHECK CONSTRAINT [FK_tbl_Student_tbl_Degree]
GO
ALTER TABLE [dbo].[tbl_Student]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Student_tbl_Semester] FOREIGN KEY([Semester_Id])
REFERENCES [dbo].[tbl_Semester] ([Semester_Id])
GO
ALTER TABLE [dbo].[tbl_Student] CHECK CONSTRAINT [FK_tbl_Student_tbl_Semester]
GO
ALTER TABLE [dbo].[tbl_StudentCourse]  WITH CHECK ADD  CONSTRAINT [FK_tbl_StudentCourseSemester_tbl_Course] FOREIGN KEY([Course_Id])
REFERENCES [dbo].[tbl_Course] ([Course_Id])
GO
ALTER TABLE [dbo].[tbl_StudentCourse] CHECK CONSTRAINT [FK_tbl_StudentCourseSemester_tbl_Course]
GO
ALTER TABLE [dbo].[tbl_StudentCourse]  WITH CHECK ADD  CONSTRAINT [FK_tbl_StudentCourseSemester_tbl_Student] FOREIGN KEY([Student_Id])
REFERENCES [dbo].[tbl_Student] ([Student_Id])
GO
ALTER TABLE [dbo].[tbl_StudentCourse] CHECK CONSTRAINT [FK_tbl_StudentCourseSemester_tbl_Student]
GO
ALTER TABLE [dbo].[tbl_StudentCreditHours]  WITH CHECK ADD  CONSTRAINT [FK_tbl_StudentCreditHours_tbl_Student] FOREIGN KEY([Student_Id])
REFERENCES [dbo].[tbl_Student] ([Student_Id])
GO
ALTER TABLE [dbo].[tbl_StudentCreditHours] CHECK CONSTRAINT [FK_tbl_StudentCreditHours_tbl_Student]
GO
ALTER TABLE [dbo].[tbl_Teacher]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Teacher_tbl_Department] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[tbl_Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[tbl_Teacher] CHECK CONSTRAINT [FK_tbl_Teacher_tbl_Department]
GO
ALTER TABLE [dbo].[tbl_TeacherCourse]  WITH CHECK ADD  CONSTRAINT [FK_tbl_TeacherCourse_tbl_Course] FOREIGN KEY([Course_Id])
REFERENCES [dbo].[tbl_Course] ([Course_Id])
GO
ALTER TABLE [dbo].[tbl_TeacherCourse] CHECK CONSTRAINT [FK_tbl_TeacherCourse_tbl_Course]
GO
ALTER TABLE [dbo].[tbl_TeacherCourse]  WITH CHECK ADD  CONSTRAINT [FK_tbl_TeacherCourse_tbl_Teacher] FOREIGN KEY([Teacher_Id])
REFERENCES [dbo].[tbl_Teacher] ([Teacher_Id])
GO
ALTER TABLE [dbo].[tbl_TeacherCourse] CHECK CONSTRAINT [FK_tbl_TeacherCourse_tbl_Teacher]
GO
ALTER TABLE [dbo].[tbl_TeacherCourseStudent]  WITH CHECK ADD  CONSTRAINT [FK_tbl_TeacherCourseSemeter_tbl_Student] FOREIGN KEY([Student_Id])
REFERENCES [dbo].[tbl_Student] ([Student_Id])
GO
ALTER TABLE [dbo].[tbl_TeacherCourseStudent] CHECK CONSTRAINT [FK_tbl_TeacherCourseSemeter_tbl_Student]
GO
ALTER TABLE [dbo].[tbl_TeacherCourseStudent]  WITH CHECK ADD  CONSTRAINT [FK_tbl_TeacherCourseStudent_tbl_TeacherCourse] FOREIGN KEY([TeacherCourse_Id])
REFERENCES [dbo].[tbl_TeacherCourse] ([TeacherCourse_Id])
GO
ALTER TABLE [dbo].[tbl_TeacherCourseStudent] CHECK CONSTRAINT [FK_tbl_TeacherCourseStudent_tbl_TeacherCourse]
GO
ALTER TABLE [dbo].[tbl_TeacherCreditHours]  WITH CHECK ADD  CONSTRAINT [FK_tbl_TeacherCreditHours_tbl_Teacher] FOREIGN KEY([Teacher_Id])
REFERENCES [dbo].[tbl_Teacher] ([Teacher_Id])
GO
ALTER TABLE [dbo].[tbl_TeacherCreditHours] CHECK CONSTRAINT [FK_tbl_TeacherCreditHours_tbl_Teacher]
GO
