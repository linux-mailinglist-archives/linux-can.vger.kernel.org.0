Return-Path: <linux-can+bounces-7484-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BsdFIC3+WmBCgMAu9opvQ
	(envelope-from <linux-can+bounces-7484-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:25:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54494C9996
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB82300736B
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D131619C;
	Tue,  5 May 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mnTWXA9L"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A30DEB0;
	Tue,  5 May 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972931; cv=fail; b=vFPpjiEk3q/WKsQw7mK7abTt4bVJnavHQHlK+Ky1zxusDuXx55ffNWDFcA+05udMbxVan+JwNMja/hW+DSqfMwJiOOxE21O0SRMxFDGyUCvRtpm0FORtkRKr0dUvzOHMrCFBoQ22T4nskVLLhmXEyUdXWEnEQNqa7WIKDNTFcWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972931; c=relaxed/simple;
	bh=hH1yE8DZwGwBi6eQ2Xn3ujolErpQYXwaSAZDiR8vrPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1xC3mpPzFFBx2PRdmHE1fum443BWlbQiJ20wV5i+O+jhJefbhlpjmFPpwi/xpA4kfzGWL5XYB7drFGLn/2C4unITv4B4n0KdaaTML6KHm+UXffhonGsP+A7mYD5uJ3MTbtkVn0C6QqUf4+qlwDJSvicIa93HGBZrnCqbZtBPMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mnTWXA9L; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNYy90jIz+IjiLm3778JiulrMT7g2BTW3XeNk9hXLyswF2ozb/3CThQYtPFWlTvv3q7IZMy0GBEjsgXeCFc7PcrZDjZRgIF5YuUCgtt3XAWbH71KxV6ERgSr6HTJ1AU+i5d7XjYeuoWWFeG7QuYD4/jEK2wnqf4B5L1AShMSn6WgkcmX+3uYJubs6vgeJbufFh9gv6BN2ws2L7A8qCJmGRY1iaGpb1uHbQKXgbt2UZNVmnXJ3Fq2BFCKE/CmmAy/yduLwRWhsDVka4879rytzQ0OrcbF1PACpxyRJOjYSRaKnuUkK77VL7ckgAoSyyw8QC+GlNW9p0mkkhX8YsUb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adSFsqmRU0YXfMsxWdZhHsT/FRdueoVjsVKvkNevx2Q=;
 b=SLPSy9WCes2VTfX9iz1U8axFiOFI5Ojl2jl7ZhHr8ARt7JvuVz51Q3bDZQ/QsqblPFeBvryQ/vNqO0HOY2+q4d6CySuE5qoZrNhnFBUHmfcdzHrU6mY2V74yqK+TXERFqAPAEFC5dW+iDGBurLfVC7EuH2h07t3g+p8AqKTcKl4ThruBhy+akuCkHmVjeyS8UyrQ+kECK9c49MZn2w8CicnnBhRk8kzXpWtI2u8in69SqDpt6ZpWjT0Kpk8Uhov190OVLwSh8Baqn/ebTujbuZZVeSC0bem9gV5BW/SCW+GJckZG2TLhclXp7/Ikw+teWrjBHc1dQSRxqM8SuTZeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adSFsqmRU0YXfMsxWdZhHsT/FRdueoVjsVKvkNevx2Q=;
 b=mnTWXA9LcQZjzIGehKqk45UJjywDuujxR0XQxOXIEBzS72qdel6H3vLbm8X78dIb9wwrIgDrgN0J5Pa5D6tMNkYxPUDjZGThmL/OX4taUQQspBD7y5e6nmyxr1nWuSo4Vxk6edzusHbdw7UXy+1EYoOyvsh0MH7X/erkpig379TgdPJL8Skavv0DBjowTKshnxfSYT82Pj+3EYDZXH/90EDr8saZwx+n1qyqXmkmQtiZgM16xElXCtrZ4NRaYTKagTGIlIkeLygHm8H0r/4vYTr5dwn/+cByCg7keDiKlM+zKuEH5ZRTWJwZjKwFujsfZFn51M1eq9HtWpoLhiAv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:22:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:22:05 +0000
Date: Tue, 5 May 2026 12:22:01 +0300
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 phy-next 25/27] phy: include PHY provider header (2/2)
Message-ID: <20260505092201.uiam3gl3cctjxurw@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-26-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-26-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI4PEPF000001C2.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::84a) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a120f35-d71a-4c8d-bff9-08deaa87c5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	o2FAFTsAHqTdGt59CoTsK/LCG6nzt2eqZQFMrNr/FoF2wroQrIXlN6M1xlCVlXsnr5noD1PtXGjBSnjMvOFbYc+AScoL6cs0/pdyw0H7nMoy1TyIzyO6L8xm744ErKJX8K+Q8aHsBEAWyeLsayXMwOr5svdh87+Blf4sdQ9WCRwoTlUEUviNYWbbVG2mRh/4Jjfx/ojRcT4DO7pYMPx+G/pCpNntR22Np012PNrc51YkyrpurJb/EpyuKeLIuQ4f40a3kYdtia3IuZeOGvwkeeBOH+Y7ZIcXopyQyd7kEhxgtWOfGipH8MVS22BTBmcLK7weiwPQPWqq+HzcfVehxr4+RxX1ZToOsDpDdqTgiUgtFZpDRUoh+64fbRUjNG2BlpZwE4it0fmPK+f8ird6t7nMCIuAwUTh51MqRP/+JJjsm1LwGUn8GkiL85oJi9CkGB6FxGSA8eN8XF9CtthENOsHFAk29mNQGZL3unNUPZnjSAumA23ZwyRQe9pplI/2gLa4wedr53F309dcqAa/B0W0bmYC06pnhW87dcYVsEi64VJNuMFr3E6mGzXs3DxUKqcp4KnX4mKXzqKMZHPTsFn6mmeOoW6Q81gbeDbqV8eDh6K224wgPzn6o8/kaHfJhVQKJA12N/JSeyOvTq8s6RcRcePcsOEfAIdhIWELXP7rL/kjleG5fdwkzP7hm29s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pcpoB6dLjaza/+Oaov/XkrRse6mBL4mGQFTLUv4znWtlzKWLMtpbOiGCAt3a?=
 =?us-ascii?Q?lAPbpq/6FLbrJEzmaXIo7eAhc3OvI0H1U1jzawkBRmT625Kz2Q4gPcuhR1kJ?=
 =?us-ascii?Q?v0ZWHCZ9PxhJEXdBhsFN9/3D8lHd/w19dAQx/vZuhFil5a++xIweoM7zyqTM?=
 =?us-ascii?Q?GeiH8dlI+tq6aTwxsWEanJ8ODZqYH0kG5sjuCq4xS0YKFYmV4inPV5ljR9PQ?=
 =?us-ascii?Q?bEqVxlteImmQHP1pFThtCO5kFeDqDTVZoXK9XdsHjXzwAUW8BdOq/RX2DsNA?=
 =?us-ascii?Q?FPv3Rp5TwB6mA6pJb6/vK9wyGOK5tHBElTjgg3IBbNwGQvIJ29VwJXgra+SA?=
 =?us-ascii?Q?fzsadr0qoS/QRFU01fWZhPYGLUrxVViQZytpaTFA1HKo4dAshYaKMisNHlZD?=
 =?us-ascii?Q?J5TyfKYfNpBScwYtd15DndenGuM6eu901AeGfyRvCAX3lrvZQjwFimuSUeVo?=
 =?us-ascii?Q?i96PMZ+7rEU2VOglDvtRgFaMMf+dX8WDaZlMV3GchKF++tsLkmCptwhYTwIp?=
 =?us-ascii?Q?d+49DbNgT9OStzFsH7IY5DZx7kgNpnK5MTcaOZKnLkptYt9zwqFLa0XY9Sub?=
 =?us-ascii?Q?aMUr4IDFGOsOquM4W35sf/EddlYwIEPRQdajD+xZX0GGYI9+2JeiqdYfNL3l?=
 =?us-ascii?Q?/vFpMlKqghptYJDcMzENy28xC0wydKNY/+Oeyi3FRLJx5/TGPErgW67qXot2?=
 =?us-ascii?Q?O7A4HYeCsPnkrUvoNgGYh2agydzG1WHm74s/5GJWREzONYg2WRDCDm/KQBXq?=
 =?us-ascii?Q?9YoOP9pqmFDGrEAC3ibkWuyGsv/ir5sw+pb6jHP6P2Gh41chnhQLZlty6Lxv?=
 =?us-ascii?Q?0nVMPU6DXthZ6X9fQRQCoIOoRs0uol48HziLZiJRwUJNS5siiqvRzZXq3d/p?=
 =?us-ascii?Q?4sONI7fiza9tkMe1dT3ZCqQGkAtyXPbA337b2T7/1E5zRM1UmIUblDDOTObb?=
 =?us-ascii?Q?F1mKM4ORQs2fm+yTVLegPZisuLVj/kArnvRFtZzxkpcRUWF2F1JO+7Wsfq7u?=
 =?us-ascii?Q?aerlkoUS/1DPrpr0xE5CEWRIE9wb2lyDxzPdtm8So8T7RNGCDMqyWZ04aZW9?=
 =?us-ascii?Q?fEA3bRd5KPxFp9Z0AWKzZcgHwLFc1SpJTrZuoNxCmBXTVbniETpUw3kW1PkY?=
 =?us-ascii?Q?7Q+tLDwv5V3JPdCr8d6dHHYbj6Kqd/HWeQU8dKiQiOkORDsaTfhzRzm2qWOs?=
 =?us-ascii?Q?InzBZdrt45MRcdm7UZD2fStcKoG/qI7GPh0Jq3u5M7BNdqgzthuNeLtg7xWs?=
 =?us-ascii?Q?Yp/AH8XSlMuA+lLO7dC3TmLPTySehQL4iT4wED+R3KL6hoDNCW1IUHpSFfdN?=
 =?us-ascii?Q?vS47qvHwdk72qaMJE0iVXn/rucN63WWvG8W1R3TOiUp5JE00FA0nVsE5FHtj?=
 =?us-ascii?Q?5+U03MR35UPuuNdrtVwRfQLuyZHWOTU2lcJA/GRNkVmk1An9oAs4fZ6uBsRg?=
 =?us-ascii?Q?5U+TDzWyGNu92lccgQ8/NxfJ2na6D13OhYps1Gf4Doh/37yqfJWgAectUMzh?=
 =?us-ascii?Q?nTpJ7vlT3BJ1FZDeP19Rh8j0wvAjGu85oxm5JdCBxmapprKW34T8eK6mTxtn?=
 =?us-ascii?Q?1l/K82nyBOXucEiNeNp0nSjtpScwLWdFedbSYbi2h3nqLEKHtcpC5u4yM4Fn?=
 =?us-ascii?Q?wjSRdsvQch1ZBS70kqZGYzJVKbWL/DbjxoDud1jHHjWqksNyjPyJcGWsNHsj?=
 =?us-ascii?Q?mXE7tzWj/XqgYeq6PRG7LrKWT4TmW5ozxYrbqnnzTjFZUwlG8xlr6Gff8ska?=
 =?us-ascii?Q?NYVMmBxfWOtarzpHBWMlHI5rl2ZAO0VmJ5ZyYf83tNZtm2AouLtY0ooT2ubS?=
X-MS-Exchange-AntiSpam-MessageData-1: 1BD7u0up7TLG826gdkM27r3Hh/ToL0vN1Y0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a120f35-d71a-4c8d-bff9-08deaa87c5a7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:22:05.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gR8P92jB15MLKuY1p1B0+QHZfA0WmQkyCX9PMwl/VH/UTxXgP+nMveRrd7lmJUcBLPfK3r9U5xK//w74bVI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9517
X-Rspamd-Queue-Id: A54494C9996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7484-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

Sashiko says:
> commit 4194b60e90a65a3b71a94359af9d2b530bae01d8
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> phy: include PHY provider header (2/2)
> 
> This commit replaces the inclusion of the generic linux/phy/phy.h header
> with the internal PHY provider header across numerous PHY drivers. It targets
> drivers that act as PHY providers or chained provider/consumers to ensure they
> include the appropriate provider API definitions.
> [ ... ]
> 
> > diff --git a/include/linux/phy/ulpi_phy.h b/include/linux/phy/ulpi_phy.h
> > index 7054b440347ce..0f9e8430d398e 100644
> > --- a/include/linux/phy/ulpi_phy.h
> > +++ b/include/linux/phy/ulpi_phy.h
> > @@ -1,5 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -#include <linux/phy/phy.h>
> > +#include "../../drivers/phy/phy-provider.h"
> 
> Since this header is located in include/linux/phy/, won't navigating up two
> levels resolve to the include/ directory? That would make the compiler search
> for include/drivers/phy/phy-provider.h, which does not exist, and could cause
> build failures.

The LLM review is right that the relative include path is wrong.

> Also, does including a private subsystem header from a public API header in
> include/linux/ cause issues for out-of-tree builds? This exposes private
> structures and could cause regressions for external modules that include
> <linux/phy/ulpi_phy.h> since they won't have access to the kernel's drivers/
> directory.
> 
> If the provider API is needed here, would it be better to move the functions
> that depend on it out of the public header into a .c file?

I have moved the file from include/linux/phy/ulpi_phy.h to drivers/phy/ulpi_phy.h
for v8, and updated the relative include path to just "phy-provider.h".
Frankly, it is an oversight that ulpi_phy.h was still left in the public
<linux/phy/> directory.

> >  /**
> >   * Helper that registers PHY for a ULPI device and adds a lookup for binding it

