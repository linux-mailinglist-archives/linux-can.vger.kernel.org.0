Return-Path: <linux-can+bounces-7168-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIbEEJl5vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7168-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:32:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C462D2FF0
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5483088224
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C79401A26;
	Thu, 19 Mar 2026 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WPGK3avT"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6E29BD91;
	Thu, 19 Mar 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959573; cv=fail; b=EdXM4spo9bNTxBGqrn/8DZuDC9sNrXutFCwNF7l5WC9STK+EPmG1rmB+LazBGJBDF/+GX6gDwlYurPE69MlbKpZgXUs9eS8H5Yhmrvb4cq/TAkFW2qaajyVMcbf452zaO+pSKSUNUTeuzpeZZdjlgSoSc7S4SmqIneTjmGjM1Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959573; c=relaxed/simple;
	bh=ekH7md/3BJ11+vzlKRKzkQMljkIz9ct4npkxuiYfTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXB7aFUhx9D76w444ofmIjsVPH9JeN+Z2y+67GFTR8DswzNdF4B9fVSkKq+JotcDpofcZOpdqbWIo2jvbqTN/qknzETTNwMS2rOYWH48fSied233oFwCXhZ3hqZ1ElCoIm6dZUhJp0moY+mC/knGD6LT7FW07gWcgJ06HKeg5fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WPGK3avT; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXIisY8sJtwnV4659apnzDZjoFQg6xaYbA2PFpbDbgo0fdAvNRoyZ3ZB/AusJb5nLwvcnZmruLuIFHAPjaw6Fm14OKhrD/h0jUAwJ7kjaeMF23MBrJ6F04bDO7VXGMbS8si9bkk+qfI9lYj1DQKHfLvImsD/bCNA7U8bVc7A7AX0i2f5fEXNuLYu3oWrVC6gBRPM6WiPo29Hae/2DE+y3QTgzwt7snD2IXPz8JBublfbEL7m/zD/FQAFczIToFGdOrWC0l1rxLpx8Eqk5zdUqqwMhOod3+lT3qjF/055blmIh9Yva89kBeO90/vQtREPIhglzy2d8MqTfSSvOJlXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp/GfWK69gwrQc5CRDy0/bt/Jc9/I2kE1t3OvSA1dPY=;
 b=EHWvJjo66cfZqMUwTwEqcXTAnD6h2NgRvoYSsRSLntRlshzGic6/wxNzVzmp1wAJbFtQr5PsGsg/2/22uQq/farjMLSR6nUgXznDaIxobTBSWwJTTQGnlUmPxxzUoGDNnIwpxbGvElh/7AhmrWeEywjkT84RcggH9cJx1q2QsobF8XV6jlFjaiMV3Vm2X/Oe+oKcs0yBOskxrQhrsZjr46i7Mk8ViYkiHxKPcV+ecLOMJ8469SpgiRD3VTMxXo3n1C4MV7BJ5j1lJ/3bEuEJnEd0CrsK3ttMTWwXaN3uQ9tji2JoWQiAVa8Cw1hEf2gid0f0GslZCM+ToDYu+e81Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp/GfWK69gwrQc5CRDy0/bt/Jc9/I2kE1t3OvSA1dPY=;
 b=WPGK3avTA/eqX8LldGuG8vZk+h2hhjkZiXsXi9flwaHeTrkWggIIp+jFtRsJMfexhNQrzs72MhZLpa1G7iH7V+3bAfm1F8++YkOu493ULseFjXMIOId8pHUC36l1jtexjHz/yc95tL+po9NFQ8VyygVUAlTCi+eGwVNsFv2cZJszSOkE6uCxdUXkuRx7nR796vKsHu+J5lETNOi3snouN3JorepwILvKoOkFodi3juU4jNQAleTthWUAXJaMw2OxfCBZ9SfNW8c/oVm2NRHnX8dA/IPmtyHCK49u/+bYxr7KxlqFvqNbtt6mQM11O5eKav8ryQUjplHwZA5pKpfS9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:42 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:40 +0000
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
Subject: [PATCH v5 phy-next 01/27] ata: add <linux/pm_runtime.h> where missing
Date: Fri, 20 Mar 2026 00:32:15 +0200
Message-ID: <20260319223241.1351137-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: f991486c-b6e7-4470-c894-08de86076de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ni/LtzVP003250LRDeQc7k67Fn3qKn8coAQ1u9g1wB8sHb0nY8ZhoJlMoqMdOih+c9eyO2I70xQALUFqSyzKBoqZVjAhaXGWZVek3xR8FAHRf7+mA0fuo/uarmZIfXWa5kZeVuw35Mpxt65Dk/6FM0W2tk8LXL7xF8RyT5N5LO6/1v1nR1E15FnhAq3OQx7kL3FyvhucTgFrFAqCL/W+t9nJ6X3qLYPp5b9q6pxzwJgON3Ew3dE9L916L8F/X6LKWcs9HdN3RXuRpZ99zOKgZWa9Fd+IEnEewiZ3pyzW5NnUHVD3ot4Gf0oAvhfmFMlEqB14K6HsrOFy3bk0fu4cnLWypa1krDt3YWT8na5QsDZePkUKxQCmDp5AFSRgk88H0iAkzprdAbSD9EyfTmi+qyuQp3LX46s0GG7g3B7/tKxig7wNkCh4fdjHYusrAU1P+jLJqp7/hlZKUiMB/GLV3Y7WdU8KnzML0jb3CKAgRJ4nQRR0yVGnlHR6iPc3jiK6eClRbAH4ngJCZE23O2Xo7yJr5YTRNGi6gNnsHzH0biUH2jbmOzdldqFfE6KgQrW2m0Sh3AxHCg0G+LZFdWhkz1lcxlSK3FIsDW49YeS51jVMrbpCM0ajrGEB/JXD7cqffRciZAgoqX+HiCRUtp+GkRTMjk1iKoUw/DIbwpwXy4ffGmLmbqhA8segJ2v4eB7e42QRomb9iiyIK40f/tx8XdqcD9mRuRrRx6QbHewLXRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TsDZdn1D9lJJru6e+E/MtjMvE3BsC/eSk1iHJraQFWQFbOEM/tTYR4MD8wgM?=
 =?us-ascii?Q?mvVbPgEBddKJSVylxqhj0P7CHxQnpc3LeSzApeg2iJCBfEfgSzAJtFaWhQip?=
 =?us-ascii?Q?dOnk23E/rccNHpxm44b6SsqPsa6kHZt8JQc/Th3GJGDcHbUOsfw9CmLPa341?=
 =?us-ascii?Q?2PrUp79l+UpM/cK94LfVzp6Tsk5/uvuE0hkA1JDLDJbRsSXIp2uOjQB6ynwl?=
 =?us-ascii?Q?HSt6LOZd024xghJ4koihHSSrTsiguK2h7fAU4eROXobPLFn7kp3crXvy6XQz?=
 =?us-ascii?Q?MGSN7sUEOBVVk5a5xDLMulNFUwWmz0DAX2qJsgVA/BOq+h/gmguBCm02HLMV?=
 =?us-ascii?Q?2lI3k2PtLSushKx86VeGrAVMzp0mD5kuHU3VRRnh8KpuqLcBnIAhgJrXhMbe?=
 =?us-ascii?Q?+0bEwqOgdeTY0U5nqWwQF2tz4yRN/K3Ch21zMSTYM0UBMh6EuyK9KnMQaf4v?=
 =?us-ascii?Q?ITStG1BV0UNA0ntzpSwI/6yDHA5eFhP4xs3zsn8tP9g8rDpdZAEQ1z5s6ja3?=
 =?us-ascii?Q?keLHdKzJzsp7S21YeaTTSRu/HHoeXHDA6TbjbYDzh1OUd6oP9uXWJdR/CWJr?=
 =?us-ascii?Q?JU1iO6S4t1nT7PMRUIMPcvfbFcJrswB6oZCgzZDtZNrGf0gCI6h+muNMEzhe?=
 =?us-ascii?Q?bIUhITd2SMKUhmQ0A8dR1wPI1WaVXGk+swGXYaafG/+cpsBBGGwyUnmSW2Xj?=
 =?us-ascii?Q?j8m0cNJUbUlb+fuNf8DMVi1CRuIBrklewGualrhFpVVyOn2+Mpv2gmA6XrFd?=
 =?us-ascii?Q?iZFBa1uDzRcggBtSYBpPpSnT9hZrsRU1YhFNxGBBzU+CzsCYBIIIkK+yIGK9?=
 =?us-ascii?Q?L4iVbuGfwDAm8XaAet8yoPnGZjoRmyzHRLfQ+Ui2HOhsOCGwooVodj5RZCfD?=
 =?us-ascii?Q?lKVsdCo5qvYXWQN23cvzNd33ocrCsLXOeOaeQ96o6B+s0EZYsHKpTU8zNt2w?=
 =?us-ascii?Q?7rZ1NJSvlnZyc27igscO0vOPhKuAzljadIjmhd8Izf4lCXCceLDiAb1jXdQL?=
 =?us-ascii?Q?0yLY/CumKl2uR6MF8EJ2/Y+14VxkZwR3mMczRSncp/gIcVdKOcF9DZx1N42S?=
 =?us-ascii?Q?zLqT805lVMW/aQ1/p2uPrnUUjaZlUPVKD/8E8uKPtrUXrN+f2L3AB6xf1UCI?=
 =?us-ascii?Q?ZErQq38iy7P3OU8VuYLvjh2rFmVCR7Urcjf7nwjK17yCJ8qz9Qdy1D0vyL1k?=
 =?us-ascii?Q?DWJGgaaWLkLWNEhYZK5dHzgURsPzSDHYElSZL2xv1k+jXBfaXDPdHp5p03V9?=
 =?us-ascii?Q?ijCdmd7miFxuvqg/GPaAfK9hnfl+g1LqoJu/zQfTM3ZPYVYCXkvESosasjc/?=
 =?us-ascii?Q?lzMGSHN9clGnya4yNhkJRpvypO/kzD+Sc80A7OOlv618NqM6LJmPaD5PrXE+?=
 =?us-ascii?Q?bMO7d07FzDfX6fCx/Oy3YPchH9jckG/AC/Q1TUdUbCxxkRYXxeWKU5DyJsZM?=
 =?us-ascii?Q?+/LbwtZRHHoqZ5IQfBO6cehp340Awy7EU44q8vaX04+vbASVAyeP8V5ZHlni?=
 =?us-ascii?Q?rrqeIsP0tOQSi2L7vtsuF9f0fgVk/UQ8kNPWGTjDDQTV5t2y0b6MtXc/MzyW?=
 =?us-ascii?Q?VHV7G1WagDQ4qJ5+AmH9t3mqNphQaE6cl0e4o0wSaBRrw7SOOEu29xg5EPF7?=
 =?us-ascii?Q?0nGZbU9phe9FdWyAiIUk3lIQ/dFzjhd0lS0XT6T4cT27G4YxZwUiElXZFeFZ?=
 =?us-ascii?Q?Pjv6e/gWLxudnHUAUAkEji6sO/G80B3hGwr2xnjwnQLn5AWn0mJA4escT/rD?=
 =?us-ascii?Q?/jlehz+b0JK3NUdtsr01e/frs8CwwcCctMxQGLAiy0M37hlN+ME+XxFPajiD?=
X-MS-Exchange-AntiSpam-MessageData-1: ZlSXl+TlgibzFXdBloOHE0hap3gXQcttSbo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f991486c-b6e7-4470-c894-08de86076de7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:40.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqOrMr9EcZHrILstsJfktmVS8cGgWeUlvtIjyQ6ztgqudmoF1tlGF3mCxYrtPdGTLasGUBrZTX0Md2eXImNwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7168-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92C462D2FF0
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

v2->v5: none
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


