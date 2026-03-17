Return-Path: <linux-can+bounces-7101-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKH/ADHeuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7101-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:05:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE92B36E3
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BFF2305748C
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303B374724;
	Tue, 17 Mar 2026 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k5N2AqLy"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F11C8634;
	Tue, 17 Mar 2026 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788717; cv=fail; b=m98VUYwYuFtp67QeTaPFpvqDxBjbgeT7kcJMdTyOIXaP0qNK3IbKcuyU59jpPycfEmJzEE1iBfvmXwBleQwEHBs/zhTZ4iju93ROSiYUd+5mGtRLgey6brP7FLJtAzD5lb5//uuWLueyECySOkPQhoN317cQZyJmCibafJ1OoRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788717; c=relaxed/simple;
	bh=hPNyFOqwf4V8RFx7/kXBxpZ5ZPN9yy3bm1MCI3N6PU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jbuzXhbYPjc+mXon+pycxyOKXJCV68b99Owm7LA5SLvuvlZLW+ayPMF01psFTCS/TEu2E2N+Pq8zME4+0BN+0A5342ROCvY/oTrKQ2CFiQgFFNZYDVwHbYtAWI6Hh1wLh51lI1xpstBU/kJuX2C6EeAr0yH6amGmhUiz5DrwpdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k5N2AqLy; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYn+k8gV3EQGqCL3mCCIIYAtoyT3A06gzqmU8ftXAT9hinC1e1UWTResI5Mf6s0NrJhLOWCUarV/x/ynuwTz17y3g5HmIu/o5CX+0jVVBzJ0ednCsjzOQePqIb5DXqmCEw/ETAg//aLoqslESSln0FZpI859y7vIth5aPduXLmcP6OQXEUMjYqJKFxLjpfQ6dr42Brs9X6A+Mlmhc2E8xNfq6Y1gvgSUifof0hbWTsf/ATJrHRo3DGjrrv2r7vHxo/X0twjs5mrqiw9YN3oI4Vw0tw0xBTncRMycd3u0rKS+SwJZx97QMq99TlQ9OafG6RamfbY6Er4Pq82qTrs5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPWhNEkrCqRZ+00OtaPJbnAsfNJUYl3B1RyQ7BFHr+s=;
 b=js2cZv7wf39DceRjeL27RKS7Ce4kOOf0QXe0/Bs58TRnRpHp4kss2VuKwTJIbuTbRhRz2oR7Im/L6jVjGcD0E69sK7f5/jwAE1cuFmLYBH8UkhmcDPexrrmg5itCvE8pWhviwpZtihkc3YiJ+pJvRcpgYiJgwVVRgmcScAI85in17PMLrKAK8Qsq5C8byZI0Q3I8MdBe96UcJxPAnPV58DAkoIfAQzZSHJ6GWsSLQXCyW5rhcP4NzGU3u1EHqB2RVqSPXxjZo3SRHF2VqJ5jTP5WqXyWwpmoF9qJngUgXq0oX6i17fiUNqG/KXnj653JFbgHJzROuOsGyIDJ1PywPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPWhNEkrCqRZ+00OtaPJbnAsfNJUYl3B1RyQ7BFHr+s=;
 b=k5N2AqLydeJo1Yuts9MGW3tbhIUcTeHjsQI6b1StuD8Pi96IzwhX61+J630vaWE7wfvqqMEsliOy+kuqYvjNKMjnYVFKURJW2VFDzV94E4UqHLtSN6VRMIpYKdON2ED6O7EOWdYhcdpqxVl1J6njPukXj+E7OPfkJEjFBMnDJRJ4JdreqZCiIyS0tkrjLv0ibA1gQiIggYSutVqOgJqcbLlE6lhaBT7QaAVLs4E0GP35N0YOw94P7XBhq0gLNcWOnUWIGIbbZ7MVwREov3Os4HM95U+PJAVVCvdHAXas5X24hAkQPj+9MsWYHifrwsWkEy9kPLHkOlTWWsbJm2Jg5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:14 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:12 +0000
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
Subject: [PATCH v4 phy-next 01/24] ata: add <linux/pm_runtime.h> where missing
Date: Wed, 18 Mar 2026 01:04:37 +0200
Message-ID: <20260317230500.2056077-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIXP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b37fc59-8dc9-4638-f784-08de8479a444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8K7h0VYCJTZLGONOGjWSRwObQMh3V61aBhMQXRkiiquKedM6Qffn92wPvHrzBzj+I/SomwfSAhKnQPaIbk5blEd7ui5FlQcGDLN9IAIGv40gf6UWtlQIM0fPjUzdKlli3tOHJKBaEpVfx/dcI7FPscU4KCCu11Wmyx26DbYJyBYR5yKmzRXSXofuLWZj7/3PwBB8pAmQxuRJARjvBA9oRhKV/u8BPPrdBbzMHVMZsCaB/iETypjBycXd38LmfoV/tK1Ww91AaWxG6lPzGBUEuRDXwyfyUnmuhG4+dQ3PhUeiOrqA4t/Mks7P90wuC5fvALzKrOue+Uvjtne/x2Xue0k/MhkLDa2EXlwOvj79GzJMZNDFx+hHOB7ApjFcu4/ITanjaP45GoTsJSvnK2xgHfuqipmdX62fd6ZZ7W/0KCsVK4ByWi5WS/M/iKhLhjwC8QFZWSmdJfu3g8/LCK0Z9/h/Yy/1PBHuCfLdAR74/f3ZD566FvumC8fGk3qM4hyMcYI6Z+whVTy6J/XilO+h5LK8YaWMX2t/jME9lbZWd5p8DrOlQRHzYLHhoeCkgKnyZZPlLeTYre6+awDi1DYce7A3oomRF3IpQLwhbou0UUhpK65i5Dm3VkTGmjMTPD2cGpBO/gfFfXPYVo+C3Xtr4qcRbGxB22JK22TqITPojZzkl+/wHskyS6s5rghW1q9e0Cz02Ls5Xi1h9wEvEiUahwWbR2vEk7PFTG2flq5Cxzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Izc5M0BnBMoft74ZVgbAMBoa0bmYi+fRlVWLKkjqRiQyegBVsaUSqTeBdcf7?=
 =?us-ascii?Q?g0ifvoC8MfnYJRrOIgi/sNwChvumtsFEBVKS000xEYZWfXTLlMKGQLy+FlTo?=
 =?us-ascii?Q?EEM2/RNvFHmvsz9tLi487bDyPxnvFMY9z3DvtnkxyFE0W8aPXTmje62ynOA2?=
 =?us-ascii?Q?aqGoeEMCyTo82G0SylwrXkV0s6BdkNJl+1lp13q4wDkPTREEkTQ9QLLOJ1os?=
 =?us-ascii?Q?TVF6bFmMD0t5Igy1lBHX9B1WSmORnxRkCxMi+/9C6jrwHyzSqCcGqakwH+Ay?=
 =?us-ascii?Q?FXOiqKL7HbLlpmfURcN76RU+lgg6U88jOkE7UvvvVUiyki4bqsAGXe27T0cS?=
 =?us-ascii?Q?o1nFYuvDSSxqGnUR5i3pc56APe1bdD/KbpcWicBrORNFBOa1LlaRfVASd/KF?=
 =?us-ascii?Q?uifpr15rjXrdMvup0R54RhOLHpyM0Z0M0DYEP9r1MBEJG1oXYbfGFsD1ej1E?=
 =?us-ascii?Q?FgvsYx6cE1Q6qS2UzK90Le4UOZiZt9OfXonC3LnsrHXwLn7/NSEG3LC1JFX3?=
 =?us-ascii?Q?W3Y86gqWJZ4n/t+cdvDpg/lQEI2yMsDIhH8HZjYmSq3uqgFs6nzu6pPNg2TW?=
 =?us-ascii?Q?lSr0lHr/jZCjpzD80k8Bt6gcSqG16lfP7gys175O2a0CTe9tJ8Tjlvj/UgJr?=
 =?us-ascii?Q?Y4OIdZahIfk0DABgLZdXqjokgtGB9f7nObirzY5so385cM9lWQ53aN0KOC1E?=
 =?us-ascii?Q?+tjiWUot9YgadUL2sM8vXZNGJ4jyN3+zrCpyzkGQEk2P/CMLR/My0zpfrcF3?=
 =?us-ascii?Q?kRJmv2RvKRb2A9rUSPcXfnnMXQWpE9MwQzoHxvBi0XX3VDtQbEoPmr97szmq?=
 =?us-ascii?Q?sOiUbxYddNe/P4BJJxbHSTuBs5gPWaKqAV3+J8YmQAy5YSfcyLX0IbNKfU7a?=
 =?us-ascii?Q?PcqYHbgsldEiJaXy7bQ7rOO6v6zmmcEPV5wNsxG7xUpPFM4N1SIjJmv7lTku?=
 =?us-ascii?Q?X2uNjnvNBeMmIhZWxVBOvc6DdJ7oyZbIiAmnWwfbJJ6r0Az4Mi4MOQtBu+7+?=
 =?us-ascii?Q?5x9H6HXKzFrisOgdYyBeuafLG9gZlJj8HB+B0Zau8eRaL2hkq7/J9PFwW2eO?=
 =?us-ascii?Q?4M1Owc3r03deJwVqS5zJEQ7Y7jSYq+FchFkZtBwbPpyKiYbXc2D5FDHsBcdN?=
 =?us-ascii?Q?4CqP0lNHUDrumOuzZXdytrexYOLjKIKTEOvTVk7N9pMsd1CCZo/6FTuhkWX3?=
 =?us-ascii?Q?CpktG9UKGqL5iqo38+4QD1eMM8n0sodxX3nxXgwOq+AA0neG+Y7oTgAGsi9J?=
 =?us-ascii?Q?b94sbcBRA9+at/xjC6oFsWafM0YRJ4gWf/eXd4q+vbftTe+hiNfJHSLEzJJ5?=
 =?us-ascii?Q?nkNBwjMVEnDbAIlt/zEtwoRBa5PbVJ8XmkMXOY5X/ebVjvUjTfaWRwEsa6Fl?=
 =?us-ascii?Q?y/C53WT4Bx3XliZhYqQaDAch3yFl1vecME1GomtaeQPjuxwLYDbAZqFmNpa5?=
 =?us-ascii?Q?+XjJt6nAIoejSkFLJL3wednWSnmZcODwXFvRcrfBQBR5nA9cks/aTdgv1s/7?=
 =?us-ascii?Q?cGUWxrhZGPjmaP/bU7gUzF5+JfWoZXhzv0A4EfEJb9wN9dW6RP1ofQZPOTPJ?=
 =?us-ascii?Q?lP8UdwkZpCyfMnzB90mxZtt/gC8+1ZKSU8fHm2C+gm/drkfBvcRlNDjBTjtT?=
 =?us-ascii?Q?fycgE68QqbAakELNOXHKLytUD43Cpbgy1rQ8MbQ49ndnsZVcp+ylaf9CcM5S?=
 =?us-ascii?Q?ylV4VUuMU9W7i55UPSJPYv0Yz0CyXi9awe6PRUdbxOvzgytLa5dpdeF/QjFf?=
 =?us-ascii?Q?6FtEIk5l0/uJKcbnGLwOGiNrWHYzOYQNQU5AQCNLw48Hv143taiZpw5bj88O?=
X-MS-Exchange-AntiSpam-MessageData-1: Xbs0XP8Yosa5tnzQLkvw/znr+OnyaHKrVKU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b37fc59-8dc9-4638-f784-08de8479a444
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:11.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DZQvE8XIZGGctXeu1lb1Nkhw5kSPnmgv62H48eVCVdNYT770Lcx77cfoyFc+OoeYTqYSxwaZnkasj5K3+qdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7101-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BFE92B36E3
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

v2->v4: none
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


