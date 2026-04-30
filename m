Return-Path: <linux-can+bounces-7455-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCzEGks/82kGywEAu9opvQ
	(envelope-from <linux-can+bounces-7455-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:38:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C64A2427
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3778302064C
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240F4611C1;
	Thu, 30 Apr 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PGEvgGLi"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC3D9DA5;
	Thu, 30 Apr 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547277; cv=fail; b=P5P2WDfCjyP/kvvbDdreaVKfYGViKsckfoLkfX45854uTqbrmJot1jJXpOSckmIGIzcbP5Yx2zeHm/leo5KXSB7ZDFHvxVTXrNL2HguxzSqUkPbDc1BBpclZrdJB3br66TXQp57azRI4VGWkQQTKt4pi6mAcEUnZ82hbHvHDuqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547277; c=relaxed/simple;
	bh=mgz/MrfQyrbidNyHOZbUdKHZVsuN+qllvL2HQioDMBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZOTP+LxZaoOFOJqhCdVOEGU1MCTqr9pggG/jzlHaAdB+/bvuC7spg9HPPLfd54UrCst0zgZLs47DCeQA6pafxTVadSJBgpb3mbeYamXEnYvOYzX5xbTvkwlQE4jQEkU9E0RrvMtlGH+5ndCdod5zsVPFHP1imcU0WYhzC/Zg6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PGEvgGLi; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPNaASJViQfaV2TvNLZYuuwvBQ81y08QhJ4WjcirGc9Pr/DtJKZ0IM6/nNUTkxqMqTl1hzklBNc5ryUgiEPv8jP5yTj/BysXXeRZHMkOFu573fbbOziJ93evyVmj7U7gJiLW6OMuYq/0uOm4EdKoI5ecACuLOcwyCVDD8SSaruRK9zPP34oKtCWdOqfDN3B91gbatz60UtRZ7qn+r47XeMeb48HUOruLBXMmSgmm4rnfJ54fKndG4NFKTRwODBqsPfhY/pBBdAqwvcaGZZ8rrsh6oKqsKq+PhUKLS2kf2iKguS7D//ZKAwIX+bV2A9cvvwu2smh42OCQDm6L/EaPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLMvkx/jDKJ88xfratN174cI0q8RyGovxZKwPAoCLEQ=;
 b=icoEfedCXonW9DkUPysIvuTfoDkGQTZJeubLfXadswvTWwZZmo1dRbi1WMmObapNPkSIplJx3beFu2zvlsB2iygfx3cV040Jw1uhAsKVQ++cPTV+H47s5ioaJi1jS9aRbCgpvdXulzg9U6AnGqCC0bifJYhqipmDWccLok1qWZ3tRyrFMPhRsfN9uDXcnU+GfpLtUPikGw0fxJhEmwYHp0Tpox5px3MtGtZPdzLDY2xDuulhTdASmFFhnigVLVXKxQu7+USwq1+YbRZBEClqIwcuQHq2kc9KH2VubYVvPAl8WvgcvqOCF24AN3mJs0HnxdcmjKAHZUg+fI7BoPXpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLMvkx/jDKJ88xfratN174cI0q8RyGovxZKwPAoCLEQ=;
 b=PGEvgGLizV2aT5BoDVbdlIezYKUMUElF7ramOtvqgvP0ibcVnnpnH9bPCFJlrcZp5tW+bUGJtCM6f2DRlWjpPxUL/2VRpvvhNKvsicH5kt3KYU8K1ogi1Tg4xJRnlssFJMv/qOueHzWqsL5r/SBLhTsPM0/7W8Gfw/lDt79kWgfcU3InLVzkbcxJUEmDclDK+BoeQDuxrNUpd7Kq3MDFybTqVJLHtwJmn39fvrlyeEf2VfgZAPmlphciZZfPyjyTJxoHC0Cb3ybnIpD+2kKo/VAE65rDyYY+G0X5xhYSuqqR1XF0UsM7qTAHEiz20HgkNIAWm/yNnOPlIwi2y7Qcew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10583.eurprd04.prod.outlook.com (2603:10a6:150:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:44 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:44 +0000
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
	Joe Perches <joe@perches.com>
Subject: [PATCH v7 phy-next 27/27] MAINTAINERS: add regexes for linux-phy
Date: Thu, 30 Apr 2026 14:06:52 +0300
Message-Id: <20260430110652.558622-28-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fb7c4a-6589-41ab-0124-08dea6a8b43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yIBsNjjdNHR7f0VicnHDhQDzT77LEnytEqYRaWTQm0poMYFRgjFHBcYpejfjjtHH6R/I5iAnwyHuDzQ+WPBbh+f2lc5k2b2sZA6aKiO/gYZSFL/EePNO9rFvUusULf0Ls34FBuET+dhlXRIqp8yQHj4jTrTqaiF984KDDR0CxYbB7lHDBGIGLTLMM7nvKujQeg9n65/P3XiJ3QBbbDgyi29AcL4/ZgvM3l9v4fj+75M5mnj3wNxkX7PAKOheCXmG10cu059p+wud5Aga9pNvVh6L9p21w1R3hPOvXZdrZgOhoJAOWzYLg0ptqkh6slInWjoV5zId5s1VM5iSRG3vYO47rvenqUjv5eaMnVlT8euHSrzi6SANC27az2rCcHWZcp5u/8zquggoozvtX1+mF7OAAmP+xv7dQ4SHqnepfX1mvbK10umiqz38OzTjy1JeO8RWzIHXnBJNRmx3LApVbnFwLqFQfjNOtZeYkBIkS0MZ/AkdrUpNrvavaW9ShP2t+nx0uC3HGdvkoa4q1Hu1mbCGSLpzCnY3gV9nDB+EUX4CKTrDlCcuPXwoATcaTS/tPj3edBOg3EJxW9jKq7rfO0J+5UGkjbI/x3Bc7ZHPW5GKB7vD0DNjiHa1G+OzwjZdweZHYS+XK/nfcW7vc6sALKOCWDPCICw/fwfrq0VBToKCJwIpZaMGU7NLbWhl8l7TR5/Mpby5LLKZqbjTVXc7c9iwa60jczXgrocQwRhyRcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dAgADMyyCx6nTeDi0fenaL7/6bIyQDHbqhOVHiSKnWH3/8ZTUm+5NSukNNzX?=
 =?us-ascii?Q?A3uRvw2YGnGfBd0PJbILTtPnVNYjjFZ6d94ilp6fK07zTRfB5GhhEnjSYxq1?=
 =?us-ascii?Q?HotgX/BexYuTLSddtlnsnnIMosppWLJgPWmMfpT5pWuA+G33KpIV/B06EkdA?=
 =?us-ascii?Q?RWuzy0rTdGoogFhT8DKuRXqCrUok7G+YehJKEgVGbj3DaPrGjB2oy/0vznP2?=
 =?us-ascii?Q?E7eHaujatxDrOD+A7UnsRH7WmHZtVRm/qI6Q6y6XtY2EdsSa52+H9ei8GYq3?=
 =?us-ascii?Q?Bmo7Dx08F/m8wVPYHGsXm467S84B6PTSHQvY7wCUbu3kZo0AMniF77bQMVtl?=
 =?us-ascii?Q?fJ+TYfClEy/XBOIKKJTIhu5hFtbfIWgkxzJUJw230rZeIOGMTWbJzig+mcZ5?=
 =?us-ascii?Q?7PruU0o/kZUxb+qVN9CSmaHHohny6yh1kxoyhgpDmBgmGkkzCcd1ryVkg+63?=
 =?us-ascii?Q?27A0HQ4c4+9m7qRUCLPZvL8Tr2VQNToygI1ASx2d+xvha6MyFOXK+Ca4VQUR?=
 =?us-ascii?Q?7O18olYxsM60Pb4bhxHEBMiUzy0ZdVTlKesrvZSTwETcdccQViOzdfrLwGqG?=
 =?us-ascii?Q?E9EBSOyDrAilhDlkJTJLQfjsV9IjdznMSQWNLv70RiqrEs0LxR5Be4wH3j8S?=
 =?us-ascii?Q?UQq6PuSyAfJpxKyVt43y/LwxbFKSgODg87BPMFheYLmcqUgoqhRsf6OLCZBi?=
 =?us-ascii?Q?5e/sFJQ/OPAAm3UQYr51L9FdmK5MHCzdeV+CtpTxc8QiQcWg0pu3HDbUwVhC?=
 =?us-ascii?Q?slDdm+10MIUavSM/O/nyP7PZxPrJy5VPIxO2D0detOMg3JcQayL6IpxSJ/K3?=
 =?us-ascii?Q?mBeyhqjR0fP8LJuM9wsBEZsDK976/j3RjejBKCX19ATChsSRL/MkDIRLKo7L?=
 =?us-ascii?Q?85ecAZin1i+YtIGFMlq+61HsWlh0wskhNDHuplDr+LPVx514cVilvgSNaJK+?=
 =?us-ascii?Q?Q+gZehXPJ7d9g0W8YK+so9CygDB/DS1PZtCrEebegLB1ysfJtDivrno/M4aA?=
 =?us-ascii?Q?hswxNH4icu3vn/r6I1c4yG1cRn0VlNNhuBen2vDo/rpE+OF98PLv1obXOh+u?=
 =?us-ascii?Q?A0ib6Nca186EArO+DxCSWJa4rA/IzDAAoSv74PU+jB7xc9frEX4VGxkFtBY1?=
 =?us-ascii?Q?bG8MFws5rPXweXNXccHprlscdlBgPiY//b7bJoqtJkXzubvKceBhhmrXl3iM?=
 =?us-ascii?Q?uVhtag9OqX35+4z04aPUsS4k8Coo0n6GoISF35CZUK5Oaed5dsnkog02oqdD?=
 =?us-ascii?Q?qLCzDAjVAKRaStbcTwIVCWyzhEBkRDqLsHyUpQTDtobdrImVcqu4/VIEpOjs?=
 =?us-ascii?Q?S4cEzNP5O1hhKhhxfH8A48UGvdOiy/ZF5LapmXN4pGHI+3Yht7cfzurUWKfn?=
 =?us-ascii?Q?MCv46Mb2/4X3z1REIfumObAZ3fpXHFkt3t4Wlh2qyFSYl317YCpPIzwPNm4E?=
 =?us-ascii?Q?Ph8n+nKBtc6zTI+qx9GlDjPRFkH8K2YDyrquJefPcfsTjMW9d3UD+YMtMACW?=
 =?us-ascii?Q?TvqrQnouJ5lgPS884e6FxFvnhUr2ZEYMU2pyoNDjTyC/42DaFJ5IGLLfuj/G?=
 =?us-ascii?Q?x23NluZ5RmZQWFyW3So6eVoCCEv/lm/kIg5md1pxiNJQyOgYaKxofD6Tq0v7?=
 =?us-ascii?Q?/DHxDj2DCLoyhwbmPbKL7NOi00WwYyxKg6DPG5eBEJM8+7jwHP6Dovbtr/Bn?=
 =?us-ascii?Q?HrM7CSMzS9kf7v+tdjNBA1W0aend9iFVUA0H4F9pch6aDN9vNNpu8Mo2GfIJ?=
 =?us-ascii?Q?oZCciV+xwV8ochTcdXUtnyJrLshhnVoGG1Bc1tfYarb6AEPI8uA7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fb7c4a-6589-41ab-0124-08dea6a8b43c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:44.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3zia4O9vZ/LzZ2HYXexmcVDFi5zd37pZ5Gpgzx2EWyM/eg17pNxAZNAiIzt+t0iAw/b5a789pZ6Xhrj70Yh3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10583
X-Rspamd-Queue-Id: 672C64A2427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7455-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,perches.com:email]

Some pragmatic shortcuts are being taken by PHY consumer driver authors,
which put a burden on the framework. A lot of these can be caught during
review.

Make sure the linux-phy list is copied on as many keywords that regexes
can reasonably catch.

Some considerations that led to this solution and not a simpler one:
- Consumers may be located anywhere, and their file naming provides no
  indication whatsoever that they are PHY API consumers.
- The network PHY API has similarly sounding API: phy_start(),
  phy_connect(), etc. Similarly, matching on "phy" would hit
  phys_addr_t, "cryptography", etc.
- The header files themselves need attention to avoid matching on
  include/linux/phy.h (network PHY), include/linux/usb/phy.h,
  drivers/net/vendor/device/phy.h, etc.
- At least for a transitional period, I suppose developers will still
  try to add PHY providers outside the subsystem (which is discouraged).

So I used \b to try to match on actual word boundaries and I went for
listing all markers of PHY API use as they may appear in patch contexts.

Bit rot is a valid concern. I will add a test to the build automation
that newly introduced struct and function names in include/linux/phy.h,
include/linux/phy-props.h and drivers/phy/phy-provider.h are matched by
the MAINTAINERS entry K: patterns.

The keyword patterns were written with great help from Joe Perches
<joe@perches.com>.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Joe Perches <joe@perches.com>

v3->v7: none
v2->v3:
- escape forward slash in linux/phy/phy.h in regex pattern:
  https://lore.kernel.org/linux-phy/9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com/
v1->v2:
- split into multiple regex patterns
- use matching-only (insted of capturing) regex patterns
- adjust commit message to reflect the Q&A from v1
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..032be68cc326 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10799,6 +10799,17 @@ F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/dt-bindings/phy/
 F:	include/linux/phy/
+K:	(?:linux\/phy\/phy\.h|phy-props\.h|phy-provider\.h)
+K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
+K:	\bphy_(?:create|remove)_lookup\b
+K:	\bphy_(?:get|set)_drvdata\b
+K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
+K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
+K:	\bphy_(?:init|exit|power_(?:on|off))\b
+K:	\bphy_(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
+K:	\bphy_(?:reset|configure|validate|calibrate)\b
+K:	\bphy_notify_(?:connect|disconnect|state)\b
+K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.34.1


