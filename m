Return-Path: <linux-can+bounces-7104-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FzqMs3fuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7104-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:12:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822A2B3E22
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E859130500CD
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A153E9F8C;
	Tue, 17 Mar 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HvjfDyXk"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7B3B2FD9;
	Tue, 17 Mar 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788738; cv=fail; b=o8HgoAvpaao5+THTpMfOjm0dE2mp+CXhuWiiIe3Z4jAtgGflel7atLjjR2rYfxfUB1qfhz4Xm0BYotbR+QmadGzc8YARKGeQVsTrqpLqXI87WBbvVOBiFvXUWF1YzdxPXyIGuBHVeZfQpl7riuZ0kmWsLi3rSAC7VLA4/ZN8wCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788738; c=relaxed/simple;
	bh=cdR3QdjT0Tm6eItRNU4Ho/D3kfVHkixnySsCf+MuQWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyITrohxMXjFub0Ga6qSDUPkV2+jZYb5uprRFHmPFMchusbMUIxnot0AlHuqC94gF2vji5tSOZcEG4ivzuBfsffK2cu3ynxotiwtxGGSdihfKWs+P4jKsGG90727yRRCh/oBH2VBBZ9mPjskz8zSO9pWS9HT0Lo63ct3oyglMJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HvjfDyXk; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1yzhiuCXuTTAd/J0V+fsMm1dq4FyCzmhcurdaO08si+pW7P2Erfgz4R3GWUU/sPak5A2OxArpdvjT8AccWn7FCyyvymf3R763rYlAc6Y9j2kho4LtZ+Pm8AbieRchZHs44VVgAJguRNEmRttnnSKNZT/+5odfLy7MgWFBSdqDZvZ1uZrd6NC1Gd8IUZkeOcDuy6cH7RNKHdxiTcu7VS1MeOnAg2KmNrphj2+3Smb0XPoejDrtvnf5mkwH/aGDUw3iGER8+HHn2qCnCBfp7KJIxf1xo5q8Wfdx1HyZUPGtRacBQ/82QgE1Zv+9yw1RVwYxL6wulgnjm59aPRfJCbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x130PS5fpCtGanGRuYZ736wgn4zVhExsvMw8HP22h6A=;
 b=CW//GCaQPRnZypRG4ZXxxWBRkao6q5VOchaLUWiagqz3P4xFq8DOuXB5VULpOwX5n63mPiZS13KQeG24XFBcu2/VXjnmlmPACuPzz58fmSpbNZGDqs6+KwB1rzMV8gDJRrKb3hUH3itdyuRpUtHHvu9tfBNsD1T9GzDLlN7HY7OssfLf23zBHzm7Fdn27M0Uk5rGveaYU4H1w7jKWtWUwHgJRj5Q6vlhT7bws6lJHyD6HSCK38jZPOgxjfmcg8fxx3j+QK2ybBjEFSGKYfERVhx8Y2Zq+AGhRhyiYpb7mMPOcE+I1oqpV8xUyv0miidMBDd6gI/Pgn/08fTuKyKWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x130PS5fpCtGanGRuYZ736wgn4zVhExsvMw8HP22h6A=;
 b=HvjfDyXkDN1qRg+ODszwwn5swF9dJmhDcYCpwRO/v17fNiYHsMXL5rgtuXYjL8Vkm/SCLF0Q1Ao5LiK87lLtjC2m0QDjRTtJgrPxdQoRVx/qN0hGjjRgRM7XcRN3jaAj7VtiPGQ13HHxlaRYAZlAs3DZcfJ5Bs84a+CpjrNTTwd9reAQR8KmwbLw8UxJtx8fa4c4DoBKPIPMrJsFLTcaqT7TNWT3PVkNoiebqvnqvnh9JcN/N/R5zgNMyVkNEJuDoK1bkBFP079faamMAeiEM3TD+5ypyXokRjn6u56UAwGppqRXi1Uj19J2btLBhvs4G+axgYCBMKOcisglW9TrRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:19 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:16 +0000
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
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v4 phy-next 03/24] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Wed, 18 Mar 2026 01:04:39 +0200
Message-ID: <20260317230500.2056077-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::46) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df5392f-aba7-45bc-2d09-08de8479a6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CiVVwlTZSpGA5zvQqK1NFGPIpnKPBettwRucBy8uTD0ljGt3p6FQFJOW2NYyEokETT8TSyk6IJniyYuCOwpnIWyxw69aW9BpqPU0OmiHE5S7+xoXE+NL8nsoXxrl2u+nTB3OCUGmePXOETlYgndsiHIIWpVY85Tc92/HZMJ2Oi57q3JWdLEibGkr9pY3GBSi99GrEHoo/6uELvbeNxCaQByqOXk+LpeiY9WkbEqFTnKNAdr2pzqd63gjyE9d09IShEyQTGg0Js9Yizmm8zy2Zv6zFNK9/BNqWJVyDmAn4FuuGHLBSkdtphtsTBnexHDJcRUhFeCPtdrtUC8G1PJAU9nScLjE+WVOjIDptjiSw/95bOtUDtU6bKnO/PEJWNR3ZFpNI0/CyMRmbB5mJ8vnsUdxllH6sKS3h6wfEIp32Feg8yEl7IbGEGcj2dbc58r2REFCREyh9IOmURzRaySpGdYwwOwVYMsBt1z8gg6ozzsjYZTZjmXbUSM88nlnz1rFkYCzObUoZst2cwomLLZzLo6LqF1LHy5jgM8jA0lHMiBw5XOSzsxoOkk0Zl0k9Vwy4A7HxNPQnyJ0v8dcRgk8anAydIAWqGA4gVJ5Pug+fVqSxfDradu/oBKaR3wJKe6oGWI0+zvKELhgXjqlMM1Gp6SObn5KV/vXvpmHMzj8smI0h4BxSPtmqGE3t3LO2RqfS0IaXESmm0eRzbDV2SnFxd2dY43KHRIN9TM9cLoEvjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHR0l0HApOZFpsM2t7vfnOwA8J6Ieb9kywVmGVW8dhLT76CnrCotc5NMu9gX?=
 =?us-ascii?Q?4KXexf8nldBh47Bb288IxoWyW5IW75eJU6yiBF7sLWuPNOgq9pI9aZxlAOU/?=
 =?us-ascii?Q?aW+pu/EPwFvy43QC8WQuwYVOoAhMQXeKIwgu3EGmPgYiefuJBiUvYSzRgk1+?=
 =?us-ascii?Q?pEwA0oKVwPRv0/s36yRpdaYwuH8MOi1qAlFNHLdO6WxIi8LQVCl6bldTs7xJ?=
 =?us-ascii?Q?LMoHZKeX1mHFRjwp+V3ar42JRvZkXysjLqJW6sRxaAGimBP1uDx09CjQKz85?=
 =?us-ascii?Q?ZJi7Y4TtlCgXwNhQ/c667BdUbkFwEoVd77gHqSSo7ekKKttLsoQrhHc523rU?=
 =?us-ascii?Q?NtSm4xkf4w/kKmaNpWZLJVlQedSTDXa9nUZgGrHktfgMJAkWKhanVKxUTZUZ?=
 =?us-ascii?Q?PPFrGrSkn/IxBBxYt51TkdiLDWpLhDAeMM/pPUsDrRgyYnJf4rfQgSzfV+eY?=
 =?us-ascii?Q?7h6Ry6DpR+8Isf5ZixSwsPjud9se0FlnNBr4MRgQZvTaNlALli2Wc9deQDVW?=
 =?us-ascii?Q?9igUqXJfrtzRPF3uh0Eepft3eX8tT7QGH+HmPQ3bvqwTwnuj9O5fcRvV5WjB?=
 =?us-ascii?Q?PkgaHzeoqEm7VOhScIMa5DOX+l4BejGgvkbarSJPCUVfNpBKtYutTLG9irPp?=
 =?us-ascii?Q?7kFMibGVIuTADTow6Tr4vhnFjCDL+0Ajv1av8xt6fbMEpnWPn/l40lmFJzcs?=
 =?us-ascii?Q?YwrTd8qy1xsYYcIqqwvTgqhwPwgJtBJa3Hj+Gctbg54Lzd7LZ8Z42aS9DN+d?=
 =?us-ascii?Q?NyzHjo5DS5fZfTlliwYrKdWK90LhErdPYxdLiFknbzoXBsRslCtfHBpcRihE?=
 =?us-ascii?Q?FmfqwctHGEuURwtzIKOyDT3FeV7BjrRtlJdfCeYf2jVW4zBS5bWbvsOGgvWs?=
 =?us-ascii?Q?D0BQXvLtjonvK+Vhq6OaiaIBo1sLfqYs2cLysPIz7a3z/o660E0irh7Mk6A1?=
 =?us-ascii?Q?Yrco/MtE1awcc+4OKqaxhoePSqbbpAiQDAZFzfcCQExH0NXtesYVtJKdi+gZ?=
 =?us-ascii?Q?p7cQMd5bXuSgIUyp28l1GXrF77viPDqdaK9zCFB/kSV/Yt0TBjd4tCc1vqUy?=
 =?us-ascii?Q?TNe2BwcGOYihHdcuXmbLdrdl0rJe5wNm1PCsXCgjvVobhVnB8mRSHccrVLTH?=
 =?us-ascii?Q?ExPETKtKODuwdTKeVmxMJEsFo/w+nirfiKOoecHQOg466n3H1JsxTgLsh7PS?=
 =?us-ascii?Q?2RDQVY7gDmgBHPuelbHQaKr1texGJIqyP/c6aGdEKY7qTfmxfrWMOc6cIMSh?=
 =?us-ascii?Q?FDEm8bFY89rnXcmsnkNX852ZXwjx1LoIclwS5qrCgBikAYPK3HjwhgSPPJ8p?=
 =?us-ascii?Q?lAvhn+5fsMBrF/gEQ4LfqJMEMobarRaBWa0ooAkckSTZhB1vOiOLcL+78e/W?=
 =?us-ascii?Q?fUXu1XRRHKDZ8FzZ1lsSDePnvwS6HBd2k8e2EjL9PvJPzAYtrH5PfxorCxeG?=
 =?us-ascii?Q?+Shq5xWu/y+WxX1A/eid+eJ4rdwoaQf8/X1RxoAP0iG7SwUS7S4kCpXrw1vj?=
 =?us-ascii?Q?a/RPBLkcJMO7PQ9a7YwF1teFRHcpyvot3BVfbkqeIICFIMGPkadhFVqZo4TE?=
 =?us-ascii?Q?QzUZKK4FMp2SQkn+g6WKkCbGid9d5Ie1FhWefDZVE6cBfP3tGx/HpgaLB7OA?=
 =?us-ascii?Q?30+AdFILuA2wk3bYqrueTRjYXnjc7bEtUS+s3L3ZipFBtm7nKZ2NpdUdUt6K?=
 =?us-ascii?Q?WK3Ir88lF+hl0ABq2x8fImVOYAb0xdLFocC3E9dxjUTZ8qM6b3eX1mC4uKQ7?=
 =?us-ascii?Q?f0RHN4nN8NfOljBg9MRSZbKgms9ZDAWZ/OUz2tPbfPZdyuhcoYPGkwSXFLxE?=
X-MS-Exchange-AntiSpam-MessageData-1: s/BifD4HaDCwy6F9u4bR2WcGJppaBo7qJ9E=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df5392f-aba7-45bc-2d09-08de8479a6b7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:16.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAmOa/cv/2+E3UxOu90Vd0QRyuM3djOyCq/5ToKmG1GlzTzVOdeFd2UeC7C2Cj6EuSx/f/7sctRTDTqKiP8s/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
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
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7104-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,synopsys.com:email,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 2822A2B3E22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The chipidea ci_hdrc_imx driver uses regulator consumer API like
regulator_enable() but does not include <linux/regulator/consumer.h>.

The core USB HCD driver calls invalidate_kernel_vmap_range() and
flush_kernel_vmap_range(), but does not include <linux/highmem.h>.

The DWC3 gadget driver calls:
- device_property_present()
- device_property_count_u8()
- device_property_read_u8_array()
but does not include <linux/property.h>

The dwc3-generic-plat driver uses of_device_get_match_data() but does
not include <linux/of.h>.

In all these cases, the necessary includes were still provided somehow,
directly or indirectly, through <linux/phy/phy.h>. The latter header
wants to drop those includes, so fill in the required headers to avoid
any breakage.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com> # dwc3
---
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

v2->v4: none
v1->v2: collect tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c   | 1 +
 drivers/usb/core/hcd.c               | 1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 1 +
 drivers/usb/dwc3/gadget.c            | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 56d2ba824a0b..0a21d7cc5f5a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_qos.h>
+#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index dee842ea6931..7a3261f72463 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index e846844e0023..2ee1bb9d7199 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0a688904ce8c..d06171af6870 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-- 
2.43.0


