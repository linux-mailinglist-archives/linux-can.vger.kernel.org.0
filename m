Return-Path: <linux-can+bounces-7443-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PRXH3M682nKygEAu9opvQ
	(envelope-from <linux-can+bounces-7443-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:18:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F269C4A1C46
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CFC33070E81
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2A426ED2;
	Thu, 30 Apr 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UMBFweKF"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E6426D36;
	Thu, 30 Apr 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547253; cv=fail; b=MaLS6BhJQATszY9Y2xdNK856BfjYzoaMnKia/ncjUeGrdDSfuqgSSDy8YqRv/8IwV7/gOLSi+zFTBTAPkLOq3b7eC5FZuTNECB/uQq5ctoaLYhYmRuev2yyGc52DVBAL2x/Gn2x1//taGWE/G6TjHlHRjpNDNkDQ1b+7rAESx2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547253; c=relaxed/simple;
	bh=1jbR8ctvdwfWn2+V0Am+qBM8BmtJ5xZ5CM0TNSwx3yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnSKEhEI5YrWZQi5/6b6eui4bstgzMPZMnt0tke5Lg4R6zXppqx7tVBJ4UdX50km2zPl2uFUsbUOgiVVfS52ASyWgbAdTlHEIQh6JnjJzI7uleHVilQ5owPjp0yPfPeSmEWa9GMVVt2tKcomMsuvhIlY9BZgxWOZgfXL8prOVw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UMBFweKF; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3BKgWGHAHAbStytQpD473qHz9JsCtp3LgHcdFFPWgIfLUruFhAbBFa/gOU5eFsKM0hQSvc8IXFLRvZ/7HTSIiz3nSp/UUhw3cac2Lf9KEEfur3Db07w92FJ07ojwsYnI5YeqDYMlRjWx+Y+7brDOP3QYFLlDTI46/5ol0IOMSWDT0kk63EnYZL5ETk91qv1e9+HjkWnjw4q057wOmD/2W4g0Py7QAlqG257zX1JTfV0+77EPFQvaiihQMP6ni/CJHqBQuW/umWmvlrRqoFSRxpWV54LdCGcWbGeVlPNZ0qWzUybW5LeIyYEPzCd6MH4Rt0cjc83G/io496lhe+qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5FCjmEG1XDGz3sCPq9VXRXcsutJAgvtv8mVJdpgqgo=;
 b=tQg2osPf6RWRe7vuaKRvc6QOMphBhilDAqEnzWzCyXPIYcEb6nhxSQAOgj1vK8Ir0yTM+l1vZsXww/mnilPnJLkovXEZaU1pTN0JBOw4Cyhbb9LzKckos/IK5qXhXwGOF7eIxEfDVgWFMNsITtW1HlZHB4m1gsfY1BVVKdXaLGqhqYpoI0Gveap2hmqHO+gWTvkOQWSMvwvmhL4LEdilono11RMEg+Xp6hbjrdbp7g3IQrjh5Xci3TZbWBD6ho2Cs2ksG2WTQPQH+QLAK5F7fIwTcdaUUrYY1vHgH+CrNuN/MywPVGOEXpi1I8ejYKDc5PrdEQ1oadstaVhHVK9Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5FCjmEG1XDGz3sCPq9VXRXcsutJAgvtv8mVJdpgqgo=;
 b=UMBFweKFxaHFLRqnCq42ai/dLrol9kBw8noQVypRevSjvZ53U5fMdcExa+J9z4Yl+9yiTlrUtTZRbsCDU99bmSO+d9y/hVwMI1AJGlx/Ou51j4dRbeV37+3itK7iWGx9yKpjlp/TNEL12ryRU2OVNAYvOy/2U7Unp+kJxYE9S7GJhp4GOMNH9rY3K9oVX3D2OE3gzSGNJa4rhiuJB0aKoWMrgGeAe0yPNxj+VeCC5WYJCa+8aqnxpYO3pUXn6aKMJpL5WTmgsK5M7vG7Zpq0s1TN5op4VbFxhmv9vo4LGfWGH+HCf5DJ5x2ltgMH6pTecXOiR+AyZwi2a0NAEtXdNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:21 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v7 phy-next 14/27] usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
Date: Thu, 30 Apr 2026 14:06:39 +0300
Message-Id: <20260430110652.558622-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e892bb-aad7-4e75-7375-08dea6a8a650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vjxm4dT4YyrAAns68Zk2tH54RuyQO39C91uPBT8f0gJz7f95Yzt1H6bSZNDv7S3jrD64N/liAlRMnr7uqw3MZ0/COe0b2WYOp9i90bRAKOmsTG/KLPHJLZ/7M8BLp0vITL2MtwHExZEeY2Ho7ramZ4fYFNotfW/nMU55bbQP8NZLhoz624hOtsdXFZfgLwYjOEU1zfcNssoXnzfL+r92LOKoPQyJ89iRstr+Ky9reM1s6Z+gerU166pZCirWYw5j+/iMWIYKyxAfmPjPhBm0T6NYju+wqJOnvH05JTkadM+rAB2zlsBIYQ0k2//7Q1jkgpdW5CCskUNOZ3LBm1D9rUXlr2nXLf9OsIgr4I0pAUTzTCY+/SM3GSYcy9TUGmi/ZzlJxFO6eOZo+6gWzoyaWrBfCg3NLZmJI5NjrBOgz3lprgjrvxu69xl174+NeSJ07zo3EL7lldE3dWyF19eDcKy500c2QPH9G3B8u6GYYpKfZoZ3D569Phh3/KtONs17WOmzkZp6lZ4x8x3GMRwzf4IuWnfvkIkv1JekjvMSTGDoSkL3BlwhBN+3MnumZCmZ+BUKysVDg6z5qZPjAaAPTqV8tA7nCYcRws0u5xpcTn9p03wnRWnCXRgaLZ5VvsAJVqRAZ5TzMUBWOIB3SNUGu6MbHMlgzEPwvN3gQ18BGP0NQ41lnWbLCmPLQoLwOhqA4r5foqI5UyQTVqcW1A9xFnQO76dm9cEXGaNqtx8sBn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOSUmq02vXVyKIg667nUdJkomAM/j9xzmmGgg8x27Ib0TX/e/NZZwFpRGKaD?=
 =?us-ascii?Q?LnGpoEx0dx/Rjj1R7/nl5/L5cKm//bCGBdGpLX2jmYW/pGN/pj0pND+PjiIX?=
 =?us-ascii?Q?EZ5iE+oS6cmiFApOfQOEbIDLL+FFMABMGSxOUx7Zjg/XP2pvAza4807AhbxC?=
 =?us-ascii?Q?Kk+75if+2ZJGtLssJkirIXRzzltnUth/nOoBH/kz3IK3McRdLMnzjFLB0Qqi?=
 =?us-ascii?Q?VQsVrmD7nEdfeqbELtdtHcxV7BiYbzinqvCaai92jxfFz4X0kizIrkCjR83G?=
 =?us-ascii?Q?SpAHMDo/mGPP3dNOFKMSkMaaZ7cGrlG11rnMHsePPOsGIZJfNDmKq//nJt3P?=
 =?us-ascii?Q?Rl5s+qwEnfgbRFdQE3ihmiebOpM+edkMxf4XvbZrWptsTg/czVtCPnIH7qME?=
 =?us-ascii?Q?Q7HCQX378DhOmz7QgR6YtD5A2/EfpRNnn8AsWbfNZfouMBsXpRzQWboC2BAj?=
 =?us-ascii?Q?+VRe7mvTOXbvjXqCabH3mGVfHVzz7ilO83LuGaB3QamNa1sWXIIREZvScW7Q?=
 =?us-ascii?Q?5A2RK/nLZx9STapnctZBszcXsD4+VmVMI0sOnbUAVfud4A64GkLxkXgPkB25?=
 =?us-ascii?Q?2DocKWCsl7aIVQXOBa2hMDe11iTuE3aOwmbAKaLB0v7QP5oJEZFDJ6wCSMdl?=
 =?us-ascii?Q?F/EO5hI0ebnb94ZVFXrRY98Kk8D6USVaA45670JAYlrrIQl71yVeXK77BFfN?=
 =?us-ascii?Q?pdLewn28V97mNCXPpJEOcsOsGsByBG4wnCYdgp+er4s4WQjx5EnBOnLUylEM?=
 =?us-ascii?Q?+EnYOqvn1Qc6DO0oA9CpYhgJxZ5N+K/+FcOMXIgUKKxqdp+kGJoQzMOI26y0?=
 =?us-ascii?Q?5Y/+M0Jtwd0MoO6DE7OnCz2/CEjv9XsVkfOPteovcEn4Vh6dQegIr2+56dbR?=
 =?us-ascii?Q?NamwHwJgTZOYIhIhFU+W0z0pnR7LRZQV1JHFp16INzL4BiTeW1WJfF7kXYYU?=
 =?us-ascii?Q?QqzNh+Yatc8P5RUlerLYIK9bj13tvzBRvs+uHOk3EDnRL6M5pSaAjkf9zWik?=
 =?us-ascii?Q?7VdBXP8sfONe39Nt8WDXSYgaNpB6/J/m5xrIW2TXYWaAE/jCgNjhZAWMSKTR?=
 =?us-ascii?Q?dH/y5wWjTf36uP4bKYHA+XBeM/6CmoXQpPg15kJe99OZnmdMPsZ2KnRt6jST?=
 =?us-ascii?Q?S3hU7pHGsnRQXD9l8g5pdVuU5NqKKiEJQ8B2seRcIBDyLpPSQ4bXPrdTRhBP?=
 =?us-ascii?Q?lAlRlZMKwFdkvyyav2StpSd6T7jdYJbtxuvT8IFiHEls1fwOwTArYEtsdCn/?=
 =?us-ascii?Q?jF2E8W8Mc48K289K4J3kGEwMkM1xIhhcjAhVdayMoIyxRpsXfiPZcFZjxvzf?=
 =?us-ascii?Q?I1Kj5BoQs3osUdp7tMjRLgVYdJjyPYUW3yV3AhaCU+RJ7rGDjBlTLbyQvxgi?=
 =?us-ascii?Q?RHnfaxynMnUKQXnkkRZKXHE7cjff5HbXHff8wptB9l0nSIbjJpaxCy5R9dbs?=
 =?us-ascii?Q?8qkRst8PKUtxj340aI2SZpm88NP8xqxCTZpMXwKRg+jonSZmfIqVVhscInv0?=
 =?us-ascii?Q?+XEb+RWp9k0Yz+hgiAvWqDt0Nyy4dcJ+LvOGjZyF2S1/VNC/PnQJW2kgk0gh?=
 =?us-ascii?Q?HaeljTyDUgv09qOKXoBo5uF65FjY9AvaAb5If/6il5ziARCXlgIxiKGCHf2J?=
 =?us-ascii?Q?QKqXnGxTjrgaqbD/ii7VG4noq/sf4CAVqDJIalnPO1S434AjYIOTGFVzRKV4?=
 =?us-ascii?Q?G8MbzT0VanE/QZ9MoJ7SCTg/5R3iIk+iMKcLpiypTi1oFBHlOWpTx04bjVNx?=
 =?us-ascii?Q?gr8/hd9eiMwV/G2TrFjjJ/AVvHp0IKrSvBiwalYjIEGcknozCUiX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e892bb-aad7-4e75-7375-08dea6a8a650
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:20.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8EGf2P8v4K0XOZvRQI+9IBdZ+H+sDVngmOBs60CmjT9R1w/swBSVhiNG+zSanxsx5FpWwSMaByuhI+6CXtAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: F269C4A1C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7443-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,args.np:url,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

In a somewhat similar situation as the Tegra USB host controller driver,
the Tegra XUDC driver for USB gadget mode needs to get to a struct
usb_phy that sits behind the same OF node as the Generic PHY. It does
that directly, which will no longer be possible. The PHY provider is
also the xusb padctl driver.

The rework here is also to implement a parallel OF node lookup path
based on the "phys" phandle and the #phy-cells of the padctl provider.

Some further notes:
- create a local "usbphy" variable to hold the devm_usb_get_phy_by_node()
  output. This makes the error checks more obvious (avoids keeping an
  error-encoded pointer in xudc->usbphy[i] even temporarily).
- the "if (IS_ERR(utmi_phy)) .. else if (utmi_phy) .. else if (!utmi_phy)"
  pattern can be simplified, considering that neither the IS_ERR() nor
  the NULL case continue execution in the current block. Therefore, we
  can move the case where the "utmi_phy" is a valid pointer outside the
  "if" checks, and this reduces the code indentation level.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

v5->v7: none
v4->v5: patch is new
---
 drivers/usb/gadget/udc/tegra-xudc.c | 35 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index e9d33be02866..cf4e6c87e44d 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3494,6 +3494,7 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
+	struct device_node *np = dev_of_node(xudc->dev);
 	int err = 0, usb3_companion_port;
 	unsigned int i, j;
 
@@ -3515,7 +3516,10 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 	xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notify;
 
 	for (i = 0; i < xudc->soc->num_phys; i++) {
+		struct of_phandle_args args;
 		char phy_name[] = "usb.-.";
+		struct usb_phy *usbphy;
+		int index, err;
 
 		/* Get USB2 phy */
 		snprintf(phy_name, sizeof(phy_name), "usb2-%d", i);
@@ -3525,22 +3529,31 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 			dev_err_probe(xudc->dev, err,
 				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
-		} else if (xudc->utmi_phy[i]) {
-			/* Get usb-phy, if utmi phy is available */
-			xudc->usbphy[i] = devm_usb_get_phy_by_node(xudc->dev,
-						xudc->utmi_phy[i]->dev.of_node,
-						NULL);
-			if (IS_ERR(xudc->usbphy[i])) {
-				err = PTR_ERR(xudc->usbphy[i]);
-				dev_err_probe(xudc->dev, err,
-					      "failed to get usbphy-%d\n", i);
-				goto clean_up;
-			}
 		} else if (!xudc->utmi_phy[i]) {
 			/* if utmi phy is not available, ignore USB3 phy get */
 			continue;
 		}
 
+		index = of_property_match_string(np, "phy-names", phy_name);
+		if (index < 0)
+			continue;
+
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err)
+			continue;
+
+		/* Get usb-phy, if utmi phy is available */
+		usbphy = devm_usb_get_phy_by_node(xudc->dev, args.np, NULL);
+		of_node_put(args.np);
+		if (IS_ERR(usbphy)) {
+			err = PTR_ERR(usbphy);
+			dev_err_probe(xudc->dev, err,
+				      "failed to get usbphy-%d\n", i);
+			goto clean_up;
+		}
+		xudc->usbphy[i] = usbphy;
+
 		/* Get USB3 phy */
 		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
 		if (usb3_companion_port < 0)
-- 
2.34.1


