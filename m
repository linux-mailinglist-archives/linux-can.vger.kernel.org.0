Return-Path: <linux-can+bounces-923-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89491E496
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702D71C215A0
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23D16D334;
	Mon,  1 Jul 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Sr76scjU"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4016D4CE
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849011; cv=fail; b=j6nX6WY0ga3WJVptbmRQUQIRjsN9ldQ+eY+3CxG1i0qfbYzErC/qGH13ME9V8pe371ZUg9mE8Sb29A58T7moufwRvt/+JeyYr1xQgGB2ywPocuClTNPt7m7UrfK2OISnl/Ohv7s3VVrmdvTvq5tbg/ufsXz4P4qAiHS6wh0Nwck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849011; c=relaxed/simple;
	bh=XSAnCDIlA/NuSe5BKK15GvIWk8QqBa5CWCBddpVS34Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PU6xsQc7ov1VN1erWJapW0Xhf5geN0+cz6S+j3YNdo/ZR4Pj+mriuwPqOwU/EW5pk4KccF9njpZIZ++qv01nqLGsANmG2ZRROtwAn/oRRqd12vQhLBZE74Ui6ZAUhihAHKMcwCzaaD9s9eQns4UUEUCVFBRfeO4fBnDJ/t9IFiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Sr76scjU; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcrVq8f0DD3gR6kQt6/++uenfTNx0WGTHqJiZSWK+oGALvTiO2XQlv+jl/jWTiTAMzk7I7aJ9N3MNZMawuyt5YFUB229PS6NjnB9A7ZaIIHyD/ZPiHxLa7hwNS660RiCbnT504rnoSUujIEVLOXAQO7xBotAJL8eE4P/H8/hAW8wc0vZDTCETsulbYX1JR0mEK7BAWYCglYHFOXBe9W2HlyAlsl2VGHr5XP+UUMXCoBIWlEyYy7Y+xI28kjWVWKILS3x/lCgqYqz9FSyLZh70o5ybu50n6iPmgGhgMynl5EPapvJ6YUpIEwqW6N567nJStrSLQZe6haj4j+1i2vT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxHy02nseLp80gQMleN5/fcpasdlPPbZGRB/5i7ihhc=;
 b=PodJorKhA+K4aDh0lgJvMjKuzW4SoQDX667dvd7nOWIshiItjwYPxzqyTBV9uZ/xVGSnN478oPyqj9eCTvwi2vkMHpXDmO+MjBs23uPjaXdf/DzWkU3IjHydZKRv9tl8iMf8XOeXysUTRr3uJ0L8bagy7vw4+MF33BkG3gPqi3WhoI3nGgNooblMF/jOtPq/KOobTFYyFhYS13Dxe8PVReIIFe0w3k0Q9qC29+9ws3DFv4IJw1EQsM5H6dcM2otjVHgL4zDeDJy9A9geO8++Hq2uaXjcTMwPdmgmATcP49QX0yEIy/S8hr/nB0wP3niVJMyjb3DTlobKhG+h6KIj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxHy02nseLp80gQMleN5/fcpasdlPPbZGRB/5i7ihhc=;
 b=Sr76scjUlC5a0vx6tRVC9EapvwIJvlm+DNS1XIy82vUVIlT9d7SNWli1Hz6BsSSHhBkHnvCF75ZAMwpoID2c6SH442TReGUwfGh8LRkX+W5xQ3U8d+VbZUgJYKu6tNieDbQEHExQeAvC6Qx950ar9JCtx8i8fsFW1cct7uhIAAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:01 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:01 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 05/15] can: kvaser_usb: leaf: Add struct for Tx ACK commands
Date: Mon,  1 Jul 2024 17:49:26 +0200
Message-ID: <20240701154936.92633-6-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c5d1960-9575-4947-0207-08dc99e57762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AKcF2JCI7A805r8a7O/P1QkUX2JBDtF4LtPgjleRM7712SZCuuJluin5iCe?=
 =?us-ascii?Q?ZVKc9JNvuukgwUg81NzMieYsb55VGybmw2uLe5mcMAbeKDMGCQcCtUd6vnjy?=
 =?us-ascii?Q?dAyZ27758pKsL29tWgP/C07uSy93Rau8u+lIUYZ5nf3ZrvwkG0kcvJiaCSod?=
 =?us-ascii?Q?t192Lvrgw/fLJk+WJdw2nQeVv13IQ1rBf3hjaaT8xqP1DihQw2shxtDWHTZh?=
 =?us-ascii?Q?pAEOi0elA5H1fR4meBsuZQxE8PPnSr94HK7yykwSsGn040Z5gRDWNEtq91Dv?=
 =?us-ascii?Q?5GCFNG+/L3in2+KHWQrgvtAr47xHqvP6IZeNKl9L8qFg5SZAzdGBsMUdw8tW?=
 =?us-ascii?Q?gv5lGEMKuq5D94MwSKqijKjiuutQI9Mws4VYkbaB+svlgmh5SJaNoK+hMKxO?=
 =?us-ascii?Q?O+lawBb52QHw1yPnjeeucUv04EHfTJEq1IFjV+eMgtaxk76YFcoJXpvKec8H?=
 =?us-ascii?Q?Kxo/1pj3lQdvZZl3LnxNT5aZWJ5JpazU1UuzOUUucHSFATyyXPrmmoksHh2B?=
 =?us-ascii?Q?5TB301hUd/c43jePa5aCtjghX4u159eTjNowUFBOHTA20kDXOgBSJVF/pJLf?=
 =?us-ascii?Q?PUwz0swPcxmX8ZMr4w/Y0DbfAFK0xuWDtq9YL2VgTa2Q4u5X3xjVU6Sx9Yzl?=
 =?us-ascii?Q?uKltAuRPLu3D9/iOgp8sHZHLT0kj7bHFdXb+YJg+ZWiWK/NfIEPUXITlO6q3?=
 =?us-ascii?Q?dmGdiwUe/SvpQwFpr0pZrx1b97fwSim8E8FQi3OoD9ekRyNP8iwR8C90puXg?=
 =?us-ascii?Q?NhwDji1DO2eEU/FkKMvog6Z2oXDXSNs/KDj+dXU8LXQnytwvKZGhnldR2iuo?=
 =?us-ascii?Q?d1D05MDQCGmc50itMjRGlRdnZtQH7I8Aq4mQSHzDcE8sW22EFBpA4yWDMHdF?=
 =?us-ascii?Q?1Cvt22GQu+hMjyRZ9cYSuSSCn3TQZpORtJhVGPtyNyLG/ZLrEwfLIjuJnAMp?=
 =?us-ascii?Q?3EoT5PARj2iMNIFzTTWGINxqXtwnRQIPhLgRTh8EZF1RqXPC+TNI1L3feMsb?=
 =?us-ascii?Q?9vWv2FaDsb4/wvnHxumr7voV/Jf4US020xARhCGveh1gA2BygcacHK/NeeT0?=
 =?us-ascii?Q?Umg7pV/QyFAcxVGgLb6RN3l00iOGniqPPEeM2Nz/7CnzsthD+r/43XDXXNME?=
 =?us-ascii?Q?y113HEidv3MDS296Q0hZn174T+vxvAgPwRSsR4y+4AX6RzN76qyV7wxCdCca?=
 =?us-ascii?Q?PhI6BfjWsvH5HE3+aAF2qLEtOr0Fq2VvfvNk1dG7jycs045kokEiQdcqLG9L?=
 =?us-ascii?Q?2NroX80gVt2fojnbV0sE4cFF+d97LHovK48rKcNR7FB+TjeQuzbO3fA9lezP?=
 =?us-ascii?Q?ZHNQdlRe8cN73J/T4viXWhld7t8IGKT5GhYNSw25UqVosQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHnbNJ4a++LTop6T8pDcdMoFNXjJLu8pWhsxVNWsO9Wvz5nQqpA3gify51MP?=
 =?us-ascii?Q?q56wKN/NN4fug37zrBb5xt3Pb/rdiDddzVbbR+9Avcetrd6x1cZ9jF4c/NyB?=
 =?us-ascii?Q?zheupKOPkCnEjs5vpgoSOVuQ4C1aZD2oHffRscB6pV1Wvrv0bEY0yhlDcXm9?=
 =?us-ascii?Q?KIICYsW76w+uHxOJ/6urDUNpqpm7o8Vjwjm2FezRTymNdTNrQ11SZUoATkRO?=
 =?us-ascii?Q?ewvfc1T7ykTzn4kYjiRIMhXoEAlfpoHqC6K5bKe4rF/VCVX6r/VFNmPTj7N4?=
 =?us-ascii?Q?e5Wsn1bj4j9AWE5173g2JS4YqbuxtHSKVwrvZYq54FXsUI1MFyGdQyiLwUSj?=
 =?us-ascii?Q?XfIx2dzt99lWPXnQUX3Bhf4DS62naIyd6vtAiizNby7mRxWIW95qCNKHWk8W?=
 =?us-ascii?Q?k2pjzUHJOhOYSPHRUjse93PituFMgayWI6ksbYO+iiydB7bRps0MpK3tdfkD?=
 =?us-ascii?Q?B/y/qmNTZ+74i47fmqPtGy4Ho4Vr26xEHvCX/2pW3j2dBCeNEKMH4+qc6QB6?=
 =?us-ascii?Q?1IqLXiCg/S5LTLUu8B8P4GdEbNG+WYCtHwbo/Uf5z66kg32YHELH+s/KKXyv?=
 =?us-ascii?Q?ka6y8KY32XPh6TdxU4UnPzCXiwcXascUH3rgrEXo/FHnwwSbaRA6E9gkr5Pa?=
 =?us-ascii?Q?2Kh0XVGnCZwBx7I2s9Le46yQwdRjic++41frqR0ouGvNBRvjjQAq6aSozmiN?=
 =?us-ascii?Q?qGgBU3Cdxzpazr/DzKyMS6p00tWVLeWXJxKpyyh+4qaXWkFv7KUxdXPSWWz+?=
 =?us-ascii?Q?eO2StagAcCy1EIT9quihmg/8FE++j/8kRmbbcyyUNAXK8WsN4Mme1TKZJEej?=
 =?us-ascii?Q?aMjcHLlrvC/bGECDj6LH3Dp/CS4ISR+PBHYBAyqqCth1bdX0pLYQViOZCaVq?=
 =?us-ascii?Q?SJ/Tyvsr1RzPPLJjZefsrGALdlgp4CuCIA9asD6n+OlVFigwXiEP3QQphb4S?=
 =?us-ascii?Q?tSQFQ+rvBGiWgHSw+8zJOMJ0gFlnaWcGG7iy/1nRgJ8jQW4uNE36/52Gg3BD?=
 =?us-ascii?Q?niR+rQp4DVOWtcjHVpQE8GXXHZLStX2bH4+2nV2B9CYvBQ1C0UzUO8iqEP9P?=
 =?us-ascii?Q?kdpc5/mPhQLxRiyxhiYOu8zT58t4MuyZgYyCYiAbtU7VOsDlLv0plZxF1S8w?=
 =?us-ascii?Q?Fw3rJeRMpD5HqBtCBXCjNsJLX9xTIgOQUAr/JFqO78sDJ+WXW5O77xiebtCv?=
 =?us-ascii?Q?epFHkDMG8yCpiZ6aunItiW9HNXYCzDoOKJnXOnbb9K70LefSm/e0gw/KMoSd?=
 =?us-ascii?Q?VgwolgVOKpbAEsQazqwSBhMH+Vz1UUvmiSoF4z3T0KoYN8ARcKEZ876ZKGxb?=
 =?us-ascii?Q?ISIZ4o0ZR93lUvdvpxvmZlHU+TndSANciXuVQPyMV9ScE0I3yKGJqg43d8QL?=
 =?us-ascii?Q?dvdp9fc5C3ya/+G8rdbldt33WMWmVX26CT8U/JanQpRS+HrwxG7/iu8CdTwZ?=
 =?us-ascii?Q?ZHksQe4tlV3DSxAf7qqpT8n3ZSYhQ0E1SnofIKZASruCWMvaMZYhkKAHTuBK?=
 =?us-ascii?Q?Oxf1nS94fd1BWs4sOPqY0Mj7zWZGnvXg85TFqljHKkyuHlg3kFF0aLfrYB+3?=
 =?us-ascii?Q?yNLqtn6lCHyVjd21vOx9sXUIr9fIZiCzHIid1x4o?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d1960-9575-4947-0207-08dc99e57762
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:01.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaHJYeiIf8Amx16xYqt9Pb8EFy1Hz0zyZk+KSieYiICiROItaTfcTQzygJ6impK7ZI/M9pGiX7xRM6nJU+EOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add, struct leaf_cmd_tx_acknowledge, for Tx ACK commands received from leaf
devices (M32C and leafimx28).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 23bd7574b1c7..70511e151a3b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -235,6 +235,13 @@ struct kvaser_cmd_tx_acknowledge_header {
 	u8 tid;
 } __packed;
 
+struct leaf_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time[3];
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -347,6 +354,7 @@ struct kvaser_cmd {
 			struct leaf_cmd_error_event error_event;
 			struct kvaser_cmd_cap_req cap_req;
 			struct kvaser_cmd_cap_res cap_res;
+			struct leaf_cmd_tx_acknowledge tx_ack;
 		} __packed leaf;
 
 		union {
@@ -370,7 +378,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.leaf.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.leaf.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
-- 
2.45.2


