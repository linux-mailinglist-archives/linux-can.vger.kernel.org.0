Return-Path: <linux-can+bounces-7568-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOGOGLqK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7568-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BC4F2C17
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 160663020100
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43837C107;
	Fri,  8 May 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="A9ZIGB0D"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021132.outbound.protection.outlook.com [52.101.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FD37AA91;
	Fri,  8 May 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223710; cv=fail; b=uAXJEXbH3lWLzLmI63aI5hvgk9ZscAfQbv5e0JB7sLbn1pGl+MuHB5DpRrVZ3br0GvY+wCSjTK9cRQeqDxPMaCTs2EzRh0NDHAY0cajLvtZvYYHuPS7jYQTyvyh+ONzDp3w2NwxX/XNSqAqlRNGb0tVS6bIaCSe7ZVTTHYe+mv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223710; c=relaxed/simple;
	bh=Km12ixrosbVGmhYR2GbUSbl8hKhtuJJ0eFwVzgmHNuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOqesabVwFvcFDOVuVTlKorbxPKj24OiBpYgs2MR2bP9vY0+TOeh+S/N/UF4NebSUJdJ1RJoYjX4HSnMvlvXnqBGia84DCJQBNN9BLCEw04T7kGAddbhcZ3EyoJZrGObXP+6BjjpfoWKvKuDmLemkF4UqDJVba3Hyat6mTHihZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=A9ZIGB0D; arc=fail smtp.client-ip=52.101.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3ncCgV8UbE4wcrBT6e++OkDxTLGhqELi0D7M8F1yOgJL+MbADxMtOnJHn2jd4zzukn4SLOzaqZZfVBu3cESZNC1jYPmydsdwOfD1+pN4Db9A4SuQvKsMcrX+bsD+KCD5bS4urOCqpNWlO/iSoAWRJJN74ILDHRLIvIV+EOFvl5ezbHQokywTce+rIv0l+OBXOA6KeOQSIMydfkBAZbYQy5awTQpI5BWLfBM6VffzJwldUPQPo0rj8dwKetDNKC1GoeeL52DHVqsjRj90jJzA8LwTInQ5NODuvz9bl4ZcWK4WSsupMknZXWEYWsUKhIpg5taMkjymhHgx4tAs6R8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTCRGPFdNyxk+jkgnOtOUE4qdEl+tgH4XYmKSPlDThc=;
 b=sgEyZ1QF4s3ct1IuFugfE94SbGxUWuPCFVgMi1oGfJa65A44/JleRYM8YqFhXENxbBH53Ghd+XwAzoMFgWGWyrPHshZ+/FQDpvagYNHMbMtV6GHcYmnjHkEMFOGyy5P8NjgXva1cS4y+CDqRRrziFCtWZdHTRvVsmGDIwndYyJUZBDB26ozbjP/TpRkgPxTX1bmKEVVKjOGNhqc0lw2xIwav//7sDreVNSP2OmGEZ55KaDvD53mDrmEUc4J6JFpaQ+4S38nl95T9/sgt5I4VBCPEljhB5RKdR6agwaZmf9xRnZpnYRCmlHYi9QukxsGfevbKE0qmvHmVfCf1Cjn++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTCRGPFdNyxk+jkgnOtOUE4qdEl+tgH4XYmKSPlDThc=;
 b=A9ZIGB0D34qvoxIYF4/x6ztnXtpzxcb53rn/im1wMkGECukNusvCA/C/KX3uTyiYnf9ZCYZ81YdUlq3jjJ2H2sG33wpaftz4qs/IpxDsrfbIN1iz2FoHo9gvE1wMPI4n3WdPy+kOTnPO5sSO5r04gU5acrqTfBy3sOScuHusFrrvt/Jj0eTsNFR2X85gOxD6EWEmk6OhfMXE+dxo5EwYjGPaKThiKg37q3ZxizQFlpni7FIFGPP8iNe38fA1ObNTD/ol4zy6Iezf2j+K0AwV7vRjx3LZ1xVYzEFci57j2ZiNy3QiZAvsNF8WuzRyHYjNCJnwJsHrXQJEHuOBDvjHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:35 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:35 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v7 07/15] can: grcan: add FD capability detection and nominal bit-timing
Date: Fri,  8 May 2026 09:01:13 +0200
Message-ID: <20260508070121.6918-8-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
References: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB0889:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c491b8-3d21-4397-0155-08deaccfa489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|3023799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ar7DRX4z5kzhKbduoQCYy4Py/lgSfRFGBnCsttAP64AWKsl/Hspc8gj4AlYhxrmtterkQ35roJFibpaGUHvN+lnuu/GHZlpTnHYkmWQturbtYGENgPQuQ5BtrfUCHlueu6xD4K1jZYEyY+ptg+LfRlbmjHICBE/fWp00iiBdFPJFEJdeIj3KjL4nzzu35qTEC52QhW17YO1OxtF0DkjrpjhxORqDvT5vsyTdZ9W+0oN/zNH2n+LUB81aw7SPHABqQETRQICX4z8YSz+ZSgUWJWmzsrv1BEIuN+LK7fxc85xJA6rw3ikk9uUB60HabkfEEtvS2JsiQdgN9sF4PJdOKVJpciB68CdGwhLI0B2vngDeo1z7CrqHmS4IolNqyp0rEOPEzVTU4xn3F+SBnSo/Mv36VzfoIYcyaz7QRi6HvEVoBR8RKt/CSF0y+CgldZI3IrNs+sv1n1ZZihmmfit7FGM0KlUWioXC5X3GOBfmioD39ksDNB6mV+Z9IWNmRXpe33Qb9fnV8DES6+RP9e0pWjWi4nhGbGSKbtFCMLBiTJh0XEFhu3djWW6CojTjkNAQTiBQOpJaRb335NL1OHx6ojmshAMYslfSaUH251WHgdOokolQVlrgMhibqWa/s7Lq6dS6ba19AaHZd+nBSqxf6aMwqzo1UABDijvQwxPhYrj78X2Fa7qg3D4sOYOjaTndrJx3Nk1nMnnR5kmf4AKDOOsepgH9ySaYdfj6bfcO7jc3AH8VC1TDzi8FU5K4/TJm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(3023799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p/V9niDT6W8KzyRCsQ6jxvSh58K7wrqXJYiG1Dqwcac7IM3tZ26rOUpHOK6h?=
 =?us-ascii?Q?qusvK9Ub6ST94IBTO2VSosMjTiLDl29Zu03EUduH/3LD7YZeVg55QHYeCcj3?=
 =?us-ascii?Q?G5p2AeZLbdRMdvXmxnwXXh9Qf3+Z0+g1M4NL0xwqVMJRdW1mhO8N6dPzz35/?=
 =?us-ascii?Q?8UKMkP26bCG7StSUaCWYH8ETu7tFHGcDA0T5kssdZ/O/4xQ67FufRG8gmcXF?=
 =?us-ascii?Q?diDIrY/YZWa2YyzUQrrk6GnYxrsDinBco4TZXqxs31O0ex+FKKQN3Vg2mBQi?=
 =?us-ascii?Q?su9zm3Z0HkkhY8bVXVNOyGx0a2rwnt8Qh9voFCzjjlDYv48jVn4ZoDGnAsEF?=
 =?us-ascii?Q?U0ZHKPkqddZhSMOydJU/gyyfa0veNGmKuE8zkPkN/y/Byu2aViP/pomPXatA?=
 =?us-ascii?Q?eyHWWrlr6+9kggUF1ag/fh3m3+epP/r0SlqnIke4K1xP/uEXhOX1EgMfr2QH?=
 =?us-ascii?Q?caWmBtmJmWkznxCGKmiXToyh0LosxkpeIdBCT2v15SB71n7F0X9fJG58PkPP?=
 =?us-ascii?Q?cqqMvdZKYMVHdMXTOR9e04gvB5IeUbl8ByNPEEgvhUacucQiSkoCaMDouA9i?=
 =?us-ascii?Q?OzK5eZkVWLy8O3wyc6NiKS9iVmRxlqclU94ArYQN8UKspQudXqi5xhCcld5m?=
 =?us-ascii?Q?U3Eyx3LAzACMjsec/m0z48/CpxVyqUH7Km605zrDFWeOgrcBUupsc8idL33V?=
 =?us-ascii?Q?2534VXqconhUSmdAYPgXZZIuQJ8ZmygVqVr8+pO8SRFRcerZnOjh1Ea4MWpO?=
 =?us-ascii?Q?PKj9MWi5gHofVC7yubVAZ22Q83tf1IjyfBfT5Dm2qJdJkHwcWhNbvBszhKNj?=
 =?us-ascii?Q?H2IzF55xwnk0Xi2Mi04/RC2cKAMO8jVMKXx1G6pK/7BNSNdd6gXa0hpBojZ9?=
 =?us-ascii?Q?7//bTEhqPvvwODoP+U7//DZWYVwQu37dcgjUuvOFYrKbaIsoZNw9J3m9jFuC?=
 =?us-ascii?Q?dHjWXt3r9iVD9kxWmdgHp9HIyxjwh6jAEzHs6aO8D+pL30WglNjSj4fdoL4a?=
 =?us-ascii?Q?IACO7PnNEkWpIOH5OBKDKHSy8zWYTS3I7r1i+QbjnLNzpAUFdXMuBavrlXzz?=
 =?us-ascii?Q?aH7u3/E1cLmSR8f2oSohwtK70PPj6yt7Cw3m+nczp+XbnMCSeXWLqE9sfWlZ?=
 =?us-ascii?Q?U94B0X7g+iYHqYOdK6HCgnhz5YPmC2Ngc5/QHg65NCVTN9V6RKMhKZFS+ZJk?=
 =?us-ascii?Q?/8q1XCl3l/XNPyFErWo+1bOJBlw68mWVgdrKpPWYifg8eBY/c7P/V4MBNSUu?=
 =?us-ascii?Q?1MKh5hBKDpE1Z3c+GL429CEtr6x2XO5Jj4+UurBPvM4B1m0FGOM1deNJvRe4?=
 =?us-ascii?Q?hxGpdtWdS3SIXSMhK8BpFyK6QNq/LV4QwEXfZo4jaWLNiUI6gsKmdvOReNsg?=
 =?us-ascii?Q?x9PgEt23JrvV9sJAUgvH4LW33o/3PuGbSQtnwpjRt2bRWoemivBanKKL/sIX?=
 =?us-ascii?Q?v6uy5Q4o/Zx2CXHqxTTjSIPa5TaeepHVoXdbekFVoFHXC5njaYCc7sq9IasW?=
 =?us-ascii?Q?MU+mRimWdPd1tbcXIFPMZ4zcSH6v3bsUdZfN0I7zHOVJBNiLG/eaZYLXDq2v?=
 =?us-ascii?Q?55M1jhns7Tljr+CD7CM1Zf0oGclpJ4zUiaWdJM+ONd6XBT1O0f1vxarLFWzO?=
 =?us-ascii?Q?3U62f0kesPGppLlJk2l5d9bboadMGDi2hxxn/WeMYFUKu/FVA8kQ5m9WWeH/?=
 =?us-ascii?Q?NjRmKvQ5g5JQTI2Fjp2BfoMpMCPeENR52Kvbkw7QfTX1OKFTVZNpTSKPYHmZ?=
 =?us-ascii?Q?1umSERO7PqKHTjd60mIEThPdsJBM++s=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c491b8-3d21-4397-0155-08deaccfa489
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:35.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eQPyuljLXMVyUtxvQlSfeWIbPLqLhwxsU+au1Dsz3h1WrFcZNNmC1S/tbJFP90sBPko3EBR592p6tDo8q6V07qrXwzoi59/Cp7HVJYZjSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: F26BC4F2C17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7568-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:dkim]
X-Rspamd-Action: no action

Add capability for the driver to detect CAN FD support
and adjust accordingly. Introduce structures and functions
for setting nominal bit-timing for standard CAN FD.
The `grcan_hwcap` structure defines hardware capabilities like
CAN FD support and baud-rate options. Additionally, improved
device tree compatibility by updating the `of_device_id` table
for better matching of GRCAN and GRCANFD devices. Also update
Kconfig to mention GRCANFD support.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/Kconfig |   6 +-
 drivers/net/can/grcan.c | 137 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 125 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e15e320db476..83b7dc8c925c 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -150,10 +150,12 @@ config CAN_FLEXCAN
 	  Say Y here if you want to support for Freescale FlexCAN.
 
 config CAN_GRCAN
-	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
+	tristate "Aeroflex Gaisler GRCAN(FD) and GRHCAN CAN devices"
 	depends on OF && HAS_DMA && HAS_IOMEM
 	help
-	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
+	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRCANFD
+	  or GRHCAN.
+
 	  Note that the driver supports little endian, even though little
 	  endian syntheses of the cores would need some modifications on
 	  the hardware level to work.
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 8ba21d94e87d..c9175a6a013f 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -33,6 +33,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -51,7 +52,11 @@ struct grcan_registers {
 	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
-	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
+	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
+	u32 nbtr;	/* 0x40 */
+	u32 fdbtr;	/* 0x44 */
+	u32 tdelay;	/* 0x48 */
+	u32 __reserved2_[GRCAN_RESERVE_SIZE(0x48, 0x100)];
 	u32 pimsr;	/* 0x100 */
 	u32 pimr;	/* 0x104 */
 	u32 pisr;	/* 0x108 */
@@ -203,6 +208,39 @@ struct grcan_registers {
 #error "Invalid default buffer size"
 #endif
 
+#define GRCANFD_NBTR_SCALER     GENMASK(23, 16)
+#define GRCANFD_NBTR_PS1        GENMASK(17, 10)
+#define GRCANFD_NBTR_PS2        GENMASK(9, 5)
+#define GRCANFD_NBTR_SJW        GENMASK(4, 0)
+#define GRCANFD_NBTR_TIMING						\
+	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
+	 GRCANFD_NBTR_SJW)
+
+#define GRCANFD_FDBTR_SCALER 0x00ff0000
+#define GRCANFD_FDBTR_PS1 0x00003c00
+#define GRCANFD_FDBTR_PS2 0x000001e0
+#define GRCANFD_FDBTR_SJW 0x0000000f
+#define GRCANFD_FDBTR_TIMING						\
+	(GRCANFD_FDBTR_SCALER | GRCANFD_FDBTR_PS1 | GRCANFD_FDBTR_PS2 |	\
+	 GRCANFD_FDBTR_SJW)
+
+#define GRCANFD_FDBTR_SCALER_BIT 16
+#define GRCANFD_FDBTR_PS1_BIT 10
+#define GRCANFD_FDBTR_PS2_BIT 5
+#define GRCANFD_FDBTR_SJW_BIT 0
+
+/* Hardware capabilities */
+struct grcan_hwcap {
+	/* CAN-FD capable, indicates GRCANFD IP.
+	 * The GRCANFD has different baud-rate registers and extended DMA
+	 * format to also describe FD-frames.
+	 */
+	const struct can_bittiming_const *bt_const;
+	int (*set_bittiming)(struct net_device *dev);
+	bool txbug_possible;
+	bool fd;
+};
+
 struct grcan_dma_buffer {
 	size_t size;
 	void *buf;
@@ -245,6 +283,7 @@ struct grcan_priv {
 	struct napi_struct napi;
 
 	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
+	const struct grcan_hwcap *hwcap;
 	struct grcan_device_config config;
 	struct grcan_dma dma;
 
@@ -393,6 +432,19 @@ static const struct can_bittiming_const grcan_bittiming_const = {
 	.brp_inc	= 1,
 };
 
+/* GRCANFD nominal boundaries for baud-rate parameters */
+static const struct can_bittiming_const grcanfd_bittiming_const = {
+	.name		= DRV_NAME,
+	.tseg1_min	= 2,
+	.tseg1_max	= 63,
+	.tseg2_min	= 2,
+	.tseg2_max	= 16,
+	.sjw_max	= 16,
+	.brp_min	= 1,
+	.brp_max	= 256,
+	.brp_inc	= 1,
+};
+
 static int grcan_set_bittiming(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -421,6 +473,32 @@ static int grcan_set_bittiming(struct net_device *dev)
 	return 0;
 }
 
+static int grcanfd_set_bittiming(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs;
+	int sjw, ps1, ps2, scaler;
+	struct can_bittiming *bt;
+	u32 timing = 0;
+
+	regs = priv->regs;
+	bt = &priv->can.bittiming;
+
+	sjw = bt->sjw;
+	ps1 = (bt->prop_seg + bt->phase_seg1);
+	ps2 = bt->phase_seg2;
+	scaler = bt->brp - 1;
+
+	timing |= FIELD_PREP(GRCANFD_NBTR_SJW, sjw);
+	timing |= FIELD_PREP(GRCANFD_NBTR_PS1, ps1);
+	timing |= FIELD_PREP(GRCANFD_NBTR_PS2, ps2);
+	timing |= FIELD_PREP(GRCANFD_NBTR_SCALER, scaler);
+	netdev_dbg(dev, "setting timing=0x%x\n", timing);
+	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);
+
+	return 0;
+}
+
 static int grcan_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
@@ -1544,7 +1622,8 @@ static const struct ethtool_ops grcan_ethtool_ops = {
 
 static int grcan_setup_netdev(struct platform_device *ofdev,
 			      void __iomem *base,
-			      int irq, u32 ambafreq, bool txbug)
+			      int irq, u32 ambafreq, bool txbug,
+			      const struct grcan_hwcap *hwcap)
 {
 	struct net_device *dev;
 	struct grcan_priv *priv;
@@ -1567,14 +1646,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->dev = dev;
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
-	priv->can.bittiming_const = &grcan_bittiming_const;
-	priv->can.do_set_bittiming = grcan_set_bittiming;
+	priv->can.bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
 	priv->need_txbug_workaround = txbug;
+	priv->hwcap = hwcap;
 
 	/* Discover if triple sampling is supported by hardware */
 	regs = priv->regs;
@@ -1619,22 +1698,29 @@ static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *sysid_parent;
+	const struct grcan_hwcap *hwcap;
 	struct clk *clk;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
 	bool txbug = true;
 
+	hwcap = device_get_match_data(&ofdev->dev);
+
 	/* Compare GRLIB version number with the first that does not
 	 * have the tx bug (see start_xmit)
 	 */
-	sysid_parent = of_find_node_by_path("/ambapp0");
-	if (sysid_parent) {
-		err = of_property_read_u32(sysid_parent, "systemid", &sysid);
-		if (!err && ((sysid & GRLIB_VERSION_MASK) >=
-			     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
-			txbug = false;
-		of_node_put(sysid_parent);
+	if (!hwcap->txbug_possible) {
+		txbug = false;
+	} else {
+		sysid_parent = of_find_node_by_path("/ambapp0");
+		if (sysid_parent) {
+			err = of_property_read_u32(sysid_parent, "systemid", &sysid);
+			if (!err && ((sysid & GRLIB_VERSION_MASK) >=
+				     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
+				txbug = false;
+			of_node_put(sysid_parent);
+		}
 	}
 
 	err = of_property_read_u32(np, "freq", &ambafreq);
@@ -1669,7 +1755,7 @@ static int grcan_probe(struct platform_device *ofdev)
 
 	grcan_sanitize_module_config(ofdev);
 
-	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
+	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug, hwcap);
 	if (err)
 		goto exit_dispose_irq;
 
@@ -1696,11 +1782,30 @@ static void grcan_remove(struct platform_device *ofdev)
 	free_candev(dev);
 }
 
+static const struct grcan_hwcap grcan_hwcap = {
+	.fd = false,
+	.txbug_possible = true,
+	.bt_const = &grcan_bittiming_const,
+	.set_bittiming = grcan_set_bittiming,
+};
+
+static const struct grcan_hwcap grcanfd_hwcap = {
+	.fd = true,
+	.txbug_possible = false,
+	.bt_const = &grcanfd_bittiming_const,
+	.set_bittiming = grcanfd_set_bittiming,
+};
+
 static const struct of_device_id grcan_match[] = {
-	{.name = "GAISLER_GRCAN"},
-	{.name = "01_03d"},
-	{.name = "GAISLER_GRHCAN"},
-	{.name = "01_034"},
+	{.name = "GAISLER_GRCAN", .data = &grcan_hwcap},
+	{.name = "01_03d", .data = &grcan_hwcap},
+	{.name = "GAISLER_GRHCAN", .data = &grcan_hwcap},
+	{.name = "01_034", .data = &grcan_hwcap},
+	{.compatible = "gaisler,grcan", .data = &grcan_hwcap},
+	/* GRCANFD */
+	{.compatible = "gaisler,grcanfd", .data = &grcanfd_hwcap},
+	{.name = "GAISLER_GRCANFD", .data = &grcanfd_hwcap},
+	{.name = "01_0b5", .data = &grcanfd_hwcap},
 	{},
 };
 
-- 
2.51.0


