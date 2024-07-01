Return-Path: <linux-can+bounces-929-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C891E49C
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B231C21AEA
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F116D4C0;
	Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="DndMAplu"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2097.outbound.protection.outlook.com [40.107.20.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECE16D4D9
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849015; cv=fail; b=EsoRed2tU/e6y1LeIo9Bw/fiYO5U4K+gU/fpTwE/Wxtfec4YCe2XK/wjxrK6igqWfa1ggJdsAIYuXXB0a//TJyIQ2wpCbxj+uiUwQSRAaO+MDOtaQCesshSfaUSKhT3b91YCIcKwqAPt1ykd4b6ywNybFvyouN13N5WdlnUrLcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849015; c=relaxed/simple;
	bh=wEIjTgJX/oXtfPRXSHoAnqC2sdKVnUt+36ts+PD4ZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rS2onbpY7GHdVqKyOG7PyG3CyapyBuJ1W6kopJK66k/eCa+F2SDkrBbsp/U8ciu1Al3CnEhhgK1TJ2qOPOoX9W/NbigFHh8kcBcl6MI6QkRRoUpuXnzXkGuo0KDuOV2bb0zIjHoowL2BA7QQECLtn3UElFC+JtdP3gLA/zy6plI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=DndMAplu; arc=fail smtp.client-ip=40.107.20.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrsvQs/NHlEO+Ck05WNyCTBAvwoYtXjnMmdbzZ9g5UfopWDI6SjSPWWVBZWajQztXo11OP2gNfHrTKSBnfqPnfNrALroDyNiyCg7W+HqOVAGLMbshWptCjvh7ttqvYSfmlS70rFhnIPq9SomrrJ02K2tdmCOrLAzyveRH2uM9BhOUjvLwoTe3tZjQ5XkaZ8u0OtQGJLx02TU5eNGo0QLWtb83ZfaiPvch/dLKsa/HP+9BhurS4J0W/WWsuI+W7ILzQawhZalWU3PrSuhP/+k/6q5JvoCd2OjJxXXzBZn/8qputvIqH8clFo8Itt3ZEyqxCJuICV4Y8OhIEt8HeP0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ed9FGU094T5+KaUt6QZeVUUki5zl6xyRRTKBTp6mMA=;
 b=d+I5BP5wWkz8zWD1k8O1vdYGictM92MryYb9sW7S97ObclAxzr6mWCSQxmhUvhYnAgszNiApTsAPQZd50j+gWqn9jaQw87O61f5L/oYFuZFvGZq4hTLHzIQDtQxpkMt4F93zmhS/Vcxup762kZKixygte84JvK5mqW4lMbTJhS9S8ZrILKwc44GI7rep22nv9i7VJ8sEJX6CeI2b+ovw4f4MGrmfv1acjLm19rSiMv55Sjktlo5ef+sc64mJrCIQVbWewznbXX3brk6x0QvCcZMemHbo1O72Lr6tQdNd7hwCq/dz7qMN/mDY78Iz4fQUdB9LKdmBGY9myuaXXNTKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ed9FGU094T5+KaUt6QZeVUUki5zl6xyRRTKBTp6mMA=;
 b=DndMApluUuA3yjP8TLRP40Vyop4doVHjluYZ57j+MgOwGFbJSowIpAjAGskQhVdn48OZg1xI3GC6eph0321sGE6XHxzqTmD3pcxXcCSawTtUPHj3r+9ZUb+bCC/p7/VP+8KZPCLQahgg5rnSJNPDtvHGrIDBBjaLmCIWDU420Ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:04 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:04 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 09/15] can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
Date: Mon,  1 Jul 2024 17:49:30 +0200
Message-ID: <20240701154936.92633-10-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: cb26056d-9e78-4b8f-629c-08dc99e578da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uB+ORsHMQN1SNzoKAJtKYxchSrk6a3tPbGTZUc3RJShFj8+LuhkIa+JgHUie?=
 =?us-ascii?Q?QcK/+V+mKcr35KGyV3OrkSBPS4+f/TSQwLP77A02t/NPK8TWTF5ggcufhUHz?=
 =?us-ascii?Q?Nhmr6mbWwP44PaNwA4AIpJGbz4kVaNLohRMNLfCJUd72lA7DpxclEX2esEis?=
 =?us-ascii?Q?Z7SfTyWYFCoSC0wU0bCJpUzvmDAOWzJBXzHi6ixKggjwNLRxebv4wAJCkHdy?=
 =?us-ascii?Q?iz4/XaUFfYhy3gx54yHmVK/zyjRxFZXalWXa2pizvfLAOMCLwJr9QyxGYJn6?=
 =?us-ascii?Q?iaNGtLKymRnBsKNkmEKAWvWE1lb+Op+I/dGHEtqcKij3jAbV/uu++P98S/8n?=
 =?us-ascii?Q?Bg6Ne/YRjhVTqyQa+B5aDYZGxsrsfPRq/RASlGlts93nNr8bjI7O9dy2/Zqn?=
 =?us-ascii?Q?c1WlMzMB3Fgl6Mk/S/3tY9IVT6UTnavQuC61DOqp6Ij89k7VlaJNUDK/X8ns?=
 =?us-ascii?Q?nZGvdJmSxWMvQX/UILRqigLJKvTm0v8zm5zz812cpxv5Gah/RBBI0qaF0xBB?=
 =?us-ascii?Q?45iIEaUe7w5l83PI5ugglIq07Mk+w9/HK3SIokAw3FPm3CXB/39aqmafVR7j?=
 =?us-ascii?Q?FT1yTq9CKEZBmXJK8qvFoBQc6WVwBIQD9wTMZAx7dcLxCx6OiOEo/FO4t7Wt?=
 =?us-ascii?Q?LxaqdyRAL3rcKOBrQpc8cQZ/AK+GjBb9XfZb0/o0MlHKNIXcSVQzTroNkXWY?=
 =?us-ascii?Q?vnGgdN/WanDNyr3/F5DN7abTlbytrTpGQKi6rR1zjURYJtkFdFoVMhSiGOzc?=
 =?us-ascii?Q?f3KSv7FwyCtNU1QYLprfL4mAENI4gQpvWvjQ6Q7JT3MQYcg5emB/FKiOnMmj?=
 =?us-ascii?Q?Js2lBJf5Ys6Es0alvDyHkTV7AdrjdNsHvuXCox51TUNv0PEY/bD51l3mV0tJ?=
 =?us-ascii?Q?NaDIHz5pajGCyY5UvFsSeQ26gCK3QQy6M6f4gRziZwXjnr9tx+Zk72oFV56S?=
 =?us-ascii?Q?JmpwRiCaLr2tjIcNiCOfjMmK/5nIntrCsJ7o2T38wIvmMFXaUIg6QEy7zIJB?=
 =?us-ascii?Q?DFd3zwBrD6dEP/pEPt46X2z/uA/5bZqv51SdOiLnX28wm87RKDU1aajFZ5o1?=
 =?us-ascii?Q?mh0WnSVG5oFyP/8BIKd5I086diGFcJ55eFDr/6afygTBsJt/LQ1qe7Vg/X30?=
 =?us-ascii?Q?jVMDQaEC5yO60TXtFg8x0zP6wDoNhQRDttyGiIc0dQErmP4qRMBL2GGvxDem?=
 =?us-ascii?Q?Jd2tPKzAwQlZbeOji+uXnYFXm4FBmmz/LCu3cupNintBn1FIzciiJn94LIo1?=
 =?us-ascii?Q?4+JhrVt9lIPBOA2cIjkAZ7vzl5if/wcQmaS0aPcmW5SIvB+oB9MQNVcOx/RC?=
 =?us-ascii?Q?L4FcqTci6JS6jm/1sY/lC3PMMd0wIXJjrmcCM11TO+2T/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWLddGVrsJ0TUapYU8hBe3jZMlU5hTciQdSUckPIuMDLaRXmgLsLTcgB9g9K?=
 =?us-ascii?Q?i55Fzw5C41SSJvnDAh6yptetw/dn5XrEw1AtqKRN9FiyEwAjxfOmkDIGyxhT?=
 =?us-ascii?Q?ed+CkKvrZK/JLmQZbKB7S4Jicj0+kkQ/L1lTLUrBvgtCxoYTsx/n6/BaES5l?=
 =?us-ascii?Q?aD55Qtpi2uaQisGP5IfA0EgCBnrwzPWxHBINe3DWJGYOYCIRB58Q3D8pp/qz?=
 =?us-ascii?Q?GfzFafy/p7emrDmN8EAWoM9YASf2DVtLq1vr2MpEkMJcSvqIGvIvN13Q8WCs?=
 =?us-ascii?Q?dL2t3ZShL57yqaRbHcNmn2xDZ1DpWwm0XmynjKsWWlxl301dxMY9WiWa6PRp?=
 =?us-ascii?Q?uvHHKhi5ReRnMCbJTRGJvB5jHTPxIUnMsa6xIMHMmLjIrkCKhwpLdmgr26Yr?=
 =?us-ascii?Q?8P3gcsNlqXXWcoFkFRWwxjUTFJ2OwUM7fYFwE5BWw3RApJEjpUJUCjx1eSVF?=
 =?us-ascii?Q?g5aljoFI9C1VptHsvNvsSTvvqn/BsvXN89+lpnC4l7f9x4qxIiZlVVfPpIFt?=
 =?us-ascii?Q?8es+FaVyjJ9SeNi3EUCM90f78oZAQFYbMJ2VdDhdYwACqGNZ/L0IDswS8UZb?=
 =?us-ascii?Q?9dDoAIW3CiKNL183haQFDesbD3a6fdiBuHYZgvwBf+z7BeE73ZK8yKiw14th?=
 =?us-ascii?Q?wbVKpOhdlYRybH2ZQTOD3Cwpbv7AcnKlxhdKQ0W4jG9ZhHVMcNDx7kUQZo8s?=
 =?us-ascii?Q?cqri35kfwGU6+cCBph4ZfWU++lFR/SrpzsjtL0gfPuZ7BfKgCsd8Y8w8d4tn?=
 =?us-ascii?Q?fZu2HlR2jD9hz/K3ouU38GxO0jn4WIesxmwT74T7x9xn8fxflYSNuI+Fs8sU?=
 =?us-ascii?Q?aHwrZReiNb+jluN0wxrLBQnSPzSDjDtv2A4MucKFk1Mwtv8QNPMeNN8SUVmJ?=
 =?us-ascii?Q?WSOKvVwhG9OoH8gDVCBRJmQ8fB84Idkcrs4FW97aNKCCBs3i1WarUsbcj6dh?=
 =?us-ascii?Q?shHjD7pD8MpiqupAYkJsg/ul55a1c/TUY6zQSQ963QATP5ieSk1PqXqv5+TE?=
 =?us-ascii?Q?K+ROPkFxcilSf/h+oxHebV4yAX/6BDn6lUm4d9L5wHngF5U5U3QMKX3QIAK3?=
 =?us-ascii?Q?f+WEx+wPGtd4cV4umbcDRPxvOj7Z7j4SYfL8y+jmaWMUqHPBtFjg6BQ9oc8W?=
 =?us-ascii?Q?yrEa/qiDyroyOmunBVsqfX54HOHbuipuTNcSW7uDk7HUcxYxmgAaJlZ1iDUQ?=
 =?us-ascii?Q?EKBazftl1npklwDBt5VilOxxvWxZWweRArTw1NlFBRtjmVxFNeAgTFRQKFSv?=
 =?us-ascii?Q?eUhf9XXCV1sFjlwRP2L5ybSDAt+V9NVOaNqjRQ2aM3UGbHmP+YCfA/GcStM9?=
 =?us-ascii?Q?Gs4ZLep/VUz8afSNQG0fQOIBqPuXC7bhBiKzrnx5A+RMUbarPh96G0vfLoKE?=
 =?us-ascii?Q?bWLBNZOEWy9qNIWBV5cQ3j5tdwDZ7de6M562VRHCSSnj/SS/wBnqsoLraFBE?=
 =?us-ascii?Q?essjkDH8LpmAffPSfYOnUmvgbvt5mWCOgEAKm2ci/0+ggpVFI3VL+nbz3u3d?=
 =?us-ascii?Q?VGFyb0MwFrnsuAuUbv3lSkNd5jjxLjkvLx4hqf5gVvrqJorQc0E0BEsTPVNF?=
 =?us-ascii?Q?RVlZtCtH3ytsX/4H1BGYbNw1qnQav/pbu/tu+N8L?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb26056d-9e78-4b8f-629c-08dc99e578da
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:03.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2NX0tVzDp5V3yUteUtQURqCFTs27DOwik7sfpKTXIYTjkrvBng4JuXRHz0fxeCejEaYYEjbWHgnYysFFXIMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add hardware timestamp support to leaf based devices (M32C and leafimx).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Utilize new helper functions, from
    can: kvaser_usb: Add helper functions to convert device timestamp into ktime


 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 +++++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daa34b532aa8..b5d762d38d5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -106,14 +106,16 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -121,13 +123,14 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
 		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index caef1f26a95c..5839333eb5ae 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -915,6 +915,8 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 	struct kvaser_usb_net_priv *priv;
 	unsigned long flags;
 	u8 channel, tid;
+	struct sk_buff *skb;
+	ktime_t hwtstamp = 0;
 
 	channel = cmd->u.tx_acknowledge_header.channel;
 	tid = cmd->u.tx_acknowledge_header.tid;
@@ -954,9 +956,19 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
+	switch (dev->driver_info->family) {
+	case KVASER_LEAF:
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.tx_ack.time);
+		break;
+	case KVASER_USBCAN:
+		break;
+	}
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = hwtstamp;
 	stats->tx_packets++;
 	stats->tx_bytes += can_get_echo_skb(priv->netdev,
 					    context->echo_index, NULL);
@@ -1334,6 +1346,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	struct net_device_stats *stats;
 	u8 channel = cmd->u.rx_can_header.channel;
 	const u8 *rx_data = NULL;	/* GCC */
+	ktime_t hwtstamp = 0;
 
 	if (channel >= dev->nchannels) {
 		dev_err(&dev->intf->dev,
@@ -1364,6 +1377,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		rx_data = cmd->u.leaf.rx_can.data;
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.rx_can.time);
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
@@ -1410,6 +1424,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 			memcpy(cf->data, &rx_data[6], cf->len);
 	}
 
+	skb_hwtstamps(skb)->hwtstamp = hwtstamp;
 	stats->rx_packets++;
 	if (!(cf->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cf->len;
-- 
2.45.2


