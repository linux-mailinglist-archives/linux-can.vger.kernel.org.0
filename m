Return-Path: <linux-can+bounces-7271-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOSjJrPSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7271-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:55:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB23349705
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69B703111FD6
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360C38228D;
	Fri, 27 Mar 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nb+JnWRA"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B437F8A2;
	Fri, 27 Mar 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637334; cv=fail; b=sxbnUBSr647LZoS10E/hDlcYPxagRlSm1/dZCyyaCS5lAR3an9TSg/Dau/f8M69Z/5qaKISrjkly6bT5co6DclFuHcA9eY694HTn5/4A90FG/ZjZCa1Z5LiYykk8JztHx3fcacqvpGnvelDNWXB7epuGmcDkNZTf4DO1Kwglyhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637334; c=relaxed/simple;
	bh=mRs0VEeaQ9mSSydv8Ony3/7NB0yxqQ/ObT7qj8fU00I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jiK/QcKIq/8hC7RKxWJAhSJTnTtNl8xE8wDZaN+x+SUMzcwI0xWqSe8Lpc89zAQzTrIZJg9mlna/bo15WRShjT2MjSlKy22ZGs/GeqVjBqRzZuQTw0jZ4mx5TLZDSsB5VQdaPdzC/0ifJnxKdexRxu37B+zIEcdQyCSJRLdBD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nb+JnWRA; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOLZ3+lTFZtDMC+EUh6cSw6rt1i7T2Vn6NQK/1D3b3DIMFRCs2XceCOiv1ouXsX/vstRBtU2yObra3pjckMCHSdnD3F5uyvrI1Mzmb+WqOjhWaBs8iPVbtsgvU9VFJd52omNZH6irsScT6bcT6b6CKIM4a/PLpcl7TGJJuxs42xl7SiEIsJNo745pRmBrVKZHTkmtsIUyLy1IzlyGvVVOBAXZT11WBN/HrOJKtTIe2j1bKvU8eO6M2VbAsCxVKq0sLiZ42Sm9xffx3nEw0gn1Pu2C4ahgCPCTkDijhnSGhqGjobSylEPNQ9sViZdza4SMIm6L9SRizvutfgwrpPWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwNG62F9hqMMZG84hNi8OqbD+XU/a8nu28kmJu9fz84=;
 b=AqRfpMpJoLGuM6GsljzbfnbW+QM2gj4g72kTTpTmTw4Cu0JYV5WhBSQm//9tScP6yqxchh/z/ue8pvQu0aEG6OC7RObtEShRZFpoZBEFw5YaZHXmt/WT0EnUz9wp9VUm1qaFdMa0PZrZmzYZZcRHuTTVi+8/slSlNE6onim5ZfBVeMUjyC9sfi7zwLJIqkOBFORZnU1Q1wz5aGXvJrrcw/oZzcNCP42AqJXtwt+FzLjOCyjffyKtPsUvRD15U8D/6LqK1p97hunfYNtjQ+A59fxe3RoYzN+KJbBqGRAszeMkRI3qCBHNoLdn3FExd/11V0nnbvCq0vx+2RYKGI7Hsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwNG62F9hqMMZG84hNi8OqbD+XU/a8nu28kmJu9fz84=;
 b=Nb+JnWRAk1y0fhknq1QhK+8RctpM5ADxBFf+yzU/Sxn0dXmAFDwr09CYE/vE4dK12hgRGVPjSdfRfJqf35nOeN1vHH1mL+u+LNQxtU1A9OeWO8pcgiFa7nq1EmusYvVOaAmz+baDgjuH7qTSZOa2cX5rRuJzagvHY18TctnmcjWpkBanNaW7qg5Mf/FQNG1B6wL5MNISWifXhvqbBPwRSvELexllgBsydfYoXhhkeY0sRZk3ok1whpmHXXxqTB0wD8Vt5YJfNQAxKEppD4aB0DxVL81c/HbfQc3XfcRHMaSiTbqhmokD4bzHY9ET/6M9ky+fTzZh4uB9wtccltGjpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:45 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:44 +0000
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
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v6 phy-next 06/28] phy: spacemit: include missing <linux/phy/phy.h>
Date: Fri, 27 Mar 2026 20:46:44 +0200
Message-ID: <20260327184706.1600329-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebd9850-74fc-4690-0440-08de8c317933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J7WKOrSeyOMfa8T8riI4AHZAsM4NcMvXMOx8j8e+tCctlMf4ejpkMIy3qJ0UGL4C85c/S1CDMwcGkl81bRQxL5O4YaiTijpdo1UbbG/A64KnjgLfF5+kiJFPWogzsYyDgNCiQw1T1kFud/1nikbw7HCcDY2DHZd1x1uNd9gORgr1SqLHZJlcVTxx1KsfC9mbOQsmlNVdvWzsd9Qb8rTgylu/dRlXfo6ii3taipbA97q7o1LIqzVSTmSUPinFsgRE32gFvtIV4pDCaIiMw0YTSaydiK0wIzKMgN+v2A9xZb4F+BQYtzRIQEH6xwdfh5zKsCx1lqJBmCHYM9O2OcGpdKk0KvCmXm+aC7MBeDuazFXFCnCHsSFT8snbJWKWR6NOYNap2/UjrV8qp6hgAjMjKJ7BbG/6Si2Nx6Fu71LlzLtWNFHQqEJSRSLQeQvYxCoVxdA9rBoxkDaURbwXOE59MFzgS6/9eF+MqJo2N53vMC2vnYZuSsZoY4NbsVOT7A5dPc6EZtpa8JjrLv+Sg75RasTc6sCggMKSwVBYYY+ASuyeA6NQ+sDq8yozmxAn05qTKX8WUx7DoOVJCJWfqGspL5YPDQd/sUn82UqsRuNUmGSsy0hvzxobG18wvxRSSXLSKxBQz/Pkiuv27IX5wyZ8FNjSJfeh8t7pBQvnq5+OpF8XbNtg3fL/s9xj5HV40lVikJY9g+h9s1udXnM7fi6v6x2hgEelnEW/BhniVKIWpQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fggDjpdMaLNUFKcRy/Dus8GyjYci3tlZqBFStWcgXK/NZ/I3jBeyU/yj+10m?=
 =?us-ascii?Q?4C3/lnVA7zLtvwRURE2/7hVut5KE7Zlk6QdDmp5wBe87TVMithIn4ZMkiOLP?=
 =?us-ascii?Q?5vmyAOPqZDS9Ol02D8ICUn8AFIClAJp90c+97WwpFbpk+xSqYEpqCpTSOPyI?=
 =?us-ascii?Q?yQHjHdhn0bKur308IAbo4gPPH1oYN7+qyXZbAw54Oqo+ge5PE+eO+p85W/Qp?=
 =?us-ascii?Q?RSGAcftGrolZPMJFbigRf39sn+iWSZsJF4++MYwfHNQWmAPp3migGHxeOjbu?=
 =?us-ascii?Q?7NJ6uHLtTRi8mByBAJuxCfgBeZOmPqUDLV9TuIxbLsjmSwSTOzB8/NilWLOe?=
 =?us-ascii?Q?kc5dqS1sKTB1mFexUC8qyzEeYS4mwNDFXHJjV0Y5UIVxBqrFwFcGSUB4pI6P?=
 =?us-ascii?Q?IlDd3ji62wgZnSKCe0pgbZ4ofXMdFVJpBxuHnGeggiIudHUUyd4lsMb3gv0i?=
 =?us-ascii?Q?Z7d2NEO+wqj1U6DCWUMkjbgF/efI95T/kvf/l/B5TOsN+15ACiagkhb9abNH?=
 =?us-ascii?Q?rV0R39hXyBTYDvsbCXaWpiQlJUPy3/dApwfJao4Pq07UGT8mUlzRWXOIYidj?=
 =?us-ascii?Q?1LqYNr0GcwT0YoxFRTvZ6gmtSoPiUkn+fFZr9gWSmpFP5m8X6BkW3hzDHYLW?=
 =?us-ascii?Q?9p4e6UmgmiIqq+QmpN//LNhSdVSI3IremMvBh+VwCrlqdE7fVzpXUF9g2m8z?=
 =?us-ascii?Q?x8Mc/1UZ/aGHWlQ41GY8KvE5xXzBtSR6ZLH2PDSCi7XDU3ApbDIxfHNzLi1H?=
 =?us-ascii?Q?zeRQoytcwk3ISgx2tA79uhQAc3o0Rt49Mb10kH9AArTsF3iWgbnpa1Km8xrF?=
 =?us-ascii?Q?hs3gsa8TO37R9Do6TAoBLfhh8KZWhnucO9PIZLyYeHYd0wpYuyIDBxv9ZIDf?=
 =?us-ascii?Q?QSCVaxxGrCP7RfLFmVd1cJXvFZ38p57dcRKw0IiVFie0Wpltbd1leHAWPWZJ?=
 =?us-ascii?Q?IgwesX+LOXTtVDsyZ6R0W6VK8BcLzB9N5+vxAX6FEu9lB4iImSxRbE+yUZRi?=
 =?us-ascii?Q?WReea8orRidk5K3ukGBm+GrFzNr0my49xe4FjdaEyMDXSE/bAMTWhkg+dJJ3?=
 =?us-ascii?Q?8lC9PRcrR/dKJ8zCitIfSBcXu5n5qhl9GMgl84sjLT6v0SeS5xlf2SSUonEk?=
 =?us-ascii?Q?Q8F6lk47KcdaUnI2l3pFIkjxX1h5YRnRBgR9Js1xl16QezpoTZQEyd63BsZj?=
 =?us-ascii?Q?v2K1NNvFDA9u6FvXK4Xfb4Yks8mW4HvvvQH7aT6Jn7dhwKiGLqftJZ/Jgrd4?=
 =?us-ascii?Q?G4pXBxLKyH6NkyxQzF3jgQVl15sRwXtH1suhI5AhDgMKgHDaOOi0sgEbcMEc?=
 =?us-ascii?Q?0t4qBdBAzupsdkVHWYlBWwkJzoQykS6vKhqBATSDe5pzm303g5oSAti7iEuu?=
 =?us-ascii?Q?uIdNR79O6URi2MWcoPwtAKTvSRpr4eq94Byd5qDWXTqzm1bPKBZkYCJBAvMr?=
 =?us-ascii?Q?JGXhgUES1NwBk8MFPP8kiKQRLOsHAtM9hnFRNM+0doJWlRQORKE6p3jsj6Ru?=
 =?us-ascii?Q?gDuqiJzn6jjB2EgBZT9YHS7ctryPLyAXE/oBl6alkJX3is0CX648s1keMHUc?=
 =?us-ascii?Q?TBJscBWD9FSivDQer5ea+zybykSTNopiBFoyB/gFaYOkR8Dm0YOCxjBhYUE6?=
 =?us-ascii?Q?gyYOx/844UClYJhNond71vb+esh6nFVIKfLq2ST+Rg3pLncm0UByTdgTwDqc?=
 =?us-ascii?Q?KGN7aQnPlHXkygURv11z2kZ+eWQ7E2gfYu5clJPXjK/aTDgVs3x60l9xn5jJ?=
 =?us-ascii?Q?OSEhmgJWFJXS+8zI0o6XeeoN+OMGb8+O1FTUJv2ALAPFBy40dOj3EIngwGKp?=
X-MS-Exchange-AntiSpam-MessageData-1: 9wEvlR4jXi5v2Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebd9850-74fc-4690-0440-08de8c317933
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:44.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGRTk5hgmGxB7D6JmEOBW8hWl3hC2Q5fODtG3mrhEvQX4PXtASq0TptaW9GTeuOdqZEXYIfHKZ4Ri7ZkRokbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7271-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB23349705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
Cc: Yixun Lan <dlan@kernel.org>

v5->v6: none
v4->v5: collect tag
v1->v4: none
---
 drivers/phy/spacemit/phy-k1-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
index 342061380012..14a02f554810 100644
--- a/drivers/phy/spacemit/phy-k1-usb2.c
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
-- 
2.43.0


