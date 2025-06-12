Return-Path: <linux-can+bounces-3829-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F11AD7B08
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 21:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03833B3384
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC12D3220;
	Thu, 12 Jun 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="F/gjGLyi";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="CA8b1L5+"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE31F473A;
	Thu, 12 Jun 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756527; cv=fail; b=ZfVKAwrWcwYGuuPCAEFJ7wEUmxMxB5G3Myn6U3GL3iPXdwu2QCw2pqbgFr330vilg4UzreioEzuU7IdH2iE3jbZ3TZArYqIqOyMqhudoLeOnofo4w/VSijyXVe4pvP7LsufupQpVUtLtDDF2tkVvK8C3BnjCOX9yfb+mv727iT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756527; c=relaxed/simple;
	bh=NJ3d8PWyp1pWQUF7FN/D8VB8rX0OdXYtnLBLgX9boOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FsyxCo2bqW+MbfeAtbccq3nrPhnHarxXI0tr1Z5G6ZE/7JiS2CZegs5IpVfGo8dyjE/dJpeVjPEoO4M8V7dxLk0qV1mJUtwr9DrmLAV7SoWQCpJpwt6ac6HywLttfPDDqU+NHbIE6mSebTmD5Q+8w87sgPa0wVPg4m3pko7qbsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=F/gjGLyi; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=CA8b1L5+; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAOka9002475;
	Thu, 12 Jun 2025 14:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=kwDAfVX6eWQWkoklALyOL4qWRTg
	PyaVpgJkfreXb04E=; b=F/gjGLyiSndM0KpTDZABxbMVgpOZ8P3YIek9XF8XXiJ
	eidySqIJuZoP3AmNoqskEFRqzWVXMUTTPiLRGKxXe8xPgF+8GrHI5ICrDODdWQFy
	ZmgzoIkWUNh9zWbmGRaDBIbP5xNHsnnn5ZDYLN6rLpQajnAFo9xpObMeStJb3jou
	EmzPHr/R72ZCK2A4t/znZ9lwTXGKHvz2oXESEdGDHAlXEjIOB6OTmItqgr63AJZG
	YU+/RDy073GvT9U/mCqwOtzbypRHy0k/oEque/qvMBZDZ2fgD0FY7+tZb25ZoqFh
	9oHiABXmdSsJQrXVwEDf1afX9Y/GAULw53I+nLUNo6Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 477w3ps55x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 14:19:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/DQ3FQ7yh2PpUMJtnCbf+DYyaq3Mc7XOjETYFeZVonTIfYMDtZ7jtxOjLkULEHQltaXBH1k33jiMK3JFAGJ/zon6BPsbZiKSrfee8YpjLOo6MIDIA5nMa0FKbfvOPIBbuApuyy3YdZCdCrr/roY1W72OflHHuAsCbFPkS/XszAfbKe3jrKPlRHgF/GLn+WCyQ5XmqgMIVwpVk9xPmVmeJjAWWn79FS2z4INttW0jH465R7GaV2B2mMYp353BSvVMHNLqbycKr55/g4fEqdvnv+HP8cML1KI/ql3yXradtfXnSK2Uk5YFx/yvCH6YP06vqTbHw0NvCBNoNuAlTvYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwDAfVX6eWQWkoklALyOL4qWRTgPyaVpgJkfreXb04E=;
 b=dnt/gdRSTOoANXs/jkz3n/Vh+JytSxJHXXXgAYDZRJZz70k6iy/+jJ5zPzqH0nvo9Sj6L19c8U9aUKHDVIq9JBZHLu4jjXmPNUPIk4cXOzlpOcXPNoJeij6rmujZvRzJ+r1vk5Uk7PoLj3bKbyPYE8gzvulcqgh+kDuZ81akaO2eLFQW7L8K0TyEO2WjllOrEO4ELK9UbVwUbo8sfvUIy4XNfg8s9/V0IQMBJ9+eTgJgMvb9UVmHMvg/IC3uaa+DahnZCCyuUhnffkQkdNNH+MVZFYYfQ1kmklBFDWeu1rXaQvt5sGSVY7j9Q2w9bU+uVSpqIsrKsh76s7FsZOtDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwDAfVX6eWQWkoklALyOL4qWRTgPyaVpgJkfreXb04E=;
 b=CA8b1L5+XjQgox+alJfjz/sd/yoECzXiGeo3sjnu0F/giSsnbcyDoUhHB0W2088MVQJMZ5blBYKgAhKLvXeANl/nlFqxZVT4jtS5Upbc8AJS05CpyGdZ2sX4ONbexG6WpXDrFNY+kj9XH70CedHrDbntya1lddbBpjQP+o65edPRIorSQwdZ8Ci4ryptOyi4JYngV5g4MFI2ZPwQz+hk8GyXjcJqFBgo6VIU1/zawSro0TooQbGbNrfemtwraKsgf+wSFkDsslwRXpQo1BHXvkOQu9trlbH/ljVA6JlZssrO7WCfKqtQR5Ev4X+rTyr+V8iN6K9y2d7jBQRbHvIcIA==
Received: from CH0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:610:75::29)
 by BY5PR04MB6437.namprd04.prod.outlook.com (2603:10b6:a03:1e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 19:19:08 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::49) by CH0PR04CA0114.outlook.office365.com
 (2603:10b6:610:75::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 19:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 19:19:08 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 14:18:27 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 14:18:29 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 14:18:28 -0500
Received: from OLA-JW4GN34.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 12 Jun 2025 14:18:28 -0500
From: Brett Werling <brett.werling@garmin.com>
To: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, <bwerl.dev@gmail.com>,
        Brett Werling
	<brett.werling@garmin.com>
Subject: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe
Date: Thu, 12 Jun 2025 14:18:25 -0500
Message-ID: <20250612191825.3646364-1-brett.werling@garmin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|BY5PR04MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 9250da59-b459-47f3-095e-08dda9e60101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hoEukW/Ku6aoeAaBV8MnAkKJnHQHyA04676Gm0wiTc8Pd4kdLABAXDVL/mhz?=
 =?us-ascii?Q?BJzhg5cIUi1CX+P3ZMTNLVl1LPsVFzJKpui3ePUB/7L3+hqbxQk+GqCSvYJF?=
 =?us-ascii?Q?S6BZiwxDAmbzoVNv5YvlKgXNANwZMt9LXVSt3PC5vbIlfzAQIbVlbQ1Xu63N?=
 =?us-ascii?Q?8ygvg7g5uAnutB7EyT2j7k2pF0lXrvSoS9OQcOywJdsGFGaEfKe0DrgHZ9+N?=
 =?us-ascii?Q?Uks36iBIELqJx7WyOibFOptOb2h9TFQNfswF62N3fMpJG8r2rPzKKYKYbd0a?=
 =?us-ascii?Q?3WW3i/FSDbasDqYTtpxOsu8W5FDfClsuJcj4hIn/c8mNG2ZhFkfB0jFfFxAX?=
 =?us-ascii?Q?TA6wKfmRBefAy4sZgKxk22343Q+X0QYq6whzKFfLAsWyX+p6nl12Hq5WgrJM?=
 =?us-ascii?Q?UvufXZqx3PVXd5GCNuYBX6oq1VMpCpIQeQwDYj6bvtiyj386S/5NBRdFtL0o?=
 =?us-ascii?Q?W4PJ7PZTOfxU/pdPyWr2YMUE6REquyC7QNgevJQJS+SmAjZ4N05llvUL6nN5?=
 =?us-ascii?Q?DWbgS026H3ojgKMQskghZf6DHNhUtI88y7/jKsWn9HGUzW4KsTFjXSYvDiQX?=
 =?us-ascii?Q?Z/TASMPUqaDaM645A1TDF6DZx1PwNEXnjAgRCFmauJBTY3wZ2mKTyIFn6Y2S?=
 =?us-ascii?Q?S3wHDNiCenrwB+P4DzBwy1tV7k8a+LhX+gQfjxUdfoPP3EXPQJu/HbxUmhWy?=
 =?us-ascii?Q?rPTrcVuG7Cjm2iF0Orh08odpcd6DV7zuMNurX0MuTwkloplgTHtDDu8L/EGI?=
 =?us-ascii?Q?mAnYYTGNvAo3JeNyNLXmNxtgWV2xQ/3eZqJ3WMNAd03R0j5NagNkv62bxSGU?=
 =?us-ascii?Q?kkYGIY3OCBdz8yyIlEcOzqlArxtadT7hC7uBngf5rsbokEl9X+V1X52Z+CDp?=
 =?us-ascii?Q?g989Y+9DRyPQ8YjYvCYYA/6wOGTND+azYDBgU1kKx1XTStwkBZ9jqPFIFNyT?=
 =?us-ascii?Q?ZVQeKa7aRGKR8nSQ66vDDi76zvcCNO2G8SGysqeQ+t/c9Rgurt/LFCf7dWhP?=
 =?us-ascii?Q?VUQ/MjVRxbO++H5/oetn1gM7zSN9VrMfMhU8SgQRusMGE5QrfzJ0SDeHhNVt?=
 =?us-ascii?Q?z7XUd5pVmd8uH4NC7p9Y13O973MMMvDYQz2Yt80P0j1AUYFl+BnafpCsiGgX?=
 =?us-ascii?Q?S4G8buu/8wvdfdkT+CLmUdl2L1ngrMtQb2d5Ala84OrSjwdb9CdN4fXQchaU?=
 =?us-ascii?Q?fplLuTNnNpNghEl1IXXnQEbPM1i4MqKRPlit/QyDaEa8eofMP5Mq6sWM/dE0?=
 =?us-ascii?Q?Gl4y1d/pMlj9BJi1xJYasuRm4BpJklz/yknqXfqJGy14edV3LR8orVcs10sU?=
 =?us-ascii?Q?G79qzfetftAF/Z8rLsPBmDRxy4spCG0M0qdR/XXZQ2q5VwXBG46yQ2kM3fSZ?=
 =?us-ascii?Q?hBrb+OEch0oTKhkAbQpwlrBeJoWGrjDUyaGTYe/FSm3r6trKHd/1AO2B/Wum?=
 =?us-ascii?Q?cUk3NzW7aiPX9xNbmyw1C7LFSJt4+YivLlAeMnAvZF2HfBdw6b9Arp+zRoXF?=
 =?us-ascii?Q?ZxYHaYz7vH9Cl029wxebHoa9zQ3BiCSsgirV?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 19:19:08.0117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9250da59-b459-47f3-095e-08dda9e60101
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6437
X-Proofpoint-ORIG-GUID: 1K7_KG6xJZ3tMR13xlBr-3XPxkunVbGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE1MCBTYWx0ZWRfXy5cQkhaznyFh hPavI8M4YNltfSlP7wGyJvHMgj9dj8bnLCN2JXjxKvwVMZeGhBXz5MJMQNW/ybbQZXvrWeGmD/q U2Re1hRvS1JScalmYm5Pf8He8LGa1EaYbCRUNEQlvV6zh6aZA/ttBnrNM7I51ax68/y74/LgrF2
 00E57afqsRHQaaF2/edJDxE7ka5sMIST/qum8W6+eq9AWU+kWW5jHGypwUrEZlUvMFMAiRBIhX+ eBi0pbYyQxmA6EZkE8UWZQgnlMKQ0QpNVTnHlk/Os/iGqqTaHniXD4NUPxB1+xG919g8+pP+jIH F+aXWHZ+5RmlOCo5ACiv6CtHCxR/9SECu+ZM8V6yneSh/MqhPHgQ/aeG0/t9kwUxxATJzAE7TjR
 Z/IXkX1R04iWit3uNohrwGhfwhlwlDViVATpiz6acavMsZzVCaHZwhH14Lt4z52mhv0+5ISm
X-Proofpoint-GUID: 1K7_KG6xJZ3tMR13xlBr-3XPxkunVbGI
X-Authority-Analysis: v=2.4 cv=SMdCVPvH c=1 sm=1 tr=0 ts=684b282f cx=c_pps a=rpzdijBBfSkI3xxH5MEd0g==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=6IFa9wvqVegA:10 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=K_XiwLw5_EJofLazd_wA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506120150

Fixes the power regulator retrieval in tcan4x5x_can_probe() by ensuring
the regulator pointer is not set to NULL in the successful return from
devm_regulator_get_optional().

Fixes: 3814ca3a10be ("can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before parsing the config")
Signed-off-by: Brett Werling <brett.werling@garmin.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e5c162f8c589..8edaa339d590 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,10 +411,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out_m_can_class_free_dev;
-	} else {
+	if (IS_ERR(priv->power)) {
+		if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_m_can_class_free_dev;
+		}
 		priv->power = NULL;
 	}
 
-- 
2.49.0


