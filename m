Return-Path: <linux-can+bounces-7491-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iETKGOPC+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7491-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:13:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE14CAB4E
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445FD30AB2EA
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A97342CBA;
	Tue,  5 May 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iR0vGn4k"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C633F598;
	Tue,  5 May 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975543; cv=fail; b=SBmtRbnTxyiPUH5UTZ6Gu7IERG9V77ZPdSm39FEFuigLngmEXPOLrS0qVY+VNIOVNDr9wnfj7sRGN4YrifSxLg12fJvtRslnw4sZ/GXSkpPwHXvbzkTyrKyNnRGRkdAv8LxjaR4sH79+ipBDo//KY0KIBWzelemd/0jOVh0+WzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975543; c=relaxed/simple;
	bh=j90azL7fFd0uoWEhJbznKwtu9zmF6kVr3ddR9dijBoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHUS1v6R9gwRymGBD8ZlvQptQbkLaz27cGjTMbCVhn8d9ITWvJRKUk+4J2aI3WrOZIiiF4AoENwB3m8yPK/TYLh4YwXtDM1IDM9jQOLRwnoTR3v0nRV4P6qq8aFL/xh4tSAIYZnQOWBXWqlqEQ2aeeef1PWPZ0EBl2uSg0CUR5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iR0vGn4k; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnv/xrKVPmSODEG7ulz+mkBKwnL+f4e8/sHadeZiXadtJmIi9bOd/jX1WTVEW8P6ROJcOjf/SoAar0kuIQ7boJsIOry0uLaheA9NZddGdKCAOkNanQfoJtZvxPGRmxFK2585Rlu9zOJQA7/CSWQ3vwM2n7xbvS+F3ZMW4esQx2hCxRcQxexVwQlC40w6wIG5HNXiF9PubM4l1l+fX/d33OSPnystTKA9FxVH86MWeAsqhAGVoyyOFG9dR4XgeJJXL07ukDF+gVd53KIkASk1zgSbCvmVy1A53OkB2P9MUjx8f8zxfeGDJQZ3tzl6Y+YvnzbrHZ7xm1ieIDm8UMNT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATYvk+Hl598A+74azMEV54lqE0bQy/vXGXe/Cs3+2iQ=;
 b=a3dwt1AFJl0JFZO2WB1lYaRB23RxOKAOG82xtDxcS8ik5lG2bUWSyN0FHsW2p/x8Vhtqf16RgTwsPyr6btb8jZh+fDdVHBja+kgBSWWLFUR8eDUqLrEW5Yaa/DQn9RZXkJNbX+ZO6wrAU29HhmCvGKNSTgTYqzu9Vbmw39+7WcoNXZSrghlqK0SfrOcAgK6SZAq8JtN2dba6HMuOYATP6kzuloAVDv8NXoDyPyX30UlV4Zyi9L8WI6IdlD2GHmu3dAOUvj21gTvlEeIPIUe8Abk0EKXgJ969wuexNQHsTjV3uSyF1vu6vrC8rYeRVDeejCLgAlekXguYaikGll6ZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATYvk+Hl598A+74azMEV54lqE0bQy/vXGXe/Cs3+2iQ=;
 b=iR0vGn4k6pvNnt1nRVjitCuSJr7pQtRNXOekK0IkvTjS7R4xv/GaD2Xh68qh82QwJo5+ulbQY33Ys1Y9MxSH9hypjktIckgvYcBkVUF0bfSY0Z8nkUYrH1ASAk9fGTzNHred4PXORTYkuu5ek0SIbUnevWOjW1dno1wzvB+535yiF3DUdSV8yWH+AjKNMfiEwFht4hJ42gLq1IgWtZV6lFcqGbSLzWe8boPy32O68nZTf23R5KdDgJjEBpaKO24zda00RoGllI6/vvP35pEKdfVhjSM3rzKCI5GhbslDe4JviZ7dBlc+AWoJo8mKRrQ8x8WfN8QXmA5pJiGHiYBc3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:35 +0000
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
Subject: [PATCH v8 phy-next 02/31] ata: add <linux/pm_runtime.h> where missing
Date: Tue,  5 May 2026 13:04:54 +0300
Message-Id: <20260505100523.1922388-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a49931-8d41-43a7-5c86-08deaa8dd9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gh5ACZahvlxrd5sgFmQDkHZoLkGNTzwL/wrIPTsQxh+nJVKvuD/A4DNMpjrbTmxkNq7lIuuyaRuvFvJ0N4w16AQQNSNVDhYkvTLhuhqUFVjjSHXqm5IXINpLX5aPYyp07aDD7RnrFzrMqluZJMBKWF9xma1z6UZnEs6b0t/r/40lg+/O2PgP7Z1QVjwDbTGsPPNhRPHBDokiTWyLh+rJFNuAgHpb0bCSu0HDfmCzD4RAZeiW/CxIS55J70tX0qKUiRLwXN5rFfVREav6iN0BE7+EdozGwO9BOy+1VEBT5r0igEqtr1KKZAN8uI9OvGoEWgEH+gMJSG/x6WWFdmN+zMMk6ApAxfu6dP1JbGVZ6I7FikYf05rrPT72CBCvskjLRcYDtVZ+lq6cqdEQKzMIBKN/BMaYmCYHnD05WoLJgbZ/8iFVIy03GIHtpyRiVDt4JyNlRUYZVraK/yY5XoL6veq6qzw0fSjSJYsiWZUc5lGqbfjUr9H0qYJSDaGDz6U6Qp0fdUKQtNJsWJFYIWVobnZB4jRDGXV4pE/gJr5yNJ+8/D3pzkXGCZB0ktdUfexqkqXD+sP+nZCfNubQg/yAF5vIFmGPv0Jl14WZ3ybgLjiBPVZtuup1q5i6X+30xSDUH2lgOr3n1AZvevLQLIxLmqcvb615DNnMOWbg82lZqQG6ptDypIuN10lGKVJAlYdB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbInUapyGizYGvym9XLNeQwqX/5LQTGYt5FMNUq7rqIxDIGqonQjoMnIjbzY?=
 =?us-ascii?Q?+IU4S3iJAXFbuurc0bHmbYEovrTpmbmi0cw0/FrVJ72wEaa4yzoc31PsBf7S?=
 =?us-ascii?Q?+O95Efq2i1weZnT6EhFgronnA0myVerL/NQXSmEEVfQt8RmeFL9ZeARAv5nB?=
 =?us-ascii?Q?M+20q04GxhNw6oehEBuOIEnfUpPrq+4VtM9i1o2g3N1/z4/lZpxqs1JtAMGn?=
 =?us-ascii?Q?Oh29Egey5PspQsaHl/C0JxFpO9KrEmifPyzxBdzv2cTD7OJC+MptwJS5mW9R?=
 =?us-ascii?Q?lUaIn6299dHOsY56W8x4cDFfcpc2frVKmsGPiFiYIt9tpMm0dTtqHMOgYI+A?=
 =?us-ascii?Q?pdLd+mfaN3JeVELEAs9lgaPjuknQTs5ZujHq6wwxTe9NTE7EFwWI8qsqfAda?=
 =?us-ascii?Q?oakfSEISb+3K5/DdSSCbBtaq5fnJG6JzkaBR1j5qgI0skODIRy/WlxeNeTWf?=
 =?us-ascii?Q?brs7ICU6hMRdqZbBh1jkVGyiVqv2MxlPmgYowP4/58/47ZcbyPE8gH39uIhe?=
 =?us-ascii?Q?SodK8nh/p8mYHuLC/VV6DXclCrlrx1Mry2xPAUuj/Kg61Xus4iT6nrUF5T7U?=
 =?us-ascii?Q?azL10mI2dakMdiw2L9ldDSguE0AxmALOUn6eCWCtkHt6le5gAvrtxqMN4aA+?=
 =?us-ascii?Q?tECQXb5MoS2yrgWFmQJFPrQKI//q+sLfoXaaKpgApeDSGVMdIFFqvGeUi5sR?=
 =?us-ascii?Q?JRcgMZLI0oEGuaNaLE8UR7yAsp9OSbDu30xxTnfew06Tb7eBHBZXnDazlyGB?=
 =?us-ascii?Q?YvKHMmCuJYwU/Be1y7yoi6BZsF+h86VM0A2fAjQGPRLLT1LQlRU/YKLoiFUG?=
 =?us-ascii?Q?d5YeIaq8CzNDejUiqH6q7DmKiDDzIpZrSsxwWxyTTmGEho8ot1hUWa/a73VU?=
 =?us-ascii?Q?dRT9pAmC36MD9LAhPH9TfwVK0z8fcbosIkMmZ4om0TTHFQMcGNKy3i+F6k6i?=
 =?us-ascii?Q?b1n2R2IZ8w171XgHvOceWgAJ16kNz+2xidlDQNMNoCUHzXaOJ6qMQAyI6Jge?=
 =?us-ascii?Q?Yf/CG1iFxDBlejHKvU8CBiEhhnb4zty//+Lt/pt4svpqARviNsGYcaYuuXQP?=
 =?us-ascii?Q?6bRpirKV+LO6VyeL8G5xOIVcQNVbv9fA2E7kfXhr6zxygdipZlGj1q+Ej2TY?=
 =?us-ascii?Q?SuCwfFAsEJ9tf5jii52xU9HOXeD6PdFCz+aMWUP6DReKt6zW9bVIZliDFhLI?=
 =?us-ascii?Q?e0LcsWoWVckTlP2ZFsmUNnV5tdksccXoxD8aV7tITefPwT0Uzo+YRaXlPoam?=
 =?us-ascii?Q?K1qfcSpXIKdWPOeK2WBBKSWol1DozJ6UrjDYBpkAB/N2tjYdmH3QTHh1wTGE?=
 =?us-ascii?Q?rx+qSBDutr3C8Xd3t9fGIivl9fk+8Ja07p6Z9gWfLvmd8tgUuvis/IWBgPTz?=
 =?us-ascii?Q?YAKX0MC7eRnfu7INXVtj4gP083PL7dYDCY5Mnmo1Q9k/IoDEtjszSvNbTGID?=
 =?us-ascii?Q?5S0mrdsky67d93n2KKUCrcpPkyHJufWNMOI32ZqZTZ49rCzhLAd/Ftdv0FNf?=
 =?us-ascii?Q?/tHzATR9nqNF1dZsNtzczdexuOKiT8y78JlD2DAfzbOmFj1g+uFSvhZu/Zdz?=
 =?us-ascii?Q?fy0oKg0E1bl1pKIrNytJT4QcctR+VhwCZ1DLcBIl7xz/Z2LgmDX89q0CDXbw?=
 =?us-ascii?Q?zQfIUC/3RBUA5E2gvc0j08sTu6x8hONUmLqZObOTY21gPoACXqIYyYI/2aWp?=
 =?us-ascii?Q?5ngTG5WupxiKT4a8uMa10c9dOqgjzdXBIB3Nkj33UZMQfEqEYdQjx6W++79/?=
 =?us-ascii?Q?0rY5ZM1wEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a49931-8d41-43a7-5c86-08deaa8dd9c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:35.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv7bqF9WBDxB8ccw7whPGuDb1YaxEjw1rFRVgdZANdKPoKBD6u4blMhoJSZ6+odVietjIr2o1c3Rw2MaPymq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083
X-Rspamd-Queue-Id: C5AE14CAB4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7491-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

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

v2->v8: none
v1->v2: collect tag
---
 drivers/ata/ahci.c       | 1 +
 drivers/ata/ahci_brcm.c  | 1 +
 drivers/ata/ahci_ceva.c  | 1 +
 drivers/ata/ahci_qoriq.c | 1 +
 drivers/ata/libahci.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..1396a53bd6df 100644
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
2.34.1


