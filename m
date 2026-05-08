Return-Path: <linux-can+bounces-7576-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAubICyL/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7576-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:05:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0494F2C99
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A80A301B07E
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B43803EA;
	Fri,  8 May 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="r0rpQRXw"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021139.outbound.protection.outlook.com [52.101.76.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422637F743;
	Fri,  8 May 2026 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223724; cv=fail; b=GlBOacseZHRcI6imVyLFuUfpMmXHEG/T6dT5urY0/17OntCptNDoJVRnpWvzLZr5y8MDIccyQ83gu5hreUeGSqdClk72nMim34cryWsRQgZPINh5ecqBjKf0Z5eow29cKiJ4hU8kO/jtKYuVodEGMaNbgx0Xj0ostlU0yY+AUFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223724; c=relaxed/simple;
	bh=/nUGDTD3llQDxFSb/WuFLVdYQrXzw7KhS48bOoyBjU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFcUOm4dfEO1B4TDfAxcSaHmrCvrYH8sR8aS48XtjKf/O/2CEMKhVz5w8Gh3KFsiSfqbem+NXH3Nk48VihkeD0KK3GYrAMNgynk0bKZfu0mhVgfTgFW3y1eVA7lEcN2BE4E3p3JHgAzo7M3YKKuVG67R6egZFuU532nEPG4yx6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=r0rpQRXw; arc=fail smtp.client-ip=52.101.76.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtFFiAeDfSAku2y+XL/WG7EUFnEJ/iL+wCwF8lhhvEr9HDJou+lH+Z3M8XjffiWFdVHvdYNofkQpleslX127p4k/TrioGMKn0282TEDVXMGKHmBqdLQCERSsV9NdA3+hrHyHzw2cakNCv5vAQtPawHegZWiqbGUO+jeBZSiHKShwvB/pU9OwVEdf3znJYrsprhhXyoCo9EimRfzRm9mahZ5m4nb2g4skscYBkUpKtgnS8FeYdltyslvIBGUwmEi3ecFkueHIPJvYmi3tZVOu4EHLH+7Lh8VdbKnQsJ8CkF2zWiTwvqaDHU2qgN8bZwDfP5skr+9XskeKfw1JUpMAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcChQAunjokGQIQQ9ojwgInPsEGmgOvlZMheeMYor7E=;
 b=xM7tUEdACWomPwXHEWKgyWcCOEBAY5A3QUtn3dpAhyjCeF+Y9DKV0IBxMm6+z9HW/gMH2LBQU6yXUmRSOxdIXF7X5ZqQicXK5GypRmChw+gMFX/s+lvvGuUdr0GovmKBvmmW6seefjh/hyBBpxJZqH5YjeRPzkOYYy5ge79bAC8HgINQsOEKwZYvR0ssCnWHFIMgLxRuY6L/rOIWrLp/MzJrZHzhOmapnXaQMMwAb/UrygzDd0na/Aunmw9JmbkfRqUbXywMX/ouTmux9pt9NQzVbfRGsxXK+THgpn2QLaDOqWgNUsag/KG3xkm//lKgc249Ywl3PMogGo1rHPJBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcChQAunjokGQIQQ9ojwgInPsEGmgOvlZMheeMYor7E=;
 b=r0rpQRXwwJmAciTARN3dZyRISXRu11c5xB2fYCaTBcoXlVvNxz9FaDD+rLkHYFz4p0EsPT1COhbNAaG4cABgAvQ7FIqHcoStXix8SU+PzcYuR6lKXtXdZKV21gxOi3BksY7jLgQSmIp1WSjFQz/OlO3bfXYEVHeJ2GgtUm0Xqj65JuYISdSxaEtvnRovoltxV8tqPPKwKQaYb8zsBW4pjsJl7VHtl09YA1WLBi7rpLaNMUmdBhkzNuh0y2okFdpDVS86wLNrLo+8KSZSvCcNLV/diyjGw7d/SVR9lNZoSWAMETSnPZytDs1o6vsJQi6YWT75JA4mOxW2DGCcX2VKtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:38 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:38 +0000
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
Subject: [PATCH v7 14/15] can: grcan: Update echo skb handling to match variable length CANFD frame
Date: Fri,  8 May 2026 09:01:20 +0200
Message-ID: <20260508070121.6918-15-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38c2fba2-fdfc-489d-b007-08deaccfa641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8duno92EN4miaDrGbH61982fdUSVBdvACn1Llx8g3osXXCB2gDwDpPJK7NDAcKW5C9hyW1not++SrsODY5zpSFEOpWfIJKLxKGVfKBkTzLHJ3kiXgXepGtXhR67qeIUZdz2TzrAyj/SH1lG9hopGEg8TWipMQ4J4MmNhnbKlIiKMgiwbMSvczpWLKQLM8Hl2z0mbC63kId1v+4IiLTFn/ufgpvVBmwZdT6rrcHn540rCjCQx7AIeKaMSjq084OACKil6jk0skgMDX34J3hW1sD/wK6Q+SQhu+rvgw97xYIQ637+8VH+Ym1a/+ltLaYKO81rHiUnuGb5G9mAS9ujkNyVefbFqfMJvoIhdVcH/Pm6vY4qcE+wsakbGtH3rORzdE6IMqxoIm7h1RhRktNbXiUfVTbAbn1QOaugEOw56EsAGYJtzHsUcnnoslBYx913eNTx0U48j2j8ZuSNCMP+ioStb/1S3QiWLg+h3u98kxDjTqhjc8UGPlGyu19FdkX5xhjQQkTE3xxiU9j0Mwg/M0gW3QGUmPnmLZVPRMjyb5QVVFrwe3Fx+ZTQcqGX+zyAgG8MbtCtQn2ftD+quAIRASt9aNY/JXJQ5ixLI7TZya4g0GK2ETEZiifivUMglEzDubPh9kTzoALrFbjDw8pfvFuJ+GIx8LLkV9PCvKf9FtiqrkbL8Vnnv0XcUDX4x6Zv3nERiBoCIUCam5cXHa1iGL7TV4cBcQjFiCuZkv30MYLb5Tc+HLCOfoAQW+OP7pSTc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tcmir71q+IpgAyO7m2mqKRQto+8EMg7XgH5sQst2mvVQngmKIis89qTQBaGP?=
 =?us-ascii?Q?XA79T8aMbBtMJ0xBWagiFFbg1CFxXuJSrnN8BRJt3WZMGI6k1VPOyvYANI2h?=
 =?us-ascii?Q?EzNK+TTA/2GBJwwIWdsQgi/8sfJ8umCEFMwuzo92HH/YKAC8Y7TzKh1nO0lZ?=
 =?us-ascii?Q?cTRYFOlIBj+Hsxiqev73EQ3n9paEr3ehiPd+6x39Kz2j2dE7FdehIfN3eDZ3?=
 =?us-ascii?Q?NmdBr9NKe0kf39HwnZ8hwWcZPNcpXYAuhQ1jn+/KozX4AY0uIwAteBSgMBfm?=
 =?us-ascii?Q?Xam7se8ZsiLKZt0OwRQAcrA53U7k+yA4vHFHODRjgR3lIyoAPup0psKWPDOw?=
 =?us-ascii?Q?cwDGbLmciq4VfddyLUUvEOMpKkNCbqr6AC2i5KT73/J+IwuMOKrPQGu+RgSW?=
 =?us-ascii?Q?i3xFy6d6DTtGjKHmxpxTlIiOcgZU/5NFme1c87jT8kccOFXqoXtjP4NjvbVd?=
 =?us-ascii?Q?EccknvNFtnUtNfS/Whv51N5bOgnDc8FF0z41B1SaY1odvbAwofNSPeUZfU/3?=
 =?us-ascii?Q?Wt+6wWJSYLmrnT127Oa838GPr3bgm+VeU3XsK50GGhG4DzuQJxD16JiAZpRv?=
 =?us-ascii?Q?VJWGT3epDULNs8tNGqI4DRNpNaei8SysZPwRbN7Yh5wZI4avtAVo/PeBYfgd?=
 =?us-ascii?Q?+i+aD27uCxA/vO4h/u7znOVou4z9L9Ht0BFHQ/I2koJ80Q+SPhqAjWxYf373?=
 =?us-ascii?Q?zoLDkusQtnNjqIV5jIDaE+RWasQ4cjo5IJPvYDi1ZoUN9yG1kJ3glykevVjK?=
 =?us-ascii?Q?HD2AQrxE19bTVGKTpjR8nPPHVre3JiIJSHihMsnjT3JNGM7b++q3TRkvWxne?=
 =?us-ascii?Q?bIYCV78NrDFy6td/tjmQEOjg/0LzCp0ZLEELHwjFoDUfqMr7cE4FDoYdgI3B?=
 =?us-ascii?Q?04WxAUuQs8HBjKaVs2WR2OkhTkFtXo+z9TpSdJsIb6FvkEXpTQ2lToJHiJQY?=
 =?us-ascii?Q?yUODy46AUepeguc22XuejS1kCXGlaLVabu05i8+wr7eLTaKueM8n6QlC/Fp1?=
 =?us-ascii?Q?Tx1NAqjSAsGF720jYcKLh6XZz2z6k57XjJZ+RFnznnr3mwGNxQ19HwSDk9KO?=
 =?us-ascii?Q?k/yxGz5gcO0exBnd+cZebnuJ0/a//DA9kyw3/Jjtvv+qaucc8w+5tm7lGBcq?=
 =?us-ascii?Q?EZ91na+nr8EJK+3hRy9jiQgQyRy2VxIvAloIOnKVaRDsc78DMQRGvEplru1p?=
 =?us-ascii?Q?QuHF9Tg7Ly0lmgLlDyuW2Uqs0xkxqU54WzcFqESc0IjFcImdwcx1gS5jkhrT?=
 =?us-ascii?Q?1r+Zpqy6TCGUTwOhIlyJPHZV4CdO/NtrPMjT2b0BTJrwWW31rfy/P+gfub4Q?=
 =?us-ascii?Q?Y0Kkoev2TSzu10U4Dz92ItT8YlYzBEdftu+6xwkIphQP1/G2jDlAVtMDKnbK?=
 =?us-ascii?Q?xEAcBDYTV3wf8Nb+DMjnoyNlcYKn/SPwJmoswBz+UThjlk5gk3/VkELrtq1s?=
 =?us-ascii?Q?vvjUQOlPck2duC0g6olbtKf69d9vMMzd5kaGzw4jrd9g/K9PGwB8Ys+lmhA3?=
 =?us-ascii?Q?kopjGlqA5rr/v9uFXczflr7byf4CApQjmHlAzuPP2ULjK+JS4dQ6paZEG19U?=
 =?us-ascii?Q?516VlzpA92tUiGfY7PxGj7G99bZblOXLeOq4KYxsuuEuNVXaejhG9Q1lFPsi?=
 =?us-ascii?Q?7+xPshqbBBGzmVVkDvEU2ab1QumbVQwAHLj8z4xuV1CS0wUsf2IUH7fsmw9s?=
 =?us-ascii?Q?actzxCY6q3u21CvlokmjxeCPZZAZORE4h34J9c8DoBn6DsROvTCwu4ctNPb/?=
 =?us-ascii?Q?KWP4CkBuz4/8mDIVAjbuStrxpvuzlG0=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c2fba2-fdfc-489d-b007-08deaccfa641
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:38.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYUgjs+Mhjjnd2Hqg/ylhPR5LNSX3G5lfcryr+H6WyC7vOVP23jA9Pqh/VzkpQj85eCpM8aJu/6AIDo75PmO+QcJiKV6XE2jA50vdaDGMlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 7D0494F2C99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7576-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:dkim]
X-Rspamd-Action: no action

Refactor echo socket buffer management by introducing dedicated indices
for current and next echo slots.

- Introduce "echo_skb_idx" to keep track of the current packet index in
  the echo buffer, and "next_echo_idx" for the next available slot.
- Adjust memory allocation for echo skb to calculate the number of slots
  based on slot size.
- Enhance logic in catch_up_echo_skb() to correctly process and free echo
  skbs.
- Initialize "next_echo_idx" in grcan_set_mode() to ensure proper starting
  conditions when the device enters proper modes.
- Improve memory and index handling in grcan_start_xmit() and
  added a check to stop the network queue when necessary.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 53 ++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index eba52701c882..06ef081970a2 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -312,6 +312,15 @@ struct grcan_priv {
 
 	struct sk_buff **echo_skb;	/* We allocate this on our own */
 
+	/*
+	 * Since the CAN FD frame has a variable length, this variable is used
+	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
+	 */
+	u32 echo_skb_idx;
+
+	/* Next echo skb free slot index */
+	u32 next_echo_idx;
+
 	/* The echo skb pointer, pointing into echo_skb and indicating which
 	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
 	 * handling"-comment for grcan_start_xmit for more details.
@@ -593,7 +602,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;
 
 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -604,19 +613,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	for (work_done = 0; work_done < budget || budget < 0; work_done++) {
 		if (priv->eskbp == txrd)
 			break;
-		i = priv->eskbp / GRCAN_MSG_SIZE;
-		if (echo) {
-			/* Normal echo of messages */
-			stats->tx_packets++;
-			stats->tx_bytes += can_get_echo_skb(dev, i, NULL);
-		} else {
-			/* For cleanup of untransmitted messages */
-			can_free_echo_skb(dev, i, NULL);
-		}
 
 		priv->eskbp = grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
 					     dma->tx.size);
 		txrd = grcan_read_reg(&regs->txrd);
+
+		/* Grab the packet once the packet is send or free untransmitted packet */
+		if (priv->eskbp == txrd) {
+			if (echo) {
+				/* Normal echo of messages */
+				stats->tx_packets++;
+				stats->tx_bytes += can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
+			} else {
+				/* For cleanup of untransmitted messages */
+				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
+			}
+		}
 	}
 	return work_done;
 }
@@ -1124,6 +1136,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->next_echo_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1135,6 +1148,7 @@ static int grcan_open(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 	unsigned long flags;
+	u32 nr_echo_slots;
 	int err;
 
 	/* Allocate memory */
@@ -1145,12 +1159,14 @@ static int grcan_open(struct net_device *dev)
 		return err;
 	}
 
-	priv->echo_skb = kzalloc_objs(*priv->echo_skb, dma->tx.size);
+	nr_echo_slots = dma->tx.size / GRCAN_MSG_SIZE;
+
+	priv->echo_skb = kzalloc_objs(*priv->echo_skb, nr_echo_slots);
 	if (!priv->echo_skb) {
 		err = -ENOMEM;
 		goto exit_free_dma_buffers;
 	}
-	priv->can.echo_skb_max = dma->tx.size;
+	priv->can.echo_skb_max = nr_echo_slots;
 	priv->can.echo_skb = priv->echo_skb;
 
 	/* Get can device up */
@@ -1467,7 +1483,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf;
 	unsigned long flags;
 	u32 oneshotmode;
-	int slotindex;
 	u8 *payload;
 	u8 len;
 	int i;
@@ -1504,11 +1519,9 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 
 	txwr = grcan_read_reg(&regs->txwr);
 	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
-
-	slotindex = txwr / GRCAN_MSG_SIZE;
 	bds = grcan_numbds(len);
 
-	if (unlikely(space < bds)) {
+	if (unlikely(space < bds || priv->can.echo_skb[priv->echo_skb_idx])) {
 		netif_stop_queue(dev);
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return NETDEV_TX_BUSY;
@@ -1588,7 +1601,13 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * can_put_echo_skb would be an error unless other measures are
 	 * taken.
 	 */
-	can_put_echo_skb(skb, dev, slotindex, 0);
+
+	priv->echo_skb_idx = priv->next_echo_idx;
+
+	can_put_echo_skb(skb, dev, priv->next_echo_idx, 0);
+
+	/* Move to the next index in the echo skb buffer */
+	priv->next_echo_idx = (priv->next_echo_idx + 1) % priv->can.echo_skb_max;
 
 	/* Make sure everything is written before allowing hardware to
 	 * read from the memory
-- 
2.51.0


