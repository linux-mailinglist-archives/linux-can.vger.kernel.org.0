Return-Path: <linux-can+bounces-6998-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJUeJINirWnf2AEAu9opvQ
	(envelope-from <linux-can+bounces-6998-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:50:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA222FBB5
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F939302AAF2
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 11:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F837BE9D;
	Sun,  8 Mar 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FtUaULOz"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAF314B82;
	Sun,  8 Mar 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772970192; cv=fail; b=US4itIe/GdpNprlmTQJpUQZgbxqu59TxEd82GveVw7kyHdLA7OAGXJXPyv4z4dPMWh8/qywUFABab+TGbw+mwaOW7NDweLrQTQPuX0wLFXHlKQSfRIzjU6Tl1mp2vgCnhryZGS9f41KlqYkarWXZ6dGWG81g9pxYj0AyobXVd4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772970192; c=relaxed/simple;
	bh=HJQW9mEZbX4JTdi7TYMntWMNXcVDlXnbrQYDFl4Gn4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jv5sVadM69/nQWYU7D2yaWpdwKKPiFn4+a5saxtlqvQsWwQy95H5rVLNCAida2Ub7nYMEQepAu5AsL7ZQuq+aL60n6Oi3M3GCqks2H+9/urcqreVb6f0y0FKoQWZDeHVHlB32y7ISbo3peeNbZezQq7Fx2NaZR5ihdFWx6zNj/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FtUaULOz; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfay6j/igh0U2Z3McpX+TeVh8UUg/hwaoJNIvrg0DVsI6mntoWc42B7/bIYPedKkFkqMaLciAToIRuJXO9HyXDmXR+n/NjP/uDG+blsPNgssk+cZhMhXKWB3fTOMhux90StgucDMAHtwHXcVj49bqs5d2v9FpFEiC8UNoTnVqRMpNGE31+CKcznMD4Bd8zpULVHS0yTIzyGNN3sdZG+NIUsWtzkYoWXAMehL4ZzXwgVl6HJft/2qIneMZMX4s+b14NZ7zjEsynmtbsdPFLNbjoXjna+xc5ZKhwcYFNprH77s5Re7HsxjQgXhGc6mJtrp2MW/nXM1IQmCtAveJv72vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maw341kHq5XrTZiUTVhlCj0sYwibNC1Lj+D8kxo5j8A=;
 b=xL0ZXAEREMbcJLEaNrTF1FIwoo2af44pygnBXU0OG1kYxxsmY3VYDWKRGXe7CXxQ5aKoHaKqPxxvBnDQ2e6PiVS5jDIeMtS88ySz4c7fG/6KBKcmNTgNnO0XtyPW5ZwC3qMNGompCV1Be4+bzHndFeT+ufr8nnCKJgN3Ts1XXJgMCftJxYeVhqp/wEH4LJLCAL+4dtkbeEPTpnW/9ewrHQiTJqi+klL89nHeqfS3UKxyqgf8sHWajm2vt01/SYvaD5Iw2/w+rA/6vvATd8cCQMhhXO/9IuTuUn9i/K2WcjWeCnMVr56Ufa4Q0wc+YwmZyYI9jyMHTjWB1fUqh2cKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maw341kHq5XrTZiUTVhlCj0sYwibNC1Lj+D8kxo5j8A=;
 b=FtUaULOzjFVuTfxQiuPWgdk2RRkAwBMoZpn5IiWQdVrcSdlZ5gv12u6KCCvgSqH/EhUO2fOPD6E5XQ0M8cGtiiwAMVnDAO1vC3KC8hktq0DYQ3kvXL9PfK4h9NCUgvj9Rf2B5RWTrafbuXNqtopowThmuxlgZNa7kiIWzD9NqDQekYfr0QH1yvToFruuwFphuOD9hCMXMMP8W77VHfdJUjZntQAYO9xiALIyfDTujvBQTR/FLYAXpVmfXaT9wx7H2dPrDQZ5CBNOUwhjfDbk6WthnhfDOoUmZSa44X2nb1mZ6sei7NYxBtWHZXwsSBRCEfjby52gwUT6M283SK1vrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB12426.eurprd04.prod.outlook.com (2603:10a6:10:614::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Sun, 8 Mar
 2026 11:43:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Sun, 8 Mar 2026
 11:43:07 +0000
From: vladimir.oltean@nxp.com
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
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 phy-next 06/24] phy: spacemit: include missing <linux/phy/phy.h>
Date: Sun,  8 Mar 2026 13:39:51 +0200
Message-ID: <20260308114009.2546587-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB12426:EE_
X-MS-Office365-Filtering-Correlation-Id: d48416f5-03cf-42ca-93fb-08de7d07ddf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	XyZ8YBTqB+Sid/YLwlk5nfHOWHLodOtG/oqG4R5gMVPggQ6avzRPcPJPG1S2mvxMz0CkCOMmiXKiXlNxfet070fCTClTSzFuS5V28YCttpPW9E6QvpQ5nJe7Yt3XnsQMGOOJ4th2M1mubYVcbSXiXBenKl62x//ZLyUUF5my2DuLnWe9xRIqFdrfs9wBFRyHslwbahP92ImxN4fJHk2kxvwklVi6gaNGYzAnzQiGJe8Jx/8ro5RmwS1xY7uZL62k6Ln2wUM1X/W0Y80nu2HjUtrh5E/MeE2emTvcXZrHXuYuoGuaXkWaJs2uIPMkBKlHAPGEPNOldJPNDq/23Cm4Y4crwxYXMfkn4MbgvRSO/Fk6IRghHYJJ7gK5V83EWD9FT/OAvBzVY5eYZkGI3GqSzPmQCRrbx6dpwSSGizRKiT3IvKGfvlJxmKEuu2NUzw4bWXjRGIigOWqcZytn1LGSwvCDcBTmFHTp5jsW3eQQqVzLeAmBiuKugqXqIs0Ijmx5SMnEjXO2OfTpxA4B0yt6/HpcjxM24q1fcsF2XxauzaelsmKm/ey8EufGz6f4FXg30kMPzykdHr8XbtvYibyRwDTogrEIlTlFk3ZrjkwIXFVKdXKXk/gS2binnz0wxrsCWgGRwPxRgXOkbQEyqFbMATyfT0wZWdtWpVlc2J/K8H9qew1Uqt2+2y4Qr+TMRNQ3j2SZxrYpZCU53Ez9AZVzNNMArnYTlBVjlm4vv9JbFPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXE2E5dBDlI6+e7MMAYXIeMBut5SKRqaEoOcQ/0G4Nj5G/apbInSbVfBBwIS?=
 =?us-ascii?Q?nGJ5buYAZppXiwcumw6Fgn2GbhrNnyKYR1whj6iBs1NSyn7GgGW7JgkgdhRG?=
 =?us-ascii?Q?oobHQGHh9dMQATJBU0yPBNas4h0GovGh938ic3PtZeQPGPuub/7zsPnvGH+Z?=
 =?us-ascii?Q?0XBdSm+pBDCgcOpseqBoMfSmxWdz6gJSGZwoWPrshVJcMjbKxcEFUPungwCQ?=
 =?us-ascii?Q?Q+nt9mYJjrt0xj1TxlbgbPmoayAN9mdL0cpJ3zqjKHZ1VfGdQ8+QlbQ/hWRo?=
 =?us-ascii?Q?U+cnntL6mdmXsBSQoPA5E30I1FSkLD0NGXeSuXlFX6MBmmAaBEafKqQ6YPKc?=
 =?us-ascii?Q?rWejZxrF3dIOJzzEdDSs0qfS6dkKxEYLeKAXg2VQG8ACTPrVR5ovBiX5yxfp?=
 =?us-ascii?Q?WwXHqJtn41hn5jQgXGnR2S+d5eABVvYClszcDUEOy28hGL+XlIZ8/Y1PxeB1?=
 =?us-ascii?Q?/YfYLdzy4YQd12rw3zaw2E0sjwiEFyICq5t/9qhclC60wqsEAOzZCj8oUFbQ?=
 =?us-ascii?Q?GyubIypXm3MyrNjNfCB7O2sM3oCWpuhrUncwx4EJV0CsfnbUS4/jI0dZKVB8?=
 =?us-ascii?Q?6gRvTX92lgTSl9t6xq7NMoDBstT4uMWRKV4u+fzo0mWiuKTThSbfNNz0NGWn?=
 =?us-ascii?Q?swzRV1zBRWfi1Ho31ZHT0dPAAkVIZV4C4rCVRXBgUiGG+vfUy2BS6QYFF7Je?=
 =?us-ascii?Q?vP5fGlo+xAwyGlrhxAuSkiGoDaUmCgwPDZ3AZv6c+5vVjnBOdGIGrCWcZ2IR?=
 =?us-ascii?Q?wdde2eTCmWmYIWBYK23vVOWOzr09zsyzsJe9au4uVheB++mvyf6KUhHEQfYd?=
 =?us-ascii?Q?gVwQKU7j0BYY/RgoN/xRdEf6HfUSTnUGX6978kzNIIcNUBxq1SBvinBXJ86t?=
 =?us-ascii?Q?NkIs57z/hFigeYRVjqpV6UGhPMbu4gUXV4hdp6vuTJbd9Y7xDlO30rpPjGz4?=
 =?us-ascii?Q?vWHS1u4nORimJ9rg9JiqY+hNYHPxCCgpBnuKEUlo0R1VB/YKfAFVAhOKzj1+?=
 =?us-ascii?Q?d2gbutoGEcEtfE6F+qJ/KBfGjkGpehR+Y9iX8o3BNLGxibavROKZScRZ9MuP?=
 =?us-ascii?Q?/aYhxGCGiDfqPtfbCO0cE75osp4ktQ72ICla9YrCBuxEE91XMb0hgL07RFRT?=
 =?us-ascii?Q?5CiCVhIEYPl0wE4Rxgy7TWRSGsqdRLDr4m5z/ge8Wv6zScPGEMdGC5YSFohW?=
 =?us-ascii?Q?TWIv3jOyiSkNpCAqgBF31nQ6245pzKlc/UgT5jM9FYyPe1MshYEdBFd2ElRY?=
 =?us-ascii?Q?MACGcWYZY/SM0oCR3cq6uVl8ryi0e9ngUB9yV8PIo3wedwOyAKLXNjqUwHqC?=
 =?us-ascii?Q?lmUJpgXZQ5Cu86KrDXD195HTxINRvh7ZNYROsGDQvNEctztQdAgx3pf4DJzb?=
 =?us-ascii?Q?2oBoe6qKhCd1QGpVdMIGxaysQR4mddeOuxSLc0jKMSO2FqYfkqIBPxSe1LRQ?=
 =?us-ascii?Q?16TbIyjjT6wr1YmLUJx/txSTtAbzWUKtU52osuaedZHbfgFuneaHSNkVh+wz?=
 =?us-ascii?Q?kcIzNjNAcOMIAlTl/XnOX5fsr+x1xuZxE4Gv5ejLBUAXDDM6BOutqox1H+/z?=
 =?us-ascii?Q?8Uy+e6dbStYW8bd2H1qt5lrVuNNDgFtbemvPyg2XNRYi19B9vEdMufPxuB+o?=
 =?us-ascii?Q?wgJKpyk89bmxbcJMmdiFxEo7oSNH8Zlh9js/PN60WXADEm10c7JgtsmfQeE6?=
 =?us-ascii?Q?B20eJV+jQwCIRjnv7a5ZTxQdcD9k/dpb9crSPt3Hy7jxWh3qPKR75DrH8hAL?=
 =?us-ascii?Q?pRweAcMzqLlPQerddXxzGIIOkI5aWfVypPmAV6tMGqBf1zjsKw44uMTOXlVM?=
X-MS-Exchange-AntiSpam-MessageData-1: wd/EbYLpRVOQ6f10f35dTI7ZvOtVsROohEw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48416f5-03cf-42ca-93fb-08de7d07ddf8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 11:43:07.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e6SCS7pVoJ+lw6esab1ItQOgJ63f+67t9hBQ/aP6I4qXSTcL7by5gqn4+r0q19wXr8ZeiQNGSfpIYQkgHS8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12426
X-Rspamd-Queue-Id: DAAA222FBB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6998-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org]
X-Rspamd-Action: no action

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Yixun Lan <dlan@kernel.org>

v1->v2: none
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


