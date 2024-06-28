Return-Path: <linux-can+bounces-879-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7191C6F5
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FD32849D3
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56577581A;
	Fri, 28 Jun 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="MFTsp//w"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729D78C7F
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604563; cv=fail; b=uOki4NcuDBFAqaESpvHoYJgGiAG5p4Zvui9POvOnB2QxXEeqFwpoqO0tbQ5wINF+Dy196RZw6Olsk/Q7rpzpQlsQy1DtRzJs3cKDCMRXLS0sLU7OVku6qxS6K0z04Ht6FgXX4MpdG5V6xOdF4IidWdJ4q2+kaA0R6PPUBah6oOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604563; c=relaxed/simple;
	bh=ZLQWKJuyacMGi2AdbdDrhB5y+3nJTOBD1ytGejJc8Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgJrm0jS6zfkCyTn1tL3e5sLGXcX2/6FkhpE/qZwqOqIMXMM7tw8isMx5P9CDD1S4ytFRrSeyGCXOO2y8Gcifv4p4BycrP/VLHhVKZBlgBvNQgNutuLuA4vzjfu1mKGcXh90L49KWrAcwAyn2h/6UmtrSqLca34g30QNMcXNhZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=MFTsp//w; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTBkaj/Rt7ptMPoWeYa+4rL/pGLOZwKD6qMZ2ECo5xR89p++/LB8TbtoK2l9zZkNc5/eyGr/5csF5f4bRmjsZL9eqeGlsK85buJA365ATX47k8hdxrZIF/gLhXqq9TY2DJ+JGxbgW/L3ysOj/cdJMTQHwQBgTep2Sq76Klzi9eIeMe5iM9golArII41/xGPtPaLOIp5juJgOZQ7S/JAzOn3TP3KWWHMvk73bRyFcKfMl5luEs6JpvdsdBr1uzH5yXH6GrBfeEzzgHovv4WwHC7os8Z9tEbFS7XYA4RDBa5qFZV4/vdJ/HEDfPqQWRBFJXoXBcSD4b+zgFHgIEQHHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97ETRWiHeaWvfG6/m8V32IGsvRhrmqMRmYU9lKN5XTw=;
 b=LFWEZRvazLg1BWXr4vkB8pA+fXHnlkhhLVMh71Gbeh6JZijsHfQFrvKd9xKZ/7vGvLbXkuYLjccPT2XvBq9ldWem0KNcbAh4wVbMped+GsvRUKcDjBvDPgOz3jYQyIwC/wazqBuF1HFS2wA2irgGZPpfwA/ZK4n+0vAPQz9o90qaGRX+o10vHtGyZVCsdB6Dy3PO7lKRXHROSRG/e63uv5sVw0BnllzMV1vHYEkpnP0AxwPEefFHfxnnezbQzIpH3ddgbDKqQ4FPqRnrkTRsXZe3nq/uuubaAv8/HuliKawn4MTa394+nXpgESJuhvFEmjF1LL1SvnSOWnzwUdiuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97ETRWiHeaWvfG6/m8V32IGsvRhrmqMRmYU9lKN5XTw=;
 b=MFTsp//wCvp6Bim0+KkTk4XqPu70UmNJ2McaQvsNK2WyHtsrYuCaugtfht10aXJHbeuBrS/FDMdiEOemzkPovzLT+KUpTgsBSjQVf/uIyrh2v/LViJ2IYumTZMpHKF3okACGxoeM+IwB50SWBAyAkjr+w9vJoHurr5z4k6DwJ14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:47 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:47 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 12/15] can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
Date: Fri, 28 Jun 2024 21:55:11 +0200
Message-ID: <20240628195514.316895-13-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca87d2c-f509-4a72-2f31-08dc97ac4da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iry7RaxDNo+LNgX3f/acykWstf5DmjrT6fjM/T+iwGADAqO/A0mV3aSsahDV?=
 =?us-ascii?Q?ka6JSYBzAtWMXWBR4gg7sDys9lNdRB8U/SYXig3MrAOmt6peGxxjl2cYLeg8?=
 =?us-ascii?Q?pYtCnqWb0kqxvIeGw7IE8uRoywRz5Z92ytUkc3WruvmQYMzG9nkqbKjQI1Tk?=
 =?us-ascii?Q?Kjl2nBF4C17XbmuDNdFkZ4l7hb7gtGjWL4nDhNmUh7mKkjFW+j4AZoFnRasi?=
 =?us-ascii?Q?1DT9/VOxaL4Swg1XndyBXTO5CavK9qbi4GJfj0qKZevkO7sbXqaMs7EZVNA9?=
 =?us-ascii?Q?54Gp2Qm2YPTF9nu2USBlmXo3rdXD4AlPAppFvQQJ42u4IhOAYTdsik2yVD6f?=
 =?us-ascii?Q?7S5mIyAiyn8On2mMKKKi2diN7S3NuCKOdLMNQVhw2kMEkRr/bulHIQbSogbG?=
 =?us-ascii?Q?keJ0mSqekWM7PnoS+dbVOIic4aiw4tfYpANAbmGhNkMLdkm2lsBEmjUrP5Vr?=
 =?us-ascii?Q?2ZUrfP/wNia0SErY5GiIqu4bRhlHEQfN8EyFLWcMVJ8h7WTW97RIbQ3dqac7?=
 =?us-ascii?Q?U/giFlAddjePV4326EP06etvg8kJEek3q5ofu63OvjURgwko02W+MtCW6412?=
 =?us-ascii?Q?3Y6UFc8uHwnT3hobxA/btk1ycye7DtEkX0A7XIXHDikiZbjf5i/CzNXHXYe9?=
 =?us-ascii?Q?mMb5NBt0WmmGJf+AkplpqdeqZ+0WE4Bk8+RcXw/U7wVvnRRKJNduBDpgTFDk?=
 =?us-ascii?Q?oFzWxdz9Ozo0FgyXK8GPOryvFzYB45H7L7CRO8EdftJIQhS57zTAjQyzR8d4?=
 =?us-ascii?Q?q4QdOzTxuCOH77G85nV+sh0h4mZNKZpdBWiQ4heFL/l1rzhTUrZUJf89ntnA?=
 =?us-ascii?Q?p6W4pVmfAATB7FZlR5XERT8yfF0PHtBn36TjxPZeHwLTinfBwGP4+8MKAhQC?=
 =?us-ascii?Q?HCAnDZefYCWYp1VFmhbuMbBRaO0j6v9ZEe90GqztERLydLuEbKwbtCYumrm7?=
 =?us-ascii?Q?jAG0Guh1m3+10kA2cUb+7nSt3197NFtuiXxPYSq7g0cu86073Caw0e/vnU3M?=
 =?us-ascii?Q?J1yr1vFncTJdNyHTdQYJdTOHTU4Na9cj36+W71F2A8yEvnSCtXcDNykB5Ih/?=
 =?us-ascii?Q?5M/WdaKelW3+msnYzpZNtzoy6tvkTgTSh757RkdEs69pVXVT0yzONpfSnWwd?=
 =?us-ascii?Q?m05arxSBe7YINLnUCWdShb3Iu9XgoKy12mhcC4ATG98IvZn6eBup7je09uBl?=
 =?us-ascii?Q?gHCS3SFPx6qxymwGLtGMKA+il7Pp85QZ9uPI3bjAYNUxXcQUVKjgFMkMpCoh?=
 =?us-ascii?Q?TpyL2GintJx7lG1gyPIs89DJm6lgrtizlEac6QRYthOflyt+ZcRDhz4SeMTF?=
 =?us-ascii?Q?KMYR1QI6cFM1bGu8OtiswwzUg9pDHvcztIG1gJm+Dx5DBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3LRig1fW/wpcR/Mf1WXjO6waw5sIOJ+YqEErmcADTjA/VFEIsuFaXqBGgR4i?=
 =?us-ascii?Q?RZ9EFP7mueoFciMqfwQQmuW3NWtbOVFRv+tcA1A5DWFvyQAvaU769oEi4Yt0?=
 =?us-ascii?Q?B+tf0qk7NBSxDTLjmdW1MQu5AL4GzUKLoiIKmuWEJZ0iYbzzFKwOthE5L7Bf?=
 =?us-ascii?Q?g6Bv9zzndGKbU9/YiHq32q8OjGMSCe7KsztllSGOI0u+sRVlQFYz5Hld0nk8?=
 =?us-ascii?Q?o107WJ6kbMyLUH/N/+0iveaagw/hm99ivWPe9cJUME+/IR9S+cJyyRYo/l9W?=
 =?us-ascii?Q?7fpsAPC60CmU1UVcnwGWVoZjzpCVqK89E1czGZVvqOvaRVoptRbBbkSrj+xp?=
 =?us-ascii?Q?vHEw6GSaU5owStfJQpCsVgC63Ttnz6HeaCUhU2Kq0MsuLjVPBZKwen76S26X?=
 =?us-ascii?Q?Io/Um9+bH64pMAJVK+vnc8+bhwzLEv391j0LSlhJ7jGL085lJG7rtsu+dPoe?=
 =?us-ascii?Q?32DJfDY4GPDnnMb3L3NQEkXqhuwi+k17y+DGimxAji079yYFHgRPTb/ckbiI?=
 =?us-ascii?Q?sX2Pe7POFx4E/+QhYm43rgxEnyj954ChszjCTduUz7PChevY94/x0mRc5PHy?=
 =?us-ascii?Q?Vzo0rXPouBSro0OrH2qovNzSGq1r9en9MoWvuhUICgCIgTSgQ3ms+h0If6qR?=
 =?us-ascii?Q?TqY7IfO0OLe8OSSdka2VqfxmRe4wqw9Os6FrrLspCNlknhZY7ITQnEAebbuA?=
 =?us-ascii?Q?3NLLHqSNV+c8+QfZQCBKBwzM/gcdddQDejlaRFlHn1lTaxmGPJHfKduKXioS?=
 =?us-ascii?Q?M6F4XLWz0PlVmbdik0nOenrf8/WkL+P4m6aK0wLn79gaDsbWJRgbv5BpxIIT?=
 =?us-ascii?Q?SJCp+Bu7w+KBA2MQc0GBfccLe4jW3PnG4rgcuYyNHJmrNeVHb+o9OFM4m9gV?=
 =?us-ascii?Q?oyXHRdglF7qJEvCsjkTG9GrBOjz/UTKj2AkWhgdsYyfatj/BCMtUKPH6SntY?=
 =?us-ascii?Q?xoGpsp7bOIAMjgk/okAEBckDWewpaMGX17F+KAPgsszhUXd2IopiGN7AnjEp?=
 =?us-ascii?Q?ygQopWmcMlkf+RmYUAn8pHJDRkt5sQ3P8lU6QRiTtAN98qckgNh/Sp5kUHSB?=
 =?us-ascii?Q?8TfNlNh1xvy2E9b5BCGnnTHriF6jtz5Yqvy/iB0/pdDjrPHhZ3DDDB/f7mtm?=
 =?us-ascii?Q?9jNq/hqpDJv2JTXq43x6uW5iC9AtHgrV6T07WkJH7icVPDa4uQojpR1oIN/h?=
 =?us-ascii?Q?/hc6ErWhvpC3wosKKBzkMZyJrN+RoIrf1qAiI9JqJVLNH3Kam0s8rZBtXlHx?=
 =?us-ascii?Q?JPJXmj37RQjUNkIPjPgwKb03wUNSpAFYNHTXKYgqWacLb9/4EOK0b9Qep9bH?=
 =?us-ascii?Q?lQ+x0SFJV3Vp+UotdW4ybYMw3fBjB46xNCZHI4fpdzCxsh7et+je2nZZM9US?=
 =?us-ascii?Q?4MhTXf2puAx1731YFAJKF7m1yUWYuzvy4wGzlk4BKj4nLbSTzxn/9ZnMiuzL?=
 =?us-ascii?Q?ABGbir4dnrf8p/FC5eO3VLLJwNiJy76CJE5/csjRK+oSE0naNH6mW4o1qIUg?=
 =?us-ascii?Q?ssmHbn2ytbG2ILup2QGeDk+POrrHC5VqF5Kf221GcQ4lRPk7ikO0h4MN/xyB?=
 =?us-ascii?Q?3qyhvjIHIDuajzbycPnjx/jGKmZ+T90MWClKaDxH?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca87d2c-f509-4a72-2f31-08dc97ac4da3
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:47.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7tM33YLNhb/PI71y9EBQZ4lWGZSYgZk9u+yPTfonhXFW6imf0JnIqoiYqPRwNyKkHaCpkoAd3g3c2A8lkvJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add hardware timestamp support for all usbcan based devices (M16C).
The usbcan firmware is slightly different compared to the other Kvaser USB
interfaces:
  - The timestamp is provided by a 32-bit counter, with 10us resolution.
    Hence, the hardware timestamp will wrap after less than 12 hours.
  - Each Rx CAN or Tx ACK command only contains the 16-bits LSB of the
    timestamp counter.
  - The 16-bits MSB are sent in an asynchronous event (command), if any
    change occurred in the MSB since the last event.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 ++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b5d762d38d5d..576ddf932f47 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -100,7 +100,8 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_USBCAN,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 9b75f240485d..26227a4ed580 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -121,6 +121,7 @@
 
 /* USBCanII timestamp */
 #define KVASER_USB_USBCAN_CLK_OVERFLOW_MASK GENMASK(31, 16)
+#define KVASER_USB_USBCAN_TIMESTAMP_FACTOR 10
 
 struct kvaser_cmd_simple {
 	u8 tid;
@@ -980,6 +981,9 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 		ticks += (u64)(le16_to_cpu(cmd->u.leaf.tx_ack.time[2])) << 32;
 		break;
 	case KVASER_USBCAN:
+		ticks = le16_to_cpu(cmd->u.usbcan.tx_ack.time);
+		ticks += dev->card_data.usbcan_timestamp_msb;
+		ticks = ticks * KVASER_USB_USBCAN_TIMESTAMP_FACTOR;
 		break;
 	}
 
@@ -1402,6 +1406,9 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
+		ticks = le16_to_cpu(cmd->u.usbcan.rx_can.time);
+		ticks += dev->card_data.usbcan_timestamp_msb;
+		ticks = ticks * KVASER_USB_USBCAN_TIMESTAMP_FACTOR;
 		break;
 	}
 
-- 
2.45.2


