Return-Path: <linux-can+bounces-7179-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJYINKF6vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7179-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:37:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C862D3471
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E421B3047F89
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF441B37C;
	Thu, 19 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hR277gjE"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154D411606;
	Thu, 19 Mar 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959610; cv=fail; b=ttNkFZPz0zdlawZZt3jHjqhR6911l6cINF/b8JzaX7UpGgTJkN+eSI1XkVKUgdMRK9u/LQYr0zbKPxhQrn53jCsMSrwA5Ou8noNX9VLeF4uTLeNUB1Hb7V4H3mZ5sr9C0h03H/fnMGxMCvxwy3vdJoGNowoMrJO8M3RF88m2Hao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959610; c=relaxed/simple;
	bh=8sO5Ro2INaALqyOtMVBulgTNKrGjr51kWkuQbicRJoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFAwtrcXQodxqX1f7TtCW30z70Ham3w+07J61PP1uI19OkFWMSCMMKdO7HzS3DTGd/B8zfhG7LIKKev06goGT64UdTRgpyXUWBW2DJxR2SwfVvWHRN53U4sW3//J+cAIPu2Pe1cHt+fHaplinPi8SBk/Bb1+nrSgWSjlvRqhjpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hR277gjE; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5xVMHk8+qEnQzYgA0WcVS/+HC5YRoYnnYYIAHNn2zA5wHChUep2f18egJ3Ome/PIugFbxK6GeF0qhY2KIeSHa30zgjyus9n0KuALiflbib3NMEanNBdNaenAJ+qEC3PYT+MKoW0nETxWJMDfivHpj2Ej0RQtpexTqV2I1u5k3UNILwE2OUilx1sk4avQDB/b44Yi5lLXC7GZc3jUhevkD3VXUIjtnhW7CxW8/hjFJt2FnNV7tardyksqYFKzdAPOl/w67Qk+cdwAvOJidJ3eCPwJeVjpR+vM6GgBBU84XzB560NIlKmgSej0SpW16dBcvJvjglE17KpROLSi+TrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6/W9u1nF+rccnysPC1E5DHQTyz3pz09E7LpVScZQz0=;
 b=iLAHLiesGupDybzCjoQbK1iY9i4SlE+6w2VooMWZ9jtITU0VPUp/E3MLZd5Nm0tMkU1e6kwgfNMQJ/D5eWLb7vX6lROHu5VWKK/lPy9Bte8zcOXBVP4un5nqAZbulmW98O108IZKQU+oG2qVK7wnoE6MpORgfCnF7iYObYM0uYmdugEsfyhvhI1dVW+qi7GsreCscAfvZ9GdN+T0DAI45Vq7mq1KlF2QflK+2ZCxWMyqg+5OmuO5DQYy01KruxcqMopWKdcqoaxcRcgDhNFwoy6EOjdHM0cBBIeZlzfrKowTI04P38cSxpPi5NSmkAfmj+QCOMEZFZZiR5T3Cgro/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6/W9u1nF+rccnysPC1E5DHQTyz3pz09E7LpVScZQz0=;
 b=hR277gjEo4TqJ8E3i8u/yqkC61lU75G1r5jqB9gqueU2Z8NzSb2cg4HQ9OOS6Wmd//RK1XNhZHiLx9/OgDma3gT+2pMkk+pu6TOM0PbWQLX3eB/2KIEnRVON2DYNZ5c3eCu6ycxoFNPN9pK2TLs3GW+VCDidD1DuSfwEHWtJDTasd25ra27ej/z/LZcVYAwNzdhoemLg1HeFz9dJFQ79csz7etRoQOfj1epslNs4AQQnsCQWxL1y74ixmuaMhsy3kjV78bdDNfPb1xwnhTfx+sbUu7Bfao5arPifAPBVm8lb9k06TZXLcdrxZ2v70C8qfRsEscctq4Hbd4vWUGXMmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:57 +0000
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
	Bart Van Assche <bvanassche@acm.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into struct phy guts
Date: Fri, 20 Mar 2026 00:32:23 +0200
Message-ID: <20260319223241.1351137-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d21f4f5-2017-49fa-3dc8-08de8607785e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 xz7Xhr4ezrDKjGt7N60btnUqJJViOdnnfrpHhFs6hIDESmb1yrj098HOopa6leagBaDykfQt6L2rDqRKxbLOH9+vfvUJE4z73chXsccUZDr1Yet3+HoqcAlOjqKPd3FOCPxWtu6ne2L+mSY8Mb+T57QhfTVZqnyOL3wVfRW50ZuZqoMVcBUcqcPwwH7VKpQE0F5Yf7RMDAKkjaRRV1nyglsuya5vMifGjIZsHoGvVT3Q+FeoUAl82GqMDKrPOEXHetoc/esIcmR7C4L+EYgaeS7soFlapFI7Yf/xC9GUAGIf5tNRKDrnnNFeXIq6zoXQUEs8253850o2xbh1qyiaUeDIZaYpEm9UJLdFb0qq/pkNOboN/m5y5iZ/McYKvGStr2wHhymDnblbjGfSN3nhwvSiPC3FSQTvn8UccvWO1puGTlGkna3s9cOfjRY3ORjFdpdiOOeX1PWh6syNzMvU4jloyf+dCSp9ko7CqlDu1t8BJDULLiICMYgqDbFM2R8SJc5L7kcIqeb/V4wUmxgOGXnCPySMawFKeACtGqVP3fUYtWKQIRfnVa8sdnlBMLiDOFcbcprMx+gI7MogE1y8Q6abPb0P8tpas9iDC0shhNgVXG7SI8wUzCqzGT1E/dqcZtGd7pEIgMOlL942l/l8B8oUslWcpPVkatj6060pyIgDu+tI/Q8tUZLPF8RcgA6QdJW3X5nOzgkTxFBTdkghcI9tTE8gYzfyB8ipCdu8En8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ugqNKYV+9LzhJybgtqYfnpFhdAE+XH4jHz5Xdll3bLOoqIBbmeP41reGeB5n?=
 =?us-ascii?Q?28DcwTEsz7Ka/lGVKmVxnfHxOH69/KLjr3OG2mW1mBVWn+sbuJ+khxEXk1lI?=
 =?us-ascii?Q?2Zx/div0oZSMcjKR5WHUqkZDBl7jJfSvKl/9CDeGFt97TmZdSnvnYybnkMgT?=
 =?us-ascii?Q?xHsVw+2yxDd2N1PKmafyzOUnpHlLNePbyFxXGsjCJQWsQjHm2Qjdw32LB6RM?=
 =?us-ascii?Q?O6AsZveL8/ImOaor6zrGAHzKmAwJNXzqWfp2Irfe4R5UO1+Y2SWw3DhlXg1e?=
 =?us-ascii?Q?Hwpb+7ahG+oAoPds/GXRFkMjAGoo6pkfRMJz0nTcIMgbu4IZNTg0h1T5zfoF?=
 =?us-ascii?Q?ovrDVddqvVvz3g/LTF8UNM6Hs6Ha0BRtWVDQxMA3asdx+azOOhHm/kZPGl7v?=
 =?us-ascii?Q?PfWhM/KfkuVb7Z+ndgHynIk7NyR3bGuJrkoQ3Bb+dc6gR63IRdRkkeboF6e0?=
 =?us-ascii?Q?0jyIG/RldiUCDjz6U9HsYjqvKIIAg4Z0mtWS8/1CmWO/LIGCZE90Im2PaIQT?=
 =?us-ascii?Q?ox7MNiFaDGm1lHNAtPB4l+GqDHoYLDKcCgxN2q15gJuQqocOS+icF3tfBM5E?=
 =?us-ascii?Q?kNELoEjw8a4iSBAFN4qX26scQFfA0hJ++lUX3gZ2T9cnLF19y/Xz/OZjuFRn?=
 =?us-ascii?Q?QbE/szJigRqlWVBgc8XiVeUVVMNdMokwTy4cbyFZ9qzMisK0YSSJPU9/fcsC?=
 =?us-ascii?Q?9b/1MmiHFRV57Qvtw4Ml2ddpjpEODbR36W4Bzei+qbfQZEjIAIegXV+z++i6?=
 =?us-ascii?Q?I8f8KODa27dbLKBlHzO7KmI5X/54lcOOnXY+w5phgF/AWlp49ZtgeTrGhfTO?=
 =?us-ascii?Q?xS8dUStvZfnppMUNDE6pgb54vHY6JZrIu666C09PZeaMTLQ6faquThT/jXrr?=
 =?us-ascii?Q?3zFJr0EScnAu4horuy7dyMzzuFNrSV1h6PzWqN/aLTk2dah8dZN/BusXuGnd?=
 =?us-ascii?Q?4SiXxUaKxaebqow58PIZrCSlZCy2Mh5j/jgjKCV9husEnnbtVjHfnuwvvuVi?=
 =?us-ascii?Q?NSvqb6/3AXAzXdqndOOwKzd2tmDMeLe4tV9lURWIQgogKYwe0YqbOT8jOhFs?=
 =?us-ascii?Q?XLOF5Dn0ExJx//yNk7Bw6KjyIGwuChE6VnA+fwGPtvPk1Rt+tXHwkflsbqJ2?=
 =?us-ascii?Q?X4nHCl0DCSx/56ByAegSj+Ni2rH02Xjd81w4WF/gfM2fbLPD52U6Y+c5tffI?=
 =?us-ascii?Q?vaXucsiv/AIXzD8rezDcPnBmyr8U2e6Za1MIRLDJTKnDj91KHaSxJkIYdObO?=
 =?us-ascii?Q?/kOh7NMPIJ5iYlPJBNFizyIb4MXsTwzfaHCArc738vcuofqKznaznv6BPazM?=
 =?us-ascii?Q?hAcML4FjtmeDLdeucyJkp+efsAoW094RS0ZFbrO1NDGYW1NDiJArYDqMr24u?=
 =?us-ascii?Q?D80DUttWPWutbtm4szjEk1QXR700WgG7n01aIcRKqVbC9u0oIut+FGAhW0vl?=
 =?us-ascii?Q?oimDgTsBHD9bk/AViryqrl5FTs8fUylJnFPkHMMwXvyTNSzjYmBuEBb9Y4Ne?=
 =?us-ascii?Q?tfjwD9EveFaxZkWD7vQPF9pvtxv7iSW7g0IcwVbLI5uu9XCzIkgN13t4r9FD?=
 =?us-ascii?Q?dDSm0/5Z1SLg0ZDwdk7XAuGpqWFoLNh4NQmgjFrOlz9/nYGRHXHttDENNVk/?=
 =?us-ascii?Q?1XLaw4Yku2C1890fESG5lBjmcXoAZHKKhkM21pvApY58VCKDTDDOFN/Q5tBd?=
 =?us-ascii?Q?aanC29yxQOXKCreyzsQjfXvRZfix+PhXgaa6mU2SAfTmBIc0GVL5VjZrm9xN?=
 =?us-ascii?Q?7XndxaVlBhqxvFTOjqcvWdhGId4v0UTmMtAWv4jazft44S2qT2usPwEo+qD7?=
X-MS-Exchange-AntiSpam-MessageData-1: u9Zm8LXOV/IPMST3Lzp1VjDwknPsgEmOc74=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d21f4f5-2017-49fa-3dc8-08de8607785e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:57.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWlIILX84skLF32xEGWKMe88VScoqSRjTgvaOh7pdzBKR8pvGAxT8t85APvZ+gVH6Ju9tQXJXyug3KHJC0Z++g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
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
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7179-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hansenpartnership.com:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:email,samsung.com:email,oracle.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: B7C862D3471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Exynos host controller driver is clearly a PHY consumer (gets the
ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
to get the generic_phy->power_count.

The UFS core (specifically ufshcd_link_startup()) may call the variant
operation exynos_ufs_pre_link() -> exynos_ufs_phy_init() multiple times
if the link startup fails and needs to be retried.

However ufs-exynos shouldn't be doing what it's doing, i.e. looking at
the generic_phy->power_count, because in the general sense of the API, a
single Generic PHY may have multiple consumers. If ufs-exynos looks at
generic_phy->power_count, there's no guarantee that this ufs-exynos
instance is the one who previously bumped that power count. So it may be
powering down the PHY on behalf of another consumer.

The correct way in which this should be handled is ufs-exynos should
*remember* whether it has initialized and powered up the PHY before, and
power it down during link retries. Not rely on the power_count (which,
btw, on the writer side is modified under &phy->mutex, but on the reader
side is accessed unlocked). This is a discouraged pattern even if here
it doesn't cause functional problems.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanho Park <chanho61.park@samsung.com>

v4->v5: collect tag, add "scsi: " prefix to commit title
v3->v4: none
v2->v3:
- add Cc Chanho Park, author of commit 3d73b200f989 ("scsi: ufs:
  ufs-exynos: Change ufs phy control sequence")
v1->v2:
- add better ufs->phy_powered_on handling in exynos_ufs_exit(),
  exynos_ufs_suspend() and exynos_ufs_resume() which ensures we won't
  enter a phy->power_count underrun condition
---
 drivers/ufs/host/ufs-exynos.c | 24 ++++++++++++++++++++----
 drivers/ufs/host/ufs-exynos.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 76fee3a79c77..274e53833571 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -963,9 +963,10 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
 
-	if (generic_phy->power_count) {
+	if (ufs->phy_powered_on) {
 		phy_power_off(generic_phy);
 		phy_exit(generic_phy);
+		ufs->phy_powered_on = false;
 	}
 
 	ret = phy_init(generic_phy);
@@ -979,6 +980,8 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	if (ret)
 		goto out_exit_phy;
 
+	ufs->phy_powered_on = true;
+
 	return 0;
 
 out_exit_phy:
@@ -1527,6 +1530,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
+	if (!ufs->phy_powered_on)
+		return;
+
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
 }
@@ -1728,8 +1734,10 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (ufs->drv_data->suspend)
 		ufs->drv_data->suspend(ufs);
 
-	if (!ufshcd_is_link_active(hba))
+	if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
 		phy_power_off(ufs->phy);
+		ufs->phy_powered_on = false;
+	}
 
 	return 0;
 }
@@ -1737,9 +1745,17 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
+	int err;
 
-	if (!ufshcd_is_link_active(hba))
-		phy_power_on(ufs->phy);
+	if (!ufshcd_is_link_active(hba) && !ufs->phy_powered_on) {
+		err = phy_power_on(ufs->phy);
+		if (err) {
+			dev_err(hba->dev, "Failed to power on PHY: %pe\n",
+				ERR_PTR(err));
+		} else {
+			ufs->phy_powered_on = true;
+		}
+	}
 
 	exynos_ufs_config_smu(ufs);
 	exynos_ufs_fmp_resume(hba);
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index abe7e472759e..683b9150e2ba 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -227,6 +227,7 @@ struct exynos_ufs {
 	int avail_ln_rx;
 	int avail_ln_tx;
 	int rx_sel_idx;
+	bool phy_powered_on;
 	struct ufs_pa_layer_attr dev_req_params;
 	struct ufs_phy_time_cfg t_cfg;
 	ktime_t entry_hibern8_t;
-- 
2.43.0


