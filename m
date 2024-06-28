Return-Path: <linux-can+bounces-877-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF0991C6F4
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7ED2848EC
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53378C75;
	Fri, 28 Jun 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="CLZTrlMu"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533178276
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604561; cv=fail; b=O0E11uTQfzv87FWZQ0TvPWrldgtdUFfG9oLrDKcPbT2r1MO66zNHmabszPGk5Po/oFNSJ4F/pI9iLk9H2CS7YLo407LWWUz5sQhbxBnjssYzorYn1DrEMuv3DjVeahDGFnFKjZ/a1RxBXsqW1fmmanjIesrI4HpIwJkH5NFoUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604561; c=relaxed/simple;
	bh=VqRcMDxGCrQpxN7A1gyFfHBDp4HhedjpID8ccoXRd3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKp5DgGE+scs6H66dgzZzLVQbRvlfZwpZYD2DltJifYyyo2ADYRYycUOlR2AeRfkj/KLY1tH3TxQc+4xsE3Muf4oS0a+jzJGyQkdTDH82h0paKvTD3NHEAExECLE2t5AQHDl4rPPrT+BF13PSO/YzbH3ed7lIzaYVSM2szaYsa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=CLZTrlMu; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULRrloIRct8bGHObELfSlhqh0GxA9MGK8Hqk3dapqYY7D3beVocDc6hrPBezKqY3/oqqW/vrfDlQivVZ5QQ3+L/3H3nlvu5yFXOUAckcUhIBg+nfmguaRbNh0htj7k7DKq5a91EIxEH4LKeTDdh3JLr6PqBfjQSHsnojD7meTgnjjT8AbZ7xpbXGJWFy5EQEE+bOYful29MBjKgzfGV++eZiBRcnEVOC3DDtHmAVDOVSrK/wY26MNz2KlvwXc3jOdZ7hzaOBUJyiZd611P9HuBw6dUWJPuCsIDF68u8mO2KogKvr1vDSqyEwje+pXOzWQRCjY6ZaXAwn+1QHPVU9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NepO+JiC9bRKFDu5yob+b6OrtWb6amRQZn/1o8cpNg=;
 b=ZLWSZJFclCWDSq0IBX1zW8SczhtDQwTqCWUS+79AWkJn3wsVDHF9rZrNJn0XPeMCokRRDbM634EXFH2ArXxWsenLdQW9WCudJeWD6Gn8z5gbcQOzeD3UW/PrpkSkkqICDHgE6+w7pVMzOtHTbyoTjTaB2BlgS1reOb6eoxasV0+1J0uG46gCNp9BSmqemR7kxbEUWsoAsNlcPe6moCgP5zQrzYGDmIPWa5+XpQbb+CIWKmjjkRohE9IgZGBfkbYCjvE4GFdb4N/itgxjqSbzZDAVGfD5UvPuqFuSmmkZXm7cpiclaqOanm+XznRJS4Nmg88t11WD4HE/xbHvbBSv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NepO+JiC9bRKFDu5yob+b6OrtWb6amRQZn/1o8cpNg=;
 b=CLZTrlMuBldLa+USgnE4sNHTg/K6U9U5TG6zbVo4kSVQ6mf29+RPcpLpYfVtjWBrk4MCVdsWGYSz4heFZYDUcOVG6T1Bu7j8ZVe/uivMExb0tqOS8rl7+B665i+EiGTboWKcZ34IJWTflSoae9fHPrDDPo9WdLrrzUmmkNohIMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:46 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:46 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 10/15] can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
Date: Fri, 28 Jun 2024 21:55:09 +0200
Message-ID: <20240628195514.316895-11-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23e70556-7f78-4d75-f468-08dc97ac4d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HeVUS+fRYv6uu+CMKQbUqxL5B88qf9mVqLwbR2DZPmyRfsf25zDK5MGgEkrS?=
 =?us-ascii?Q?SG3dfxr6pqRoht98tpdvT4juGwBV3+qbOmZCWIaPHt3nZ6sLFyyY815oyo2S?=
 =?us-ascii?Q?3LLfciaf21HeW29/enX4efAJZLhLgEJRNP9XC9C/etK4MHVzQUN58j6Y+JD8?=
 =?us-ascii?Q?jedEQK6ml+XlyduYlAAVw+/Lf86Z8lIytNe7lUlRWUnbZhBh2nwtEWKsWP6x?=
 =?us-ascii?Q?lp6DjySYidTWAL0zXiXvm7shxFzAT/i6/Py9KLjZH8yTMSgnKddveKpGCCw7?=
 =?us-ascii?Q?4324xCrpAAfwyVgr/0+mITrP1yFW1QhO5JR9wfqucgV6JlPZtvIzJ75IIRKf?=
 =?us-ascii?Q?WmHOHusBv2hyDlleNq5TRHf2/CdiWrRyG1sYXKI4Pg6tUPJ6U2g8VFvPLZdW?=
 =?us-ascii?Q?g9XbNkI1HSFSjntjU9Wkz3oFwZq6iZbtLcximZolL3XJOs0hiSp16mTGzrQ5?=
 =?us-ascii?Q?hFLNqjLYerGhq0Bz2VO6CwMPIq3BRWxzkGga//Vyk92u8iBua+gDYHDf0R9w?=
 =?us-ascii?Q?9Rsb1q4Wfw+3fqXD6OAWW7fnNr+ZvIHZV9ue0ti5j9JZ4ZumpNkDyoJf7LdX?=
 =?us-ascii?Q?LcPF7U88JHUx0LuitSjqNz8om5I4NEcezVHLIydk69lFHku9gcvsEkit2/bU?=
 =?us-ascii?Q?I7DsHpBLPfC1vJlK2uxY1bFy+aUiSZ3HKFm5bmZEwj275KwGSuXZZszyUHYX?=
 =?us-ascii?Q?r/FphsAN3oyg60/XCPEt7J53tlrkgHzdj7k12sAfDZQTtue2sFdSr6YKZFXz?=
 =?us-ascii?Q?OUkux8+f4Y/mJJRxywz+mPpi2tx3N8HhvsByKqIlVjaYiHX+LMGURXeclKlj?=
 =?us-ascii?Q?2evpi/ZZvbb8kC0UqPiHSHPk52Ujt3s1++xZWteZFSe0PRlAS+ZdmAgaw2/A?=
 =?us-ascii?Q?mBcR1T+F04vC8oKQiAGZJXfGi9837egqzogFQvV9W91KINe5AORCjL/PNcxh?=
 =?us-ascii?Q?ckCij0AXkW/2yO/tTEwy9iRJovmgVQLTUK3RyPmJSVuhcyEzy03mk/v79oWa?=
 =?us-ascii?Q?Kr/lSA6j95uxyOdrU9h0wVWYgWSXPz9QMaSSqm7mSg7bLsxcCF9Ek8J5R3xz?=
 =?us-ascii?Q?rbitgdwCbpvNsfYH2BfHbNwfYjbfFt3x1ca/H+ELMCtTfb6LR/OuN8prP61z?=
 =?us-ascii?Q?iI1EmbykhUBgzBEablahB0KOItIu/7sTXpAAmx5DaM7PZqRl6g/aAEjXU/Fw?=
 =?us-ascii?Q?5bOJZnOy3YprXWMtoqhGPeqOHV0mZjflGEWmyD+oa1zzLRASH7AI4s1w4b4S?=
 =?us-ascii?Q?Eilz3OOpNnEG9PmzvnljVjmijuU7IzJRHSqejRFNM/OEte0Otxp3XH3ie3aH?=
 =?us-ascii?Q?4dU2yiKTFOL6kOW87Ezn/8mr2248N7L0VHE9JmqnorRQfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIdkPneoo/TZ3cn9cRC1PL0q82ANpJEU9hxL5ptBJkqcRgg4KPAuLhUiJywA?=
 =?us-ascii?Q?JlLPAadIxyI5WS/a/J6alBW2LaxdcknOVu4QD99yMZ6yQwoHoCr2WjuF14tr?=
 =?us-ascii?Q?nlPCKq+Cn6dtarMPO3gmrw0IDldu/qKY/qkBNQftjRHET7N4ZP9yCGitPN62?=
 =?us-ascii?Q?7q+78VQkK3FGcpGVSfrt1drUfNmwcRmtKyLlhH3fYgJVnH4wQ7YwNSfjkW6P?=
 =?us-ascii?Q?ltZ4cku/htMIyun3WUluw3sf4HP6eOOEN1PPSlSFEWsfJvNeRFaN0Ih5omP8?=
 =?us-ascii?Q?+HSL8gwic0XtnYlhTwQgnLqtLVb6T2/UuKnlriY2C4tbFEyEPwi1VtcAHEwP?=
 =?us-ascii?Q?8BL3ZM6XeavOMmSr8vY8xwWSQcNgY6eTFsPXg0EDpQd4umyTGWcD78MGf6Cz?=
 =?us-ascii?Q?nGymQzl0jTNddHeoCrlnBee+sifd2R3z4I5iCaX1bnbCqaI4EeLE7SWeWeP9?=
 =?us-ascii?Q?enCs1bm7K9BdaP4CSPIm8JcQIbSj2XbtcbQHIU9qs2xBmGg5cgz2FWAJ55Qm?=
 =?us-ascii?Q?BgkM9rkGJdrxmy/tKhzdid4coDV9m5zzKKr6AuJtjgYtZLCwGg/pNCzbnT/z?=
 =?us-ascii?Q?3KgNwe3gQDd0TE2O0DkLUoKHiKRjSMNn00wM8sZSYw2HkdTSpzOtdVutKOwd?=
 =?us-ascii?Q?YYTf75gPGUREdgC4YooHQelwNBApySJGV3OHWx4NdKSKKRp1hp0qMzeHKq/H?=
 =?us-ascii?Q?cvHE6xqeviEomH6vaXhzAwQuFjDnJATzv6SyNXEW8YjGjSfWWWYAS7Ok112Y?=
 =?us-ascii?Q?O1ZH8DymNIZhRRd2BG7i28fB70jsf+JhXEbZZD2owyKuSPznPrN4rhkChgrz?=
 =?us-ascii?Q?NIip3CMPUvp8QPEgFZ2Kgl+Tq2f6rQ6cIE1/7vvyhHEHEi5KoQKh87Ygyfe6?=
 =?us-ascii?Q?CZWnT3Nkfrf9qXEmdzzv23sGAMggmyIf3yfwIgWSj1CPAuKELAKaQlE/bteQ?=
 =?us-ascii?Q?TQprr6f4NkJvDy0pvH0omm+PrLECr1O92kAbp9Lh0aA6HAadH60VflBI42yb?=
 =?us-ascii?Q?UuAwQAccYX+jMfb3bCaBwcl7KVUNDSBWK0VPUd5GLjP8pYwubAO+sm1/JL+h?=
 =?us-ascii?Q?uZIcWEZHvXthFvpaXDMD+Orxya0eE8SD3TzixOHvI7At99nVzPWhlVWLMGuZ?=
 =?us-ascii?Q?o0WJ7l2BNP2PT2SMBBJOuVw5PhOT1SfyhaUTZVntji8SOhLwSMW5RUg86cCP?=
 =?us-ascii?Q?lNXpLie5DonS70iyATadSaxM+4J8GVgWJoTMQxXx7mXN9ZUyYcsOCQNdV+xj?=
 =?us-ascii?Q?RzLR8zvguiIY90Mxm8Yt1HoWE8uJN9W5TSAGwbPsUEb12Gxg3S46dDniskSF?=
 =?us-ascii?Q?A5ka0wV+0MQmr4Jx6I+YQtzv1No4v6vQJ+v8YU/FA8/KBxwdUP5booHCuPV9?=
 =?us-ascii?Q?bFgTKk5te7vV/HBzr27CuDRIkR9aXdAFQ09W2aENCx5UntedlrFgouN9IWl5?=
 =?us-ascii?Q?Vor7MCHZ8PQTvLlcEfGF/eTmj6wBi9RPWtILxfGhOSeqaD85NClpyKxmufQS?=
 =?us-ascii?Q?k0EDYFFdrYRPgsnm05Js7wVrYMjQuHE3G08kH9l/swRWhk4Jbsjld1iTVEAi?=
 =?us-ascii?Q?xe/Y9AINJeEVtn6byydSjKk+yFmlSzPUHsNWEmsT?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e70556-7f78-4d75-f468-08dc97ac4d1e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:46.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEkdskkEfj+rAjtio01vZ0aFJwEkLIQgo573eIJ0pOErea5yrl3S/XK2it0heViBXAMBy/2tQB279GjIcKxgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

For usbcan devices (M16C), add struct usbcan_cmd_tx_acknowledge for Tx ACK
commands and struct usbcan_cmd_clk_overflow_event for clock overflow event
commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c0a8713d8cf2..98bd6cfca2ca 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -242,6 +242,13 @@ struct leaf_cmd_tx_acknowledge {
 	u8 padding[2];
 } __packed;
 
+struct usbcan_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time;
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -288,6 +295,12 @@ struct usbcan_cmd_error_event {
 	__le16 padding;
 } __packed;
 
+struct usbcan_cmd_clk_overflow_event {
+	u8 tid;
+	u8 padding;
+	__le32 time;
+} __packed;
+
 struct kvaser_cmd_ctrl_mode {
 	u8 tid;
 	u8 channel;
@@ -363,6 +376,8 @@ struct kvaser_cmd {
 			struct usbcan_cmd_chip_state_event chip_state_event;
 			struct usbcan_cmd_can_error_event can_error_event;
 			struct usbcan_cmd_error_event error_event;
+			struct usbcan_cmd_tx_acknowledge tx_ack;
+			struct usbcan_cmd_clk_overflow_event clk_overflow_event;
 		} __packed usbcan;
 
 		struct kvaser_cmd_tx_can tx_can;
@@ -396,15 +411,14 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.usbcan.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.usbcan.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
-	/* ignored events: */
-	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
+	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
@@ -1608,12 +1622,12 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_get_busparams_reply(dev, cmd);
 		break;
 
-	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
 			goto warn;
 		break;
 
+	/* Ignored commands */
 	case CMD_FLUSH_QUEUE_REPLY:
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
-- 
2.45.2


