Return-Path: <linux-can+bounces-7018-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM8HNJJtrWme2wEAu9opvQ
	(envelope-from <linux-can+bounces-7018-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 13:37:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 532B023035B
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 13:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450A9300B985
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180F36E485;
	Sun,  8 Mar 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fD9T2cQo"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAF2E9730;
	Sun,  8 Mar 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973455; cv=fail; b=mdUmfX8Uxc8g1vPla/u1Ic8onDiJmz2D2s1mYgqfVtX8/tNcQIiey0srQjshmRFHCIJcOkmPUt3H+dcUH1YW/FU3swHDrcZKZbeNqPVzHxQKDyX9PqEqPompWXeOffhnpZf11Tu4fs05ViA3wAGZlpyiaoG3RrmG879luKgIqlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973455; c=relaxed/simple;
	bh=S9YMp878aBCxiHkiqmUPs6I0gaNdE2IaFZZwBPHJE6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYWmHCH1uT9o7L98zsKPrDM007tjP268cU7TQW+A+b82wqNuCXuTLt8vbKifkrmLlPHVGxPjqVro3T/3Ri37z7z2oKhadqwqfrbIsEs57hDKRKZ16P8lVE1hz2Li47Jw1dei58lIm7ArmA5wPS+yeJu5fVIOX5p1PLmJOtLnTdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fD9T2cQo; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvVVBLJoP81LrXPJgepDsymjnY+I2PulvCkf3aDBQa2TfWaMY0q+jYyjItaASK3aY+KTiI3eAfQ1rbj8ZLtSbtf6TRoqgxBhYGaf5rEnU3M4CkUH0wBKKDwazySOcxu9j79bPg4BYVnhXg92vEAEFn1uByKOVUkl6uiTVUXo1hM6Heu/SerQ7wLXl1zHgNTT7AG4wh9HwOYRh4eI0BrYiPhdB/Ld4IDAVqPj+Xkefste72cqqX43bs0mhdAf4kNDnQsnZfecUOZ3PUwNSvrk0vPtwMFrXVQ4l4po61LxazporM+rC4Kob12o4/DoHrvZAAaJ8X2/D9B3YSF3osK5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgVThgK7zA7GD+lZsA+jjr3lM7CdjEMsU2JGSDbnqdY=;
 b=dWXBFGrhQEIhsx/LbSCJdwInejZ92TLu8S495d4J3vHpnPap4y45dCdZawR+be6pPK7RqVJ8G95jx9pF9EMUXd3dbbMoNupLxmZ+fzj5tGO99sEXXQDnLEm9QIyOdR2csYUhdL6X0PKTqe0HvAMc4Stlw/1vzlItyQyv13ivoEUw0d6LYWTd7NsG3sLkX/dTzmV3UCMkLsvDS8f5UUk9td98XD11zpHs3o/kPYtB34Xbdh1rn9g021uIgndC1jwmbJ/karfW1S9JKC4gBNIwpduEzUeJQIvO5/a1UUrEk0JSe4v3WPwi36VDshwD+jzVss79Y0qhFrZHQR3mnP2k3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgVThgK7zA7GD+lZsA+jjr3lM7CdjEMsU2JGSDbnqdY=;
 b=fD9T2cQoHOaOyx/wawzpzX87ozoz9HBRcMkvZsQfw/G5PpLBrbwShmM6lx9ATbvAxT4KilgOQPskyrJcE0sBNHNakmY5T3aK+M4mSjEhehI77dhWkGH77Zyqd0SIJk9hmwRhokAmIc5AtYdEiVnW8SD/Ln4tY4sLG4GCtePa+bd/jLqemwnrMmBvNYmI1CNrVXlu+l/uHijgDmZAQYa8X93t3WWITxYUnB1VoikshwdFSwRK4hWTFk37xwjn3skmH+opufz0X7cv2+sbYLIdaISfgvMhMiWJBV9o3yliWzmDEXoNrVgIo2G+9fiBhneHLFdUTyO/E1GwdnEh6N4BsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Sun, 8 Mar
 2026 12:37:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Sun, 8 Mar 2026
 12:37:30 +0000
Date: Sun, 8 Mar 2026 14:37:25 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 phy-next 22/24] phy: include PHY provider header (2/2)
Message-ID: <20260308123725.qpfgbtpqihwpw2sd@skbuf>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
 <20260308114009.2546587-23-vladimir.oltean@nxp.com>
 <aa1lIBO3j_apIPjb@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1lIBO3j_apIPjb@shell.armlinux.org.uk>
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: d79d16ab-f0f8-4848-f03c-08de7d0f7677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	amhzRjQ31WobgVrckKKXnIO6apkT1G3m55bsuz1BTJNt9S5IrF9CD6IHiBCKNT7/qahFAx4wJPR6/TAPhL0P9SM/E1nqN+VnBlL5jdsRAhYhzAWc6iRh7V4A4VogmuBQEpKZ2D4KOj2xmD4Avqb0J3Sn66svZ85HFK7kCroiCbnXShcfUOw3je/qWF7Eu4cZ1qriNc8FFsZMqf7rjcbTfqcjExbHFliTMVsi58cAlBW+A2pgWfxwvb7zOk7nW5OpcA6y8aeXMjZ9s6V6yWQ6f0gyXO0v0rKLZbLOOeoDazZFUhKdB21/z9Wg2OSUs8UXJuzfUw0jNkftRxETpWdH0CLlY3bHa2suHVJWtih2XZV94La6BB7+lk7iPM+Jl51cpgRfwLlltWMsIqS/pehy7f94+/YCF8UUZPkM1/ee8N9gULQrQoN6JrSDO25awzHn6AA+x6Eh1Dlc8Y77wEfVXCRppDl8Z1p4vK9G7AGE4pDefnmSonJiJVMGzReuyDq/v0zsbZ3OcyP/JX1BTea1RyFGPRw5/O4pINksxAfGmOxPryrtZdS1KwNKzT25pIrkBfQHlmLBs7suu9+0ZTju09hsmW8i82u6AavK5z+E8OxU4w2kacQyCy3IGMLYgO//IB8+zixiZeh6cHC4FmGaVQABxMN+d6WZGZeWNlZBzjXl0s/tJIO2ghbHaLMTvX9W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONVmVQxiI21aLJ5WtTGKPOPDec7BRFxAM0uhokI5zM4Tqcm6QdQU+9maAdV9?=
 =?us-ascii?Q?mjkzbn0XBGZtynHo6F+DEG3z59vbFo7QrS2Lvrcfwhd9/c0OketO8sMeDabs?=
 =?us-ascii?Q?TdpFpxwpIsrRV7IDQTHkQ1GX7EcR4jc2Cs2TgDqTIAy+iwQpv5YNNy2PybPw?=
 =?us-ascii?Q?gG85esNKQ8+qSAdiCTb8JMgQLHvDYd+nlVNv+Xh5rgeKsOYgQSsxsFMtaFzi?=
 =?us-ascii?Q?cR84ADDVIwgpSwejexJF8VVpjyq18H60OYNIm4CWEN6+jBmTwDJ8G0kR3Cpp?=
 =?us-ascii?Q?jTWXnr/dto2hGu7B39VvsqSyoj95P+Fu+Srzisz03fKmLTHVl2rA6zJ66VBM?=
 =?us-ascii?Q?KnKus7zxDEnJh4cqLClO14B5vARx4BKFdRLpUg6/gwcSUEsmMUhINdwRLy3e?=
 =?us-ascii?Q?NaZLz53gMN28Mz7R2NoF8bsNEgTjnFsLXBSNbqEx0GigoLdf7TkJzKQwYvtu?=
 =?us-ascii?Q?vuE7Tb3fCIZopfjDMZSrIfonPg2caMGtLMm5rbL16jAUIbOuMgAz2yuScnRc?=
 =?us-ascii?Q?gks/hcGKw0FuId1Z3HhWD7DodfJ+YZbCDlz9MLzwKpLAdarMkw2fJkDk+Xen?=
 =?us-ascii?Q?MbYlAV9Erz9Em8QEwipVBEdMwzpi9CHbw2R0/+uPYyxaPU+qpBm9fZHWr5q4?=
 =?us-ascii?Q?UKdd/E8z+ELoIHPeJDfHH9ZryhvT0Oo7eJQJ2ewB70DF52Gp2dgGKPwSairE?=
 =?us-ascii?Q?3Y5JWaE7hLPXunjL7lQd3McAfsCqIz0NBhW6NPz65WtD5XAjCp+Z4jFSgO72?=
 =?us-ascii?Q?vxQcmtGUMrmHYovkSS83TvgeLlegHmKuL0J3H3LuD6dNFWU+9y9oPJnuqY1v?=
 =?us-ascii?Q?iqzbeNrNOyEGV//jiLkut3rFo7PG5LP9cO4N3OIYkkX8v93HD82dOhy8ak/g?=
 =?us-ascii?Q?QXyetJXgn+Q0Nk+WXmS1XMTRpIi7KqcvY+s73p7F+HXEjuLnOOhAcamY4U5P?=
 =?us-ascii?Q?v2auyTxrTe59FQePYHSTlXmNyY3Zh5wyu+L/Uzx8Ot99pRUYvKvaVOZLVmNt?=
 =?us-ascii?Q?R6Rw6JLlidvF/hfcieNnsUulJQZTiaO1S4QQEB1Wfmibzk9cwGXPjFmpgFev?=
 =?us-ascii?Q?zpTXYXFrIJow0/ijvJYGQbg2LGvGmr3WUHdcgSvZZ0ez/BAhucprWA5nGdrJ?=
 =?us-ascii?Q?8s12DM1UqVMQvbCVjDKN+NgubNgZcSfC70LSzp6j6f6ApdoMqrqzEJX84QVw?=
 =?us-ascii?Q?h9ldqVlHGidKmKRVX37Dr5VMX6BiiAvqYDCwmmNXgCYhrcwvavVu46JZwvWy?=
 =?us-ascii?Q?hYI6p2UZd5512fAtc3FwjjixJil6dg2cY3hdtdHx0jEpjC5/4jnvNfPmFs3e?=
 =?us-ascii?Q?xGi3yBPx8YWG5LNlqy5ZmZipFIlv3aCdwl/87DRLgnvgdm90vxY5U3Z9T1gm?=
 =?us-ascii?Q?k62/1em2F0bO1sEXkt9iDT/tfPRzym9S1w5wcs0hT17ztNZN4HTg4JR2baho?=
 =?us-ascii?Q?EVGY6sFP6N3aW8TU7IQYGaulxiZWRp/Ro83cH1wUlOdiF98+NpsxtJJJVzT9?=
 =?us-ascii?Q?MorfPPv3w4z8lsKCFs/600jDoebEfy2KtVMKK7Z54UhkUSXPPbdjlEJ9QtgS?=
 =?us-ascii?Q?d0NpsJTU5MyjfB+C2W6puaANxfxNH8i0hTa05RdIir/MtMfNDNuU9xhYrlCh?=
 =?us-ascii?Q?01u/IIo/qO9aj410d5+idBFcY3ycdfKs58r+3eOe2/yiRI1LZT+GAb63nAUA?=
 =?us-ascii?Q?KGIVB94Sywdvq+wikM+MZdOXjAkXRyJ0uk/OSZ+WgTvtLOH17aZrt2x0OBe4?=
 =?us-ascii?Q?NMFfDWKmvC4MVo5Am4HwJQ5Ti3qJHwjVuWWM6IuTjPpB03Z9qIHufQk17B2t?=
X-MS-Exchange-AntiSpam-MessageData-1: 7lQn6lFl3PhGK4glSFOR12pNEQN9yqR3pX8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79d16ab-f0f8-4848-f03c-08de7d0f7677
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:37:30.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0j6OVtM/NWaQ7WLDCl9k3lRFN4h61fp0WQQd+FfFF+kADtsNawHs/h6hPGwqjdkoBZsK1gaXSX0w520anaTh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526
X-Rspamd-Queue-Id: 532B023035B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7018-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.948];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 12:01:36PM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 08, 2026 at 01:40:07PM +0200, vladimir.oltean@nxp.com wrote:
> > diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> > index 5b1c82459c12..4f8ffc6524ab 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> > @@ -7,10 +7,11 @@
> >  #include <linux/ethtool.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  
> > +#include "../phy-provider.h"
> > +
> 
> As we know, this will conflict with my patch in net-next. I guess Vinod
> hasn't (yet?) merged the commit that Jakub provided.

Right (https://lore.kernel.org/netdev/20260302155736.1fd2980e@kernel.org/).

My thinking is that linux-phy needs to provide this series as a tag
itself for other trees, so it needs to be applied apply on top of
v7.0-rc1 plus Jakub's tag.

But to get some (public) build testing, I based it onto current
linux-phy/next. I believe the adjustments can be made during patch
application. Jakub's tag can be pulled on demand when constructing the
linux-phy tag.

