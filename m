Return-Path: <linux-can+bounces-7569-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAxaA82K/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7569-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1E4F2C21
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80EAC3063677
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D7345CD8;
	Fri,  8 May 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="YHs6haWI"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021139.outbound.protection.outlook.com [52.101.76.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137771B6527;
	Fri,  8 May 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223712; cv=fail; b=WAbd1aH588FfZsMzqWaEfYRPMInTe+CN584iNQRwKiTYpJv4Rh78JjN1e58zJWeMPS4s5zJkOG53vJkWndBtPc78oaURedl5noxnecaDVJsMVqt5AVJxF6ZZFLWy+L9QKVwSAJ9QhpGiiGRqCuE5ubQjmJnF+LpqC6r9P+Ze1QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223712; c=relaxed/simple;
	bh=Y2YnclN31Y11o/f370dWt2CkcvwhRa1BleFTyaBumFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMaCrBOrsQFoyadLfOASampXWAsWM5GuGwcHjmdKaN5tH3/iVO+q/6VoV8OwEmU5fpgfIUy5NaRhGFsvT7xDpI40QsAPBBHRhkqZU5wL0EzbmNhOJ1E8UvFAdG9w4xSa7ZjMYOqtdjtJLbL2Bi2gG1FoxkYUHIbIkjh8scrBIcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=YHs6haWI; arc=fail smtp.client-ip=52.101.76.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7oQUiKKxflaQHFR38khyl3nxoFGu+eXDHln0gXgFPhkDIffuIJuMLm0pGWKNUKpJNwPEF49bjRSwImWYZmRKdTNQ9IL5ssqPg1g7vK8BJNPpbE7xkmFaKuazmhhPJSfkumrJqfqS/6AOIZ4aTvMqZ3boG3awu1fMHrf28Fof+APLF0HXw/ZPrXLbXjd45lobnjJFBr4jXsJGdOZHCxj9hDsbpiV/xM9UKFCfGN85D9dDwkhypSmtFxIkEbUIJcfISr/R/PznLoMOD87JFfKxloqMI4s1uy8ofGsXZsmxefhE4mNMUYnS4v//gM39uur6Sjgd4f2aqoMBNrJFTEv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjezKLMwKyz4V/jypTMtZXeabjB6bJUTtswONRYhbRs=;
 b=jjR3n15AVX8Ht7ACKBh3lAzWeTB65MQoj3BF82wT6XKcJDP7nH124O6uXMx3meI4kRiYPwXDEcSzYq641Zt5Vl75x1srpaE1j9I0uX578x0aVg1Mk+EiIYJsiBlMFNcZeCdWietIv0SgSiBATSs9pWLCpKijcVgkSPkKuYq/nAfDYE/SsO9TpXEh5li++fGidSOr23s/No9WWnGE2CkFhq4X6AJ9vdVx3x+hcze0xeOvyrh/DRwQodzmLSxFSIxdLCqMnyzvMuoG8jH8a0qWsHyjOe2nu+d7DTdDYoa4/x8CJlAa1dpTnRTxH6Ihm5DxHwwoxPTs4EnH2wQnOPa9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjezKLMwKyz4V/jypTMtZXeabjB6bJUTtswONRYhbRs=;
 b=YHs6haWIfB9fyBsFOGJeb+pDyqOjaORFsBRZWVASnXCx6qyojqgiBAcSO1rzgZZndH20fH/CaFdtj/QwkAssgG/3aVrbOCyLdcPD9GjJUhQSnmVaV0Vcxdx6iaXWEodGT9PCQKXY3A3a6+buFlnDDFCBtaVDh0sgMypqM9YLPElGV0iPCNoWNwaJ7b+7Jl9JCYTJqzrFbZgI1uOYGtCbYwoZK7mQ83GVFxo8KG2T0fHiBkMP+DwVVLh8Bps7bU+OO/1edvcaSid5pBsHijfEmFZKT8l0GlMe/zIAyTf4zLYclNxmH1BOA20EQ9xPM7aFrNWRZUxUD+QXzDHiwmskXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:34 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:34 +0000
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
Subject: [PATCH v7 05/15] can: grcan: Replace bit timing macros with literal values
Date: Fri,  8 May 2026 09:01:11 +0200
Message-ID: <20260508070121.6918-6-arun.muthusamy@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2f3e324-e151-4968-3592-08deaccfa417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TLKJIxnNochP1EBB2UBKYuFVhLIQyRX/AacB7Ew0J0z4040jmxVEA/DdsRGWilgN8lBDgktwmqmibREMsu2W8nYNvsfjy+PXzp2w2fe/mbkniBs5OAxVZbC3rObjG43DGEYmzkmOez4m34wYkdLj7mdxlzU4ywItmL/ciQqhRzbJ530lkVSP5Qk26Cj0+CU5xBUWdSMtcUiVfHzkKjrb8rFJIuVsbk/V5PRuk6ZUGHiPMcFE9zq1BHlQY6ufYALya0ggdGTj3t3rUbg5FnTBm4yDYhgq8mybhJKu/VCeUsgH/7kw7ZVHTyfJE32McyaQoW9kfI4Qq72IZWCzWtsRbRmJr1FzbLGQPkfijS7OiHbVQow6BsXZ4559RiCGoqDXLffqJ9AqveGBr2c26GxMI58iPLKQ/tt/qR7KLWVk+AGl+gsrXebSeX37GgsDSzQSPwQoYF/qsHtU9L85L5XriG1Rmc6i0t+T0GRldUu3tRRbKA4eVG0g25Ii9XmnDJvPOJspoDoSlTU7HjXtuXTcwCw6u1ZJGi+Mu7W3Q22r9vJTFRP3Mba+kzDBJg0GSJO+eaLDqJy6vSaNbSYJOSfqasatQUrFL096a8PkWWrHaBKm/yUJXpbOfxLgTYL2EMOxI7BfCAp+slRuy9sPg9hrv0ZlMyh3+w1zJAFWtHSVuBny9zT41giw924I5YkiyURrusU9dx3dGDcXL91Pfy9z80klmvIWKUh/z/s8DAnB+uhqpFu2BNegp1HBKFfdpIVx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjQJHIJ4vrv1BwXA0KwWIcfUD4zKM3jRn9YYwDrt4bJnrpbOz6uLQ45E5WFY?=
 =?us-ascii?Q?k0FO42VQuBteYoQGd4tWImynm0XIWkr9chp7oEC9FDFXEs6Av5qDN8XPINTI?=
 =?us-ascii?Q?KAERY+Am35I/YG4oW3iIAKLLU8HdZTuaz1yqNL4sstjyE8j2xIVMWxQQk3fT?=
 =?us-ascii?Q?/mXkZaoVA1u93vd09zVFCSV22Ww98qfpJDbT3dVYFaeGdIvcq6YlH/jNNtyE?=
 =?us-ascii?Q?FverffAJD9ZZY3fI1rFr1BsFjkKOiDDl/g1ZYrvJRyokGWCTgHM9HXl+raB4?=
 =?us-ascii?Q?QwKhyNXUVa+xKsjMB5qwq7VObcmAXsAquzr5ceZh0WFGs4yyhkQn6R/rON3G?=
 =?us-ascii?Q?/0S1XhcA3EyIopR8gcrXpDVSizHXFiDYkq8MmBFrVnCXRPdffW4PcMYIT0VB?=
 =?us-ascii?Q?cW0mqcq/ArKlpLwvp59IlufNfOSZepqpA24L4DOUu4agRMseTUf9m07Ew2nV?=
 =?us-ascii?Q?ocp5fETiJcg9ACqmHpJtNF8uvUqq7gZeewxqeXE6SMXzJLmabgWcCJqHdPQN?=
 =?us-ascii?Q?LHKpFA5v/FwI3hbnry1TF5zGmi23KdcfKJpBPqw8Ntcd+JIXUhv4kg/YIIrL?=
 =?us-ascii?Q?TSBZjaiWOpALVm2YX0tRAoZ7Z68bhDMiCCaowlP6nCinDIZG/Sn6fnlK36CG?=
 =?us-ascii?Q?7Mt/wXvMAa4Ufw84sn5r2da4j1Ks/ZLjaSVrutzb/XUu5qw+Anh9d1KvZmyF?=
 =?us-ascii?Q?uc2Y6Uvnu/lwlUSx9qq6gozPHQ5ZSwgJnWsWOarWQBYh6+F4GNm1atVx3Un9?=
 =?us-ascii?Q?4KkNc89/sJcrGFtIjVATQwdsXFvbne7+pD2gg1klO4CT+N21O0ghE9+eHysE?=
 =?us-ascii?Q?nS+QO9QvbzRsFrO0erJj91cqasNcLJJ4CIm2rdYmHGf/qYsE9ch+/tVtXKVr?=
 =?us-ascii?Q?Uj9PKuXHd7SPey4qYiX7TlDNOXKN8BUi+m9wjX1TsUk//zKHpx0LjTEPEwPi?=
 =?us-ascii?Q?ZOqAERvJ3H4EHLvrZO2DSFidrnNN2v0M+acrlQoCdrMGoMTPk9w8/cdF7R5e?=
 =?us-ascii?Q?hrAKN+zjKDFLaMRyFxDvt/fDcZpDN8+8jwov1kjjISDD3Dj3yndZOVPnMMUT?=
 =?us-ascii?Q?crr17QJcFZrGCcUSrXuZ0F0OpbscvXjauwVayikx1zOepXwnIO1xlbYBjwPP?=
 =?us-ascii?Q?FBLtI2DU3ZQ99LqxQ14EZ1fvdosUN9laWQX6ZMpaHX220OVsNnKLpVl6wgMC?=
 =?us-ascii?Q?FSch2kavT5RYsTccsvB8IoWLF8ZzeDv9pzQPqVXNHjS3woksQIEBLKwVYKvn?=
 =?us-ascii?Q?ZRAO6f0zAfEL2hO0fA2355VmSUmNwtfHftIIaPdEq9DH4H1Y0abbLvcTuRCP?=
 =?us-ascii?Q?2/ZlFj0C4HocvDsmp/vnrFQDV4W3NEKTTASUkicuJ42rqC3Lh9LOZtFg4nH7?=
 =?us-ascii?Q?Qs1on7pSxUWFZ+UroN6j+C/CL1kvQnsNsAfPo577vQwtSp1f6V0VWHLF15U8?=
 =?us-ascii?Q?ImqTXWmvX1avhi7pil5ewlR1Uo1gM/4uoZJtW++TUP2CauWEO8HYnKFZMyut?=
 =?us-ascii?Q?EtwIk6KJ2VySZctLSnN3YXbM7jN8kDKYg0P/u2uAVt6Ka9YVm+08eDZvH6AI?=
 =?us-ascii?Q?klTfNeSn/TMl8opvztoxFROXbSBo++N6VTOyOGRSUJV3rWAiERO1FesczQ0t?=
 =?us-ascii?Q?NKp4hTQprYGlucYZOdNHCqKOcgHQmRr5M4KN8Cs6kNfXVKhJMXv9G7b4bY5A?=
 =?us-ascii?Q?XEANvFA9idZAR0+f8QK1EwenAv2aGY8fyfELvAygkxF7zv/yqFjU2bR8l8i7?=
 =?us-ascii?Q?wGnaLYskSUp9S8KuryETAdbrg5UCwAs=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f3e324-e151-4968-3592-08deaccfa417
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:34.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyZcU7CsVFdXwZGQIFB6czo+xG7QAQ9EJVilTASoSW/cX6AiXFLqOaZwelKQi4bbET8yBTk38TkHeM/dQnDxBxtpmv9AAnOrVjUvq4qp0XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: A8D1E4F2C21
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
	TAGGED_FROM(0.00)[bounces-7569-lists,linux-can=lfdr.de];
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

Refactor the bit timing constants in grcan_bittiming_const by replacing
macros with literal values.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index a5f750d7e2d8..8d7bde1c006f 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -36,6 +36,7 @@
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitfield.h>
 
 #define DRV_NAME	"grcan"
 
@@ -93,16 +94,6 @@ struct grcan_registers {
 	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
 	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)
 
-#define GRCAN_CONF_RSJ_MIN	1
-#define GRCAN_CONF_RSJ_MAX	4
-#define GRCAN_CONF_PS1_MIN	1
-#define GRCAN_CONF_PS1_MAX	15
-#define GRCAN_CONF_PS2_MIN	2
-#define GRCAN_CONF_PS2_MAX	8
-#define GRCAN_CONF_SCALER_MIN	0
-#define GRCAN_CONF_SCALER_MAX	255
-#define GRCAN_CONF_SCALER_INC	1
-
 #define GRCAN_CONF_BPR_BIT	8
 #define GRCAN_CONF_RSJ_BIT	12
 #define GRCAN_CONF_PS1_BIT	20
@@ -392,14 +383,14 @@ static struct grcan_device_config grcan_module_config =
 
 static const struct can_bittiming_const grcan_bittiming_const = {
 	.name		= DRV_NAME,
-	.tseg1_min	= GRCAN_CONF_PS1_MIN + 1,
-	.tseg1_max	= GRCAN_CONF_PS1_MAX + 1,
-	.tseg2_min	= GRCAN_CONF_PS2_MIN,
-	.tseg2_max	= GRCAN_CONF_PS2_MAX,
-	.sjw_max	= GRCAN_CONF_RSJ_MAX,
-	.brp_min	= GRCAN_CONF_SCALER_MIN + 1,
-	.brp_max	= GRCAN_CONF_SCALER_MAX + 1,
-	.brp_inc	= GRCAN_CONF_SCALER_INC,
+	.tseg1_min	= 2,
+	.tseg1_max	= 16,
+	.tseg2_min	= 2,
+	.tseg2_max	= 8,
+	.sjw_max	= 4,
+	.brp_min	= 1,
+	.brp_max	= 256,
+	.brp_inc	= 1,
 };
 
 static int grcan_set_bittiming(struct net_device *dev)
-- 
2.51.0


