Return-Path: <linux-can+bounces-6908-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOUhKC13qGkLuwAAu9opvQ
	(envelope-from <linux-can+bounces-6908-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:17:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC812061FD
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974433135074
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9D411634;
	Wed,  4 Mar 2026 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NdYtsoKF"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B43FFAAF;
	Wed,  4 Mar 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647252; cv=fail; b=biPEWa4jCgmKiKfRgzXYC0F2bFX4gBcRnepYXWBBp2sJckGC46S0GRmWpFgIh4caJ7CTk3aOjMc+dC/CUnSj0mpOo6z/INRpatbrNtFoUK5cCKZvVaF/ogoH8jHehfIbQv6iKIQiHb5lo3SqGwkMW4U98L8zNaanHiifpVKZnDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647252; c=relaxed/simple;
	bh=vDQDdysH8uQIVXcpMJBGQUhYCWmfJs5GSJuUmWwhz8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YH/XjKrfNF2/9Vypz1l8kMq3yp1g2bry3fshhavcShFo7dlFkIEf7DhptkF8kOVQXh4qyqx0yPzFfdIUEGA7Xmkjes9Wi2AfAB4XbJZUXZEdbvrrX++qkgzm80HVpkMW4+jlifHjAhI8cAklTR2G//bDLWxFQQ4YfPwzCQD/Rk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NdYtsoKF; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5/dhSvknCenkz90bG0cOm+9smJ1VDY2fFWJG7Bn5KVaF7qsBkgU8tI2q1bZVis6YY1CqJqauek8Jxz2O7RuEEo6yBpR4s/ewfqJ4urFsNVyxLWeId/LYNYrQv0TyTwqVbup8qIkG+kJq+HZS2gaUYbvcTDl4BLEUQpaH4VO5FZka+SI+TbmS8KBemwgvbwcXyjFKgx0gRiu1eeBPzbmowU//9KdRXCA/sEslaou2bwaN+UzGujdadOEUbEUexx/gF0gAeVD/OLzJ7R6JU2DPXmPL6rpMQObmm/2kHyxGMbK3l2sX6i9ZMXcUBDQY0PSPJzaELZlKkiIC57FNpoteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TufLQkkJicSIiMXLOmdkprNfKKLjXmStM1jfSJ1WAM0=;
 b=yu6jblo7mFHqkWZxInMxT7+ajMp5zENa3HE/GYTR8q5JH8OWpbyj5bZfybmXOj7w1pirHu1laP0TefCWuFMRxXpo1FACMY06JVLlRYDoVj3FFMhIoCv/Fu8l9lA6COeDW7geXMwAIHx9ybNwjanPKhoJBQjiwHDVKNFnX4VjGGsWtVKCSKsQFE/HB86xmr6ImRmRls4ko1tiecdyH8ZhTmcc6DVytg3TA84U432SSqTjmatYrzU+AfZtSzkA7meYjwPgtXM8B/1j6WBqORAoOrskIkOLQhwRHcpiMeS1EcyuAQp+oLiUC8p+TuvvDbcPkpz077vh/zzYmXdaF0rI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TufLQkkJicSIiMXLOmdkprNfKKLjXmStM1jfSJ1WAM0=;
 b=NdYtsoKFgnqXldFvG5DuuY6rDsC5DgjnJlvokwFUqsHgpbOut+rMhmH18VMo6uII/R5n1p+CztkIKxgZTVJ/xluDw7xcMM7Oh6QbW0uFYUWNLC5nq8O7LgZGLn2cZd9WXPkAk05G5XMt8QjdJ1PKj14EG7bR2QswIHjRaFbVUZJSZ1IRoP2ssw7kyISW9+7BpMMlPuXNVXRhcDXkP7izDGOJfDEDYS2/iMTr+HQZhDWs0VjZZRsZ6TzQalMfdgOP4ecNIk7UgBdHg5H1MIuPTll2sPi+Dnyaoy3tKeKOaQMUt9Aw/eQRsKmOtFs6kY6AjL/6vILuaKBlv3VXIi5dgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 18:00:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:00:41 +0000
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
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Date: Wed,  4 Mar 2026 19:57:35 +0200
Message-ID: <20260304175735.2660419-23-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: ec05bbf8-40d3-489b-029b-08de7a17f30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	+SBK3VHa1vZFfOpMFSaJye05PDV6Gz1zMpqvynvth4ses8x/WIzrCmh4zxPy5wxjNoZXoBpyHm2rceZR/q4aI99iJdE/M1dwD2yY3AnPjalydxlT/EuT7JSS/p9NxuwNMxZv9mFi59EuROhJW4dx/LFoZEocxkNLVN2OgfMcHNZ0a9E3cTP/fN9H7vese7UB2Qjb/NSxFXGisNjlzhFpFXd6+mUfXrO7MaI/g/+mhFXbjGv8QKHbIMKN020ho8NlRMMPpoUwC1Pqm9k83FzW4f4BH+h6U4G/oaiVKesY3bWxVO+VGYDzne6vYKl3WSZM7sfFGk/FK587q3o78VOZvOV43pEah5zITbjXXQ7AkUdiya2Pttt53Njhtc6YQvoipSpddUmblmiYlNXSFU4+lizLX06P28StyC2C4wN9t9hoQp4zQE6NxNcDxPbUV4gzbzXRVLyTPMDc3A55pi9/vNdmKBsHBAAtoygwfZrDHzwE+PJ9dyTG44YgsrXkjg7TSdEB8J60hrZ/r5QPFO4c+SvCTK+GHv1A1UbwpIrzYo9THe6t/zAbYx2L2T8H+u1g0AfeZ3Vileez7U1CI72fJyOpslUZpMVXPkSbK2aUsYqOI92YSjGR8G8GFHrWiKP17lbjtVCPnKgAjlgEG+Iwex/U/eluXPNUxdobjgwJ/MpkSBgU3Gib7bfV3HMs6m1k9ILf9GF/BtRiNqnWaMk51J0aJZ+o54/AyvHM4onjsfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKopRMUnQUHc8NUFY7AZAI3xNfDDSroafoZQmWRdbb8wYktTtr7hgApmWe22?=
 =?us-ascii?Q?Ad3x27ywMBCkjQartSDWvCtsBQ3VAWJmWR1y+ABAYoZMlF6nvffRhnZl2ZlR?=
 =?us-ascii?Q?Q8Gf80Ok+6geFdl6Dk6yj0KOzefJJ/nqxfVJZIU6QbdS/d7QdysnqNjNhh1Y?=
 =?us-ascii?Q?tFtCzvLcfidLSIUtNqmB0JpPIZCyQtQ2fhBBQt9DRTRa4sOwGx9s47uYC0Cx?=
 =?us-ascii?Q?+8YIupQohvjKyaQTxzEGr7wkM2WJDa1ZzXNxzpgmEbn/ZNYqTfGxzB64+FMV?=
 =?us-ascii?Q?Nk8O4ayLngu+8aDBHbGdvBgbGq7FKRRMwwuxbw/k/4OL9Q0zDovT6YcZhvvX?=
 =?us-ascii?Q?oGMZG+7opNfxETuRKogyZJPy0KNnlykHDK9L1WRzKXGX6hkUG1a2bdoPLyr2?=
 =?us-ascii?Q?p7D6VvCxaVp+yitAa1179m1+j9UYFM7yutkDS219v+mHm98+vu7D21uus9/j?=
 =?us-ascii?Q?pD+RhHdK9EU34SozEV8E4W7xpzaihCDsnWByq1G/CzjCp+VnWfNj55gNFGQw?=
 =?us-ascii?Q?yzOfqsyFPGKJkxxfmJobSLAFQrosDW/q0zSSKAyc94HmXzJh+9RA8KSduwRv?=
 =?us-ascii?Q?QUbUO4PzVLmzxl1TBpCBvOUx2/b73hup5kJTlBq59iVP5JHhIYLL4FKx0jpM?=
 =?us-ascii?Q?ad1tL95Oapy7KdWmJFp9QsBEznLfGBTaKYY+AB0xM4VUNDFrxNA9HjuJJ8za?=
 =?us-ascii?Q?TxxH+tGgwu0BXiPC++o6/ZQuY065pk1wD4BS9XKTRIjb2u5pnuzWKVdCqGBe?=
 =?us-ascii?Q?peHJFxd10yAkGJP/JO9bEi/nOeqlGVt6Ni1cVCc2JXKPxh2kARi5jS2eLrau?=
 =?us-ascii?Q?mznkwKXbUHorUTVT6/iUG2TZAN3dWeW9zjKxqaBJUqNMXXnQJ0Jy42OfmHXz?=
 =?us-ascii?Q?MjdPi/MsRx5RYKWWiJ2f4XgApnLfcBQoHsMsQP9JCbTCNNPS4ATuqKgNnZRy?=
 =?us-ascii?Q?jUfoY6BicjMHo/7NosFdCwybSqeE/efPR7hGool8olNkC3chSYOAqn7q7/L9?=
 =?us-ascii?Q?ntxiYsMtPbwceZ9kDaNFurHvzs7MT8sZyWDmkTLwfb0Ak+51sRnM15UuAEcY?=
 =?us-ascii?Q?mKamWPzvdahQGGnz4itl+NE4ei4Jr9LVwv9iVuMvGyMfGiHG0w4zuQCgaFtc?=
 =?us-ascii?Q?Vb1MTyW9NiTqDmWULK2eXY2zVcnWgzJMMXBXrAwbV8MMj9xri/X/o6JFtjzr?=
 =?us-ascii?Q?sXr2lR3XBPp8nhte0F9w4Q360pCfwpNMrECMesgpQj/AekSTZAXo4JcHQbW5?=
 =?us-ascii?Q?dGrzs/elcGX3lY6yNzQlH79z0Kj37unESNZmU9RUlkOZfhlAY5wwMLnqtUSk?=
 =?us-ascii?Q?9Ammz77cUiJ5PbyIVDApwMwAr0uS0iOGwpC9O4ZYFVjLXSrdybPAuBy8/dYw?=
 =?us-ascii?Q?AcZk24sCznKc9kuHUg4xpg8OdVwhR6fmV+ct4YheQIeIjWxn+kdcnmx8x511?=
 =?us-ascii?Q?+rN1paEGBiKoYDbFbynzyA8TjhkSUpb6szUwZr7yrYmeyLjKla6N/1XzydtW?=
 =?us-ascii?Q?19jH46UblRopzT4VJ7dAg/7N++EfpApIm7OxQrS+2ubI4ll4+Y71lBbCETlM?=
 =?us-ascii?Q?UnMb91oHWoE67W4ihxSitNORSCZHXK4MGfRsE90NgPBT6O+3hcFVnh7reCgi?=
 =?us-ascii?Q?KxQay0bmnoVdA9tzJi/ivmXqrIY6NsR9w8tV3ytE2XEUM1oolrt9lH+a3I4V?=
 =?us-ascii?Q?ElvvFa7SmI1EV3805tvCSwfvy3vB+FcI+Ne7noSPRAVjU2qcKyc9CCur6tI6?=
 =?us-ascii?Q?iudTL11fQyiVwswGQYuN0UI0CGjhLxGYtPrZapwzO6YPnkRUUVGbwesv25Cz?=
X-MS-Exchange-AntiSpam-MessageData-1: a/e0Snxr9Mr7YKO8XJVVsH1AY+hWKDiZvIQ=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec05bbf8-40d3-489b-029b-08de7a17f30b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 18:00:41.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hav+faJSFtcsdnxGhRK0OVzAN+CtIQjA+X/PCA/OoH6DY10G0RTe43uOcrp+Fhq8+OIOU4cF439iPwzJYUWruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275
X-Rspamd-Queue-Id: 3EC812061FD
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
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6908-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sang-engineering.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Some pragmatic shortcuts are being taken by PHY consumer driver authors,
which put a burden on the framework. A lot of these can be caught during
review.

Make sure the linux-phy list is copied on as many keywords that a regex
can reasonably catch.

For simplicity sake this is not perfect (devm_ and of_ are not valid
prefixes for all function names), but I tried to pay attention on
avoiding false matches on things like:
- drivers/net/vendor/device/phy.h
- include/linux/phy.h - network PHY, not generic PHY

So I used \b to try to match on actual word boundaries and be explicit
about what is matched on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..bdfa47d9c774 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10713,6 +10713,7 @@ F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/dt-bindings/phy/
 F:	include/linux/phy/
+K:	\b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.43.0


