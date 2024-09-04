Return-Path: <linux-can+bounces-1411-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A13796CA6E
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CDE1F22E01
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845117B51A;
	Wed,  4 Sep 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="olBRnpRz"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020095.outbound.protection.outlook.com [52.101.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAB17B4E5;
	Wed,  4 Sep 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488871; cv=fail; b=lqywUAu8UhXE6w6Sk6AutDJxSAXolWWMueIugiBAD6E058BujtSZMp1oem4f3NyIcHIxJx8QmmcD8Lt/Kq0PoAzF1ZAebXWzTm0ptXDdi838gUWoWKG394wzJ9K+jIaLtCWF/ejORannr7NGzGhrFpoFRexeCxnIpvJin2rYz6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488871; c=relaxed/simple;
	bh=ff0uevsRtp8ADwP9dSytnxNYhFmSQCYkiWEbACFit90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/1nsw1s922BNSRk5LYf4AD5KrclMErVOKo4hyobNavjYGb19RT/aOzr1of7rHexjfxgS56tvk64kRr/EV90yqx2SPV7f7aN3hHkFOSzdQbtf+zdZQfX1B1AqfEciyptEcEzK4DhCOdodN7uxplDOWdfh008rvl0tnKgdkAo6I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=olBRnpRz; arc=fail smtp.client-ip=52.101.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr6kUi+6FIh3mVibzsu1uB2ryMPovE6KwFMdcnRCYkNy0VdFX7McUHgrETQU+Jiqf3jv9YVyox3H/KyLNS+QjiPr7S0d5Zd3WAl4MtS/DESMIBGcroDNpDdKErelivhmXMorikvO7PV/zdn2XNb6MsT3wMN9II4kB1VO+JHej/C4F2GsDWJ9MzG0i1kFiWiXa0KImIyRClKFj3oxfiNM5aiPRaPjuyMS9PwY2F2NgrucCPx78agLc8BK4I8ZcRX9yYK1kxsFgvTkXwELgglM0TrOKtQMnxSI4Y4cyZbCHv/a7tRoq2xj4OeDXx/UCfo+5GPzJNUuydWnBO4OvoHruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wvwlgfFiCWSsXUZ1bPuClLh8oSAUAhZyBW3ycn/glo=;
 b=TgYYc1nN+qZltqCxUxSXt0a/BH1lpr19i8X+OE7ZEWftiyHcCmXsSoAx0cPuEkNI1JO/5kIzl4qsr5jAEoNE+yrL4oBx2CrRRg1gc2Itq4+oe168t2V2tVQ+QbFhTfhZMGHuoRMBVC6GrdImwIXWFmAtz35dv7BTl859MXLC+AuEFSSmSsMgU3XmHz3s/rMzMBMy08ziTFTDfJXEKNZHaPcxMZVvGkNaQJMvxRKOzMsJuXIqOEqQir1vS4MNt8hG04y0bl6Z2gb/EgTbzOsGvIalnSlW699GckWy2GVXEKnP/Wi6ZgcZhMmVaepCWSIrH/SSeImsFg3ff5Eh9Rlpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wvwlgfFiCWSsXUZ1bPuClLh8oSAUAhZyBW3ycn/glo=;
 b=olBRnpRz5C8UToCA4Wh2gY0UWywm+Dq9lDGVQIxbC/oYbVGP/WyJbLfHOaim1ECEmhiFxBW7oRYHdOTRn5zD9H2dpdVEpCdUComfHf79ZHpDGRSn+j0Vl6kgLGJfsY6CvWOSm6bX+UQvRBt50ZOIXOCT5q08J3Uu+CAECfff90Q=
Received: from DUZP191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::9) by
 PR3PR03MB6617.eurprd03.prod.outlook.com (2603:10a6:102:7f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Wed, 4 Sep 2024 22:27:42 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::d8) by DUZP191CA0066.outlook.office365.com
 (2603:10a6:10:4fa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:27:41
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id B7D447C16C8;
	Thu,  5 Sep 2024 00:27:40 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id A126F2E17AF; Thu,  5 Sep 2024 00:27:40 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
Date: Thu,  5 Sep 2024 00:27:40 +0200
Message-Id: <20240904222740.2985864-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904222740.2985864-1-stefan.maetje@esd.eu>
References: <20240904222740.2985864-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|PR3PR03MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c1eb55-546b-4c07-15d3-08dccd30ca04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1h2Tm9KNjNIOVpRS3BkK3d1SXZxRFZPcTdyMGtma0hqMENvOU93bWQ4L0J1?=
 =?utf-8?B?eElFT2ozZjFyV1BhZWxUN0h5dHJpVU5oR3hCc3ZWUlgwdytvbUpKbS9GeWVs?=
 =?utf-8?B?djdTTTNZYVNMVUUwa1VEVC8zdWU4LzlyZERaZ2VYZkpjWmJaNUhVc2pwV1ky?=
 =?utf-8?B?RVM2ZmtmdEtWd0hFVUl0MGVBcXMzb1l3MmJKT2ZTR1hyVVF4aFdNTnU2WkFW?=
 =?utf-8?B?eTYzL3Z3VGd2RXFzdmhhZk83cjZqQzdNWUlNcG4wOTRHMEl5ajJHd2pMOWJt?=
 =?utf-8?B?Qmt5eks4Z08xY2RHRTdVczJlaVlneEpIR3pVeUlJbFYxNlI3Qm1KQUFZUC9n?=
 =?utf-8?B?cnFNRjFwVk5KSjVxa2xnVXd2SFVzUC8yUmxlTUlEZTRoRVpMejhQQzN4bGpT?=
 =?utf-8?B?VDdRbHl5aG1YNldoMHp6TEdXemRnN3lpc0VtaHY5eDVIdm4rM2NPRlZINitR?=
 =?utf-8?B?L2UxZWNUMGJYWldvTWFMSXp3TVFMWU1lbEhrazluQ2lOSkM5MlFtV21lUjlM?=
 =?utf-8?B?T01MYUZMVFBWanhFVTZTdFQxZE5ha0c5cEF3cndWMEc0M2cwcjBYZ3Y1Tktv?=
 =?utf-8?B?bWMrZlpranhnRGhaaUdjSUZ4bmVJeFN3bi9ILzlHZ2pzRFVDejNnL2JmcVht?=
 =?utf-8?B?VDNNL2ExcDcwUnFpa0Z0d2JYT1poMlNMNE1Ba1BvRGVlcUN1SUY3a1hCUXE3?=
 =?utf-8?B?TldIZlJNN0dXZy9acTc4VERCbHR0REV0a2xwVWZhck0zd1pid2p0bmdJblJW?=
 =?utf-8?B?VUtuQ3dtOUhWeXFTNmExR1NTQVdDUUE3Z2Jra2c0aHFSdm5Qb0FHeXhOMHlN?=
 =?utf-8?B?OTZ1ZmZaOUZLWkFIUm1MN1VXVWxGdGx2bHBiMGhvbGE4TFlXY0czOFk1dnN1?=
 =?utf-8?B?MmM4eFdxZDd1VFQ3b2JkdWx0V1FhcmlaOS9nR0hESXZsa241cHNSL3lGYS9C?=
 =?utf-8?B?Y29HSEQ3UjhCd3hOK0xDMm1oZVFqR1ZLeW5jdG9GK2VYMEppa0NXa3BpcFMz?=
 =?utf-8?B?U3hRL0dtRGpBR0tzaFVocE55VjRrb05uUkxKSFZkU2F4dGJoWmdWKy9sUmM1?=
 =?utf-8?B?cTJPaGwxckVyOExmUUYrTzhEMzl4SWdKakNrVUJNR1lZeTFrWmw2UHAxNHc0?=
 =?utf-8?B?VlRxWUZYQmlPVHJaTjF0NWdUbElFclI0K1AyNTRCbHhFOWZXTVZiY3BZRUty?=
 =?utf-8?B?VXBTYytVMG5pU1I1YnNBNE5Jdjh1eVlaY2FzNUdDWFY1MWFYOVdZdXNIM0Nn?=
 =?utf-8?B?cjNucHZCZmJBdjJuTHhNQXNOazVsbkRaWGQrMWp3ZFFLbWJXQitEeENkNmdk?=
 =?utf-8?B?L1ROMjNPckNWbkNnK2E3cHBqZU0vc0l4bERWbEpleXFOcmg4QWNoUStTbWFH?=
 =?utf-8?B?MU5kNG5nam5VSlpBajdrWDVYYTQzNko3bGdwQmhOS3N4ekk0OFZNUnE5ODZD?=
 =?utf-8?B?K3BkRjY5WkRLSVhqRW9tdjlhWWt5UlJWL25KSFRUU3IwWTRDV0s4dGlZNTFk?=
 =?utf-8?B?ZzFqRWh5ekkweUsxcUViOFdodzJYMjJEbzB5VXVWMHU4LzRVVDBWV2pMaWZR?=
 =?utf-8?B?WlBxMDZ1Rkk2UjgrVmlvZmVGQy9BbjZvcDhJVVZ4WWVtWWhVUmhmM3ovYTBD?=
 =?utf-8?B?aFVpUXluNmphTW9IRHN3OEtwMjZDMmQ2WGxSME90MSt3YmNrWkhOT0FDenF2?=
 =?utf-8?B?WDBHUGNjQmJWYzJldFJ5c2NRbkE5eVdRT3JZL1lyZE8zNVhKcUtxOGJPOG96?=
 =?utf-8?B?N0gyb0NIYWl3NC9uQXNuc2IxSzg5dGg5RkFWb0NIb3lkY1VBUWEweTRTc09E?=
 =?utf-8?B?ZWxWengwNmhyYU94eVZXMW1DcS9obUJTeUQ1ZXV1KzBqcEZPN1E3OTh2OXIw?=
 =?utf-8?B?bkJ2dGhwbFhvUndQQXYzaVpNa2FGNG9Lc1FCeFd3M3YzNXM0bmRPb3pEOFlk?=
 =?utf-8?Q?Cp5CPUPtkahDoXJZlJWj2mYFdZXBrz1q?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:27:41.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c1eb55-546b-4c07-15d3-08dccd30ca04
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6617

Remove the CAN_CTRLMODE_3_SAMPLES announcement for CAN-USB/3-FD devices
because these devices don't support it.

The hardware has a Microchip SAM E70 microcontroller that uses a Bosch
MCAN IP core as CAN FD controller. But this MCAN core doesn't support
triple sampling.

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 41a0e4261d15..03ad10b01867 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2023 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -1116,9 +1116,6 @@ static int esd_usb_3_set_bittiming(struct net_device *netdev)
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= ESD_USB_3_BAUDRATE_FLAG_LOM;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= ESD_USB_3_BAUDRATE_FLAG_TRS;
-
 	baud_x->nom.brp = cpu_to_le16(nom_bt->brp & (nom_btc->brp_max - 1));
 	baud_x->nom.sjw = cpu_to_le16(nom_bt->sjw & (nom_btc->sjw_max - 1));
 	baud_x->nom.tseg1 = cpu_to_le16((nom_bt->prop_seg + nom_bt->phase_seg1)
@@ -1219,7 +1216,6 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	switch (le16_to_cpu(dev->udev->descriptor.idProduct)) {
 	case ESD_USB_CANUSB3_PRODUCT_ID:
 		priv->can.clock.freq = ESD_USB_3_CAN_CLOCK;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 		priv->can.bittiming_const = &esd_usb_3_nom_bittiming_const;
 		priv->can.data_bittiming_const = &esd_usb_3_data_bittiming_const;
-- 
2.34.1


