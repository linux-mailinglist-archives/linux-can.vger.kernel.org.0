Return-Path: <linux-can+bounces-7051-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IocEP8cr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7051-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:18:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7023F94A
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81D1B303AA83
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825C436348;
	Mon,  9 Mar 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TANfjLvB"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C144CB5B;
	Mon,  9 Mar 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083423; cv=fail; b=H3SLJgZe3wKP4EAZDeiizZYAoxDRy77P8s4R1otYmldyItrmf9cRdKi1MSg905hcNi/ngi9emCEVHSjiilMzqIuduMlDgF9e/GjWxr56DISlYN0vFR3hc/HcIFupipZx6wimr4DEiSInN0omj2YqB05IaCioLHNk5jC+v7Q2g9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083423; c=relaxed/simple;
	bh=Mhq51Z/kj/Ey+UI7/1RISSOV7c0BD+QU1nGC5Gnhvsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzK00L1hnYWwuZLY7EybVAxnrmRJ6gAFsh9S2bEE6IKgFCwD+jfXFw70gck5xpqDcyU88nuWMi8mW+FEo3ni4UW1yZd0eWhw3fUg1hvxMaaRAeBdoKMLANWOwVoZwabNtHynx4c97KffpznufvDS4uLV9Rl4cuM/BVLpUFJbInw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TANfjLvB; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csBTjiREscjP7EoRsguJgvwhkTsp27Np0WTbEB+Dyaw2Mo33eQugJpjtDedOxeyr38KOk8I4uM6YHEprKWN3D7QcgYuwkliayYwsBnNd15k2RzdzIjy9vz7K0lyzr8CiX2fD89+xPzvJs5an+NfmqZj5MUZ6jgrCuwkPoJakKRDViw/qZGBDDogcFq3xzByFHoZGV7NNKpFKGul8mSwISmeMqgZzQdDhsnSOafNKIzjnpOS+Xxj6qvHrKiosvLqotB+nvpQKaUaCupn95+mFTW/aUjllH3revUBUn7j2+a6qU0/5/rQjcVrcZ0dJOpL+J2kbQ9CrzxCt6xZ1OUpxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycwxvK4POn4MH1HX94IsXkI2b5WlERnmEIRMJdeBO84=;
 b=J6UtFHumSiCxxt4Odz2gDPrBGrKbfRMlmF7NkHdymdBv1pstiZS/kfJH0TqxnzhrTu2D/Q6ZcVKt7oTATjI/MUMPuFw/m3gWLFak4EN4OxtX7wvYwTL0wSoeWFJQ1Br4BgOu8Ipo+wPmma987YXTq9/R5U7Mt9iHsykyjzEnMmapXr2uc3Q+u151k2fTG5UvW0xU4k3rGX+RTRn8/YoBcvoFvQzzCVj9nJqWLua/yRqFcqu3bsM9RSjBnXZaTGhJju7hQG7q5ky+S7QPnF5aWZfAiBHyfqsZERP2Ksdk+59WbFH/4pUdWCtXJmxaHs0LJ4kxP2kpmumsvN/P3jDetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycwxvK4POn4MH1HX94IsXkI2b5WlERnmEIRMJdeBO84=;
 b=TANfjLvBPfCj9iPqQNDvXaa+Cusi0Tbw5YsJf50pVKiZr6tQ+Da4gH0EiViII8VnbbawZrlYqcrnOm1eR+T+Sb2ibRqaFPDan2k9W4wUwfnKdiY3kMHD8lB31QmS1CAMnuoIUXit4PSISx4n5ImzotQsC+Y4ZleCLyp6XyNSS65r1G/rpQDoF2Osu2ER88cIB9LIHwIK6/bxJyOsgvpB2HNPNuWd387jQrIDvq58GGeytknAAnbsO6fZGr4/TxGIaW+zOJ8suxuqwvLf2kjlJdJWzTo6TJ0VZoF8T1LVUl2J0TWgzWQOlQnQjtlk9paF0t/3WFg3+ZgOSzzvsWDDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:10:19 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:10:19 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 phy-next 23/24] phy: remove temporary provider compatibility from consumer header
Date: Mon,  9 Mar 2026 21:08:41 +0200
Message-ID: <20260309190842.927634-24-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: d08261a0-2859-467d-9068-08de7e0f8154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	Zv4UfqbgnloVMz1meqCAhDZK+99h9sIqtJoanNpfTarqlmWOOMYcqYotK8m8UsV3RPXI7E1LzJEih4EO/uD6kT0aPSCgcnN3CA3UX6+6zhoMVPkB6hlObd7iUbfPOBG0XXzlrnzR+ZtYAs5NipCJ+VNDYv41YrjuYdsCb+M0I5UIoxOdD7Oi68gkuMxZpdZJaqVs37KVAAIyVb5niNRnIrLmNhk2WmODHeJzXdpV3w1C+fYdmUnvzSJpNaUvRmeCgLCUhAmeC9OY4LHYgV5e213G9FMUoodC04gTnreY/AB3Df+59+AxVTJ7IIJsD5gE7NQ5AoPaR4h7k6W3F96B4CIp6HC/7syNKck391NevlRJRGhFQfRWs1+mpUBp50QyDVgNQGT/hyMJatPZ0NdgLoi47MBMy9p/F3tRPVR2cZt/KcoPVG7AoPQZ20WsOSwNdeY+DIhkvfoUf2B4WQcBnhraWdWuebT2Ufo0p6UTTLiRN+czNOsV+IeLN98Q3+pTTzUfW7p8iGue383fciud54UzPRv9dJ9zLFNfr2GTueHhrIxpSFAvyjS67SQNM6QHjBCDqVKbAyC8H+wcpjxX01j+aixpBeUDiVpfMVQ0zkfg6TIHgvF7q50QNntuoxumo3yOlv219U9sm8fHz7qhWtr02ww+ihvCR3q1lEHoHt8b3ZqMqS0e2yfmyx+zYzcQ9psY6c909r6ELABuPSl0fPUyr8eVBAh3SF6iUj919dI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kzB5Yiyn4IP7w1OxmBK5PkeCvWDqMUXRVh7hi3P4JOkeioTWnAbl1GUQJ6wj?=
 =?us-ascii?Q?EXZY6+o68Kz9pOd+kHQ/2LloF52hg9A8LS3gb9a9pGyOyfheskAnEIF6S8zI?=
 =?us-ascii?Q?WvitMLe5MlE69pfzS8juwsoYzWJKAg3yeUFdtIoGfzPksrAIQMmlDDzzmGNJ?=
 =?us-ascii?Q?OmiUpQbeqA/gEvV4xF5celxPJX2VjfoheeqvNcuixyEiVFrAmncoAxtnZQ5+?=
 =?us-ascii?Q?ebOzT0TToUbVR4L35AczIqjbznh4J4yYz8QKwjwMQd99fqr7UhF82+/RB9BW?=
 =?us-ascii?Q?u37sTy8GnUrcZ0G53ai/9H2Wve/j2Nxjhd0SAHJhYZnXfIuezmZSZOSBT7ze?=
 =?us-ascii?Q?7Tdu9TDHpJxto1Kriz5z9zyYdkT6sXstDlTaOEWT/DDZ+58ojz+RGLd24238?=
 =?us-ascii?Q?G8BEKqF2SJBxHJOpE+hVGZ7Evmg202PmCKEOeQfoW43DeL7UlqR8sBXPnoDY?=
 =?us-ascii?Q?9o8mjTmb23OKZ/L7Pnfm699ytfnncvpFYjZJ/MjU4j4X7OgaiUXuhAJFoYxl?=
 =?us-ascii?Q?NNO5Ud9aP10aCeQyBsOl1wwa+KE52BavQ6R4BRokzx5MpEDIinOQiIYcq3Bv?=
 =?us-ascii?Q?LdpCu35p86iyYy91lFHgwKXKKHokW81xdo0OsWM8uInBm7sfV95jMdHtF4lt?=
 =?us-ascii?Q?R5jLjbY9jXGZX1VUVS57G0TAhQlJdMSUgGPxXnO4qN2Fgt8xZ/h19/aY7csM?=
 =?us-ascii?Q?DMCCr2AN3M32mAAUYsqswkZgPKlJJIf5+Xo0IsPFU1dmnrPTdAeYLs4Ry+PR?=
 =?us-ascii?Q?3boa8a6TUOM4MUpTYrvEmTPcHmfeL8goxHyryYhvNOOrP/N1NU9EczLfL6ir?=
 =?us-ascii?Q?2o7DWPFSjKlPwwTHtstMId2LaanbL+Lzigh33Ju9XFkG1EVhwHzqFjv9KKbL?=
 =?us-ascii?Q?k/IAUSrKl9onnzmxwN/A+7DjBPiIi4d2gtrZg7TnnUkEQCQ0vzEie00+SOAl?=
 =?us-ascii?Q?BuTddrE46jZ1pF6JI7GjVkhKwJyR3ug7HaXGgwg/bRCX5HVAaYSlopxiK355?=
 =?us-ascii?Q?baiVJMWcTB02gcItPOYYHxxsqZSpw8WmH3rJ7GVRIsY62raQPXS/UjcZhVug?=
 =?us-ascii?Q?3jGHcYOhWDYwgdsi1W21EXRbRAFAAYnYPTimBlLDyWK8PnBFd9HrD+SJSl1X?=
 =?us-ascii?Q?koiScg9+jmBV1F/kRWLVoMcmghmE3hsh1wyLnePo2hvsGNgbbFM1gvDD5512?=
 =?us-ascii?Q?zNDn40IsJu+05oTs7PbiZOCAIjIeG3BQUV26qg+Tnw2KwPysk+yyNAmTwlwm?=
 =?us-ascii?Q?NZAQ1EQwMZxxLADSeedH9Bv2HXbkdzhwg9MU97tDp+6RuvAR9k1BeszuRyUO?=
 =?us-ascii?Q?WYiQF8QX9PYvN/pMu8BjodME/mlSJy4uwnt5a154wwnW/Q+G0DDooZYkoQXM?=
 =?us-ascii?Q?vhn0uD3B4goOyk8KOiHyz0fFDoTlgLjuARM6noPp7/cOHqhhbOcKuKgf7vMU?=
 =?us-ascii?Q?ZDMfnKWhPZLIXdsKhjHVTjhVSddT97/EHPk61aW+CyznMVrbkyQ2d6i6+e7D?=
 =?us-ascii?Q?9Ooatfn3auuwhV5UqMpet/85ia+WoW+bM/X9l8FH+5dYfXQYqrHQKhn6eE7/?=
 =?us-ascii?Q?Hafgo/Me1GVQwMmQtzNwHdU6Lr7bBfrkY8DzRdJTd7R0oQS/6/WKcM+I+n5U?=
 =?us-ascii?Q?Hvk32mkHPQ2BLjrgZd/Q9/msCAPU8i3EuxdfA8GsHLEfOedrp0PvUhayBPvC?=
 =?us-ascii?Q?nR2EsMyGeEQQ2eZ/7U1iJ/J5ntOyz+nzi2L/lz0gUbFYHbwI1XQJAYJaajp6?=
 =?us-ascii?Q?tjlQxdkUU0hNtKMGKqGSVH3Ct6g/2Xs4VS9/9rqlobYZMsast8V2nvQKAwHh?=
X-MS-Exchange-AntiSpam-MessageData-1: qk43tfcOhVoFJSxVatPpR7PaIVp8tIOYuiE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08261a0-2859-467d-9068-08de7e0f8154
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:10:19.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW4cO2zqgmx7ykQkYJOTdP2DKMM2jhmrwypFQ2sM4HogbaVN9p/pBrICbv3oxFFl1AosNPAxHocO7QDQM0HxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 1FF7023F94A
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7051-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now that all consumers have been updated to no longer dereference fields
inside struct phy, we can hide its definition altogether from public view.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
v2->v3: none
v1->v2: collect tag
---
 include/linux/phy/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 34b656084caf..0fdcefaa3f55 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -12,8 +12,6 @@
 
 #include <linux/phy/phy-props.h>
 
-#include "../../../drivers/phy/phy-provider.h"
-
 struct device;
 struct device_node;
 struct phy;
-- 
2.43.0


