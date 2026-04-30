Return-Path: <linux-can+bounces-7442-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBJsHoQ582mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7442-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:14:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564974A1988
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41275304A25B
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FF426D19;
	Thu, 30 Apr 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OS4W385L"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A166426690;
	Thu, 30 Apr 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547251; cv=fail; b=NNVe9G7en6tvHzd00CRKB2zmfZi9axLHrblYkEUX99Hrv33jqz6O5zbEBc/xczACp04lnxEWPEllAOOkbqdskqm87XevTd0tDmmfxt4wHmmJ0txUqbP2kzYmBtDuusespWeXD6O256wsqWKebUu17qavNMofEHQYo4xrqNcD3tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547251; c=relaxed/simple;
	bh=JA1wlI+Rk4wgphhwBe1Sa2SdSQbR3QKCFlO/K33XZvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIgY+HYahmD5rQs4jGNyJ+3DO8ToSutGuq8eRnZl3ylI2Mr0e90/eLwOL2NWdLtVntvX0TeFJHWyqsuVCZy92vZN13DxE1RzBplqS0f+aGifEPCbqsn1yUqI6P43Vyc3KmJ7R2xULF6ib+ySwM2LlG2qdic72+oahD3YDaj6HHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OS4W385L; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW4EGFoqCjIysdC097hAU45P2c234hYNFeLuCqFJF7rAav6pMRs1q7PAeNaxwHtolSI/nJESKYiP7Zu/juR1bk92mutNw8J5uczS+W5e0OvgRJzacDnBe3MZ8sOSlhcLwSNdRnnJHqAvS7aBow1IThmMGerLAaSZthqqeEIkjo6VHlE57duwotelwkT4Bm+G8/qQUgSYAtzX+H5fg+Ekp7qjbN2zHIxrmEzqIXhLpyIT0L2BwKkvtPAxPuCHBOUF0Ps9W5wXw3si4pQQcoLQ0fEVDFtoCIgCoB2lZ6RSdhv++JMKjiEQX9KJUfEAE+0HGhFiLCgnDiwgdVFeb6a2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+waZ1NoHfTKKwg2bMbaGUn+fU0KQ45RvLq4x+bwzw=;
 b=aKna1yOP0pXNudbemWT0VbQ+6PzRMDaMJlU/ZHEfGPFPV8uOoRVoSzpUw0fC089GYWhjyLRFvJVFZ0H3O98xClHlDYuU5qoijSJJKaG2MGeRd65hweMw++0yNb7/TvcdUaoB+v5O6voL7BxgdjnMmw+bWBCqbtwrFDx4UOC7u1cGGeIcVRzlvDpffBELBAWI9z8jxYhmCjsWyVSpR+hz4tBWwADAf67li0L2Wyq7R6GAAeEGEDzYcnJxmdxxzU0nENMkrbHByazdyvtOnw47Xy2mATAs2N4IpWqZMcf7/ooTmTvzzKN6TpaBpoNrzkjUOFgFK3vpTY1Im6OmevtNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+waZ1NoHfTKKwg2bMbaGUn+fU0KQ45RvLq4x+bwzw=;
 b=OS4W385LMbqzvSz3/NG/95JH4Dx0NXTl8ynWGoU1Xl5SH9E+rehIaAk88lHWrax0OzfqJRbvm4KOaZc31SiZMlbxQ6W2hDjNskASKQPq9aE9XBx9VPJgzIjt0Ds0u4JkMLLpqd05oE19hkBAAIbJS+WKSbD/TgP/iN3+Q/ffc66VtnZ0qTPoQqk1q94dLjfXdcF4qyxxXS2JrE3Amdgn3HzFZgE6HvNNXnqKQ9M3XQ6IR1kUNixNXZaCUOVRYEeo4OUJkHpykCRnAuh/Hkq469RWAYTWlROoJOh9W4698kjqEzAkxplvQCGUCCD/iBMySsexE/ep007hpE6X8hXvYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:20 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:19 +0000
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
Subject: [PATCH v7 phy-next 13/27] usb: host: tegra: avoid direct dereference of phy->dev.of_node
Date: Thu, 30 Apr 2026 14:06:38 +0300
Message-Id: <20260430110652.558622-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::34) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fd3690-f475-4c00-6515-08dea6a8a51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4+auyliHqMWcWlb/BBUzy8o59JcvstdZG1jTXR6QPjlyyN40OpPIQy6SOB24Pku+5jGMlz/bTxszsctoiVUWbKkU75Z88naWXTxwJW/b1TPVGwbY1UNw8pWZUBMlzQv989z0dHuspUoDRhkBCYCBv5DLtio9XcVsbMkB75oZS0iaw3qThQV962WnYU7Vx20jNYbwHFiTPXMFMI0Ut9agrnlfCPeSfVdyihMymBanaTnuw3dvyAcQ8opwnVE6xicjRNHV54hj+9GYiqd/zpL+qnRwlUY9o3roRPTVqpY38TnQJ5Po0JIJz2TTSzDR9613qqKfBtDG1IsZLBXvtOplw9EXZDJW6U6m/5DzZ+7VmIMcza17iCz5zgrAZXTNjBetOtkkatnB5F4Lw4HZSgwgQn4/B8cqBbjFozdkexlOCFUYpTWFZJBjryHRwFnCj0ABzy6Pn4QMxv1vXUwi6Q4rbmx3Pnwg3ia+LW4eUmctV+gtRpWNn6bs/ZFYKmvgklhLgFD3W+75dsV8VMHozsYGYTalx3pfOsiw6J2LiLEHyAphMznbX+c8HuPfQUY0ua10azexVLYWPTCFU3Bk/wTf8PcEaW/zXECbeDAASo2EcpJTwY4dIUzYuMgNOik5S/w5jaVR+v+dh5R/PazAiIlm9lTQACIOr0k94d4DAo8JMnc617DNZA3vliA6LYKesUvHhVuvjC5/YnivKBNzHtFVzGDlhEuW2e5frIPz4slfK4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejeNE77tNWA8whavWKA98Z2JuCE+lFvf9t22SRh7Il4S6imZPAeYRMXMs2mI?=
 =?us-ascii?Q?bI/eN8UyeAk/XOpubyq49cukFZT+sKDdMd5SrzYrh/DB1EA4p2s+4c6mPsfZ?=
 =?us-ascii?Q?vBr8M8K1wKJKLninSJ/rqcthK+6SDEvAOX00Fiqm02RNPvFGQAdDI2B6syMh?=
 =?us-ascii?Q?pdTphIjjvaYXFNzB5ODMAZ4PylizRqwOKzedqUR+1MLNzC7kU31VnBy2f+GG?=
 =?us-ascii?Q?2McWh+vLCLywex3Ed2wZ5vEDOx0W0OwWIQjbYQVVNoa4I1EzwZAT4JnxW76a?=
 =?us-ascii?Q?mzN/DuMhX97uAaott/RzQaLn8c1LrNX6hRkGFVe+/czv1TgT5CrYejGLmTHH?=
 =?us-ascii?Q?+o6oe+shlCKUgQCTyA7DKjuuCZAcAuHDFiUw3Q8CXMv/fL/Qq9Bz34DwFfs9?=
 =?us-ascii?Q?A+b28pcoCssnMvkrehxeTDLRX3Vat/m86siXLZUNnvSNTKLkhSLFkVu6stKs?=
 =?us-ascii?Q?m0di6L6EbAMwsDVoZXnp2XTmCH3qGOml5+f8CsdNdFPRRiAp4FBQu+9fogqO?=
 =?us-ascii?Q?TvEU4QsuH8hXM2vKcluAE9K8V87d7dmPqEuZg4vN6PNPOBnuPYDvLjNP3Ow4?=
 =?us-ascii?Q?joAVzvOFezl5Ai8ZMi6Pre68bM+idEAkiUQP01cAmL4YvHAjaENuvxcwUajC?=
 =?us-ascii?Q?l7pbqc0SZqEMFOYYcx6F17RwBU5ipWEesrDd/5etUpgXhDUxGOWQfEN506ZK?=
 =?us-ascii?Q?54ZR0VAB725w9l5oNi6WKnUwJvtKDngiDhQ85PV/eNOLkrgpVUbGX1D8pxT3?=
 =?us-ascii?Q?bPjiYnr9bAbOU2RKTF8VOEkVBmtdlTam0iH3+EVtpn5fvDcJaGVRfD7x5ujQ?=
 =?us-ascii?Q?EnLVO1OD8EY30/nX5mnMZ2ZbZKffKRa4rHyiRIeCt1kxX+NE0WzxwgbkOcaW?=
 =?us-ascii?Q?UE4kwWNiZVlGz5SbYYAOVeTrUtOG1QEEs6jAcnuSjV+G6VjgNI76XnoxUqND?=
 =?us-ascii?Q?/kUZy6yPIIersFIM1t09ym6QFyZJcCl293ykHVB+h9kJSgkPKlLPAYttZ13M?=
 =?us-ascii?Q?c5cXFaqqjckvVC8d+idevnfCyDeN2XkKHcSndVRvHnEZhfilY+2RUElYsUs2?=
 =?us-ascii?Q?BpoBSY3v+xtRUr1sjXgeIkfG5RKVv4h2kF+WIS/x1OiPXV2BACJaOwKFVsU2?=
 =?us-ascii?Q?kbKHKU+nKqPiuSGaUmJ6T981KxdmaPRUX/cKvklMSS8EEIwVpBlkiOcsRHzI?=
 =?us-ascii?Q?zxGpFAFMa+KYht7/rDNq9J3dN0LO1ZUKtPTXy1Lmz0urBFYJBuk4ty8BSxBW?=
 =?us-ascii?Q?9giHWzBLpJ6sxJNxQL54yqOUpQBjgeOnla3OqA/JoJF7zUw+BqRDawSt1PY9?=
 =?us-ascii?Q?et8KC8IM8rI5kGzYuMzZlMKN/lnO4Vi3sObLBIeDwmewHx9JVEEoyEOPmrra?=
 =?us-ascii?Q?2lyglIjbvd8/wBlSJPhXjZWypdE2ipVXXAC0g2EOXk6gykFsfnhrKqI2HO6P?=
 =?us-ascii?Q?+eSV87wMthw8R+47EpRzup+Ke/vX5ueI8CAf7D6V1j8ZbqxeX5W7dyPNIlYj?=
 =?us-ascii?Q?3Hpu9hyH6JhocSDSHXwH3d4yVXIOP6hTJtlCL8ETbKlM0B33TkIk+5pGzswL?=
 =?us-ascii?Q?LEEwk7hnL3ndvdm7A3jicL57pLTtgz3649sonIUjIdt2ZSsuBVCukWTy48yS?=
 =?us-ascii?Q?BMWklnA0whO8G3+Cd1c/Tq/6DjY5np0B6Ql0+x9TXYYT9zZJ1OmPj0XCArka?=
 =?us-ascii?Q?/Lgdvy7pTiAOEo71cCNygTaESsG6mnEhjoQCvmI/CHEI9y95Utd9WlAODQuw?=
 =?us-ascii?Q?hcHNYqFjMEVPj0OjARPYOQmewgCZGkDrWVrRZmhPb3CX88MGuJfW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fd3690-f475-4c00-6515-08dea6a8a51f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:18.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfzNIqasEQy5HBJVCRiv+Dpquo4AFCA9ROamUuADWr7yKkG4/H48RyLodqCX7mUbhN/ZTDkkPGYmWEI6nAqshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 564974A1988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7442-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,intel.com:email]

A piece of context which seems relevant here is that the USB subsystem
is transitioning from struct usb_phy to struct phy (belonging to the
Generic PHY subsystem). Commit 1a229d8690a0 ("Revert "usb: phy: add usb
phy notify port status API"") seems to confirm that this is the case.

In the transition process, some PHY provider drivers register themselves
as both Generic PHY and USB PHY in an attempt to bridge the API gap.
Such is the case with drivers/phy/tegra/xusb.c, accessed here by the
Tegra USB host driver. This USB host expects the PHY device behind the
Generic PHY to also be a USB PHY, and calls
devm_usb_get_phy_by_node(phy->dev.of_node).

The Generic PHY exposes no API to get the OF node from a PHY device, so
the Tegra USB host driver gets it directly. However, "struct phy" will
be made an opaque pointer, to avoid misuse, so this will no longer be
possible.

Considering the fact that the Generic PHY/USB PHY duality is a
transitional state, I am deliberately not planning to make the life of
this driver any easier by providing a helper to get to the OF node
somehow. Instead, implement a parallel lookup path through which the
Tegra USB host driver can continue to get to the OF node provided by the
padctl component, using the 'phys' phandle.

Secondly (minor issue) the driver uses the phy->dev.of_node again to
print using dev_dbg() that a "remote wake" was detected. Just print the
index at which the PHY appears inside the driver's tegra->phys[] array
instead.

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
 drivers/usb/host/xhci-tegra.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index d2214d309e96..99b0ac9763f9 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1491,6 +1491,7 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 
 static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 {
+	struct device_node *np = dev_of_node(tegra->dev);
 	unsigned int i;
 
 	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
@@ -1504,23 +1505,33 @@ static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 	tegra->otg_usb3_port = -EINVAL;
 
 	for (i = 0; i < tegra->num_usb_phys; i++) {
-		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
+		struct of_phandle_args args;
+		struct usb_phy *usbphy;
+		int index, err;
+		char prop[8];
 
-		if (!phy)
+		snprintf(prop, sizeof(prop), "usb2-%d", i);
+
+		/*
+		 * usb-phy is optional, continue if it's not available.
+		 */
+		index = of_property_match_string(np, "phy-names", prop);
+		if (index < 0)
 			continue;
 
-		tegra->usbphy[i] = devm_usb_get_phy_by_node(tegra->dev,
-							phy->dev.of_node,
-							&tegra->id_nb);
-		if (!IS_ERR(tegra->usbphy[i])) {
-			dev_dbg(tegra->dev, "usbphy-%d registered", i);
-			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
-		} else {
-			/*
-			 * usb-phy is optional, continue if its not available.
-			 */
-			tegra->usbphy[i] = NULL;
-		}
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err)
+			continue;
+
+		usbphy = devm_usb_get_phy_by_node(tegra->dev, args.np,
+						  &tegra->id_nb);
+		if (IS_ERR(usbphy))
+			continue;
+
+		tegra->usbphy[i] = usbphy;
+		dev_dbg(tegra->dev, "usbphy-%d registered", i);
+		otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
 	}
 
 	return 0;
@@ -2168,8 +2179,7 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 			continue;
 
 		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
-			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
-				tegra->phys[i]->dev.of_node);
+			dev_dbg(tegra->dev, "PHY %d remote wake detected\n", i);
 
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
-- 
2.34.1


