Return-Path: <linux-can+bounces-7575-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ6cIFOL/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7575-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:05:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E64F2CF5
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDB143083AD4
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEFB3815F8;
	Fri,  8 May 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="nKlQRnSV"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021132.outbound.protection.outlook.com [52.101.76.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FE37D11F;
	Fri,  8 May 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223722; cv=fail; b=CNt+fy9dEda7zGvdE5Uc4o+S1wisN12sNfcGu1JC+JSLAOxRB1Z+fZ1PlJs8m66I61CgCxsQJGKBficJ/W+7uIa0Xo0gNbODQiM6LZ9vSuVX00gqwzu9mSnlEso68sKQq8ciZo9PcyyNK8HgKUznWOczJRjuzTquRsIv45wq7g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223722; c=relaxed/simple;
	bh=C4z19fojw5CBrQI/z75Z8XPVDqlW6LcnFRgF1BMVjD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOhjDa5AHZfWrL1eQgMMwN5aZqF75QHkK9eG8Kfp7iR7E7lIBfFRUXriLzYIsOcJudZaFiuKE++OljwCjxE1oLqR/f4es4Jp8Nk5rhTdRZOiSPD/KiTMwwSmktbLAyYYXOFRZzKv26r4TCsuduhASyz9Sv/bPlryBq57ximX2AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=nKlQRnSV; arc=fail smtp.client-ip=52.101.76.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyVtuUcGhlYu9ptw4JNESXW4qf9NeiC+WcD920tlcx8Zf6Q7CIfBPoS4sj9EpCPgmEJicQcGJNJ1Pg4wdF/RJeKOyOYXr2PEbmuLOaq9W/UeHEUH9i4TnYHZHiP+tYBwUjizkX3OHXV4vN5hEQT6YV8wIytpRICkNLGCrF7RmGCx4BMzPu+7Kje2xTlJoDNb8WYIZgZPv/dYR9KC9ts09lB5/fhBfkNFE/zFLMAorNTFznyR5id8usWzxhxq38wqf6nYOVqHFyjRi8xa6+Tv9b6KV4FPF+WrY8JY++RVo1XsJljEmOhIMyIOdTrOSeNAjROf6HVst4u23ZPXJgJG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUlqkDnY+yfLtJfJ6iaUABf04gc3vvJj57UPU0T6QWg=;
 b=t1Th42P845xZBbTkXvuE+E8jd4jWEc6ELCaCP7ctpLuzVrhRaVu6kl5iF7HuKT7x2wwE5sCKojaBzY9Cl24zOVl5az7eqEnTOkUl2C9R41Uujv8yXtVzVl6n1l9xxFWAyqnlEBns0pkZcznhAlNTxndr5CJDqEJlqSpA3mZ4pzhLWFzEo+OWCMrJ1vPx0C9ckhihevCMhW6VzuNXQVprVw1Dm4w2q0kT073nHPhBGjCw56QIJiEPCOFofKRFXH+Z6yWBbfOzINfe8HsPzfTPHePPnBFwVhNazarZPBQSfQTVdH8s8HxR5ylAEngKdmXxeTplMzE2FW4OqbDEBrufBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUlqkDnY+yfLtJfJ6iaUABf04gc3vvJj57UPU0T6QWg=;
 b=nKlQRnSVWTexc+FJ3zvJRBy3WnmcB/fughXErdGwFzhZ8EFSCL5GiRk7e7dLuMPzIQZ1Xjjif6C9AK9wtZNHP+LBiOb9cLis4VdhwDRIHYKBcKhF2fJvIay32jDq7d5MV6xQsamXtULciZI22o6+Aew+VlKseg+omWhkscAfn1jX+MWJzTQX+ZT2CKclLqPLqrO5qsIkBSluTcIf39BfdMHQYcHHj61YgHlqJZcNAF8pT9x2HJKFuTUZ3g0UUQEbVPNC6l1Swgvkb8hi2XLwMWS1itmLzPxqUn6vqFqKZnNBkXQGxl/SC08AC/+ya+V+TUwPfY8tWKv/PS6WtnfbjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:37 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:37 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 12/15] can: grcan: Add CANFD TX support alongside legacy CAN
Date: Fri,  8 May 2026 09:01:18 +0200
Message-ID: <20260508070121.6918-13-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6603d25f-3159-42e1-e2ea-08deaccfa5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|3023799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lUWMvyHgya6zzm4yUG3PmgMNLSkiGMovsjUx+YgV40etJ8FIL3h3vc5S6PAbFQV3DSdYD3/4OCQ//QGQd+zrEQ8eGYPviHIxTccRf4OK2jSVI4JoBPITijgSrodXVWxG/zPCTho8qsC1euY/dx9OP8VFqnGb2RVeQwUob5CH0jQwuy8Ft1v3KUtFKRv2H1eOUp6g0f+l4RdxAKS+xIn4Od5/inWEqz0MxNoG9Pke0NqjCW7qrAzSgPimRO+6K7gYQjqX3FB1z5SeXIP9z6W3J8Wz6r+n/E2Krtg4j9FnNZw6+d4x/oWpn+0AMt1B8c2nIu8ES4RNlBHWEN9XLG8AvWNnq+yW4gkWEYCAkwz6nQi7VxLfe/gr3Q3YSlm1Lwvk3gtJtsmoVs2UEP5Xy+Dzh7Z3mYnPakRR1WnbGvXsMR5eC6Z588lWktWz1SMLrf02tkt+nRgg/13PqaEBJJXt7GhmHeXmmAPQQRDS/kfFDHFzEUMkUpcJjqXdI6YwlJ+sAKTA8YVaGeH//WSJH5YjRr+bRUf6Bc9cuNBbKv2C4PJqtvCoHWSineSE1M5oL/264AdZ7+YUewRTYRbkP91xKP9qA+PlNOCGLz1hImBuzRoFc5+JJMEhDS/VlnCM979Va3b5x6XdTRuA5XaYucu439lpnp9ipfyX6esAYf2QGjFGwjxGSfhD1quraZ3gn++KzX3pAQxSyk3NEjHpSncGswXUjpz7rqGfm/+5nfoTD9VOfMy7S640Zi1WDVOLc+kn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(3023799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wBeHX8dbRzVGlGwIsJSyv8sLz9PzvJn6A4XXz4bYF4bcOT5F8V47EruETXFe?=
 =?us-ascii?Q?ih7ukaoxvxtzMDF6B6aYAN22/KCUeWaXbStJatrPPxMMdZYNc90rcPWK6rXP?=
 =?us-ascii?Q?mPUgbd2O5coYmZupFtabY36hdG/jlyo4OhCd7EjSxDZ53HnRa7Mbkfp2isEd?=
 =?us-ascii?Q?lcLwxnuBAe5lxmj8QDit3Wm+1HqGyXB4a0zw4D77k6KTWqQQGxdkUzg238MK?=
 =?us-ascii?Q?kzsMCSqK0qQF8x5vZqGxT2k5nBLGtemlQHPEr6kMNKpWVLrhejBnUHxLf9b5?=
 =?us-ascii?Q?FwRy2WBeoAifDGNmvwq1uMIrDbCnx93JDN2bbXJAPnwyG4rWNHnfdI/FTV1Z?=
 =?us-ascii?Q?BpTkgStAqJqQNirxc05J/Jnxajv/jMZ13D8WNshFyL+aNSGm9NMoiUNKyVwu?=
 =?us-ascii?Q?b21ZWuOpyvpPEtLGDotzdTx6TRD24/GPxmWL4AMawIJ6faf2SEUTTY9sVOCP?=
 =?us-ascii?Q?NQzhTgDJbov2J3Y0GgY9fEvJJVLpOduQ1Nf6R0xpTGMIc9x5EzdSSGSWuYKa?=
 =?us-ascii?Q?ZyeHO4bPwCvwJiT+9BqGNAs15O+ScUQMlN1CBqduGdFYqBj3e/cwbJ2Iciy8?=
 =?us-ascii?Q?8bcxDAT4Ke9tSy24Oi0Dqg7lS6kgZWOKb1fZQeWK4RgPPJJusamkRYcEuLL5?=
 =?us-ascii?Q?kxhM4oWeUekc60P8adTBa1kNwP4wbwFT7Kl4FZVojK4M8dX12lyogrGARUTM?=
 =?us-ascii?Q?ZE03S1yzK1vUOf6LPcx/p+HaShqS6EoC5cb3ZieL+gqEWwerN6NZ+gwPKJf7?=
 =?us-ascii?Q?5ie+fd022objle2OpujxLpBg5eopbWI3K7RsDKOjqTUIALp9lDjYxtUHgbxi?=
 =?us-ascii?Q?Cf2trwiQsKKC1B09Sy9/aU5ea2aquQ8cMAcB/B75cMtQoaybn02HiHBHQlOq?=
 =?us-ascii?Q?Y8LuA4PfubRsm5vN1aq66tactAAr5nkypOI7Of/XskKajufs/vLUcWqeqYIr?=
 =?us-ascii?Q?OciDITyEPGzo3m1gxK5HWjMpyLX1ZD4vRZvgh+91JoSIlcSdyHbwLuinoBvI?=
 =?us-ascii?Q?T6p1Vc4OOlXVdXSQIJz0cTsAPUizPhnztSRJxXmtuTQbx0CpXNYwyd/G4rNc?=
 =?us-ascii?Q?d7OdJ47lwz1qfj4Rq0/Vr1zTNuIKftZ/ZFWDM/6c4kCUjQsACw0t/xjXBJor?=
 =?us-ascii?Q?sI5jCbWwM/wc9dEPZdIpykE/f3LJW50RYuO4soeT1mn91pdMZje/QmMKZv8/?=
 =?us-ascii?Q?AIY7QfItBleNr/ZXoWl23amYYgXBl1W7L+o5g0RNvJNdS1KjbUP9iH6JyLOW?=
 =?us-ascii?Q?5619AtxGYR3vw7HJbB3/Dp6/UDzNZRqoBys5PXpipRwVswcplYwSm+vc1/Sk?=
 =?us-ascii?Q?VHZ/2eV29TrIX0faNJUEVw5bXb/1laIq+YRCuPRKtwG4qSaHPh3qsi52RMwl?=
 =?us-ascii?Q?N+a3w7+f+K6JZjJVaKIBct6qe1FSpZM4vsQ1bmSV41I3pta64KwUsFOg6Di1?=
 =?us-ascii?Q?NnDl1WGBbwD8utOHMzN5dGRjtjfgEIbVEUN0K/KoVdKxIdJi6WoenyVMMdkn?=
 =?us-ascii?Q?FvstERg3EtOJuvuRHK0nz4siwDekS19mjR5yLqnbQpALItri1rKzrdDTYMFI?=
 =?us-ascii?Q?uMX2P1h1yN+GPfKiwFrYymijrcLiY+DRarfssxumfTd98ngE9MZiCsgPbx+O?=
 =?us-ascii?Q?AJ4I9sORYI7uyeVXCUW4KPh0B3aw+mNV/9ukDzvCl2SFFfHnY6q6ovJts5hX?=
 =?us-ascii?Q?EEJGjrrRKkPeJ05ykmqLL1N5ImVV1tztKI5lbFdOlON/JNbUO3qJ3GzBRx2C?=
 =?us-ascii?Q?aFNU/StUM7XVWFdO/LoTlEUfJo86lnw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6603d25f-3159-42e1-e2ea-08deaccfa5ba
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:37.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B/hH1CkX21MB0dF0jHrvRHeaYNJwHfdyTbifdPd3qE1gEsUHNyS93SKLkKAhBvIPSmT319wp+5oOcviB1F8v2BIdiWsUNI+Jwo5LJbpoOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: EF7E64F2CF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7575-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Include CANFD TX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 117 +++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 4921da349a0e..690e07c7b1ef 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -174,6 +174,7 @@ struct grcan_registers {
 #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
 
 #define GRCAN_MSG_SIZE		16
+#define GRCAN_CLASSIC_DATA_SIZE 8
 
 #define GRCAN_MSG_IDE		0x80000000
 #define GRCAN_MSG_RTR		0x40000000
@@ -195,6 +196,10 @@ struct grcan_registers {
 #define GRCAN_MSG_OFF		0x00000002
 #define GRCAN_MSG_PASS		0x00000001
 
+#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
+#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
+#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
+
 #define GRCAN_BUFFER_ALIGNMENT		1024
 #define GRCAN_DEFAULT_BUFFER_SIZE	1024
 #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
@@ -227,6 +232,9 @@ struct grcan_registers {
 #define GRCANFD_FDBTR_PS2_BIT 5
 #define GRCANFD_FDBTR_SJW_BIT 0
 
+#define GRCAN_TX_BRS  BIT(25)
+#define GRCAN_TX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -434,6 +442,12 @@ grcan_msg_header_at(struct grcan_dma_buffer *dbuf, u32 offset)
 	return (struct grcan_msg_header *)((u8 *)dbuf->buf + offset);
 }
 
+static inline struct grcan_msg_fragment *
+grcan_msg_frag_at(struct grcan_dma_buffer *dbuf, u32 offset)
+{
+	return (struct grcan_msg_fragment *)((u8 *)dbuf->buf + offset);
+}
+
 /* Configuration parameters that can be set via module parameters */
 static struct grcan_device_config grcan_module_config =
 	GRCAN_DEFAULT_DEVICE_CONFIG;
@@ -1226,6 +1240,14 @@ static void grcan_transmit_catch_up(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+static int grcan_numbds(int len)
+{
+	if (len <= GRCAN_CLASSIC_DATA_SIZE)
+		return 1;
+
+	return 1 + DIV_ROUND_UP(len - GRCAN_CLASSIC_DATA_SIZE, GRCAN_MSG_SIZE);
+}
+
 static int grcan_receive(struct net_device *dev, int budget)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -1412,15 +1434,24 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
+	u32 eff, rtr, dlc, tmp, err, can_id;
 	struct grcan_dma *dma = &priv->dma;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	struct grcan_msg_header *hdr;
+	u32 bds, copy_len, payload_offset;
 	u32 id, txwr, txrd, space, txctrl;
-	int slotindex;
-	u32 rtr, eff, dlc, tmp, err;
+	struct grcan_msg_fragment *frag;
+	struct grcan_msg_header *hdr;
+	struct canfd_frame *cfd;
+	struct can_frame *cf;
 	unsigned long flags;
-	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
+	u32 oneshotmode;
+	int slotindex;
+	u8 *payload;
+	u8 len;
+	int i;
+
+	regs = priv->regs;
+	oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1431,6 +1462,18 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		return NETDEV_TX_BUSY;
 
+	cfd = (struct canfd_frame *)skb->data;
+	len = cfd->len;
+	can_id  = cfd->can_id;
+	payload = cfd->data;
+
+	if (can_is_canfd_skb(skb)) {
+		dlc = can_fd_len2dlc(len);
+	} else {
+		cf = (struct can_frame *)skb->data;
+		dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
+	}
+
 	/* Reads of priv->eskbp and shut-downs of the queue needs to
 	 * be atomic towards the updates to priv->eskbp and wake-ups
 	 * of the queue in the interrupt handler.
@@ -1441,40 +1484,55 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
 
 	slotindex = txwr / GRCAN_MSG_SIZE;
+	bds = grcan_numbds(len);
 
-	if (unlikely(space == 1))
+	if (unlikely(space < bds)) {
 		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	/* End of critical section*/
 
-	/* This should never happen. If circular buffer is full, the
-	 * netif_stop_queue should have been stopped already.
-	 */
-	if (unlikely(!space)) {
-		netdev_err(dev, "No buffer space, but queue is non-stopped.\n");
-		return NETDEV_TX_BUSY;
-	}
-
 	hdr = grcan_msg_header_at(&dma->tx, txwr);
 	memset(hdr, 0, sizeof(*hdr));
 
-	/* Convert and write CAN message to DMA buffer */
-	eff = cf->can_id & CAN_EFF_FLAG;
-	rtr = cf->can_id & CAN_RTR_FLAG;
-	id = cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
-	dlc = cf->len;
-	if (eff)
-		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
-	else
-		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
+	eff = can_id & CAN_EFF_FLAG;
+	rtr = can_id & CAN_RTR_FLAG;
+	id  = can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
+
+	tmp = eff ? FIELD_PREP(GRCAN_MSG_EID_MASK, id)
+		  : FIELD_PREP(GRCAN_MSG_BID_MASK, id);
+
+	hdr->id = (eff ? GRCAN_MSG_IDE : 0) |
+		  (rtr ? GRCAN_MSG_RTR : 0) |
+		  tmp;
 
-	hdr->id = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+	hdr->ctrl = FIELD_PREP(GRCAN_MSG_DLC_MASK, dlc);
+
+	if (can_is_canfd_skb(skb)) {
+		hdr->ctrl |= GRCAN_TX_FDF;
+		if (cfd->flags & CANFD_BRS)
+			hdr->ctrl |= GRCAN_TX_BRS;
+	}
 
-	hdr->ctrl = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+	copy_len = min_t(u32, len, CAN_MAX_DLEN);
+	memcpy(hdr->data, payload, copy_len);
+	payload_offset = copy_len;
 
-	if (dlc > 0)
-		memcpy(hdr->data, cf->data, min_t(u32, cf->len, CAN_MAX_DLEN));
+	txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+
+	for (i = 1; i < bds; i++) {
+		frag = grcan_msg_frag_at(&dma->tx, txwr);
+
+		memset(frag, 0, sizeof(*frag));
+		copy_len = min_t(u32, (u32)len - payload_offset, (u32)GRCAN_MSG_SIZE);
+		memcpy(frag->data, payload + payload_offset, copy_len);
+		payload_offset += copy_len;
+
+		txwr = grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size);
+	}
 
 	/* Checking that channel has not been disabled. These cases
 	 * should never happen
@@ -1516,8 +1574,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	wmb();
 
 	/* Update write pointer to start transmission */
-	grcan_write_reg(&regs->txwr,
-			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+	grcan_write_reg(&regs->txwr, txwr);
 
 	return NETDEV_TX_OK;
 }
-- 
2.51.0


