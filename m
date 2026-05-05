Return-Path: <linux-can+bounces-7485-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDTPNpO4+WmNBAMAu9opvQ
	(envelope-from <linux-can+bounces-7485-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:29:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A24C9B18
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE2DA302F2E9
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898231714B;
	Tue,  5 May 2026 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDds+xDz"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A02FFFBE;
	Tue,  5 May 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973085; cv=fail; b=SC58yC4OtOoxpQw8T+tC5cXCrLerXmlOqKg7SbPURCnxPixtW5IYZQ5928LJgU5fbToYdDzVXE8zTqkdv1JXLWL+gNbWjnaPenApjOatX4gMk5Y/C4dAphw/9QHdegmZj0x+p69gTksoWRSRG1/yD/7BpEiYOEcFyCLvUa3JiJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973085; c=relaxed/simple;
	bh=2/hvcgNicvpzibJUtx9sMCCSChzxK3xJeGTttJrBfRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T4IY54r9CtazsL7gvNSnOsehzb6vP64LA+xLKCsaQCPbwQBiEjzsEEV0AiXrAwoSTzhvp6kcJFTDoQ1M+MA+ifujrx6b8E+N+v6FL9uq1tE2TwPCRCcTIgP5kFKwWV1okjI3rXmAuFl+SqB5fCZZ/25Haq1c6UuURjSr7IAmKLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DDds+xDz; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhWc1vlThAYkR5cATwu+Yjh8WbrohUdqaSKWZFW/r9tfjqWyF7RlkrwfD9qF6VM7F1FKTZOW5TrtHYJBm/3JjwtF4Fg3NMv8lV7t6tHN1cc8tbqK5SfYzoT3Uc17W28iRcB9LSUuzpRiB5d22tStUgNyZXiLDejADPjxIxGUJGaMgt07GC3uD/AjUZ3knwmfk1Zoznjmwqvvurb0uQ8cRZ2BK6c/Wx4D3Kb+7OZpzjdxxFQWpHwZPaEVlYZH9heGZFa5kT02WPK7o0PtGWauDWn8rjZPEXsdOyp1/6Yf/SuISmXBpaHYgkZNIs0erBloaboLSxkjqoVOTheDiUjz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwVhSaHvrSwkXjfD/7jHyuWQDJ7/WN3ddzfU0SaTjh8=;
 b=wHuKXAaXm6PuLLaSOqU0ySUlGwdl1DuXqHB1x/OriRo/8S2HG5H6Jl4Ub/Lrv+C0Z2ZWcMIVe3AXiSUbg+bTRtz6IaPabd0i+VsthMaplfyWHtZTYWYfr35kjWKbt8UAYqFMV1gHppaGoYWyDJkJWGufOqruHpXuNE15wOlj/4o5jRXOuO7humOQwwdvJXGqlvophHvF3hUlTpxNNk00QaAj5jbBjiu9fvUv9nfavA5M7o6gtgzM8WMwaYEp4d/uK4QRzj2a+FnPv1jwlmpYgKaDpveZ8nfXgRj68OqgI9dKR0R4fU165X97DmlJXJlFnC4/VjYxsb7P2TMZsLv49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwVhSaHvrSwkXjfD/7jHyuWQDJ7/WN3ddzfU0SaTjh8=;
 b=DDds+xDzOGYdQVOIMZsF7+yttdUd0EK5S+zdJ7P6pHssP65ICFmtoDk+/dvzUmlHe/RhbFvywS8jimxlxfP4L1u2UuIM3KXEtZ3NdfHsMqzyCKzya0liP03Olqwv5cxxBV30qQg2zoCe39zCLtlQuuENTUvzUj2bKhWcwSG6dPPMhJuIE2tArKE93Z0z0KDbxOOTHuVCzSMKZkrhk9t+wrqA/onEz+3r+lvMPrHhRKYAnzcQ8C1kLdWPwaTjyn6oxxHohk+fu8LgbKPkbd76l/qn82VzHK+scDDI5CatX7mWNLPfDyKjG695TZ4QD2FrcKPXT8OYZ2K7Wvhw1CPGrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:24:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:24:40 +0000
Date: Tue, 5 May 2026 12:24:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michael Dege <michael.dege@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v7 phy-next 21/27] net: renesas: rswitch: include PHY
 provider header
Message-ID: <20260505092435.dsfsv6t4mpzluzqf@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-22-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-22-vladimir.oltean@nxp.com>
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ec2f96-ca08-4ba4-7842-08deaa88223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rEcU+S+6oXvN/E0ZCCOAyxYQngeJVWmCpAXkjD0RhmcgB7X2IJvOP0Z4J6VcEjpqUBXVIVLGVADZBEXRY9Rqrwh/oVF8FibLS8AphcJ2eDtLxJK2pD3/VzHc3PqFjij3WJ7RxTlHL4r8biZuAnK2oqhQvNYr5N3XfW4+12FWdUrQMMrqp+6Y3haEaEBOSVejoVP4iCRF0qSnllVeEzlhHndd2sjuodFQ4SHL/NBnChNrNnTK0GJhD8NuNRUdOPCOVDX7mGs4NumCJoBkVSOYDJkattXS1kyrJUQ/Vn77DOIqRG80/zzsZugHEXWfH7VkfnarFhQgtFZCMDxnONmBXqlyMfXkdFwK59yzxGzGOZ4cs9rZ6mFhPkpOLL+o7Tl8rTU0VQjmhQpPMNIDDn/AMZMWP85zwqJ5v+JihmDn8+cbRv4FFqBSPR87qM3ZvVU139pmp2VPnSvb/MjUxhd9dhtAYGFZX+xRvAAsirP744MaUftsK8ReRyuSv3Fub85DhuU4DIl2nETFnaPsassop5ae0fpwnhINSzuEgdc22+tFtfiBU7KaokOt38V+nrqE2IKfyyXtwlcHMCktG5WwyYX27EtTlOEESTT7WfkLj8g+JIct/wzrBdW9wmdISY65jiTBhi0ziTU7/Svwcuh4olWBMXLIeRgba/FYOBQByeh6ijRzfRQ+KQA97dBQB1a8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhQcAOw1IyA8eOBtkTZl8lTtJAyzXXNo157o4WyehmkNXH2wZ70MdkyNj+F5?=
 =?us-ascii?Q?F5bI1ylV8hLy9j8lgdmhwKoOs4Y0H1E7QBabh8WJYD1WHPhXCRk41thtQTA2?=
 =?us-ascii?Q?OHe1zc/UwEeuKNk0AoPH1q7YiwfzJMey4BgrWwkFEPgT+iMGcbZsAzFEsIqG?=
 =?us-ascii?Q?7WQnoeEkmvU138qZOmvfZ4ChckaTOyDPWeWwBY1EPSAvImCy8Zjg9IFMJZRC?=
 =?us-ascii?Q?RSUUiH8kIQtFJR/qN1aTadZBi24iGN0NlhyAG1menNV8DDu8UT8FaEg619tS?=
 =?us-ascii?Q?KJl/QaWlne6bMjkvUG4VyPWz7FvJZxSlPWfLWYFNT9oJ2x+BE6lFwzcS6UQy?=
 =?us-ascii?Q?udodb0ZQSYhJA64Audtp2h+/6p5Dm3TNimSp2NHmjiypNXtvBH9/OMRR4BMi?=
 =?us-ascii?Q?Ek2Sc0SJD7ewFWpscvlhTbrRfaePjTcyvAzNAUNabGgkEP3Ip9BfnVBKdoec?=
 =?us-ascii?Q?n/bNxDXnuVdTwMBMswvbnAA0rWDQg0exxWMeLzeFMS0RRXRdKhNxAYsqILj9?=
 =?us-ascii?Q?NkkSqVATF3kPiMK+qAQ6ug1gyUw9v7lmOe7It8yFtyXpwxAdsBxfjnw8BAqM?=
 =?us-ascii?Q?PKsyQSbHotwQ+/nTtJ0QO4LZadxCSZHcAljQP1TyFlXo5KorwQlKUmUYInDQ?=
 =?us-ascii?Q?aGifuSQkC2sS7DlPIdxURQtjCOOrQMo+Ff+MuVy1ylSznZAn/K4qDp/ghaON?=
 =?us-ascii?Q?oodaBA4hwtu63nAzGnJldSoQOBBCcRX7hLAQ68/GNiKOU7uktph+OS2lbl+1?=
 =?us-ascii?Q?NkIAiOO25AQcq7w43kOkOPZMfr1ADB1hztApDise96dit3pPm8bYNd2ieNyI?=
 =?us-ascii?Q?iwiKE3/sN3hrigi6wsFw279AAwDS+aiCxzT9N+wSd8/KRntGq606j2bELnxq?=
 =?us-ascii?Q?6QY58jSpmeUMqrSXGcO+ZauGhfv3m6SVER/ydFfTezvUAwyJ4sDnNw7ZOVwg?=
 =?us-ascii?Q?pblz8pN7GY8B1deNKiUnvi3aDtvEuWdQmPlmvu8ykKnDZOZGW2dE+6Fvx5uB?=
 =?us-ascii?Q?Ffmbsl6K4brYtZis7EecqlAK/rexMheNn5Jp45enmvo+goKvlv4Tp5rAJqT8?=
 =?us-ascii?Q?Yg8J5u5r+lGGf+5D+U0TBw9Vi+DqJ9Ri5kBWyf1ypYGkToSAN0CwCXR7EYjB?=
 =?us-ascii?Q?lt7j1/ErISWOExi5MQ3J2jx1bTZV2rXrWshq9IohqHZrNe3S01ZN7AGwwJO1?=
 =?us-ascii?Q?mx5/mrIgOM6TvOVGakBVitZN0nAbTDM2+/uXMAt/eT2z0RqrqsJ9JUoAzKWT?=
 =?us-ascii?Q?YqYMYuahzFImNfbI/Q0YUV3rZY5HMVGCnedT87f8zvC2ENsvNIooBuoPZIi8?=
 =?us-ascii?Q?WVPhnk/BDRb+KNi5ZhPx0xXB2R12aGH1379+C57lEjzXSCEcOGe0H09cDHaH?=
 =?us-ascii?Q?uPj6b7gx0AHtiZ02o6vwhT2vNbHaT5r/E4Glk4qadTST0pBEWKRZS3odieIS?=
 =?us-ascii?Q?8pBwrOZqC4nADLOaWMGrZCtb+DNnbK4P9ceOAQo4/+kwkJ+l0fPsSU9ge5g6?=
 =?us-ascii?Q?rYTDSDOAlypO9CHlCxCqfj47DE46fzbQJRYO1uKCXqWRykL3N4vkH/KRu0wi?=
 =?us-ascii?Q?xQ6M1bLTKMzNqvfu/BZFWQnT5kNsyWBwD8D+IMNTvvLDeVH+IMaobsUuTdJd?=
 =?us-ascii?Q?QyFRc/m/cR/dWnWwNTL1tP2wovULbI9/x6j3dYQfsuyf1A2m372vftJK59KI?=
 =?us-ascii?Q?IjCcvfIF8XGTZbvv4aJt8QK3xeRGhTsuyf0OIX8FDT9yeUXJnT7imv5IrgGS?=
 =?us-ascii?Q?V/+D++XbIyBvDbGSY3XuvH/Ae/BzVYzsw2FtGIn4ZzA41L2DGZkqewEnInUn?=
X-MS-Exchange-AntiSpam-MessageData-1: UeJw4YBA3nG0KrOPNFfiI9Ohiv1bj8yfJ00=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ec2f96-ca08-4ba4-7842-08deaa88223a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:24:40.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdcwXMpmyGwnhk8DQobsjQptw81Aw/myR6+mXfXzLRf3TxVTygQXukFsdRANEgPTJb8L/zsGhw9zvkdJm7wR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9517
X-Rspamd-Queue-Id: 332A24C9B18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7485-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Sashiko says:
> commit 4e15b6920cd2b2dfce685835fa09c66664407579
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> net: renesas: rswitch: include PHY provider header
> 
> This commit includes the PHY provider header in the rswitch driver as a
> workaround to avoid breaking the build when struct phy becomes opaque.
> It allows the driver to continue accessing internal PHY fields while
> acknowledging that the driver's PHY API call sequence needs a complete
> redesign.
> 
> > diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> > index 6fe964816322a..132be5f15073c 100644
> > --- a/drivers/net/ethernet/renesas/rswitch_main.c
> > +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/sys_soc.h>
> >
> > +#include "../../../phy/phy-provider.h" /* FIXME */
> 
> Does preserving the ability to check the provider's global reference counts
> (power_count and init_count) via this internal header leave the driver
> vulnerable to data races?
> 
> Since these fields are protected by the PHY provider's internal phy->mutex,
> reading them locklessly can create a time-of-check to time-of-use
> vulnerability. The count could be altered by a concurrent operation before
> the mutex is acquired inside phy_power_off() or phy_exit().
> 
> Additionally, if the PHY is shared across multiple ports (like in QSGMII
> mode), would checking the global reference count instead of tracking the
> consumer's local vote cause a port to observe a non-zero count from
> another port's vote? This could lead to an incorrect phy_power_off()
> call, prematurely decrementing the shared refcount and powering down the
> PHY while it is still in active use by other ports.
> 
> While the commit message notes this is a known issue preserved as a
> workaround until a complete redesign, could retaining these unlocked
> reads cause a regression in power vote tracking in the interim?
> 
> >  #include "rswitch.h"
> >  #include "rswitch_l2.h"

I will ignore this comment. Inaction will leave the driver in exactly
the same state as before. Not great, true, but I don't see how not
changing anything could cause a regression.

