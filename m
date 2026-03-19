Return-Path: <linux-can+bounces-7183-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP37DM98vGk1zQIAu9opvQ
	(envelope-from <linux-can+bounces-7183-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:46:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B22D3AB8
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD35B30B2873
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6242314E;
	Thu, 19 Mar 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVqart/A"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AD413252;
	Thu, 19 Mar 2026 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959613; cv=fail; b=RbnBGQDN2wZxPUqPBlw5LJI/CaBRiJEppQdB/hQa8Q93/aEo/Y34W3oaiOyMsES9vxh5MFZiykzvgNGP5ELhNFIYoXtLsfO9Lfx546E+x+lHrwOMq33zAUQ+yX4ZyVMboq5+1WP7K0rWVyDe73Dq4gFl4GBuLKvnHBlBbNiygGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959613; c=relaxed/simple;
	bh=ch1+QMrW0d54aRxxXdrp0Is/ImgEJUTBz77fRRcVVWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTngPdoggk0PpYR50/UzeqK1T393rC6aDFXAETz+dBv2e2WhVH95qnoXchW9NIqbUnK6QDYWi3dw4d+jhZlK9DNb1BnBsc9Elx1PiN0bbUrKZmRZodQ56eKA11ZHLOh9BDlsCffazQOAixg/8GqMdnN3wEQtLgZFIW5C9ZmRfg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVqart/A; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKWZNLoNeZMYzJHfDUek1gfXIMBYQfBXxTjaxmj0dBk/7aeORKUBPmp8Qwg5lx1D2R/MAKh/hVBuM2yjQRssSVclafsnXFi713QyUbeVCv+5TIsuTPfqFT7fsDDpn+s4Rufk2LiEZ1cS6F2iufIFjP34whQ3W9ThdGrWcpDbCUqISf+r7yjUd0o22NV/oElTp8T4YCju0Tn0ZAoauJHm9wVQ3FeV5vxgjovzOTUgc53zOSsjANoVKQoGS6E1wXtB3XoSk7eH/AWFiZnJ68PgRtW305BoAbbScRcZlk+Vy1aOP+bZbBe4C5mTnuIJ3wOQeCuR+5SfXUx9ywAXsh6ueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MtIGGi8U7z6sayPbWkjpsR35AKsf3Ssgr2wiEpFo8I=;
 b=sZpV2ITm8HFHC4q+bnPjwDtOcfYszv4KviYhmRmUPi06xETf7mDVjK3rKKAMLUb+rjuiQyUorLU454Y1JxR3aAbywtjVeOGTKlQM1ZCTkmI2W3ggzTWCmgq+gA6TjU4Q+8MeeGJ2iNOmrumn8FwA3sUQiwBJBsPTmgocTzjq6/fWNqFQ/psnLy0VFJBN0GJ8sv78PFv8hiT2zGdd2dYkhSepNJ5HKvN/r6VSoTiRY9elF1IXNlK9gAjz9kNYugjXOfg8kg4PPZrqH7SY7KsdV3TxtEcwutpGlPsWmEtO0c2k+xTQTNb1BWPxrnDANSRpwqSoTo58sX8bfWs9ONTFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MtIGGi8U7z6sayPbWkjpsR35AKsf3Ssgr2wiEpFo8I=;
 b=hVqart/A1aMHjQwiIXlShvpG99CeZ97v/pA3L2X9pNxk5vNBGzKkaGu8o4SpZFXKgOSy9Hsa5cVkE6KF3gAqI5XqHfxiP8zQoyrIyy2mmY4mhpLDt+2Rt/3MjyQWYk2G6rRYfSvp7guJDzQfQ2j77jGI/SEjeZJAjhmTVbzmo3he63ip+ndC4GjTVEiARYo4H3cFJ6JOqZgRV95lk6jZJRVIiymHMJZvwAvlQKGCTLrOHONVMTf113JDyBDCkbEpVJv1wthDtTfX+JkWd23GNv338sIJR0fKXfYREfmk7Lq5TP3CM3qLctzobD8INpfcNdjlAFkkD7UpDegVK6KvAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:02 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:59 +0000
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
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track of PHY power state
Date: Fri, 20 Mar 2026 00:32:24 +0200
Message-ID: <20260319223241.1351137-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7023de91-fdd5-438a-996e-08de860779a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ikcUkytvipMECPn+3aQ3dkEceeHklJ2dgug6qLWyizYyn6PeMfZdTOd3XnBi55MA8j5wxbnKFbQiy6n3bMwgEX+NGrE/MSBw9DgenBmh2bjGELNvP/y193CofJifS6Ougc1B/iB1DygX6jB4MzYKUDcxW31GJJvq3AEJ6/8psWg2DGgj4ub3g0kmdwIM/jw9lP5z0Coy4kW9x9yBUykQY4yQxd04gwq0jLNOnRte/B8+5+AcLfjJC0xRwvdKOaNIyi2W7YEA8/Vif0lGhkHKVBT2kLf37hFIqo13OJYl7zDO20TvcoBn5pAYPNCXRqgjyz39u6/bDUiy4H18qt+FfvkONHXzKqk2bioVmBYyMPZ4OHtNUy9dOHeCGTCfSRb1zeXCAinmyYHPuskx6ySkr3YsMkOp+gY3uwnDpMrgZFB3QKC7W8GHzXA5XVaCBY7x4gH4NDg3pHnSiI4xJ5gWhywN6zObUQzrN+vayIRZeMeareeUz3zp4fcLZySw+TTaCHMS/yISPWodqLoifGE9zGeIBDUUSHml5r9YlErs8LXUMAv+Uci869Hpo+7CwRtbv3D9c1KpHKcumAcGmc7caGm9NuNblR0xITtD7xoCCIsykfBD219n7AikJBYP1yOvMYkSUcxCyLsBfTtV/aaJ3YK70Vzlkwjm9w6BM/Kenm6wcaSofEm/Pi707exLRHJ/AYB6bLRhU/9XK1ct4s/nCbJZXOw7lLCQSy1ASYe3kn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9G1igbazjU8vd42Jp+C+5zc85Ylx1M28NNtoEf0nje1Qm1BdeVQT8ccOEc1S?=
 =?us-ascii?Q?OqidXxQVtbh1jK1/yXmU7H5C0am3YSjrhgUAJ6rK8yJuQUlCah2Dd8ypGmR6?=
 =?us-ascii?Q?xsvLGOJK1jnQa1WspfrXgFU4U/FzMAHOppER6IFD20mRasgtI/OxKNrpksqb?=
 =?us-ascii?Q?rbLmNqqzFppqQTuLvFTBaPbaA3afYcZcREqBQ+31NxNg+4sGZ6PCfv20/HFu?=
 =?us-ascii?Q?bYkrq/Gqmmumw/FMT+zl5p6fE4zRK+Y5WwLKAQ5jy2tRyNBe+XiXUTus7mbQ?=
 =?us-ascii?Q?JZQaOnDWfsVTuMXZh7z6qxbBLWZ5tAfVLCmFDEyol06CEU/0GIxNtPWAVRRc?=
 =?us-ascii?Q?wWFpzNFXEGcUH+X1+JrshqIh/Z6UWTsoZgdCQtdUGxXY8V/2Hm161P0dHgiR?=
 =?us-ascii?Q?Jji4zKfmMDMwJ4MPMORGaBLd0u0RnUkv5+B7bTV4oenDwg3Q91yvHQ/rKLvn?=
 =?us-ascii?Q?afjW9wJjzNx0YFPfqUORNE1e9F2wTR7No4EFOA53Qjxr4/K9zIzMHiwxFMyZ?=
 =?us-ascii?Q?SLAm1D/Fsp0B1/I2YkDgdMILC+9SDzvQxmjFYPVGo2FfkWLqIsAxxwLdjIr/?=
 =?us-ascii?Q?9yzaQec/KUSawHtHgIjKf9GQUcpXnHrKM3n/pBbdCKEV/xdfuCX6WqY1mQF7?=
 =?us-ascii?Q?YzvPoBRmK2sb/ehj9Clucu0kZ6b6en60dufx93QIEC1xymxMktA36feGaOae?=
 =?us-ascii?Q?kUG60Zd8mSwLHrz7cw3PqqyjPH91Y+5ddtD0r6Hw4b9dF8x3uPKtpq23GQCJ?=
 =?us-ascii?Q?YC6Hj/CTLGmW/AnbxVFXjb2KwjEf5tpl3p6neHOAPTGJe9rtU6n7+NM46UPv?=
 =?us-ascii?Q?+REzum3yYfNh/CpO9m+RVCx8T1ckhVoMKIEywBokA5Nrah2MmAOVeIY9TijM?=
 =?us-ascii?Q?vo4fvVGo35q38bCH8HtcgsAUz+1f+M0oDPjhGaVEEuKqJP3s7vJ1KqkdDCGh?=
 =?us-ascii?Q?PYjO4Ltd9eE808I62HoKDCZ0VUoRVhoLsNFEaiKbB4+w2q/bBIceTRMk4nWV?=
 =?us-ascii?Q?LKNe9H+vqVctg11VuQR5cqtwzT7At+5CrzdWVq8YRCEFlVLE2W2he2i0Va8A?=
 =?us-ascii?Q?1PX9pv0+pXbRfiC9PFuGvXG1F58FDiqVDCGNsF51CoWCDl0sKg5yHAl7qcfZ?=
 =?us-ascii?Q?9sLAFssAPQOYUvt0hWcHkdzQe4FTL0BPIlHJ4uO16AXKRZDbbAvUY1tM8qOI?=
 =?us-ascii?Q?hSppTnvYjr47Gj+8pNZbfkQgmi1P4BCus1kh1PW3irzgyTUQVU2GU8wIps8k?=
 =?us-ascii?Q?K55WRWD6jJr6y4qm395RT7TE+za01CE8qGu6jUOFdYBxCgwUoHe6ztc/w8Lx?=
 =?us-ascii?Q?fBZMW/imqAt4Kf2oQzkvk8RVC0n+EM9JW1vwrNonjxNL7ibCUpN6ryM6kov+?=
 =?us-ascii?Q?PUYFCuWVlTt8sB6Fbekq6cJs9VevxgWsCqSW9zxvHDk0bbMWxxDf+zRc6XeN?=
 =?us-ascii?Q?KaQ+jWI2BRfiYVF4LMTCuPib9MucTk0ZMph6gRA+zoLF5Rk7GHbOyoe4C/7A?=
 =?us-ascii?Q?VNwMcoBiz9zlecJwvEzK3BEhny2fap4M7pT8tzYMoaXfFw5UU1hESKXDH4Zk?=
 =?us-ascii?Q?mSBKD55OFhItuCstCayQwwImVIP/TBzbTf6LcP4GUTkOpNXnp9g06GAVvBDC?=
 =?us-ascii?Q?QL0hx7uwqCcYAhKmLV1Wj0Hkf3sNSxE5m+gcCXoYtlrhmhB1jqJwSkaI0ebz?=
 =?us-ascii?Q?fjYIgb5+Hzq/wb071XkA7uFh8J65fQzjYUY1r89LYZ6pNnloc+9tyNm13Ak7?=
 =?us-ascii?Q?QqpdOiu3TP+AfDIwA6jICrEyUPlO4pE9JP4f9bFHOxwlM7TBqozrM9aZjhjM?=
X-MS-Exchange-AntiSpam-MessageData-1: 3KCF/9VW+S9jNZFbj9atMAFvuenyqVAfcZo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7023de91-fdd5-438a-996e-08de860779a4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:59.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WTj8SRkL5/KdFtdxvfC67t1THYjCvi10XEO7/JYA7Vs78l79UQK8AU1d1hpjJM/0mpWeTxazKpxgx1CYohhuQ==
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
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7183-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,hansenpartnership.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 822B22D3AB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As explained in the similar ufs-exynos.c change, PHY consumer drivers
should not look at the phy->power_count, because in the general case
there might also be other consumers who have called phy_power_on() too,
so the fact that the power_count is non-zero does not mean that we did.

Moreover, struct phy will become opaque soon, so the qcom UFS driver
will not be able to apply this pattern. Keep parallel track of the PHY
power state, instead of looking at a field which will become unavailable
(phy->power_count).

About treating the phy_power_off() return code: from an API perspective,
this should have probably returned void, otherwise consumers would be
stuck in a state they can't escape. The provider, phy-qcom-qmp-ufs.c,
does return 0 in its power_off() implementation. I consider it safe to
discard potential errors from phy_power_off() instead of complicating
the phy_powered_on logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>

v4->v5: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 9 +++++++--
 drivers/ufs/host/ufs-qcom.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 375fd24ba458..3b8bd9968235 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -508,9 +508,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
+	if (host->phy_powered_on) {
 		phy_power_off(phy);
-
+		host->phy_powered_on = false;
+	}
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
@@ -531,6 +532,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out_disable_phy;
 	}
+	host->phy_powered_on = true;
 
 	ret = phy_calibrate(phy);
 	if (ret) {
@@ -1268,6 +1270,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
 				return err;
 			}
+			host->phy_powered_on = false;
 		}
 		break;
 	case POST_CHANGE:
@@ -1277,6 +1280,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
 				return err;
 			}
+			host->phy_powered_on = true;
 
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
@@ -1467,6 +1471,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 
 	ufs_qcom_disable_lane_clks(host);
 	phy_power_off(host->generic_phy);
+	host->phy_powered_on = false;
 	phy_exit(host->generic_phy);
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 1111ab34da01..72ce0687fa42 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -282,6 +282,7 @@ struct ufs_qcom_host {
 	struct clk_bulk_data *clks;
 	u32 num_clks;
 	bool is_lane_clks_enabled;
+	bool phy_powered_on;
 
 	struct icc_path *icc_ddr;
 	struct icc_path *icc_cpu;
-- 
2.43.0


