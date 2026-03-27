Return-Path: <linux-can+bounces-7265-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D7AAAzRxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7265-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:48:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3534923F
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAE1F3037760
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79DA2D839B;
	Fri, 27 Mar 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7914TgK"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C426560A;
	Fri, 27 Mar 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637319; cv=fail; b=ABFp3E2noovtY+FcW4yC4wZOKZgT8d2ME3fL8CLrnkUWina+rNsQNLUlqCZ1A3v1QIUO3jGJoZ+PCF2yjBm3n7rSaA+aHb3yBJF+sMVRJrwgnxUAuWyCAzucaJOB3LiePBLSxP4qNnW9/q0FVjOmda5LkXcPz4KFLb1XQyGRzcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637319; c=relaxed/simple;
	bh=Q1M8g9CpctU0nnIOMmpRSKOiBBfoN8cGcXCmk8dreCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uxHZiwymcPyKpFisknLuFE7QnifKC/anFyjl4NZOkCMzCz0EKz44qdZ7OU/SayWV+a0CcUWSHknDSZusaMwAXPxfEpox9lU51PIpPAmLXD6bByPPlnN9hdnBBm3gnI1z01YkVXd9fM9sUQcfN5veGwyrNTgVBx/BqeAss/BRxh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n7914TgK; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5PoWEX6EfPvL3U6+7Ensc60XX58LqXrkiElkT7wBy/7Qi1IqjT/XMz5dAqNd3K0CLeQxKmXZ6yyPdesjitGBbO2Im2B88td6VGqcQ8/DqhFvrS23q813tQqdU3KE3ShHuJjrr+AgriFlwPYd1gGhmc47CJ44bORwGbHBjW1rA6AgM1rJ/mleFUekr/RJafqdJEMAHU2Ri93M/LjFpzsVcwTu/Iw3qwM+qR+DCydx6Kv+62anCtTaXO36IsGQ3kgJsmShLw5Xew9vpO4dcQEgBkru04mZpRZeiw3e9JxKMFK/1S6ZY856tghC6Syi3F2Wm1wYG3mqcvF5imrPOrzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogJaDcCH4q7Fssvt91vOpovPL6sWI0u1UMZ/IVso944=;
 b=O7PBjkOAIV3MigLLi4Ry9x4mRCIQqVqPgELw/KQDNF7bwvn5s+RYvHG6rM85SaZpVj0go78B3AiHpr7coLlJOXIUPmwiqQ6KTeGhoak35AjPxnMFcBe05bOVEEczPv/FIGVJBXcEQG7BX+sbdD8yTrjQU+5d2ebzlnm7oVH4GcA5p8dFJVV58lAi5YnVp64ZRSqi1ou6pVz8fMLHzTPG0mMm4Un3LO71XccGdX98uYF8YNmW9zgHNzSiVgrG3HKrGMf+6O2ySAhzJh9SoG8hquCSKp528+gNJ2AwLUBhVNgDisbN9SznaklxLGNyTnREatp+kVKcNnvtJKitsk64oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogJaDcCH4q7Fssvt91vOpovPL6sWI0u1UMZ/IVso944=;
 b=n7914TgKtpGaorbp4GA6Ad+VBEUrk5FSxeJ9DbnRI4s2in/tnr2S218L95bShMTd2C4h7UN+StEaSlp4TpFloIK1WeRJDS3vf2w9puJ9xTN7tk7g6Pj2kM+vkA80kqtigENLNHaQZYsyRO5hWlBKlvGU/GzS83t2WeBIIoqY5rRkl6WsZFDTNy1thabE3yWrQdrjB4djCwb8WgkEDettVlzjJ088tPlrLwUkfm8ECVVtIX35TEco3eVsM+nbOCGzyj+5BjSrcED+dW59yBMu7kgI1CazgeNYDmRtI3/KwIHqfY2Skhc0t6PundUjWZn6eU4DseXuK+XKRs5lsjkOmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:34 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 phy-next 01/28] ata: add <linux/pm_runtime.h> where missing
Date: Fri, 27 Mar 2026 20:46:39 +0200
Message-ID: <20260327184706.1600329-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0072.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::25) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aa62fd-d0a8-45be-543f-08de8c31730e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rOSNIO+PXtAU2KSXs5Vl/TB/4l4VBc0m6r/C692mE4qBXcQy3S2YAJdkMnGvezUGZ7ETzYuD1qq853BTDnYd0lIr/iQViru+tJCc09LkvWs2HKP+4ru9FCKY3QMT99s74s0e3niYR7H38WcHPVZVfpfMp+bwmC1r1CWe6YyTZ0/Lx4tgYd4NzLDFBuXA+b3/1zkbBTYSq2RgGyN7cPw2tH9Ly+HEuxPi88WtziFghNSzjhE5fALaM6suWjfMTh7B0pTJhnpBmx3ks4FRKZYT1L8nYUjNtJ39VAVKBkyO0B93UrLQd61sBOC7R9PqRp6K4amSlDHtbBWVF2kAKcYwgYvhoyx61o6WTcNMY4Qw5VU5JVadGsITlpWjq18MYOHpOOtatGb7JbO6sMokpYy6wuhYxLR4Lbu+uvczPtBLMhitr1GvRL6WYrM7TItm5yNTN5Uw/m/8xI2IJRwl7IX6y4UuXBPsywvSbZVM8AMxC/irvnPJoMixW+b6xnrtrSAf1dG7ht8WK2eSksBPGQ8D2obhW4r+VvWhMFYdVnPzBMjwrorxSi/lgBssEoqwBkg9p6phyCS4XtNuoklBXtnICzj6cVzGFN1fZ6sdB3IgyqutsFRYEXw83wWl/jepzutOuiiqldsM/oenHEKwVehMTftqs16+F6rGtyXmvzTkriJgh9/sLTeHOUUji+zWDGVb0DX/v9dWIOJK0UDls7cjw5/e3Q97zZzHAbS6OSVtAik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQCZwwDasW9WMFiQ35NZfFJbZ2nc//OJr3TIigu+izvG2n1in4ePR8qorW26?=
 =?us-ascii?Q?72VPWHkLcOuceJbrNrlGB1J6aqXacy/VCe0dvrkc7JO8PU/QEmNYP82llSfQ?=
 =?us-ascii?Q?EZABspUZgTOok+8JtVygsYiwllDZesopw9z14xBOHwTKxm5Hv8+S8aIlW/HY?=
 =?us-ascii?Q?DZ6fp6hGpoFdW/n2/vlvOeJHflZDhqufpJN0me3YmsCpg3/TSp/XKl2sunNn?=
 =?us-ascii?Q?+rOng1/TguNR71DchxFYCkLRfQ3KAxY6u6dHeQnKj5ttW/1WNt5nxwhIoV2Y?=
 =?us-ascii?Q?vhLnjtcS4cSE/a0CgEYd7fC0GhcUAF4k2jCkbH0PAqoRXZ4CIyNPx5kZ4bmf?=
 =?us-ascii?Q?7SBMOyn1gsDIq6VPEh5SCzhEtyWz/VZ6a/aC+r6+BBr5+uYaOouGrDoUtJ03?=
 =?us-ascii?Q?QVR9RLajcV1LmbVERBkIqNPFaMFxQdIObmAcyuNJI/5twXKcvUc7OSLDR308?=
 =?us-ascii?Q?cHJQpklI+rtyBWFPVKsH+LOF4yscJw+n2d3bAVgbQ7Fw64oSAzQQwL1qhWgl?=
 =?us-ascii?Q?Zq395r/yQaxom0dhXbn5W0UE++FvzUR0oMLuPFoi0GlXkeqv+LCPFVuPK+oo?=
 =?us-ascii?Q?3Vwd5TwufDYKN8EXkYo/7l92I81MbxajWq63q5vdmqnEfsmGnq7VD4lh95Yl?=
 =?us-ascii?Q?6R/OwL49/kdXM5CpAjAG26yXPaiSnz+ICwNS9994tUaaORCs9tzlCY0gHhJ5?=
 =?us-ascii?Q?j9yl9+OR6lr6rNyUL9/LP84tTyx5zcOoewSOMW5M+BpJ9Xig4DC84ix8jkZc?=
 =?us-ascii?Q?bogWi/cG96cs25niB1ISWqsuNnRp165e1f0BTiKCI2L5AcxMWCTNBhFSF+BW?=
 =?us-ascii?Q?3PnYwj2WxJJwpwRrU5hg8r1ak5vp50KriIeF6No/y380ywJEbr90M0fgvv+b?=
 =?us-ascii?Q?DGMLwnKbGGS1lT08DuXl1uo06WhZ23j/u4X1LR9BqPx1AY1L58oRhq7DgcpE?=
 =?us-ascii?Q?x5au/hwjGTDWQjmrhog+VLkhbgTOeEQiBjbw4Cs+kqdm92AjxunbobiqC9e2?=
 =?us-ascii?Q?j3+IWVV8XKr9a4pAQ6q2oSuwncPl9y94CUJrQ9ZtbJU5XxQTOSTKmlM+0wne?=
 =?us-ascii?Q?0kK8TZcc64B7JC63fjX7qUEsI70SQis0D2kToVSgAM//BVmB0Q1NBira0Dxp?=
 =?us-ascii?Q?cfgzWaHwXcJX8uCAvAK0swc4BbgJwpGUbuCZxqP+cWEZIk3xuXEEXYg8DYoG?=
 =?us-ascii?Q?pB36eR9P7+TnbjzF0yjVmZd5qOa2S42TCUT7jHFkBXxu9xPZL5JaIWV07ZS0?=
 =?us-ascii?Q?RGjV94g9eMUYjrhNFrYr+0AU/Yj5+CtKYzmpKc6OoEzfnj8p4o9v0dafCgs1?=
 =?us-ascii?Q?d8YwyA+OC7bwEm1ParUWaaxGTpT7fsFXvDBK1jLiiytBU8gL97aTMuhoJ4GL?=
 =?us-ascii?Q?2/gVWnwKRkTpw8w5t5GlcxLBggTT+BgeaoW6/2UJIoNhwnDUpD1qqiV12vUe?=
 =?us-ascii?Q?+BeskeBzs0k66MVTbVHgdBUy185uo9g8gVNEk+kxTLnav7cKBEbnXecZmqxZ?=
 =?us-ascii?Q?CtU41CW2ATy5+2m8ILq4IrJFndipIArPe7ICzkumagd4mZL7gejFesUmfY39?=
 =?us-ascii?Q?4kgX1SnpGcIYBuLoeYpTKqoDe8Wrfj4+C9ThO86IsYd8g826tythbTQyxfeJ?=
 =?us-ascii?Q?PEfdhGxXBUe8V16lNFlG6zUmefG0iEfWBFkSi6NQQdLOjIpECiJb5tOl6jYb?=
 =?us-ascii?Q?+vh5wk/brj+SVG/xe+3WkzpGqpHSdPz2nwevlSvXSC184ikJQxYcRr1HhVk1?=
 =?us-ascii?Q?UuyvfGJFNSqUOcg7tuk8yFPFGqoEVOt/gQgArp6L1IS+NCXSvWeJjti5iYPp?=
X-MS-Exchange-AntiSpam-MessageData-1: BXtcoemr+mpo7x4YljW4ddDyD1q1iAUgEY4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aa62fd-d0a8-45be-543f-08de8c31730e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:34.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dluCQHfJp/7DVOstV/PSRxCm7fftNX/7nvkD+rjw6VGMG2sz9vQKqA3lO14VO9DvSMRUymdNnsBzV8l7WYIhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7265-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 9BB3534923F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It appears that libahci.c, ahci.c as well as the ahci_brcm, ahci_ceva
and ahci_qoriq drivers are using runtime PM operations without including
<linux/pm_runtime.h>. This header is somehow being indirectly provided
by <linux/phy/phy.h>, which would like to drop it (none of the functions
it exports need it).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>

v2->v6: none
v1->v2: collect tag
---
 drivers/ata/ahci.c       | 1 +
 drivers/ata/ahci_brcm.c  | 1 +
 drivers/ata/ahci_ceva.c  | 1 +
 drivers/ata/ahci_qoriq.c | 1 +
 drivers/ata/libahci.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 931d0081169b..aa3c4949c4ab 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
+#include <linux/pm_runtime.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 29be74fedcf0..48460e515722 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/string.h>
 
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 2d6a08c23d6a..3938bf378341 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 0dec1a17e5b1..409152bfefb6 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/libata.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c79abdfcd7a9..e0de4703a4f2 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -30,6 +30,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 #include "libata.h"
 
-- 
2.43.0


