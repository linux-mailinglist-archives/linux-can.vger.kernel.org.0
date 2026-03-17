Return-Path: <linux-can+bounces-7110-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLopJhHguWk7PAIAu9opvQ
	(envelope-from <linux-can+bounces-7110-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:13:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73E2B3EEC
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C0B317525C
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF963FB7DA;
	Tue, 17 Mar 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nImkZ/F3"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218F3F99D2;
	Tue, 17 Mar 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788753; cv=fail; b=tMPgltrOelmuIhSFJxDXyuvvSmPYcquU7AJvstUWV7jHjtoom5t+kVX5Gl41CsX4ogcN00onPsHVH5Qg8I/PsfR734RjQ2dxOeBLtBgdOhWtjuKh8uqjyvy5qc7n9z+qhWPwImyQ0oF7y4KFvnlwBag4C8ak9fFAVeI6qFk61V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788753; c=relaxed/simple;
	bh=hUbnx62M66gldjJA6+O0dQIpR2colqe1dKRM7JqbIUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciSn9MlUBupvxZeRVxRZ/xs7O9C8yFsm3OOsEmTssHF2PCM55FdH83AyNP4vGwFQ6KyIMxMchao1lf3mV3x4n3lJCoj8dydYyt20c2c5Aj9aM0QQc0BI1xMXMpH3aPu42eqMoqRQgIJZdVPhWh/syw8oaBMdkNy+3a7yDzB2eXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nImkZ/F3; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxCgNEuwZSLsScz4tKxhUmwScYiWkJ0S8mmKsRned9J+6qvSegZFgO66TpE03ajXf57DwxKfeKuBDcjllpFlU4laPhSx/9vZQngpIxQ11x/BbOxoCaB0Xu0eBSKAkRLDRJzQGPkmG6R1vFRcLPia5xJz8fcju0EjrAs3CGVc7bhBu7sgHuIc07iHFOa4LqSUAFkjkZUYls5Gsh3UquikdnZDMf38IwT51SqIfXts9lgz1RPqME1tKzfQU969iMYl4fC0m490pMkkeYNUWxKj0TwsrepqGn3vDHZmJ9gxDHdMcMwESFt5veLTaVVWkWQ4IayQ/1g/VwSZuFbxC6yyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dojJxYIcHAWaavMLLA54EwTbGG86Ri0c/DPsrBQcGPo=;
 b=RnyqQa7CmJunmtA5L4YVflShiGCNHPSrw3nZJTrhgTe3VTqvebVXao1NI4n/RjRu5BUBQ5/6H9OiW8R1k79OobxdctKcL2CMWzSqy53rggqYnTM/lmjLvrac5xmaIx0ZMLzoCiLwLe9XyTVcKyqpLb83apsqh8SzNv7RS95fs1jBMV3bPCsJyD36HQ7JY9rgO1FrMRsqTjB69qzQ5oO7mJkKBv9zlBK/HesRvRhqcNH4zHL2QJpDR5OqU4Spu8nxoqkcA51zY/WEwMtC7rFek7dPRfOFTGs06njzIEQoCwDAKI7jT0GlP46p09pfXUhyO9k9Iv6rp1h3o55KIbpqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dojJxYIcHAWaavMLLA54EwTbGG86Ri0c/DPsrBQcGPo=;
 b=nImkZ/F3pyBUWn1GHlJ4c2z2NB2hvEZyovtkc99uSZnp4dh484tEaZIBa7I6wVQdXD1Z0s3awbmfsSroOqcYp2cW+Kf1VR1dqExKXoxBRUNpM3pxwj3O+ZSf3A6MSryAYXVWAIUkWEYE0gklUdJdYHEsJgxk7x69EYEaWFwi8zW9iEOcx0ZWGPTAjCfxqvaTenYxv/tzKDY1KoNOJa82lET0Nv2DMxiPOHWvUQz4K3kiRBJ4lH9rMvVt8/xW+GZgwXjG0VH7iQi3icE+sAknggGV1icvuSP20l66ehagdXJKQ7s9OlpRSOFf+T/5k5/n+oJMX3c2ZT2ZBeQZliNBrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:25 +0000
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
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH v4 phy-next 07/24] net: lan969x: include missing <linux/of.h>
Date: Wed, 18 Mar 2026 01:04:43 +0200
Message-ID: <20260317230500.2056077-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e6ec25-c44e-42fa-4da7-08de8479ac22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2+XlJLDg7k2aO+SnOteEZSzPF6LAs3Lg2WnIgHyVolVG9WUYQ2Au/FbzrttkG37VOUiJs2G0aZ/xgUMvFaDq1NsRda0tidHNMh5K4b6Jpkzg0a3Ecia/aqUE6qxNytwqZSijMoH8AYq2y1n+fDoo9L6Sw+W44QueWjZs3NsW9pv5EnQN2PluyjRR6j+q6L9EqBHPBf9CE0SrAVU9PhcEBHil+59S8YSbnbkSkBm0Ti9aMo7tCV+iGt0D4u/Xi8tGxi4sxv2RlmZekWapxH29wDcf4S3Kh4WHfvgZbfh1lmbcF0/6xNns45Nz67AOTFGeVgvI/zlnSbPDhYor7/VHrCqoZkU3oS4EVLE8nE/WqPEXgx90n/+aQRKLNPo42ljNLEoMPvOcipTA8tElOv/8/Tr+uGfK77wFk8EW4+8OoPkmBtjit3wPa7Mhy2md2eiuGanwPbspdx6L26idKzjfTL1YTbWXRtbHTyYoetbFsQw9dV2ak3JguG4DnzCnfjtpaz5NzUwZYNx5dkRCyietM6BptrJGE1CRKgx8y7oeqNv2Ck5mNCpePQ7U/xuGhoTdFRMiNVAz6Z0muunuSAFl6j9KMwjzhLIeq/lpVqF2coQI1pqloykEpe5Uq2IEDPFJu34bauvUhA+QS9uxQ9BmOPRE2aY19TADnl739KGUXZ5VBrAJ1b+gT295eNL40GKd47Qgj/cN8wZypBKY0zwZa8TyXiRupvexm8U5PGAR5FA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHKeTKS8j12NTZUsufnOgv9pj265DvSKTEaYUtdvHh08kGImILahxcae/iya?=
 =?us-ascii?Q?Aw3IZev2/6j5xaO9jL6+MMxDQJkwFG/ORBLQjD2M2BrhQ5REIbeNKTlyxZyH?=
 =?us-ascii?Q?Oi+7E4PhDcMZLtRVaQ48CUNGJgaXJ7aBONStGc6t1WEhTdZuPAQu67u82Ce7?=
 =?us-ascii?Q?FXLd/BOcBILIDGVGI7qG//nEf9Azn/5a+HBS9GLmMYaZNUhNR+AVavKBxFN4?=
 =?us-ascii?Q?nlVz50YVbVjnyiz572K2zaYmyJ6Ut78sT5EykN0IsHPoHmShXPFhpLxLtmr9?=
 =?us-ascii?Q?4mR6kWne7+TtzpU6wPfVVHyU+qCeUTQzlL/JSUImhaND2rwdKxz0umelu1Tg?=
 =?us-ascii?Q?N/4cCOAVP7hemEfL88v4vkHm0OQILYW+XuGXHacS5buRrzmhEYFmbJ9V+YMK?=
 =?us-ascii?Q?145f4F3fEmrLOpMAY16xbWan9mHDcINwTJmrw6bWyB9ys7Bsx/8BOqHvPcd8?=
 =?us-ascii?Q?uhBmHy1MrdOpKrO8FltBFoME8oOU7yTfSqoTlvYOOxOxqAKLKCSk6pBq7XKR?=
 =?us-ascii?Q?GlqBRF354fVt5/JBaLxTDnxxAJw8tA1jkPKOnWEupUYm1KDKnnobVRQri3K0?=
 =?us-ascii?Q?o1aQL4v8oP621asOVV6jrtCdoAvwCsXzP9kKuqDgK+WKSbAXfPtsLy+SEtUf?=
 =?us-ascii?Q?gnqBduEZHomymszEgBdrFo7PaYBZc/vI9sBOg7BCJBgQdBafHkrWBNwbTwZb?=
 =?us-ascii?Q?YV/Sie/Crdw7+vJ19uCHpBwQQgqK0CuIrilgawayMkzFUSWDk9GQ/As2Ji9y?=
 =?us-ascii?Q?AadxBH7Eo6jzxx4ZI3/sMXW7TWqusoZKdMg4L85Yl1KrQc/ik8nwyXC3xmgc?=
 =?us-ascii?Q?8AV3aNLeOUnMOFT17HEH3S3eGFdzMMfRcX3OQqn3tuouJ6bzAcNkDAiXpmFK?=
 =?us-ascii?Q?T48VeJKzJ7E5wwSLsAqsp8LJaNfeDuG72LPM5brmKRYw+jMsNJCkgK/nSIcF?=
 =?us-ascii?Q?yzwbIhtmRdpTtBTurBUkZ41eYHcSAwNRvJEFM+TA/Jcp8rk8ACHrmNTQjDDo?=
 =?us-ascii?Q?AEpkIy3NlU0GyF8sX7pTfp1tvAIszcW4Afba4XaPBEVQS0PVHyt2T38h8/m1?=
 =?us-ascii?Q?9069q3XMN3/HNtUwlliBw1DjLzcvMP7MgmoDKsCv6Mly0/X3kI/nPHT4b1Kz?=
 =?us-ascii?Q?3E+sG/OFhaJyMCI13iGgLsxo7Fy0XJOezT0BTECVDx3KYKiCANoud8Igud9R?=
 =?us-ascii?Q?eu3eAS5CBmFnyaDVUBQBUTtwUdlCcht5ccDOw4jqSfVItW2B4pD8QMIFQaal?=
 =?us-ascii?Q?0R75yGsGZ0hHVLlBctOZvsjddBVVStidZcybISkjbDsedNk3e6YV+KJe6l2I?=
 =?us-ascii?Q?laB3u4HK4FGEr3SMxCpr16FJCBJ0CFxZWbHX5pFaBx7tf2hbor3lL/VlQDEv?=
 =?us-ascii?Q?4Tu4tnsp1sYQ9sskn08Lq++6Oeo3YiJda/cPYrLusqVIS19v4Kz6S1D2SQP9?=
 =?us-ascii?Q?qDwaC+/ha+7f7SlfhNS1GZ0427YF4f9QQzsWCmTql29hskHh703lMFfpa15N?=
 =?us-ascii?Q?lBaP1TQaxfS7xJzr/xB7/IP7AXibC64kirdOuccJ+r1pT3d9ImicyUckBrV6?=
 =?us-ascii?Q?YV5Zuh/Q/QKeITl/xM4SRAoNKl4b53AKFH6EWCNZdWBKOocEp1ZThY13z7DA?=
 =?us-ascii?Q?6w8pWrGMQWgd1zLLMFi3fnKlbZz1GCBcx/Dq4yyBzweNQ/IjY+IMrB4HCYjt?=
 =?us-ascii?Q?MWnzE/NrrnCtCrNRj15c+gYm9NEKBg/kOvdTH9Csf23uTjiomFBFFPVtfJtm?=
 =?us-ascii?Q?jtNH18Ssy8J6T9HPAQIptfTLrHPGUUB7vYlHpmW1EtYn2TKD/GqOHH22n43y?=
X-MS-Exchange-AntiSpam-MessageData-1: vXcWKUGNPu0K/4r+vY8zjbyv6ypOtyW+FHI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e6ec25-c44e-42fa-4da7-08de8479ac22
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:24.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7yGhrGSepKsYUIQf2vFYOQUoZn0JQ800Pd2LW4KdCW5D08Ar+9ldQkyneZ11lcViZijqcBBuQoBxm6owllpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7110-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,davemloft.net:email,microchip.com:email]
X-Rspamd-Queue-Id: 1D73E2B3EEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This file is calling of_property_read_u32() without including the proper
header for it. It is provided by <linux/phy/phy.h>, which wants to get
rid of it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>

v2->v4: none
v1->v2: collect tag
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
index 4e422ca50828..249114b40c42 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/of.h>
 #include "lan969x.h"
 
 /* Tx clock selectors */
-- 
2.43.0


