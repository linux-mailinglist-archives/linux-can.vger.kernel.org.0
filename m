Return-Path: <linux-can+bounces-7108-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAUTB3/euWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7108-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:06:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C88FA2B393F
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E0973012B74
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C83F9F2C;
	Tue, 17 Mar 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfJ8HToW"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85B3E51D4;
	Tue, 17 Mar 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788748; cv=fail; b=IsfE1dWA21Yf1u9/n5P8JX6t6EQ7zEGmpPrdJ8bssbALj9ZoKHbTnWne9KQMn2oCG6rwfCD50mZtflFACzPkD2HewfDTNAcKSXJtJ2iAR42vDgp5I8GmiE/iN4AuMxnak39C/WHbLaIdfEwCpol0Ne6qDKeu0mG4FXP9dl+ZUGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788748; c=relaxed/simple;
	bh=97vW6sclxuHXOYBYBrfJ2JgFIW91XBo+QJVrK8CkIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qy7612QH9SJmV8W2+lFamRDnB4ZnHVwRorPaihSdJUnOGOrhEUoX5ukYcY1wG4fe4hcDEsQ7Gol+GcoTDaRI5jVYj0JvWIbB87DHxWAXutU8Whj0lug9HxwLCid/3sOoN5nAXbGkTJLfIG63do8q7rzND6Nn47rkEf/xXju1lyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfJ8HToW; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsRTsX/p7sBltPLPbD9rf/1Yvtz+fxix+F8a5RK2nwtPOTj62J6uSXLbclcKE8mS8IBOZ8sQmYonyhweTO3JwP2nu8r9zgIIPo7MNn600P8gidH4dJx62vBMSimPxvSTukBh8+zvKGfeWpNb2XjciHzov+dcVuYYjq7vSXVG4yMVR+/eI4Tx2jIb1qeyo5b4pqZFOiZgryJvOjzHBRHRVQ1HQr3WUuo5q+p8RBcYJHNw+pHQQxf+Y/XS5Zha/Vyy1ggVVMDLyZz9AUB5aQoptzR9s2WUo+A5De0y3VYMm1ZAPL4+Sm3G2bvoiDSHgQtqh+5XpmM9CP7M6SZI6Z9a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ue3Wn37qfK9s/zGyTOjZU5aBWxkrVYsgwHCf0nZRaY=;
 b=WBYhGyVWNMM0nRzEug9HcDFVsfN3VajOb+AoP5ScKE25J4ARdnl+l74oFSBciIx3zR8nR7MnrDx/d7tfqFTinKVGi5TrFYg+ozQOHL7VPZK7RqteVcqc8xz5zNN5EZu6CjgAp5e0OjqGcst5Vl2xVUEHMCF7wPT/Zr30jc6b8Ob/g1H0SYaZ8BK3DBFbL4X5q/Wbe647Fbp9l56A91yFgb3bl8CRQCCRUn22wWjTyv31smKW1/ULPDmoOM4Wos/ezbGJ93m/BLGcxI4XkGbPR2faNpeMsXAL9AfFv+9vdbRHRwFNhFB4ylFRi6lxFC6Nw1+J7PS/eIfUOrqGYvfLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ue3Wn37qfK9s/zGyTOjZU5aBWxkrVYsgwHCf0nZRaY=;
 b=ZfJ8HToWjDeBP4RBnJ7CgNL2BkPXk6ElRKew1uVScFRAwTShGtToFqH784Ma93EcfqZehk+DGgJ+eWYQoyfBbuDw8OZcW8wm2I1U6YMefKKlk5TpoPQKP8DuRLH/ZB7LdZb5OW9PJIUxYfNrrRqQqXAnpiTBJN7CP6bUifdqqV2aZxwLnX2rW2B8CMSskUjgbULUSr0Zp9vNKKmP5fz6Y4Zp1gn1hRXHLCybxJao1USjFmU3MTwJnuTL0FBTWdFtHL6h5hYtLzOyLf0o92XQl+WEHUmDDyasIb8W5uKRuEFR/6RePPaiXMi3d4vhCdG/eHrvMLzw+KwuHbkbnuzfjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:35 +0000
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
Subject: [PATCH v4 phy-next 12/24] phy: move provider API out of public <linux/phy/phy.h>
Date: Wed, 18 Mar 2026 01:04:48 +0200
Message-ID: <20260317230500.2056077-13-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::46) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 618a8f88-7906-4719-3188-08de8479b25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|13003099007|22082099003|18002099003|56012099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	Q2lwdUu0ILWFz9Qk7iBEEiCeGARm/CXrAje6WfdXbNOB5bs4dfF4fO/NAv3MNycP5mDDgQO/ILMkNsxyN31T4dVgCQNsQwQjoT0oU75MtsLCaZS1216kapbwb3rW2j6rn9qe1nj9hYnk3qXsmGZtlhKSQQu9C9zvEZski/V7NWFgTCZwoeyqF3wy6mQjOz36ivq5+fNiItWDCUMbFxZPZeYbYBKWeXKtvguz9GpQPeG5yYy0KBnTofd90AcpOiV+f/90ukEhiu5UfHc+S78qPx3M2Hopdp89l4RdleK+/Xtl9WqhaixF0PGrn7DrsvMhmCLTpjeK/n17Gx024nIRDBt9AVzaUL7p9eucV2Jahl7ctQMMpIkuqGCvts2cD/rAhjCjU6B81RF+cKQYNbBgbDpMcFKROQS/Fd/m1t6JtLBGKS4lk/Km/QkauRjQa2Bc0EZ2Ftm74h93LGyhEWpZ+4VH9RIASShm3pwq5xK6on5lNcGZHNdVkJQUEfGslrOozJJm9b5StJhktoUhRazwCETE0B9cXxAGkoRRoiUByqz9v611a3VxmLJefMHI6D+1PBnh2XS7UZLiapOstUR8VEieEaM1SVUz8gPi57e5kXFPe8+sgtoWYotRuvdI7RnywwdVig+v01h1DlrtVrw4ZS1HFlT/t5t95vynrI1/ESQbL+gunUvSEskie49Kvgy8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(13003099007)(22082099003)(18002099003)(56012099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ame0Lp4JzaasMOi5W8PVW/s3CKfFDmbxHcG7fzgherAsvAcqOuegwHRIENF9?=
 =?us-ascii?Q?m0D8qepmF4Rj5DZrYNlzML4fF3tD2yi+ZM3fT25etPvX1+BjibsI8StL01mx?=
 =?us-ascii?Q?A/9XAR/+RvYv4pOD+vaAw5pV07UgvswrMGKMSHACauDi5yaidjL7eIUTKKBR?=
 =?us-ascii?Q?yOVhbtra+n5wwDk3hKmFSVD4SDgYAN++pMrA56wB/ENP4mEWCTnFbI37v9kJ?=
 =?us-ascii?Q?2BOAKRhjx6+Fd7e4u/9seJdShMpXeIehYiDIZAoBe2uKbvD7vVNcvw3/waMC?=
 =?us-ascii?Q?lBnCD9Ae0ifNJ6W+aUxhHaCqCrbI1f/CLxve29YOTSF/YNZxsnCBiH8GqEZx?=
 =?us-ascii?Q?8PwrcixwjgSeMz/fZ91KY+eia84Nq1jXHkDPTQmnJ3/LA/SAXi1SJJCIxN+G?=
 =?us-ascii?Q?81b40KF8ABIHVCSJ1dsHyNkEmpyeHV3ivexGCcHgImgA8pRd+w83IsHg/p96?=
 =?us-ascii?Q?nHFGgFcFERjjb/eZU/BRl/18WkVxfUPvKNRQ5w8sv2KxYnNfmTwUn4TpROkG?=
 =?us-ascii?Q?SBGn5B7FVej6gg8pVgfVsVLfJpz4y2KHBfgc48j90yd5ZlaF+7BMT/sHZuj5?=
 =?us-ascii?Q?gCkxZEqS5bqx1C8UUjq9OviHQDZrOYf2gTqvQCmBcLHCoPlLt3DAks8Ymirt?=
 =?us-ascii?Q?3f/walEIHqOKQTr2v407+tGX4fg+bdWZLOXr3hRWx1I5aOBI0EN2q1WyFBk7?=
 =?us-ascii?Q?4zQylpLBKfDrLynn6tgvFYYhyj6PCmhBISEnBgNXfOWuA1I18DbJiCE3gcdE?=
 =?us-ascii?Q?8i2N3szgQNRHurdoip1rVVBHVgIH9+0jThgvT9eL2dvtkxoQ29F+QtTLb3/J?=
 =?us-ascii?Q?Mjf4cYjQTa2WqtePCMHHRjlLbAovmRFqYhZzK1SUFCy9t4z2HFZ9HCd18kVr?=
 =?us-ascii?Q?t/SbSbkxETusNofDMAia/lE90c7e9qrECHtRinPhUrzedbt/dkrPuh2RtK6p?=
 =?us-ascii?Q?J87mhj1OXlerWRGfzqzNQf49SNjTKjtvezVfTdiwIjXH6CvDydl3AOwehyBz?=
 =?us-ascii?Q?n4RtlPh3UlXy0fKpsOmcOHMJPjdq51Z19BE3sH4Yr+/kkmTl2uB69aKoQUI7?=
 =?us-ascii?Q?A0NwK67ZnnczFyDR9YW/KoKm+ViBfaAygRKhpcvpehgCstKizJTr6kCyzYq7?=
 =?us-ascii?Q?STXJl0T+qbRVHXa4fqQRR6ga+tSGeITWqN4a3xdFT8ohrSiKDCN5K1IHazA0?=
 =?us-ascii?Q?SwiYvUxGHUHI2sQbmt6zUsvnRGOfnCuVlKG4aqCi483SvgIy9fOt/z3ZwdVn?=
 =?us-ascii?Q?hrfwUgQz02v3FWCJmkj7OLEgnSa9/2SurDoVf2H6wRgxL6No1LX7Y5+mzlUB?=
 =?us-ascii?Q?VJOD7nOh3fwDTlwM4K/7xp9bfZYnFdtIm5xY/1ZJVI/FMikcoMTkQ4IlMqyY?=
 =?us-ascii?Q?l57084fuEQJuABdCp+51fiuD9t0m5/f5MLS9urjusshDmpMIXZOj0QihaUFX?=
 =?us-ascii?Q?JJRGXMhw11gDrDCYDA+xQu3bIcloHUsVALWeeUzsuETz9KwJ2/vbOZTggWO1?=
 =?us-ascii?Q?JDRlF10QCasrMvOa4vN0QVojgRCqP+ML1zvWeJKDfozYx1riTpNv0ZQ1LaUc?=
 =?us-ascii?Q?OZ6rY4hAcGUUOX6p9OZA1xti6gj3w6bTElW9iUYFIMlNuEF3aMjUQKJtzURg?=
 =?us-ascii?Q?0bxqEq0L7xiqIDaTRveKwaDpW0WdDZvr8/Aw4rTHO4FyAl9ZA+DujFwCL31U?=
 =?us-ascii?Q?brf/drf2daBEk+iQ84NplwfiK5rBzN2zQPjqLXt3egw9hxd+36os77en2fWF?=
 =?us-ascii?Q?MNo8i3lIJUq6GwedGCICJq57Gp3jk0iRxS3tq46pGyMTsEHvh7+JYZuOvOT0?=
X-MS-Exchange-AntiSpam-MessageData-1: DF7gB8nLPLdfCLRXLSPu+Q0kdHmmYyarP8A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a8f88-7906-4719-3188-08de8479b25f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:35.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJuKeS9HcdEL/N55PR7dsTbMIOO/erU1kOljn1L30/T0yrcOpoqYKWR6SNFNeM0yQlLdoB7gGBJUmOFiT3O0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7108-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,ti.com:url]
X-Rspamd-Queue-Id: C88FA2B393F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The major goal is to hide the contents of struct phy from consumer
drivers.

The idea with "phy-props.h" is that both consumers and providers make
use of some data types. So both headers include "phy-props.h".

Some slight points of contention.

1. phy_set_bus_width(): Vinod explains that despite the current caller
   situation (9 providers, 1 consumer), it is a consumer API function.

   The use case is that the controller (for example UFS) may have
   limitations and should set the expected lanes to be used and width on
   those lanes. A number of Generic PHYs can support multiple lanes and
   multiple width so this is way for controller telling I am using this
   configuration.

2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
   We do have 3 PHY providers outside of drivers/phy/:

   drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
   drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
   drivers/pinctrl/tegra/pinctrl-tegra-xusb.c

   but the practice is not encouraged, and with time, these should be
   moved to the subsystem. This is not something that I can do now.

3. We can no longer tolerate static inline helpers. Allowing these would
   make it impossible to hide the struct phy definition from consumers.
   I've made phy_get_mode(), phy_get_bus_width(), phy_set_bus_width()
   exported symbols in drivers/phy/phy-core.c.

4. This is not a change without side effects. In the transition we are
   no longer providing <linux/pm_runtime.h> at all, and
   <linux/regulator/consumer.h> to PHY consumer drivers. However, the
   in-tree dependencies should all have been resolved. Also, the
   movement of phy-provider.h to drivers/phy/ is at least "interesting"
   for out of tree PHY provider drivers (this header is not deployed by
   make headers_install). However, it seems to be what Vinod is looking
   to see.

For temporary compatibility, keep including the provider header. This
will be removed when abuses are all gotten rid of.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
v2->v4: none
v1->v2:
- collect tag
- fix path to phy-provider.h
- update commit message with the 4th point of contention
---
 drivers/phy/phy-core.c        |  34 +++
 drivers/phy/phy-provider.h    | 256 +++++++++++++++++
 include/linux/phy/phy-props.h |  75 +++++
 include/linux/phy/phy.h       | 497 +++++++---------------------------
 4 files changed, 456 insertions(+), 406 deletions(-)
 create mode 100644 drivers/phy/phy-provider.h
 create mode 100644 include/linux/phy/phy-props.h

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..a1aff00fba7c 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -20,6 +20,22 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
+#define	to_phy(a)	(container_of((a), struct phy, dev))
+
+/**
+ * struct phy_lookup - PHY association in list of phys managed by the phy driver
+ * @node: list node
+ * @dev_id: the device of the association
+ * @con_id: connection ID string on device
+ * @phy: the phy of the association
+ */
+struct phy_lookup {
+	struct list_head node;
+	const char *dev_id;
+	const char *con_id;
+	struct phy *phy;
+};
+
 static void phy_release(struct device *dev);
 static const struct class phy_class = {
 	.name = "phy",
@@ -606,6 +622,24 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+enum phy_mode phy_get_mode(struct phy *phy)
+{
+	return phy->attrs.mode;
+}
+EXPORT_SYMBOL_GPL(phy_get_mode);
+
+int phy_get_bus_width(struct phy *phy)
+{
+	return phy->attrs.bus_width;
+}
+EXPORT_SYMBOL_GPL(phy_get_bus_width);
+
+void phy_set_bus_width(struct phy *phy, int bus_width)
+{
+	phy->attrs.bus_width = bus_width;
+}
+EXPORT_SYMBOL_GPL(phy_set_bus_width);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/drivers/phy/phy-provider.h b/drivers/phy/phy-provider.h
new file mode 100644
index 000000000000..0637278a2d8d
--- /dev/null
+++ b/drivers/phy/phy-provider.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-provider.h -- Generic PHY provider API
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+#ifndef __PHY_PROVIDER_H
+#define __PHY_PROVIDER_H
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/phy/phy-props.h>
+
+struct phy;
+
+/**
+ * struct phy_ops - set of function pointers for performing phy operations
+ * @init: operation to be performed for initializing phy
+ * @exit: operation to be performed while exiting
+ * @power_on: powering on the phy
+ * @power_off: powering off the phy
+ * @set_mode: set the mode of the phy
+ * @set_media: set the media type of the phy (optional)
+ * @set_speed: set the speed of the phy (optional)
+ * @reset: resetting the phy
+ * @calibrate: calibrate the phy
+ * @notify_phystate: notify and configure the phy for a particular state
+ * @release: ops to be performed while the consumer relinquishes the PHY
+ * @owner: the module owner containing the ops
+ */
+struct phy_ops {
+	int	(*init)(struct phy *phy);
+	int	(*exit)(struct phy *phy);
+	int	(*power_on)(struct phy *phy);
+	int	(*power_off)(struct phy *phy);
+	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
+	int	(*set_media)(struct phy *phy, enum phy_media media);
+	int	(*set_speed)(struct phy *phy, int speed);
+
+	/**
+	 * @configure:
+	 *
+	 * Optional.
+	 *
+	 * Used to change the PHY parameters. phy_init() must have
+	 * been called on the phy.
+	 *
+	 * Returns: 0 if successful, an negative error code otherwise
+	 */
+	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
+
+	/**
+	 * @validate:
+	 *
+	 * Optional.
+	 *
+	 * Used to check that the current set of parameters can be
+	 * handled by the phy. Implementations are free to tune the
+	 * parameters passed as arguments if needed by some
+	 * implementation detail or constraints. It must not change
+	 * any actual configuration of the PHY, so calling it as many
+	 * times as deemed fit by the consumer must have no side
+	 * effect.
+	 *
+	 * Returns: 0 if the configuration can be applied, an negative
+	 * error code otherwise
+	 */
+	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
+			    union phy_configure_opts *opts);
+	int	(*reset)(struct phy *phy);
+	int	(*calibrate)(struct phy *phy);
+
+	/* notify phy connect status change */
+	int	(*connect)(struct phy *phy, int port);
+	int	(*disconnect)(struct phy *phy, int port);
+
+	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
+	void	(*release)(struct phy *phy);
+	struct module *owner;
+};
+
+/**
+ * struct phy_attrs - represents phy attributes
+ * @bus_width: Data path width implemented by PHY
+ * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
+ * @mode: PHY mode
+ */
+struct phy_attrs {
+	u32			bus_width;
+	u32			max_link_rate;
+	enum phy_mode		mode;
+};
+
+/**
+ * struct phy - represents the phy device
+ * @dev: phy device
+ * @id: id of the phy device
+ * @ops: function pointers for performing phy operations
+ * @mutex: mutex to protect phy_ops
+ * @lockdep_key: lockdep information for this mutex
+ * @init_count: used to protect when the PHY is used by multiple consumers
+ * @power_count: used to protect when the PHY is used by multiple consumers
+ * @attrs: used to specify PHY specific attributes
+ * @pwr: power regulator associated with the phy
+ * @debugfs: debugfs directory
+ */
+struct phy {
+	struct device		dev;
+	int			id;
+	const struct phy_ops	*ops;
+	struct mutex		mutex;
+	struct lock_class_key	lockdep_key;
+	int			init_count;
+	int			power_count;
+	struct phy_attrs	attrs;
+	struct regulator	*pwr;
+	struct dentry		*debugfs;
+};
+
+/**
+ * struct phy_provider - represents the phy provider
+ * @dev: phy provider device
+ * @children: can be used to override the default (dev->of_node) child node
+ * @owner: the module owner having of_xlate
+ * @list: to maintain a linked list of PHY providers
+ * @of_xlate: function pointer to obtain phy instance from phy pointer
+ */
+struct phy_provider {
+	struct device		*dev;
+	struct device_node	*children;
+	struct module		*owner;
+	struct list_head	list;
+	struct phy *(*of_xlate)(struct device *dev,
+				const struct of_phandle_args *args);
+};
+
+#define	of_phy_provider_register(dev, xlate)	\
+	__of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
+
+#define	devm_of_phy_provider_register(dev, xlate)	\
+	__devm_of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
+
+#define of_phy_provider_register_full(dev, children, xlate) \
+	__of_phy_provider_register(dev, children, THIS_MODULE, xlate)
+
+#define devm_of_phy_provider_register_full(dev, children, xlate) \
+	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
+
+static inline void phy_set_drvdata(struct phy *phy, void *data)
+{
+	dev_set_drvdata(&phy->dev, data);
+}
+
+static inline void *phy_get_drvdata(struct phy *phy)
+{
+	return dev_get_drvdata(&phy->dev);
+}
+
+#if IS_ENABLED(CONFIG_GENERIC_PHY)
+struct phy *phy_create(struct device *dev, struct device_node *node,
+		       const struct phy_ops *ops);
+struct phy *devm_phy_create(struct device *dev, struct device_node *node,
+			    const struct phy_ops *ops);
+void phy_destroy(struct phy *phy);
+void devm_phy_destroy(struct device *dev, struct phy *phy);
+
+struct phy_provider *
+__of_phy_provider_register(struct device *dev, struct device_node *children,
+			   struct module *owner,
+			   struct phy *(*of_xlate)(struct device *dev,
+						   const struct of_phandle_args *args));
+struct phy_provider *
+__devm_of_phy_provider_register(struct device *dev, struct device_node *children,
+				struct module *owner,
+				struct phy *(*of_xlate)(struct device *dev,
+							const struct of_phandle_args *args));
+void of_phy_provider_unregister(struct phy_provider *phy_provider);
+void devm_of_phy_provider_unregister(struct device *dev,
+				     struct phy_provider *phy_provider);
+int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
+void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
+struct phy *of_phy_simple_xlate(struct device *dev,
+				const struct of_phandle_args *args);
+#else
+static inline struct phy *phy_create(struct device *dev,
+				     struct device_node *node,
+				     const struct phy_ops *ops)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy *devm_phy_create(struct device *dev,
+					  struct device_node *node,
+					  const struct phy_ops *ops)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void phy_destroy(struct phy *phy)
+{
+}
+
+static inline void devm_phy_destroy(struct device *dev, struct phy *phy)
+{
+}
+
+static inline struct phy_provider *
+__of_phy_provider_register(struct device *dev, struct device_node *children,
+			   struct module *owner,
+			   struct phy *(*of_xlate)(struct device *dev,
+						   const struct of_phandle_args *args))
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy_provider *
+__devm_of_phy_provider_register(struct device *dev, struct device_node *children,
+				struct module *owner,
+				struct phy *(*of_xlate)(struct device *dev,
+							const struct of_phandle_args *args))
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
+{
+}
+
+static inline void devm_of_phy_provider_unregister(struct device *dev,
+						   struct phy_provider *phy_provider)
+{
+}
+
+static inline int phy_create_lookup(struct phy *phy, const char *con_id,
+				    const char *dev_id)
+{
+	return 0;
+}
+
+static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
+				     const char *dev_id)
+{
+}
+
+static inline struct phy *of_phy_simple_xlate(struct device *dev,
+					      const struct of_phandle_args *args)
+{
+	return ERR_PTR(-ENOSYS);
+}
+#endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
+
+#endif /* __PHY_PROVIDER_H */
diff --git a/include/linux/phy/phy-props.h b/include/linux/phy/phy-props.h
new file mode 100644
index 000000000000..11f36738165f
--- /dev/null
+++ b/include/linux/phy/phy-props.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-provider.h -- Generic PHY properties
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+#ifndef __PHY_PROPS_H
+#define __PHY_PROPS_H
+
+#include <linux/phy/phy-dp.h>
+#include <linux/phy/phy-hdmi.h>
+#include <linux/phy/phy-lvds.h>
+#include <linux/phy/phy-mipi-dphy.h>
+
+enum phy_mode {
+	PHY_MODE_INVALID,
+	PHY_MODE_USB_HOST,
+	PHY_MODE_USB_HOST_LS,
+	PHY_MODE_USB_HOST_FS,
+	PHY_MODE_USB_HOST_HS,
+	PHY_MODE_USB_HOST_SS,
+	PHY_MODE_USB_DEVICE,
+	PHY_MODE_USB_DEVICE_LS,
+	PHY_MODE_USB_DEVICE_FS,
+	PHY_MODE_USB_DEVICE_HS,
+	PHY_MODE_USB_DEVICE_SS,
+	PHY_MODE_USB_OTG,
+	PHY_MODE_UFS_HS_A,
+	PHY_MODE_UFS_HS_B,
+	PHY_MODE_PCIE,
+	PHY_MODE_ETHERNET,
+	PHY_MODE_MIPI_DPHY,
+	PHY_MODE_SATA,
+	PHY_MODE_LVDS,
+	PHY_MODE_DP,
+	PHY_MODE_HDMI,
+};
+
+enum phy_media {
+	PHY_MEDIA_DEFAULT,
+	PHY_MEDIA_SR,
+	PHY_MEDIA_DAC,
+};
+
+enum phy_ufs_state {
+	PHY_UFS_HIBERN8_ENTER,
+	PHY_UFS_HIBERN8_EXIT,
+};
+
+union phy_notify {
+	enum phy_ufs_state ufs_state;
+};
+
+/**
+ * union phy_configure_opts - Opaque generic phy configuration
+ *
+ * @mipi_dphy:	Configuration set applicable for phys supporting
+ *		the MIPI_DPHY phy mode.
+ * @dp:		Configuration set applicable for phys supporting
+ *		the DisplayPort protocol.
+ * @lvds:	Configuration set applicable for phys supporting
+ *		the LVDS phy mode.
+ * @hdmi:	Configuration set applicable for phys supporting
+ *		the HDMI phy mode.
+ */
+union phy_configure_opts {
+	struct phy_configure_opts_mipi_dphy	mipi_dphy;
+	struct phy_configure_opts_dp		dp;
+	struct phy_configure_opts_lvds		lvds;
+	struct phy_configure_opts_hdmi		hdmi;
+};
+
+#endif /* __PHY_PROPS_H */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index ea47975e288a..f208edd25afe 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -1,246 +1,38 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * phy.h -- generic phy header file
+ * phy.h -- Generic PHY consumer API
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
  *
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-#ifndef __DRIVERS_PHY_H
-#define __DRIVERS_PHY_H
+#ifndef __PHY_CONSUMER_H
+#define __PHY_CONSUMER_H
 
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/device.h>
-#include <linux/pm_runtime.h>
-#include <linux/regulator/consumer.h>
+#include <linux/phy/phy-props.h>
 
-#include <linux/phy/phy-dp.h>
-#include <linux/phy/phy-hdmi.h>
-#include <linux/phy/phy-lvds.h>
-#include <linux/phy/phy-mipi-dphy.h>
+#include "../../../drivers/phy/phy-provider.h"
 
+struct device;
+struct device_node;
 struct phy;
 
-enum phy_mode {
-	PHY_MODE_INVALID,
-	PHY_MODE_USB_HOST,
-	PHY_MODE_USB_HOST_LS,
-	PHY_MODE_USB_HOST_FS,
-	PHY_MODE_USB_HOST_HS,
-	PHY_MODE_USB_HOST_SS,
-	PHY_MODE_USB_DEVICE,
-	PHY_MODE_USB_DEVICE_LS,
-	PHY_MODE_USB_DEVICE_FS,
-	PHY_MODE_USB_DEVICE_HS,
-	PHY_MODE_USB_DEVICE_SS,
-	PHY_MODE_USB_OTG,
-	PHY_MODE_UFS_HS_A,
-	PHY_MODE_UFS_HS_B,
-	PHY_MODE_PCIE,
-	PHY_MODE_ETHERNET,
-	PHY_MODE_MIPI_DPHY,
-	PHY_MODE_SATA,
-	PHY_MODE_LVDS,
-	PHY_MODE_DP,
-	PHY_MODE_HDMI,
-};
-
-enum phy_media {
-	PHY_MEDIA_DEFAULT,
-	PHY_MEDIA_SR,
-	PHY_MEDIA_DAC,
-};
-
-enum phy_ufs_state {
-	PHY_UFS_HIBERN8_ENTER,
-	PHY_UFS_HIBERN8_EXIT,
-};
-
-union phy_notify {
-	enum phy_ufs_state ufs_state;
-};
-
-/**
- * union phy_configure_opts - Opaque generic phy configuration
- *
- * @mipi_dphy:	Configuration set applicable for phys supporting
- *		the MIPI_DPHY phy mode.
- * @dp:		Configuration set applicable for phys supporting
- *		the DisplayPort protocol.
- * @lvds:	Configuration set applicable for phys supporting
- *		the LVDS phy mode.
- * @hdmi:	Configuration set applicable for phys supporting
- *		the HDMI phy mode.
- */
-union phy_configure_opts {
-	struct phy_configure_opts_mipi_dphy	mipi_dphy;
-	struct phy_configure_opts_dp		dp;
-	struct phy_configure_opts_lvds		lvds;
-	struct phy_configure_opts_hdmi		hdmi;
-};
-
-/**
- * struct phy_ops - set of function pointers for performing phy operations
- * @init: operation to be performed for initializing phy
- * @exit: operation to be performed while exiting
- * @power_on: powering on the phy
- * @power_off: powering off the phy
- * @set_mode: set the mode of the phy
- * @set_media: set the media type of the phy (optional)
- * @set_speed: set the speed of the phy (optional)
- * @reset: resetting the phy
- * @calibrate: calibrate the phy
- * @notify_phystate: notify and configure the phy for a particular state
- * @release: ops to be performed while the consumer relinquishes the PHY
- * @owner: the module owner containing the ops
- */
-struct phy_ops {
-	int	(*init)(struct phy *phy);
-	int	(*exit)(struct phy *phy);
-	int	(*power_on)(struct phy *phy);
-	int	(*power_off)(struct phy *phy);
-	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
-	int	(*set_media)(struct phy *phy, enum phy_media media);
-	int	(*set_speed)(struct phy *phy, int speed);
-
-	/**
-	 * @configure:
-	 *
-	 * Optional.
-	 *
-	 * Used to change the PHY parameters. phy_init() must have
-	 * been called on the phy.
-	 *
-	 * Returns: 0 if successful, an negative error code otherwise
-	 */
-	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
-
-	/**
-	 * @validate:
-	 *
-	 * Optional.
-	 *
-	 * Used to check that the current set of parameters can be
-	 * handled by the phy. Implementations are free to tune the
-	 * parameters passed as arguments if needed by some
-	 * implementation detail or constraints. It must not change
-	 * any actual configuration of the PHY, so calling it as many
-	 * times as deemed fit by the consumer must have no side
-	 * effect.
-	 *
-	 * Returns: 0 if the configuration can be applied, an negative
-	 * error code otherwise
-	 */
-	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
-			    union phy_configure_opts *opts);
-	int	(*reset)(struct phy *phy);
-	int	(*calibrate)(struct phy *phy);
-
-	/* notify phy connect status change */
-	int	(*connect)(struct phy *phy, int port);
-	int	(*disconnect)(struct phy *phy, int port);
-
-	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
-	void	(*release)(struct phy *phy);
-	struct module *owner;
-};
-
-/**
- * struct phy_attrs - represents phy attributes
- * @bus_width: Data path width implemented by PHY
- * @max_link_rate: Maximum link rate supported by PHY (units to be decided by producer and consumer)
- * @mode: PHY mode
- */
-struct phy_attrs {
-	u32			bus_width;
-	u32			max_link_rate;
-	enum phy_mode		mode;
-};
-
-/**
- * struct phy - represents the phy device
- * @dev: phy device
- * @id: id of the phy device
- * @ops: function pointers for performing phy operations
- * @mutex: mutex to protect phy_ops
- * @lockdep_key: lockdep information for this mutex
- * @init_count: used to protect when the PHY is used by multiple consumers
- * @power_count: used to protect when the PHY is used by multiple consumers
- * @attrs: used to specify PHY specific attributes
- * @pwr: power regulator associated with the phy
- * @debugfs: debugfs directory
- */
-struct phy {
-	struct device		dev;
-	int			id;
-	const struct phy_ops	*ops;
-	struct mutex		mutex;
-	struct lock_class_key	lockdep_key;
-	int			init_count;
-	int			power_count;
-	struct phy_attrs	attrs;
-	struct regulator	*pwr;
-	struct dentry		*debugfs;
-};
-
-/**
- * struct phy_provider - represents the phy provider
- * @dev: phy provider device
- * @children: can be used to override the default (dev->of_node) child node
- * @owner: the module owner having of_xlate
- * @list: to maintain a linked list of PHY providers
- * @of_xlate: function pointer to obtain phy instance from phy pointer
- */
-struct phy_provider {
-	struct device		*dev;
-	struct device_node	*children;
-	struct module		*owner;
-	struct list_head	list;
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args);
-};
-
-/**
- * struct phy_lookup - PHY association in list of phys managed by the phy driver
- * @node: list node
- * @dev_id: the device of the association
- * @con_id: connection ID string on device
- * @phy: the phy of the association
- */
-struct phy_lookup {
-	struct list_head node;
-	const char *dev_id;
-	const char *con_id;
-	struct phy *phy;
-};
-
-#define	to_phy(a)	(container_of((a), struct phy, dev))
-
-#define	of_phy_provider_register(dev, xlate)	\
-	__of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
-
-#define	devm_of_phy_provider_register(dev, xlate)	\
-	__devm_of_phy_provider_register((dev), NULL, THIS_MODULE, (xlate))
-
-#define of_phy_provider_register_full(dev, children, xlate) \
-	__of_phy_provider_register(dev, children, THIS_MODULE, xlate)
-
-#define devm_of_phy_provider_register_full(dev, children, xlate) \
-	__devm_of_phy_provider_register(dev, children, THIS_MODULE, xlate)
-
-static inline void phy_set_drvdata(struct phy *phy, void *data)
-{
-	dev_set_drvdata(&phy->dev, data);
-}
-
-static inline void *phy_get_drvdata(struct phy *phy)
-{
-	return dev_get_drvdata(&phy->dev);
-}
-
 #if IS_ENABLED(CONFIG_GENERIC_PHY)
+struct phy *phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_get(struct device *dev, const char *string);
+struct phy *devm_phy_optional_get(struct device *dev, const char *string);
+struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
+			    const char *con_id);
+struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
+				     const char *con_id);
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
+void of_phy_put(struct phy *phy);
+void phy_put(struct device *dev, struct phy *phy);
+void devm_phy_put(struct device *dev, struct phy *phy);
+struct phy *of_phy_get(struct device_node *np, const char *con_id);
+
 int phy_pm_runtime_get(struct phy *phy);
 int phy_pm_runtime_get_sync(struct phy *phy);
 void phy_pm_runtime_put(struct phy *phy);
@@ -257,59 +49,69 @@ int phy_set_speed(struct phy *phy, int speed);
 int phy_configure(struct phy *phy, union phy_configure_opts *opts);
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 		 union phy_configure_opts *opts);
-
-static inline enum phy_mode phy_get_mode(struct phy *phy)
-{
-	return phy->attrs.mode;
-}
+enum phy_mode phy_get_mode(struct phy *phy);
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
 int phy_notify_connect(struct phy *phy, int port);
 int phy_notify_disconnect(struct phy *phy, int port);
 int phy_notify_state(struct phy *phy, union phy_notify state);
-static inline int phy_get_bus_width(struct phy *phy)
+int phy_get_bus_width(struct phy *phy);
+void phy_set_bus_width(struct phy *phy, int bus_width);
+#else
+static inline struct phy *phy_get(struct device *dev, const char *string)
 {
-	return phy->attrs.bus_width;
+	return ERR_PTR(-ENOSYS);
 }
-static inline void phy_set_bus_width(struct phy *phy, int bus_width)
+
+static inline struct phy *devm_phy_get(struct device *dev, const char *string)
 {
-	phy->attrs.bus_width = bus_width;
+	return ERR_PTR(-ENOSYS);
 }
-struct phy *phy_get(struct device *dev, const char *string);
-struct phy *devm_phy_get(struct device *dev, const char *string);
-struct phy *devm_phy_optional_get(struct device *dev, const char *string);
-struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
-			    const char *con_id);
-struct phy *devm_of_phy_optional_get(struct device *dev, struct device_node *np,
-				     const char *con_id);
-struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
-				     int index);
-void of_phy_put(struct phy *phy);
-void phy_put(struct device *dev, struct phy *phy);
-void devm_phy_put(struct device *dev, struct phy *phy);
-struct phy *of_phy_get(struct device_node *np, const char *con_id);
-struct phy *of_phy_simple_xlate(struct device *dev,
-				const struct of_phandle_args *args);
-struct phy *phy_create(struct device *dev, struct device_node *node,
-		       const struct phy_ops *ops);
-struct phy *devm_phy_create(struct device *dev, struct device_node *node,
-			    const struct phy_ops *ops);
-void phy_destroy(struct phy *phy);
-void devm_phy_destroy(struct device *dev, struct phy *phy);
-struct phy_provider *__of_phy_provider_register(struct device *dev,
-	struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args));
-struct phy_provider *__devm_of_phy_provider_register(struct device *dev,
-	struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args));
-void of_phy_provider_unregister(struct phy_provider *phy_provider);
-void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider);
-int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
-void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
-#else
+
+static inline struct phy *devm_phy_optional_get(struct device *dev,
+						const char *string)
+{
+	return NULL;
+}
+
+static inline struct phy *devm_of_phy_get(struct device *dev,
+					  struct device_node *np,
+					  const char *con_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct phy *devm_of_phy_optional_get(struct device *dev,
+						   struct device_node *np,
+						   const char *con_id)
+{
+	return NULL;
+}
+
+static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
+						   struct device_node *np,
+						   int index)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void of_phy_put(struct phy *phy)
+{
+}
+
+static inline void phy_put(struct device *dev, struct phy *phy)
+{
+}
+
+static inline void devm_phy_put(struct device *dev, struct phy *phy)
+{
+}
+
+static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline int phy_pm_runtime_get(struct phy *phy)
 {
 	if (!phy)
@@ -388,61 +190,59 @@ static inline int phy_set_speed(struct phy *phy, int speed)
 	return -ENODEV;
 }
 
-static inline enum phy_mode phy_get_mode(struct phy *phy)
-{
-	return PHY_MODE_INVALID;
-}
-
-static inline int phy_reset(struct phy *phy)
+static inline int phy_configure(struct phy *phy,
+				union phy_configure_opts *opts)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_calibrate(struct phy *phy)
+static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
+			       union phy_configure_opts *opts)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_connect(struct phy *phy, int index)
+static inline enum phy_mode phy_get_mode(struct phy *phy)
+{
+	return PHY_MODE_INVALID;
+}
+
+static inline int phy_reset(struct phy *phy)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_disconnect(struct phy *phy, int index)
+static inline int phy_calibrate(struct phy *phy)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_notify_state(struct phy *phy, union phy_notify state)
+static inline int phy_notify_connect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
 	return -ENOSYS;
 }
 
-static inline int phy_configure(struct phy *phy,
-				union phy_configure_opts *opts)
+static inline int phy_notify_disconnect(struct phy *phy, int index)
 {
 	if (!phy)
 		return 0;
-
 	return -ENOSYS;
 }
 
-static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
-			       union phy_configure_opts *opts)
+static inline int phy_notify_state(struct phy *phy, union phy_notify state)
 {
 	if (!phy)
 		return 0;
-
 	return -ENOSYS;
 }
 
@@ -453,122 +253,7 @@ static inline int phy_get_bus_width(struct phy *phy)
 
 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
-	return;
-}
-
-static inline struct phy *phy_get(struct device *dev, const char *string)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_get(struct device *dev, const char *string)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_optional_get(struct device *dev,
-						const char *string)
-{
-	return NULL;
-}
-
-static inline struct phy *devm_of_phy_get(struct device *dev,
-					  struct device_node *np,
-					  const char *con_id)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_of_phy_optional_get(struct device *dev,
-						   struct device_node *np,
-						   const char *con_id)
-{
-	return NULL;
-}
-
-static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
-						   struct device_node *np,
-						   int index)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void of_phy_put(struct phy *phy)
-{
-}
-
-static inline void phy_put(struct device *dev, struct phy *phy)
-{
-}
-
-static inline void devm_phy_put(struct device *dev, struct phy *phy)
-{
-}
-
-static inline struct phy *of_phy_get(struct device_node *np, const char *con_id)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *of_phy_simple_xlate(struct device *dev,
-					      const struct of_phandle_args *args)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *phy_create(struct device *dev,
-				     struct device_node *node,
-				     const struct phy_ops *ops)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy *devm_phy_create(struct device *dev,
-					  struct device_node *node,
-					  const struct phy_ops *ops)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void phy_destroy(struct phy *phy)
-{
-}
-
-static inline void devm_phy_destroy(struct device *dev, struct phy *phy)
-{
-}
-
-static inline struct phy_provider *__of_phy_provider_register(
-	struct device *dev, struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args))
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct phy_provider *__devm_of_phy_provider_register(struct device
-	*dev, struct device_node *children, struct module *owner,
-	struct phy * (*of_xlate)(struct device *dev,
-				 const struct of_phandle_args *args))
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
-{
-}
-
-static inline void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
-{
-}
-static inline int
-phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
-{
-	return 0;
 }
-static inline void phy_remove_lookup(struct phy *phy, const char *con_id,
-				     const char *dev_id) { }
-#endif
+#endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
-#endif /* __DRIVERS_PHY_H */
+#endif /* __PHY_CONSUMER_H */
-- 
2.43.0


