Return-Path: <linux-can+bounces-7173-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBwNDfR6vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7173-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:38:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB92D3566
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 343ED3068BA8
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FC40758A;
	Thu, 19 Mar 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dcenMW8t"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAD408247;
	Thu, 19 Mar 2026 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959597; cv=fail; b=BTor59qPxF9MEa1qIA356oWYzPZso2kMjls0lnvKPcMfjSGQcFlBm6PDyXIbLNyDGMuXVO0YscVUDj6WsIEgr2iAJoz8DRukOmME6+UVJfC8NzfBEDmztmz2oHohF0FoPhakHhu+dxtbVSsmxdzOo4DwMZE7+Z3KfFRuIK9E3do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959597; c=relaxed/simple;
	bh=AqTAJmq493gjdgb2yxtT8oJh32lrmc//Sv8OhYHGjAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGh+IWSvOHI0Ag73ssyHOGdq8I06/OaBjRw4QGchUWlcGSmod47Xn7o/KzCBTcQEz71oolSKFcIqvMR0ch7fSB5+UK4QL7qMItPsuQMIe8uSslpi9XNwFn8exNf4HDZSh7iMh8WFDbc69/sMU+6uSi9kzUohkELJLsXic+v8GcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dcenMW8t; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=An9XIm1A8zuxy4NFpTjulDZJDVJ7Sh6NC9hXq7dVOOxuy3MBbk8KbByqL8yk4+sET2b8ijdSzh+3/dGHbSWQmxBaK8Rr+7DlM0dtQv5tSwlAQyNcaVaMLeug9edEOYnhF+EZ85UZrrQbUH8w7whK8FkVpI7yKV9XfT5JgX68zjsBJqxqftmvdlh6mFWzIRDivMgPXOnHcc/M6Uae0wrTSANhve3kO9ZMN+4nhy5juSDh/Y7ImaSHWfZdhbjJQ0bvKsXhzulB9qWt1dw0XbaFFVFfHaGsEBypMeOIQP98nEKefQPhiNrIX8ehgMRDhgl5fJrXweAZ2zOl+TbHgxS/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQZrQbYdsdyOqqUglKHwg9Gcv9xtTpeubwOEwuW97BM=;
 b=KQqDeDBanzaOvz6ggDCMzOeJkm6KK0XHIh87OzenGKQCoG53vvqQLBuRU4fVLmF3oIMKatvUhlOr6Ld1JCt8z644h4ImSBB1UTQIXL0NQJ1ivsfdOmVh5OAiQkOngydMLCbUhmdO1jQVuoWZNVfNwHbrK+BQ+X4+3wn73hoA1UtOa8EDVVxL7YIS2t3fIa7dGBQJueY9GpALY3f/MWozsrnkTxIrnpxz1pP25jWJZ77xG2dvhyd+03GpdsuB/njYv/c4pD+atlAitntw85wEeHjUvLvLUQZ9n5qNLXy9e+7l/EkXUtfiBR2XoaQEZlAXRg38KKMnsGlCEKQIUBmhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQZrQbYdsdyOqqUglKHwg9Gcv9xtTpeubwOEwuW97BM=;
 b=dcenMW8twmZe65u3G94bUHN9CAISQAiDNdy6JOFy812Ur45qxycKN55tJIcsCBEI1hUiZ+ZRgBmzUtyRwNa2VqgWZfeSCDq+Ot8xo7QkScaTikckFgsZGRR5kZvpllbTt5oHbzKvTAUrrNiWePhmi0wKr1pP82aXHN3AorjLWp4HO4EfPLnO/2Z0iTtHFZY5JIh1KyiZPfVi+OVxKSHCJQtUUGPyiDoBuayOL6YD4KLwF0wmXzRUwBGrAwdzfoKp6le4R91T0rXtvEFWbq86e+0b49uqn5DfB9tY+HGvx2ZNRczCwfa+XNwaihm3odvHL1OUY/tL1J1UxFKJro6TAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:53 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:51 +0000
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
Subject: [PATCH v5 phy-next 06/27] phy: spacemit: include missing <linux/phy/phy.h>
Date: Fri, 20 Mar 2026 00:32:20 +0200
Message-ID: <20260319223241.1351137-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0975ab-c5e1-414b-8cea-08de8607746a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m/6tlj4VFLnfS54rUubNffsmBCam+/lZbqjF22pHXN6sAtkoTGg2NbpGvvl7kRTRUe6RUW5l0tpZVq9gX1N3umRZ6mFp8/QZUb8wjCoHfRkjAfHiz35YtCfvI5eoBLwVMlWS5wvkVS2ZLfSAnXka3Yhvc/Yqu7czuLQa4gT3iMhJB2t5WpAtTaPF4Sj9UZkyn/WSuj5gPqs+Lud8QNTE03k7I9FNp0mtiJ5AF972qSVblWWgKdumXMValwEQmn3apOYUrDZjD5HaJnpZ9e59LJVpa3S6DeP5h2wI4MuMDSdl4PAbURxY4i8W5hgDPmiz7d0K2DQ7hGXvg7Km9Uojdn/h+JumcIC06Ien8201gwVj4x+atURi1D04bXzslHVchAHaanaSKu82J38OEz+sJUR2pVrhbLgtz1lDHXwMJ9qkt9VZSg8LmvLkdSJFnwO59PMKoIqzzft6vc8xNjULlF/ZqniG9SZYWqKmhjGPvRoJZRlRW8Klhww2u1yE+nIn4a4rZvw1E/HEfrW8W8ckQV2ytih9TP+gmam4pK4NtfsZeJkINKcdlHhwWxv0BCKb2QVGPX6JKiY38J8z+GVmh2mqA6P6vxtJYbIYs14Ig4pzY9bNE5jNJx7QH7Fu2JKZWIdCjBPTY7Kjc0Bb4rXd90jsdtE/AYAAfNPe9wmcFZjLykTOyQEusweqEWU+7bWarwE0pxnC6s70yFl4xmiC4Y4aV8NaxaQg9INFJSW9r80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXwvASTamedGPfM56h+xoua5m6DqljSxjlY9aq2FH62JGL332l9yCLi5e24s?=
 =?us-ascii?Q?dz4Y3ol3cZ/KODRItZIVPUNAkErFEGeotu6z3LSAV3u+x/st7NsqNpYqXLv/?=
 =?us-ascii?Q?t9xTjbMSX8GZ0FEKqg8VvlXChoHuKdq0yJz/Au4CBCVYJYNGal3bk99umrg+?=
 =?us-ascii?Q?i3oTcrVf4nP9q4Ns5CaRjrG7f/YdyA9RDGdR8iM+JEA3IXcTdB/OJPTkv6VX?=
 =?us-ascii?Q?JE6UCgZGyNTAs9XSg2HK/O+jYM2ahA4Udx/e/El+QgyFHXkPiJXO8MxcF4wd?=
 =?us-ascii?Q?b/j6mXbQEmfwKEKrFxg+fM8W1AijG9ypMQlHpo5pEMX4SpP9Q50lHDhtwXNg?=
 =?us-ascii?Q?WABZCZIYn+l2x6BWVbRr2w9h7XWqLlqqOSVNSQe6DSliR+lD+cDxlkVzY98C?=
 =?us-ascii?Q?sNTdMLy/NMAFBGOJUmO30kDxYvS3OODavTWIx8ZORoo2k7qhOGVoIV8Y/lHw?=
 =?us-ascii?Q?tGqs8sNqVTTDlRSZqd6bldFmPbcwj03plx0jaqUEj5YQYBwPKmPUxme0Ek8u?=
 =?us-ascii?Q?gLI+A36XLd2zCcERLEN44zJ27zewNvpkyJ5RC2G1a1vmkmxduPrWjBDDTjdj?=
 =?us-ascii?Q?vLOPWTaT6hBqh4LJgj0AyFzTAIXJ3GUvKbycJPckRlB3ePI+UMyVHv1HGVN8?=
 =?us-ascii?Q?GMwCm4x4/8qhGi8Z3AE3isNXUsb2NIn3rITH74rNRNbJ53kUTKwNb0oPWlF4?=
 =?us-ascii?Q?tmTiVoU/IbBUdVtM3bMAMifwVh2iCDRCd4P8TQ2QzCyB/Op+sE5oAqZVZLsU?=
 =?us-ascii?Q?0hcR6vJ27Sljb8bLgfiH/hAeUiafGCNzgEvp0pY98rWy7i9nemlbSqeFnk1w?=
 =?us-ascii?Q?wFsA8uDibaIh6pCZIQUKTDQbNbuw/Mm59KKS5Wpb2uZjtpguoop5zAWzbJcn?=
 =?us-ascii?Q?9osarZaQq05abgiN23pn+KSzD78Y2DomMtXVHgD3uyLz48uPc779oIQDr5ga?=
 =?us-ascii?Q?uzIFikluppCwtzGKMqSBy/Kgxpk6F+paCLF0yiK8r0vVIYHTLyst/XVxBiBX?=
 =?us-ascii?Q?nJklykjfjDG0VnsbBwGDPvZk6grHEs+TYAlrZQ0Qo3FfDbcIRN36Ey1S2R3E?=
 =?us-ascii?Q?yx2d0PU2vTCHL1JcGoRvHtttdqydo5lSo9rXLnU4izJFJ0AuXjkkQrtSqd1d?=
 =?us-ascii?Q?7k6tFmXxBFVIdVM42RlVbXnrEV1BYKsyCB+8AeT1ZUHR7L2uDG88AbBm8r1R?=
 =?us-ascii?Q?LN2ilLE+m5DnoTU5io+rxthJpNyP0ZlJ3A8SleEJWazL0a67EelQ6aLgj8D/?=
 =?us-ascii?Q?oD+ciZUy3rofWZAZEDwI/XjTJLtgHFhXtkNHtQhdTbQxhrUN5on+QfsIyHpy?=
 =?us-ascii?Q?NAk0T6jC3SyaSbkUeQnp1vCwHMfReWirg+nR2ENtawMa9FSIMnlW87RfCMG1?=
 =?us-ascii?Q?pKMIQY5Q0EVSTXaFTzCBsh2IiNT00rErrP7AQ1/hMKKe6dqVHCCCaDF/uuYM?=
 =?us-ascii?Q?X9Ga/8BcymqJBBOVLYphk7lzmZiQoAmO4wdMspNmHZJ2azz4PrBIYg2EvtUk?=
 =?us-ascii?Q?pXE0LBkcJ+p5ZjaUdzOdAqG3tWBChtFG8K0QGgEGNNH2/nLXBUkUixG2VFp8?=
 =?us-ascii?Q?tFTAqJh347EYCSFEVhdc9f35BHTIJTR2fPNaQLYOWrT1uyV0/ukiW1Dyd2hS?=
 =?us-ascii?Q?EQqq449olBSDSqdzIYN0L9fgYNIWAQdl6HIjyw2h+OiM2//nqIyUu/Bt0Mry?=
 =?us-ascii?Q?yFONK/dZJdZxXTyS5Ntk3I01o+lHXVtrXUvHh0cq0D5HGGLR4T0SHaqnHNPS?=
 =?us-ascii?Q?dA4wJChEOtspGOD6MQKasuGM0MtTOJEacpn0XD9DkDPi7xJjJ4kE70gBGkc+?=
X-MS-Exchange-AntiSpam-MessageData-1: pPGymHDRY8oO6ABIsZNBqlQSpw1Eb2s95N4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0975ab-c5e1-414b-8cea-08de8607746a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:51.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4vwC2sm53VS6K5uIJw1kPl/K6G/f2bK2z5OVH7CNuNsASndLJ7st9XVs/M8L4J+CAZAXlQepT5CS3kCsK1TfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7173-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11AB92D3566
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
Cc: Yixun Lan <dlan@kernel.org>

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


