Return-Path: <linux-can+bounces-7564-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LqwDV2K/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7564-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:01:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C04F2B7D
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29C6E301062A
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD93374E76;
	Fri,  8 May 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="WXm1UE1E"
X-Original-To: linux-can@vger.kernel.org
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020110.outbound.protection.outlook.com [52.101.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF47364943;
	Fri,  8 May 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223704; cv=fail; b=NI1g31/Po9E6v8XK9KMZEwzYiO5WhOiQbw+GotNKvfwkC2SZN246380Xm+4KoIwdnEfVuu4rj+QYNQjcO3/u7wivYMFIJMyV8JVrdwKQmZzhRgHxVCWLo72X9Z1rOuSO6wrD4FVmx0/5V2GECngcBvaHffxjCXSovwVCFqWjboQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223704; c=relaxed/simple;
	bh=iHaGKjbe+QlLqqxHRDlVGg3BbJGp9G3RQ6CpJ6Q/5OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiXrhWZRcYJVmEnOUgz7M3y/MZhk7YNFrTELlo8991ivkTJFZJe+7tAyI85QgoDaOnwAGmtMcWDTjrkUwmnUf19JqXAMOIDXtaujBJEWuIIyl9ynqMjBT7l45oyDeMOlZYJ21vt3QyMb4nwxbFsWbdgoI2HEiOpecSIli8Lt8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=WXm1UE1E; arc=fail smtp.client-ip=52.101.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdAn/pOIb5obxKJrhtd0uLgJLJBWwig7IqjMwjQkfzuCDNheF3FyTgMxgoptTTti0WVluO4OMfIhG48reEFtSPdXVIy3EirETt55amUIKHxh7fZHR4UYgZeUOu99pTx8QR4tpm4FF2CFhkcQD+6l6mgH85lYcQcFyKE1tBpEuQtdCyiC8oOwwHmxpQEgReikqkXtnOyV8xC1pOyYy7tTYyiW1xa9LcTrgOWJwyizcW1g33RoTHqeBhNOIBrNj7bR903vgfH0+p2hjiSiT7V1jmJAoA+gjFrhkNYsC6Dcke6coRckI8fLGyGb9ME+OivWHD4Kjrm43VTlVAXoXyZjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib0glqtaDPjZfamUy1qCbdjc777gfEQHnGzoalLfnYA=;
 b=iiwfa0jOr5+77qjsMcOWR0KYpUnFixEPcu5wVNTwr2bmVmgRnjuGBPHg5D3fWGIo0nUydB3svDswSKz9PdVwFH4+p+mTxnUvBw2/cP8bMyzVbwCVZb5TL76ZLkXnmH2InD6VxQzk/nmuWc5TwvVvpw9OZAfe9okYGV2AXYdbQGyVq/9XKSr6sDf+/EGjk7R9jN7UzlkR0zfVNog0Nbd3rRJDK0HJnh9YErldnJECPAWlaCHQCHQJi+Kxmu+H3u4Xs+/ODzvhc8Exu74udPtjxTe0xdPn2Vork58QTeRebxlgGGeUvyQtrPTiERHBZTCN/JMqdQGYfe8rGNosFD8Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib0glqtaDPjZfamUy1qCbdjc777gfEQHnGzoalLfnYA=;
 b=WXm1UE1Ed/CHbQS8OPXS0jlOBs9GL6oIpqt3ySIym5DLWIsnxp5onZ0ADTfHQeon2LfvlKclj63S0A7KNe7iYr7wdu253uts4S0bYSiy4WC4Xx0v+O6rKHnM0PumIM5ijfqxUqGrUQQLd2AwYV6b1WhjLTAaF7NaV/r9PBN83PhskI9NOaIFJwY6ibhLE32QolZaiKOcevSoF9CU4Yo9mwOvaKN0bob0j3pPQf0KT9qAhTcjy9f0QgdDfhfKcaOiHBEBdnHqGicEFigkUFuExRk4qoMXA90Q5uZe49QfAnYj4IrD9VN7xl73T0wCjRoBO3bQ6wlSwVy4ajsN/n3QxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB1876.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:33 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:33 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v7 01/15] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Fri,  8 May 2026 09:01:07 +0200
Message-ID: <20260508070121.6918-2-arun.muthusamy@gaisler.com>
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
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB1876:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e32c73-f138-4e63-afaf-08deaccfa323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H/v7TpgYWQaj6tI4zg+UvjgihX50hd3wU+4Z8IdPxudcyPvs1V7ZeC2oO6fPrtroWYqTxxMnDjIjLxClCBsa97Bdnq/mLYLwItnQ6sRhFR9YedfvvXzKulrOJzDA7VjBSCHwzf1BgAX2w8+ji71fGG4YpE1VTxKfY2EAI2SqFgFMqNtCiziKSPyIgsbLBdshqAWDdnfu2rmJWZIvr0c4ywEokTbkM6S20nTHiysp1+YSgMmIGGuifU/Km4SdPCcb6kZNWuXtXSs+1TuejkwWZ73iZzFZDcNe3I8/1FYaobGJq/qqkn46V3WYEqahlrEWbWCl1hhlb5cWaIhMU9Jl7KRiJNxP2W1+Ili3z9RVoXILh16Ym5+8Dv6ktGpTqhFvDobossC4VDfOeWS1lJndsAktm3MCMt8TTO+JeY9eHl+XvAMU6E1r749eQ2QVJ/vTEGBZwuYo6wSugF+Foq8Gu9T/qjOGDEWKS5S51ieiljtUpF9I8ZPPSHeZte2hgB8apMc4HiCI/K2LdXmNfHOb28t0u0UYF+A7jY30//fhfEU0MYP1AhloqrFqiQY8H1KWsGwUHosluLIXrkXKwnWkXuVs88rXCdPLbP5hLt9MpJFbWCrS+aKkri/+7Fv8x+RIE3gNmkEs3LkTpa/viuc0ydVPVc0RV9V3XD4YMy6XLSJLOxi2Fk/qg5eQGZNvTRaGYOAw3316oBbg3gduGhf3Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylV/op3gf3WgfYo4VhOoRfhd1j/uLcrHsStbpI3Dk6JWQeOer0eV43E7gPgK?=
 =?us-ascii?Q?18y8U/q8QwSgtnksqMmEg1satcKGH35Adzs3vtimWWM1nFJ0McRGngOS7shZ?=
 =?us-ascii?Q?LX69/kbjVrK22iWJY9ayeP5QM7QombOpoAESqDXOimRf0ZHqLqMrdP9NWT4M?=
 =?us-ascii?Q?sVaImM8GbFlB2XjcACeZOaHtq99MuOqao4Ii7t0N/aoEMO0p32/m+5G3Mvh2?=
 =?us-ascii?Q?Q92/fYglKII7pwfqvplSBffjFU2jHRu4i5vIaqUruwMX6uirGSd2ghinpB5R?=
 =?us-ascii?Q?7Oz3N248zfBsE/LKqNS5wQX6a6Q7AhnYjpXucxiFcEWJXsgw+TdFPXojhhBh?=
 =?us-ascii?Q?yWnXMw7dlDXCmykg0IKiOLOalxuEBfbp1JvPbd3M2xdrlhWU4HI6gqlxFew4?=
 =?us-ascii?Q?CcVUTEy9YQFLCLrB6gS7SZrcHzWU283gCCemjz9l9lH8Cu3yG0Ui2nkKucOH?=
 =?us-ascii?Q?RbMYBrdcgIWOo3SJK/dDf8De8H9rl61sOkm4Apl6vdLRPbtvV1UYwBJZR/Xz?=
 =?us-ascii?Q?lycwnarNlOoXIu9ZjMmpPL3ebaaEWQx+/rz8VOtP9krvvyPa/jrpLPkPZ0BG?=
 =?us-ascii?Q?+Cwacqs5PWg/XgXHiT7r18trp3RmlHTfuHJfV7l6WJb+FSmE7KrmofbChhpU?=
 =?us-ascii?Q?XVcJQSaLgUxpWLlja+JeYUXjv1IQiuAgJbCpBKfuXLtnfY9VghVrdvMMk/Er?=
 =?us-ascii?Q?6ESKv8bbVrAS83sKBBb/9T+2MzyfaX5UPNeL1wj/hvVLPsNpIscdnO3blsoC?=
 =?us-ascii?Q?Y0b0zbUc/jl/X4izAkfdh7ad1Pq65/0oGI2qZPaZuvVUUu7MEgU3GRLMo9AK?=
 =?us-ascii?Q?rUAbmO5PHIOrzdd8LR7K7yO57B5p3N2COpBu9ImnhZ81qr0zaryHfhoz+Rnp?=
 =?us-ascii?Q?qGbTjK1Id+sYU0Xvwg3yMk1t239uAdGpqi2ETvYtDFgw1/vPZEFbu1oMuSr+?=
 =?us-ascii?Q?vKESBdF84ubBVnpA5HslLaM0WlNkRrCqILNxD5fo/8otJlw4ZoLAILCVbcZ5?=
 =?us-ascii?Q?AwNTWsahZHzAhZXxo9luGD6TYs0mr5BUrbUrlGhqSIiPtjEB/cfb8ZaCEKLG?=
 =?us-ascii?Q?OLxEUQ3clow/9fLDS69dF+uhPgY7wGCXR02Ow0xRhSIVturopG0dVP32ZHiR?=
 =?us-ascii?Q?GqiBhuWxGfhkKpQ5KS9o13uqiQRHPfJsFACsv7ZOmG2DHKxLkPWpmWDHOQBL?=
 =?us-ascii?Q?TqXXTmHF2QJ724NzmlXOGhum838tcf0v9bKizZFLzBM0k89Nai2UbQRgTKRB?=
 =?us-ascii?Q?1IyM0QYFpIVN56w6/AijXqs3aB8c0tiu1pO4swJ0SXS0vUwaN4Bjl4BsNgxT?=
 =?us-ascii?Q?0fbw3xcp4af3uq1Rgffu1f7IA0ruhoNU8+1soE2sYbxmcrkj3AMFkYzZQulA?=
 =?us-ascii?Q?iBCE2MFVSQy9r0xmUnY77dZiNmssCGjKldNZvcnNb9LJbBlchxodMlHaWDb5?=
 =?us-ascii?Q?ykB/Pg+8+65qVkmTCPwJD2Oixc8kCXZ5OZiti0vpud39yVrzEs0eRxsIjiZr?=
 =?us-ascii?Q?3xq6dOpKDk/GBbY62QHrMP6z+4ogQwtfbx8IUAPXWwKIaY3N2DKFAxm2rpCC?=
 =?us-ascii?Q?fskBDITDBrjd9XFxjPGqcBEOl4gULXQXsw5IZNjjtMLzeZatH5pQfi99vPg9?=
 =?us-ascii?Q?5eiopVL/v2TEay0YjTwR2gJq/BLTm7W7pHAaMS8RrhN7GC8JLrDA6Gct4W70?=
 =?us-ascii?Q?JDKXZir8KeuDZwBxXFxoal6Ic+rawx3GS3xMhyDarAqeJ7TjSI7mlB4MHa6Z?=
 =?us-ascii?Q?rapPnWmJRPpAlVIgc11Odg7CFjUwIGs=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e32c73-f138-4e63-afaf-08deaccfa323
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:32.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfL+L+L0yuDuxYoIqIGNYX9bgM7y7ueD9ChG0GwPAmqstt50UCPp3+MlBAVIplIDbNzOSHom3MqpdAVy7dkgz+VGtfn6FsKrSyGwllEDIVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1876
X-Rspamd-Queue-Id: C15C04F2B7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7564-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:mid,gaisler.com:url,gaisler.com:dkim]
X-Rspamd-Action: no action

From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

Frontgrade Gaisler AB provides IP cores and supporting development tools
for embedded processors based on the SPARC and RISC-V architectures.
Some essential products are the LEON and NOEL synthesizable processor
models together with a complete development environment and a library of
IP cores (GRLIB).

The company specializes in digital hardware design (ASIC/FPGA) for both
commercial and aerospace applications.

Web site: https://www.gaisler.com/

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..d70ec6226f0c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -610,6 +610,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^gaisler,.*":
+    description: Frontgrade Gaisler AB
   "^galaxycore,.*":
     description: GalaxyCore Inc.
   "^gameforce,.*":
-- 
2.51.0


