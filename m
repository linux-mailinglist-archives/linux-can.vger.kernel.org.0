Return-Path: <linux-can+bounces-7506-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIliNKrG+WkwEAMAu9opvQ
	(envelope-from <linux-can+bounces-7506-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:30:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E84CB4D9
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B69130788F9
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B8428490;
	Tue,  5 May 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcyW/2TH"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42B425CE1;
	Tue,  5 May 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975587; cv=fail; b=ikJyoVFJqwYsvhLletXKvhAEmjXD5LIv6PjkTZOKXt2fx7SlZkwEBY4VYuKQIsTVZG6Nxo41DbImgjDo9zHW2aBVIGoa3Ltupbea4x2saqLiVjZTWZYmqZmm0QsSqUudxqCWsq5zhpVseXOrXZyKGs3gnum7qPXPgERqWZZXq/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975587; c=relaxed/simple;
	bh=YzA8mfijQ2A21QlziYuh4n8NM8/eDcjGDSWH0mvQx/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUNyDdT2cH+YGJ+IiGB94gKm0ql5R7r4B28Lg5GtyEbBcaK0UP+UOJwx3Og4pTF6CAekkhVvFA57QVsNPCffoaQgV63s/qEP++vPos/ddH9KnRWy1TBdTaVHar7c+DN81wSS5mCOWGwd6nF7r3wVMHemADOBoCN/BCZ6XRHle/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UcyW/2TH; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5d9SVnTONC0Qk5yDsJZbiXHf2d7mXGDQz2B7iaq5gIN7dUKicPNUuZMfaftrg4tFpDR6fKNnt36HdkyT+ZZhRQgYy/nralJ/k3gEhPR/HsfHrXfeF6RGYvyHzidCcc+bFqu91QMpXIjzaSh17l1j4W5wA8zXfdKoQwdlfj96FCKQXQVs+OeAAkok7P9whFnrcUBRtmgrnBdkGzuSsVQdHPuY60SAyxLd1x2cDNkwFW7cpJXWm5cUN0CHdTA0ktnZvinOQNw/Wyt7KamzaHPVI5sGs9ojykiDCjqRneHP/0ZalVi0t8kdhgF6H7aCGl6UJ9IDiyRlDAqofzmK8P7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDybnB3UNtSjaXyKFcIZ/N44VcjPS1MoxizI85eNGkQ=;
 b=jU69uJWSEuQVt5lqHVb90Wc0GID/41HsAr7JB3IfNV4Sto5cK/xe16SzSGcidm81vHi17+KS32P4lV+r6HHQuAJgR89OpFObjn15JwUoftXAB2HUjLdy6UX1X83xkpdvLmyCLBxkx0Xx1S5txiYvMuSBN53GnaGvVdiVfiHTmQQcCFjRx0nACIraoKgLh+fYZNWYmsgaH+n2zhHRm+kvnpavnsOcP/2tt+KL43v2HfiKw4vYCd+fTTHIU9lO+USQ9KwdhmDtPC4pu/kfN5NyWAC89BUj/4g4UY3qD6vhIV3fVxvZJHiYBEV8ZM9ae0wPaYwKDE4+DhvHlkqyiwUIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDybnB3UNtSjaXyKFcIZ/N44VcjPS1MoxizI85eNGkQ=;
 b=UcyW/2TH7SIJ3eYeGCxzkkM0I7k6lK38WS9M1C40A7v2vigaEoHT+p/iBJ/NgQwnwS218ulwaNlWss11yGcyeEfHEmpKMJWS1OogT6eukS0P/J8Tj3AKjg5WGm7ODMW0sNbOc+szpn1j0RNdAPHwoC2uE1jiyDPHMx3Btitoh+lg7tqDlA+uqAbv0Ljlj30xZ2zcU2PQAPL53sJ9MJzXVtJ7jji4GJEcLUbYuT6hSByXuxBf9azJOo41dl0+uwug9HjCzl7+W7qlOQ2NC3F1oI4Wrx2DtjhiHKIR74lnwTQu4IKr5jzCv2meIqiJLVUaiBgTBa4qvLD2y2Hz/U5lRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:13 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:13 +0000
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
Subject: [PATCH v8 phy-next 17/31] usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node
Date: Tue,  5 May 2026 13:05:09 +0300
Message-Id: <20260505100523.1922388-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8003b9-860f-4f21-8db8-08deaa8df066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+43zuyaWtPW7n9G02XNQ8SeWPaM6OkchNGuE3B4VBZ1FxHr/n1wvNmr5aIkd9J5R8gnayR+ZHlk0+DymxVjQ+vKOn3CcgUaWocRq0A/iqqeQ93A3QE7IHTbiYsTwF+gyVrpt/jNH1YvQ9wqsivPXvHr1B0veWT48nuozIEE4CN79iL1n3uvyOWyPn1CYhDXH1UCX0kaI8rneg2WpYQs0HFTTSsQGTex5hQ+6axU8rMSexdw8AkGoSRRn5p23jFjTxQObqoRPnnSYEUXNdm0ugpOgW1Jfm3sQxSOBncHAfjE0qJDAX53S7TmyAKF7ZG028z1MAoAL+5CUNu2C/+H9EaSLfmyQa9CEcv+XrXBblYNbzMcsPC58vav4beXOQhkXqHjbDmzlNft9hjx7QIzXgAuM05X/YXxUuIILaYkEBnkIvSxZWLeQ+MpF2F7SclfSII3s3vFBMCh08BmssicsrTv8Z4+eEvypgvknCMkVrZAmehEtZ9iC7buzuW4vVcaPqPiV3oYmN1/SX7Y0KeEJ5rju0xUgVyTuhLxtGWhI7CDJ6D1/D0VUS2atYCa0MeeoTslhEugNwO+VEaXrxbu+1Xy/yX9DJiL9efnkHilhqMqNTuhbJ6icgpx9WHLyNB4ULxqIypLG0aDOoxc/xCwoGx29HQiy8d5HDeLLj4SjXrTBtmkZKajJ0xnyULo9MyFU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVz6d8aTwnL3r+AoxBV3pYRGlJMFQE7CnvIjbAYmO4LHOadyk62C6fCFfcr/?=
 =?us-ascii?Q?k2V7CAg4Zmr/S1StEUoHf/MAWhj3JQo9OS49s/ovFxnfK+Cu//UAAMYdI3xw?=
 =?us-ascii?Q?xLRA+GWKoCpyNU+j5SO9KSzS1ee5Txr08gwlTcGmspz/BgFkfIExxsRBujnj?=
 =?us-ascii?Q?/mS3tH0AcMbH6s5KNgjrNKrkJJRQvbiosGXBQIecbL3TmFC7+KWKKKQ2me/x?=
 =?us-ascii?Q?PAJLukMO/vjYDjAxcqtnnLau82lQPV3avIl2h0VC4yoPg96PcCbpjid41j7v?=
 =?us-ascii?Q?cioHkb5oLy5AFI7+rniG0fBnkRNJcvQsWGH8G0mnH+IjqLUcAZkca5DOJaDH?=
 =?us-ascii?Q?B7sOxKUbVoU+SLBKbz0yfxh4wdMYnOByhlsEGEjzJA4+V0KY4o1U04svMalO?=
 =?us-ascii?Q?aCnxt45TUO8+HTQ8B1hNuKYGatpFnemNP4RT5E6Zgc1maqCblT9FkpbTtOVl?=
 =?us-ascii?Q?K490+VLCmXs2v3z/YPHrQLxxPaW7ThGbBmekSW0dGcS2WrD63C0N3K1yWxst?=
 =?us-ascii?Q?XbtqaQ0gj2Mj+KocfiGB0U3QQLcVME3x/2nTyDgdPmka3VXIjUeW7zolSP0k?=
 =?us-ascii?Q?rFVQn2gbUjMHhYJZKjkcld39myXmaUk+1zseeJLVe2qOAno8sD6gdRtGStBo?=
 =?us-ascii?Q?UvQHayFfPpmAIuQJHBrI7MUivvxPPQL4F9uDVQ4X66UbuUV0o/Pv9yunvBt7?=
 =?us-ascii?Q?wNbgKeVcR2Nrs01LmbwiocU3s3Cz6yS2pl5Xt4o5kuZznZ+ID2qtHtH6MDrB?=
 =?us-ascii?Q?vwkzaiS4I76DBigDraeLINwmpK95lczjXJr5X8uUGyDIPAkpgmF0BVXkLEiS?=
 =?us-ascii?Q?pOITghnI7FCX/lSHOLCqxc901+mRE2TioRlfibVOuichgowh/tLQgCiwKle7?=
 =?us-ascii?Q?eKSIoW+GcQ1qVB1FIeFMUK9WeCXIWgAJ/RuxYwofivUbbfTkBLQ6FbPvxLts?=
 =?us-ascii?Q?KJuOdpwXz1vRljWy4RfjVcfaNtMnSEkcAJ4IdRUj0cv+D1RUB2X3bpB6D4Bo?=
 =?us-ascii?Q?Errk52zlSCUPnu7eP1g9uV3e6+uW1OAnWw8H4zQRijpRGG7P5oRJw0Mg3Ysm?=
 =?us-ascii?Q?BknvRAVxFQ2HVCgBItAIFLdRaavZ3eoSs67CNqKELv388P4B1GN+geHdT187?=
 =?us-ascii?Q?JQNkAkxGGVTiGexCGOgXDMuqAMFFTh+aX0fGrJYBZMpKgyzcFi65bUOBNut9?=
 =?us-ascii?Q?6PVOo/4pkeGaXBWi/dz6cY3zaHDphlb3suKo2wxO9jX5K0hahvPudPaulk1g?=
 =?us-ascii?Q?VtXahv6fWsUz4f3e5f1P6qBmAdEo6R+7KF9OaP2/10iwQcH2UY4RPGcLT3bo?=
 =?us-ascii?Q?PLIIfYF8zUT27kMOpDQBKeSuWZYoI6+Gt8SDm8XmtcvQ8+yMg5Bvzsw5FQpO?=
 =?us-ascii?Q?89HtYb6G4jhjR8qFQ1jx+c5WK4dg0eXNPCMeF2HoYpJLXpIoAfVMTd1GzJpP?=
 =?us-ascii?Q?Jo8Tx3Gb+FHV/ldlv+KNcxIk6bmc3GG4aLaKLXYdiyceA37wbk6rSeYxfhQ8?=
 =?us-ascii?Q?++8dBX2+EZ8A3m5Pfh1yGRIvlVsOmGfDMnziNB4G4dyLRpRZTzQKQdZwMf78?=
 =?us-ascii?Q?UeZDyJ9ZO/I3M/ON5lw6XujVoBbbbX+3EjEfvg9F8jpUWs5H8koZ/zE+Om9M?=
 =?us-ascii?Q?DvKzIRMBwfJ/L+uFWPO2eHL1t/xQpWPCBEW+Yni2ZmQzR6qGFbMWfU6WZAIq?=
 =?us-ascii?Q?It/Own4EvJm4hx2Mo6bX2SdpxJKcFSlNnM3gLfsMCQGc5qlZAhxHvsByun8r?=
 =?us-ascii?Q?MyzG+zCgLg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8003b9-860f-4f21-8db8-08deaa8df066
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:13.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q08+RyOZNT3PkBbB/ySI9fKoKcPt+mIkDhUJ8xAoCnJbmDIw8r7uAZgmXbpkb28giwoK4CB0CrQt+jK/bc2YxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 5B6E84CB4D9
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
	TAGGED_FROM(0.00)[bounces-7506-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,nvidia.com:email,args.np:url,intel.com:email,linuxfoundation.org:email]

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

v7->v8:
- remove duplicated variable "err" which shadows existing one
- stop execution on of_property_match_string() and
  of_parse_phandle_with_args() errors, instead of silently continuing
v5->v7: none
v4->v5: patch is new
---
 drivers/usb/gadget/udc/tegra-xudc.c | 43 +++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index e9d33be02866..f93e0a5651ab 100644
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
+		int index;
 
 		/* Get USB2 phy */
 		snprintf(phy_name, sizeof(phy_name), "usb2-%d", i);
@@ -3525,22 +3529,39 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
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
+		if (index < 0) {
+			dev_err(xudc->dev,
+				"no \"phy-names\" entry for \"%s\": %pe\n",
+				phy_name, ERR_PTR(index));
+			goto clean_up;
+		}
+
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err) {
+			dev_err(xudc->dev,
+				"failed to follow \"%s\" reference\n: %pe\n",
+				phy_name, ERR_PTR(err));
+			goto clean_up;
+		}
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


