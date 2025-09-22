Return-Path: <linux-can+bounces-4775-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F56B8EDD5
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 05:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3858B165643
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 03:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7561A9F9B;
	Mon, 22 Sep 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a2e1Cm5C"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B792F56;
	Mon, 22 Sep 2025 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511969; cv=fail; b=fM1vGR9JdViplUvNELyzi7LvZ0N1ubJeEKWcIIlL7ps76O0Ugeb2x5XLygIp1TTBaZrOokYSZUqNdS+GUVzRkHsd10WF+HOfzrJ44HbKeYGlq5XQz4aGG1gSb+ma2of+Bi4elT29enPo610XrYWs+argFddkbx4grPKojiZ4X40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511969; c=relaxed/simple;
	bh=8tEghCZryOuUEllQhkP1MiM8CnLwjzVFp0azbZGxmks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIH9uMmMPNwX3w2NLtOmjaDZVTRCZlz8wuCTrEUMsp1/5yCU8rT9w8kBvEK+WHLlUAtIK/6tReoR5rIGmmZASoP8rTavckkLTT93/kCOwEuBy7mBTBKZvDm+uOxz9TRinTt5eyNveSeYPILWbnSjVZjyptMDGomdb3c8t/yykUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a2e1Cm5C; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2IDeRuX1z0oq0bGsR4ZImKsbt4zcLOiZlKWeNFTc6Udso9wl783APSOnJCkkFpFiKi00pvQ1Jsrcy26cw39B+clGteJn1C99JBMAhgNWsWx1J4ev+Zu3zVbNrI6Yutdyx5ExHny2oPgWkNqkt+2JLQZwWZ61Ur9pxitGKfEmKnCkTCLIzeq2eXW2LmRS3sqLZ9srLYG/teynH33P5jx1gOM25UZqVCGdKEu5sqtM/g27xiYccS7DIYu4l/Di9F9f7Qd3JNZwUzeOxZzlcjQDXeERUTNdnzf2ExjP5MitcEuJ5AGo6TvfU6eldKew4fwoY/x5W6cH41NepYXBX4scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoUqNBgj20cYTvHRJfRy9wo5zl4KzL4m4rVR4/VOAgc=;
 b=jB3xN3u2s2ynGRzWTcmW7gMPKy04eAgtzuUFnRDrcN43064v+uxaehM8GvlajJGC5oNoKJVhhzJ96Qit4EHJ74VTJzCvLrgp08YBiwPlexbLbzAZwDN4T/h88TJwXWgAIfUnc4PCGhDKXO/6tyGHMh/wHOfK2EwEIKqpqb0L42iWQjxDGXl2E4mzKM7g+988W1qvrTmIHy2+5F6I6OTfyIrW7/LhudzNX1jDXhM5NJGQUx0yLJfi1b2oSPqcGIBZ1OL9ryFHLHI90h64ea0f2fFsTM173XzsuciiK2036OgTSk6uj/tbjyczDOljN/UXJ6GJ7JEKYC1Dzzt3dRoE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoUqNBgj20cYTvHRJfRy9wo5zl4KzL4m4rVR4/VOAgc=;
 b=a2e1Cm5CTx5IBpZUrTasLd6psXOYxuHyZbQngI7ev2RZyBN66W1CEb3HXn9K74AIH44AzDt62V4VHdS9sVCKBKQljPn0l/aWfJE2QF3CsWuiEgSXBTQo1oAPUR2d0C02pK10Rxdz1hHx7c0P+f/YqSpOkmSc241HsE3ZKgSVCfpDR0xSFT7T4tV7hUmyqNkM0gGdYM+fZ1n4ZqpzzYBqzuz1Q5coRkziHhdtObL1tk34TvsoZigIlssDOj8/e2jMB/pjJDQC/FKSmLCNYOAkfmsYDuEPOdJU81CbGXlqC46ZHPp+pKw822IqtswXntaXLq1eVtLJlNVq0QD2zoKR0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 03:32:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 03:32:43 +0000
Date: Mon, 22 Sep 2025 12:44:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/9] phy: phy-can-transceiver: Propagate return value
 of gpiod_set_value_cansleep
Message-ID: <20250922044425.GB14753@nxa18884-linux.ap.freescale.net>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
 <20250909-can-v6-5-1cc30715224c@nxp.com>
 <20250919-lovely-amethyst-bullmastiff-5cef8b-mkl@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-lovely-amethyst-bullmastiff-5cef8b-mkl@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 925ca0c5-2cdd-4186-b270-08ddf988b0f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+R+7AP/KKFPIlMa0rLYgi437WvJcwWiA70V05ieymLIT08Yj3RjUNtLPpbb?=
 =?us-ascii?Q?ih7inZdHuanWDYgUXZtzjMLmZBvbWgXU7cOzKYZOkFmOuYIgUDazPqdKL/Qn?=
 =?us-ascii?Q?NEW34xJuW4GQ3jIer1bPH8yf2391Y6fN/kniVkj5F2+5QKXGpSw3vqzHnVos?=
 =?us-ascii?Q?j2nhjcmDXF8UbrvkZsitSSAZt3Yb/WvaQUN4bK0UBcfQCA4FRQi7IfkvWAKV?=
 =?us-ascii?Q?S8jETGJewZxbIgaqzrchKplVjmAC+47rJiDv7EoQt6NV4ggxvhfVkKyIhU9X?=
 =?us-ascii?Q?b5oR5XoQ7nrQLTZ7VQOylswZxduA/UNS0vRbzkpbefZBiOpqexbnPCBRUQpi?=
 =?us-ascii?Q?tmJYIw6AisWyG4e45llFXCPzmhGyNrG71FBdxc9n7wz3U8SU9NHXSUSI5ju3?=
 =?us-ascii?Q?3HtFXUUHoiU3Bisgk93fFV12dJ4NtlhvOyXnBPheObhrylw6k6xjGylHel+k?=
 =?us-ascii?Q?4iVkFiQLEA8nOWSDxyOpapbWIpCaXJSNpjHPXPkleHNel0syDmXRvj5vI1kE?=
 =?us-ascii?Q?TkLgY5eshm+cRT4pYKebMGZSQ7EGjw+9PscoOAbttoGLdYJ21EPIcmQRW0jw?=
 =?us-ascii?Q?yUT8SRnpRAxWAOnET+0H7kSp7V8WoQ483PHaMdSvd7Lcy43WSzToSJ6IURiG?=
 =?us-ascii?Q?FcvrTbf4gHjzoZiu0rlkhCmjkr05wSsLGSLR8DlyhWmkhm317IYB3oDLO2uP?=
 =?us-ascii?Q?hwrqv0nTo0vdu9rPDXjcvivFYK8kWewYlrqUP1fh5MfIwNwGSS3NKCKVxtMw?=
 =?us-ascii?Q?535QMR+TtDJQjm5xLG6AXCkEs7/P5qHtOFazNeVTR6WQ2jX2elTG+ZFYG0dM?=
 =?us-ascii?Q?jtYhmTqRCqj6pyc3qvXJxdPBrnAiKrjISo4ZQuNw9fAvAmc26WcaRkCUL8Hx?=
 =?us-ascii?Q?3u4rjMbk/x2JS6TnHFZc6uxrBD1tNcM8751zhEWEDHOcMXW6oB1Sl3nrbXsP?=
 =?us-ascii?Q?Nga/avSUhooshDaGPCZqH5UGIFe4fN5obgMRGgs/v3emaw8iSx+5LzNqhgdP?=
 =?us-ascii?Q?WvrJRE9nP/cN/CeSNh3PclqFI7x1bCMM29ABWJdEYiP8YofJVco5Bac6Tjcd?=
 =?us-ascii?Q?WEUz7tbLEABQd7bTuXZzmj5K+3TEkTlobwIhuzD3CVKvRiKw/QetmwCHqbvp?=
 =?us-ascii?Q?i/GqVtOTaMcGa88ecyKdfq0tvDxINNkcYKjAZ/5nfh2Zl393bdRO0ZXipgET?=
 =?us-ascii?Q?xqnyrabZaLg6bQRrOI1tSKaSg1OY0F9Vs1wATfM8fv+tOttVVKf5/E6zbHjG?=
 =?us-ascii?Q?kPsETd8+X16TtAobSJAsgS9cypDh6NSIcxyEO+JWOr0VdaAUV1zuE1pDwFL8?=
 =?us-ascii?Q?CWc0L2Twus9AWBPVHSBtznfE7NRn1G8Xyh//wW4ZAvLylqPYzWEpHv1ucTXp?=
 =?us-ascii?Q?wDyuAEojTwOwfILx76ZBYohpM60frNAVyabZkiR6sszDBMg+0cZQ4+9OHmV5?=
 =?us-ascii?Q?1E4DEddMJ8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4m5QFPSUgdTLaMtiZs8aL0z48HusRfQwjw2NgFiA7ZAvMf1IzWLwkf6pol/p?=
 =?us-ascii?Q?mP9WaPfK8ff2dUsHoSGfygFWFJdIBhbg8Tmt7Q792JuGSWrVMqh+nqb+6P3w?=
 =?us-ascii?Q?Q60GIWrHih2VDXRx0D2ByyumKQZzfRpATB8ABfNPuOUogsH9wCrP5jAKVeoS?=
 =?us-ascii?Q?rUbo55PK/WEn7hzSryUaLj6wIyEGs7a+2nRWminGSo5ySebftaT0WZrEZd9h?=
 =?us-ascii?Q?aqYQgVyPdTguw21UN2R0gqbsNOtzD7YrZUNckKluagFIsapXERPtUq8UXSbD?=
 =?us-ascii?Q?k0xjY5gL3sDNxZurjAFOpFGFlnTGg5ai5reN44AbPrxVlIE42oy7IEiGBjbH?=
 =?us-ascii?Q?ZlZbkpKuNpUHk+v4CgHmVsh5DTtBUtLr+PHq269BTSA9774GRB+4Ls8rJjmp?=
 =?us-ascii?Q?eSFHmtY7gL/CjL8CSMp9OWOe6Fmu4YSjM5+TdL2IVqQUsF7MnU1MXm8M2c64?=
 =?us-ascii?Q?f/I8m/zhTHUbV09X3yoVuVFNLbawRXeBy5VHn5buqvI4FHZTlium7pwdlBmt?=
 =?us-ascii?Q?/mMBMeT888+HlKPYrCA7yZ/ofLL5II2MRME8pX1f3RKZ3eUQuF7k1h55KR1p?=
 =?us-ascii?Q?VuIGeDeYdRyiVXCWn4ygX3ftNVVcC02urVUO9XF7qjj9gfPYynOLnueUNwdw?=
 =?us-ascii?Q?N49QCq6rKYQdW6aKEUgQ581Bs7vDHaBGKWREcXudEMVWy8YdhiroRl+YGnOF?=
 =?us-ascii?Q?hjHEuo0WU6FjwIU2W6Jgb1mP+sQD7z3ftE8XjOGDETZpW+La823nTMrGjoIT?=
 =?us-ascii?Q?OoBNdq5TLszbVzEVCSzoV0MsIyWXvnidJyTNnJeGo+qol3fbw+YmCTiz8sXP?=
 =?us-ascii?Q?9VgP88e6jk/vmCmANhm93XlxtGuCk1PcY+GnQ2RCLyk2HGhAO3qTHQYXPmX7?=
 =?us-ascii?Q?2kzvmSC+xzbCuRSqP1W3e7qNxjBDay1jSNcqzG9No+CaJIdCkXHeSzK75ySQ?=
 =?us-ascii?Q?vifOC5vL1toDA5yUnaToLvpiwseX4510a+3e55O57/ka/bB128aEmajXPLHe?=
 =?us-ascii?Q?HEonWlpggGBiSu5txs/2XalwIg2NUe53F7WoHe0+bFO+CBCHeWrN9kaPa4Kq?=
 =?us-ascii?Q?OZ6/OnxYMkpPnCD/9YP+NAdeQGThcBqIHl24oZwLkpljZJ1Tafbhxl8j08gl?=
 =?us-ascii?Q?WyVtMrFfwLNcZttQgFfQZiIMweNsX7G/Ncg3/i/M94wnCPbSISZmwfriZFU6?=
 =?us-ascii?Q?+/a9qL+tQig2rSzM0z7U1ogcoE8CMuvEP+/U5r+415cFiS7a709/O0TNnB6O?=
 =?us-ascii?Q?tDlHkIiyg3cYXVezeZSl66HwjV6GI6gSrkC7OsdOAkckP65I+QW3hbirTL53?=
 =?us-ascii?Q?1Lu8oiMZXNnhpnIDy7AYCkUqbrRAM4JWlqnGy9lnzcMj1RtlP4SaMv2ocyC+?=
 =?us-ascii?Q?xsgVsWlKfYppQYX/zrWmej7USIZoNElutusiNzEwmDXt17hoedhA57XFvyfZ?=
 =?us-ascii?Q?q5fFBXFBzIV/3BAQfr47l7CaFc9EcpaUiQAzL8DiC5ICVlaXSGwmhPFyFme9?=
 =?us-ascii?Q?NohBlYoZ+PbzEiA30R6N7dXog8SyRn6h6dQ0ly2VRrLjDcDaTv8Fpv2cNI5G?=
 =?us-ascii?Q?sT81y1f9ky2xYNyld/DJ4IayYx8jPLvEyTCTBBcr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ca0c5-2cdd-4186-b270-08ddf988b0f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 03:32:43.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBqbPJwnsENkUDqMUb9jEx/wknvReOmsR2X8wVPkmFvJxafhQMbHu676Uxux+roL5QB6gQ7nRr5S8rKQcmKIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610

On Fri, Sep 19, 2025 at 09:18:21PM +0200, Marc Kleine-Budde wrote:
>On 09.09.2025 13:40:15, Peng Fan wrote:
>> gpiod_set_value_cansleep might return failure, propagate the return value
>> of gpiod_set_value_cansleep to parent.
>
>Are there any expectations of the phy framework from the driver if the
>switch on or off fails? Do you have to roll back any changes in case of
>an error?

The phy framework expects return value, so if on or off fails, the
phy framework will record and handle properly, but if one of GPIO settings
fail, the driver itself should handle it and need to roll back. I will update
in V7.

Thanks,
Peng

>
>Marc
>
>-- 
>Pengutronix e.K.                 | Marc Kleine-Budde          |
>Embedded Linux                   | https://www.pengutronix.de |
>Vertretung N??rnberg              | Phone: +49-5121-206917-129 |
>Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



