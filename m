Return-Path: <linux-can+bounces-7573-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMleIeuK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7573-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:04:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 898074F2C4E
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C868301F290
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765037BE7C;
	Fri,  8 May 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="PJsupBDY"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021139.outbound.protection.outlook.com [52.101.76.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECF35F8AB;
	Fri,  8 May 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223718; cv=fail; b=F51E4Sr2NGgQiDi1m58N/NYK8jdNwEray80IdN29WDBuZuxeMVvkDtAr8hyXSaehG4Z4Glm4QvX47QAPpiwCStvOT71RqiupHvj1YnAbl3iCtR7oLL5Azgk4TY5aRAnDQpldXSEsk0AlGSH3g0OctD/2c2eSEiXUYvET07VbgS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223718; c=relaxed/simple;
	bh=Vf2CBWJY+w8dRaG/8/8xC5f9zZH4W2KXoF870P3Tv4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLw5fn/YgFnb5lJFZNlgYM2hTRyrIFVPzQtqQ/Nn0k9irLoB+nvZx17TaxKa/O/ji19nznpyDEDoQwBPXBAYyRo5TPcRlWdtUHinz4X4r/Se1lzB1Ln7+TLWQI6INJe0qE8B8OPqWgxrbVZIn8AeyhaHsN49Oe/3Gp7eT4qfK6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=PJsupBDY; arc=fail smtp.client-ip=52.101.76.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgC5BTYoou/GTYqbwiWiwRZ0gOmaG6H24kNjFCtnCQoYyTpUxql4/pfrGEiTeym3wGyt5xFXpltQx5wQI65Rndlj+dMOXJaxTzd7pTfnRv9L3FQWkoia1D/M5r1a/vKESOn6/Iy97hpYG6qkuuVkqBEQuA/SzbYFW03AqqH7nOjQYfmIYHCZEIWHDesb2nw/+zIivOsIQ8s7QmMNRT7XcehmRczAm7SL0jSXwEqEDyfQUgv14ZSf3pb7jRWeAb9xrdWo092gde2rCSS23PUk7EVo3Btg7Do7b/eVh0u3WSlvljdwLT20XlUW+bqmd6YXqtqNyo5CGsxnoi4Q+SOjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8glEZ82uZBY1CvyitsTBirLmVTkGitAPrvRmBDFMt+Q=;
 b=byEGuGOys+rtFX408raVJPKmBGpetE7c+wEhy/OUwnROplkpZ+bsllWX4E+AyF0Z1nmgT1G51peYT4i84laC+0V3Ny4KJrCV97PMMbwpr3iHVuHZ6A9asoxV3Gq8rsC4WpoFeNJU2HBhEtSs3xZFCMPckggJku9zhnp5nGJ+F+19867IktgEBa8R6bpgRNVq5U/FSaWiSpIVepE0cMiGwadMLvZGpsDSQbV50BYtpZLpN977FNpcnvQsxG7BHwhSPe5Ghaht9df2HzdH5VextPTShBd1pSINae1J69i+5mvUSQrdzvJdwCAWETIYTY8tZyKH0LO6M9Z2FaMVFwAUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8glEZ82uZBY1CvyitsTBirLmVTkGitAPrvRmBDFMt+Q=;
 b=PJsupBDY9E6QEK+o9xf+GE/zlVEJDEczLeYeZTtaSZ2OwXMpaynrCRTwjveQ2qq7XjJwHPXyNJusninwFfzOHCeMdR75jnK2x9HzsxTIpexhhELLwNDHETY6v734v5gDmZj+30sA4+o21fZyah1hrBh/wVDxOJ2eRnSAz1HLvQBBlh/krbbEgovhMx2jJnxLvhh1G0Bls6n5A4GOWEdrZWTf5W0efqsS0mta7V2u4xRfpOX7UeKPCz7masQFnKiFnqEHsi67NWd1002ZAOYVxGdRmpD2TgMZLBsHpxfReo6p9Q4KIDVIrHxmCImLAT4hmwx7TTFogNyd29HJUAgWaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:36 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:36 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 09/15] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Fri,  8 May 2026 09:01:15 +0200
Message-ID: <20260508070121.6918-10-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6164ae91-b6a1-48a6-57b5-08deaccfa502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GwBGZudm/hmDtWc42dTC+m0XbfCbp+cQTAO55deNgkGc9MxrYSACJJQ6UtTk38YB+9SzJRCRT1C61lTyjhjhgDetRWlz/nQOmkolVjchW5LSj0QhlW3Yh2POPMh8tBudIYONiIkeRh4GTkENySh0H7Vg7ciO/Gab2QKjXI7i66Gx6aXyJbDKsxFsvO35t56XlSRUuJ1WKd0L4LdjBAiIxIzwGR2N+YnmQw4wDMrw42+rQKkQsbCIvSpsUqUCyWAzFRqYsZkclYNZJbeJbmSOXvCIoOUPd2Ri+n2Z5Jz/ELYvVOWFx5O1wgHO6gqd3QTaKWvhTwIlcl4wUh4fFk7lEAVbegpZZ10RHwW4iB9eTqv9IHJY+pUxl3z/NeY9YBdbyeKA3QYOAOOcP/vMCOqmfH7wpPAuWHenCfJc7WJrzTLcULWfNb6S1ME630hVOeW6MooczfeKY2TIfhW1N+binobzUtpMVzCtQLMlDnEnwJDM0HU6IcUwBabPiFP/ap9RFM2Yqufgpuv5beMCGeU2AfwrIXwRGvxRjAcl/LEgtV/cpyBzolZAhQAGlEb9dEh4XaeJM6PseEtlDszn8sBNFIwvk2s61XvfX3yhJMChIUUMpDfFLFZyMhgRmGqKkM2+KT7XTVeyoOPSnJcDUZ/jdEmckiVAVjqN+z/JbZ6GlRO0Zd6s/KT/QShH+cbgW8FsEh1R78kSD6JJ6uI+Lqi/7BGzwsxp/uy57zCrQjnIIdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxE2OYcq1o2XK3a1McgenttxzCp8jDNe0WJW6Ha5NqwJhem7HVeB83ydez8e?=
 =?us-ascii?Q?uKDY2js74AvqlSgZpWAFsKMAz0t6aU4HMsiHS5Ff3Lfxuk7YRqLYBBhUziz9?=
 =?us-ascii?Q?+CTe4lbMrGS4IJeI2xoY8VtvDRXVCafTmgJ5y4FyCtoo53atyE3BiId0iM2i?=
 =?us-ascii?Q?GddQT/3zu1ohhC1fm+pVCrJY2URNYJzlqgD55NohzHUf3D4EERHwUgOawaNF?=
 =?us-ascii?Q?vzGu6qZeVUnY/mUDqDuwoc9ovf8VQPc5m9ZmdKZT7wDFQmmKgl7b+Rglpwfm?=
 =?us-ascii?Q?A0PnpadsWyZCvt7FS96LR77wqNOlXoeKu7Z71E9vzWs/YkZeZliINAW9/x0x?=
 =?us-ascii?Q?p8zyjkzuElBk4vjfnaUzzg46Cw6j7Hv5JIW33yeNPAxw+2Gf9S3UYJ9cLnz1?=
 =?us-ascii?Q?tWj8qspGXceWu/b4i3LvRdMafSTW4E3WQokApwBHQHiaM/9zr0O8DFlF3XE9?=
 =?us-ascii?Q?/XrO5cgtngBPbVcXubIHmVbqJ2pfrk7zD1jf9PNaz3dAfGk9P8mLvtG+ZOsB?=
 =?us-ascii?Q?ikiX5KRAyWriwoTinxyEO+NY+UcgqS9BdkAQmbWQL9zF8iup9+pJrKLe7YGK?=
 =?us-ascii?Q?svxgrBPgh4aGMhe35N7BRXHqNhwptOy0LyFlh/7/9bIBJCox7s8NvPa6jJ5A?=
 =?us-ascii?Q?pu8JQEO2ZSIeMaA9UNDT1hawisfi2CnHIc3k2lXlL+wBadPwUcGBSFRoIXJ7?=
 =?us-ascii?Q?ZQNkZ+8FhjUXmxotJ9o+BYq14ThKPr+o+/YPqcGns0oQD4aFdaTy1lE6iA2m?=
 =?us-ascii?Q?bt3mCQ9Hj8gpnZbKoe0hJE22HicJkuq1ztCCJr3nvGFXS/OebRl0QyGEofSZ?=
 =?us-ascii?Q?0q1Ut1NR0jkLMBSsLGCBOr0h6SddwhvEDQUyOvKKAoDdSB/Phkxm2wj91CtN?=
 =?us-ascii?Q?mzMIoN4OgWsqp65kJ0G705jPzJ7zU4lZusMynjeGHeFOduMbSZxtA8vK66PV?=
 =?us-ascii?Q?hLDE0ZDJFFlSaVuwfJxsA8mbLi1A8ZNNXygIh9D5Do7PN7lA24CfxU8UOdE4?=
 =?us-ascii?Q?QJq2UrKylEknWsvjY7PEADTzmJZ+cNgUy75gVTQmlB+h2x+EgTbwKWskbAXJ?=
 =?us-ascii?Q?NQK0NiGgsdc4AmaLeXWXqgxJNIm7jE4Wg6Mg/3OsR/tAxZEo9mF04JMLhV5q?=
 =?us-ascii?Q?YT+AaFoNoXrtDMRSElQk385W5qUH+g3/oqWuWk+SeoFFVualXDR9FqebFPay?=
 =?us-ascii?Q?JDyeNKlIGmZMJ4Qg9E1dLvqcufuObrxLN053Asd++u3XUM4YJiSS2k43ygzC?=
 =?us-ascii?Q?HFUP/gX09kpIMXm0wqf4Eao7AG0dgw86e3Q77YILV8uS8RNeu+BYR3t/P6Qg?=
 =?us-ascii?Q?xKID1MFBUaXgWbVk0UbdhujIUJQS8ilF2BYnjvLLY+vQflk2ww0a+g75VEE+?=
 =?us-ascii?Q?4TmPgpIQz/PL7sLEDY5p4YseshbQCwcpXhol/5MSM5WlG/LUEkXMMcceSWsf?=
 =?us-ascii?Q?IvdyJUKZcrrtpfwUHR/XvfLzgXjqFq81V5kOpb2G+szPLip0sixd+HPxt9qu?=
 =?us-ascii?Q?9AO3PA7KDpKt/f9mHsxKCrv55nHvTfSZSjjoCdVhm6/2CbB6n+vXGWi3nyo9?=
 =?us-ascii?Q?xGu/paAQnT6C0oZbrcUYc2qKUfJn6P9ZGlKVX+xud5m7GDka2xYdyJKewwvC?=
 =?us-ascii?Q?7ViyBj7XIotjtlLeYeLJUW3F4wIZR1F9I0EFVTodnpzXThAaAvi2NoANZp8V?=
 =?us-ascii?Q?m4vUkiOurOyQo386FdvgegHPCn1zVb2238SdFB1/VUWQws+G+QWtBxi8p/4R?=
 =?us-ascii?Q?XnHV002F4QJ/RF0zts3Vm0y0at4P+Xg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6164ae91-b6a1-48a6-57b5-08deaccfa502
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:36.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1ZenrUPjrbnankXy9qQXLZlbGzL2EBvl8ysJfc6X1rVuyhzghhDq0K/SDomrP74YoyBOQs6tP9uU26IQrGDSmmEXbqnjaV6I9TSToB98Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 898074F2C4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7573-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:dkim]
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

While reset the GRCAN baud-rates are preserved, since GRCANFD has the
baud-rate in different registers we need to add saving of those
registers too.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 6e0a393785e8..ccf4032ed642 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -528,6 +528,8 @@ static void grcan_reset(struct net_device *dev)
 
 	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
 	grcan_write_reg(&regs->rxmask, 0);
+
+	priv->hwcap->set_bittiming(dev);
 }
 
 /* stop device without changing any configurations */
-- 
2.51.0


