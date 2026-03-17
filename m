Return-Path: <linux-can+bounces-7125-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMaNLQLhuWlhPAIAu9opvQ
	(envelope-from <linux-can+bounces-7125-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:17:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C32B41AC
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEBBE308B99A
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A684413236;
	Tue, 17 Mar 2026 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxiDZhiN"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129340FDA1;
	Tue, 17 Mar 2026 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788792; cv=fail; b=U/ZVq/VRWAwPQ/BiWMNQlFekr0uqxHD/AbH1g0C8iYF1M1SYxL1oZowJkz/vXn2TNUwqnB3MBG9kcWHhRJJxY37uuEB5Bk4l/YoT0PGGAex8ptBv3VeThqJFo+J4j1lYRlaRcadLqV3k+imFeSbLRABgvD3xPeyuAs+w0GK1Usw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788792; c=relaxed/simple;
	bh=lwUIB8nTMgyITA9JfD4pa1X2kpkj3PL6fYE3xAWCGFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxVZwqS4gIQMnCtjhy7RE8qmF6UqEnOsPLYUSt2qitWQwJh3ZDSjpD6+fXoIEPcx/gC0QggNtu9wu+Fj7elDMKV2Z2svKcs+nDtrIw36/wHes52zG8/M4NhTo5LIjIHstucWhPaEQZb8xwINg+SwgLrZZDYjJ0w43zj9NEb+928=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxiDZhiN; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHrEMWt4IfRZ239bQyHZ/p+l827kY40aNR7Vw/80h5uyg1hHMb0ODpUKBUbBHMiEskJWvAhHtK9qR9RF5K84dnvhSc+qidZsxHDYz38Zy1v6aeMM04U/IBpHeUmVPZXRtQRqgNrLqzRWKBW8dAzC2bPNsm1sPw+phKdcqVoe6W8cwyUYmAq7EcLfaS3JKTRS+MhCNn0b5LYNnIZuzC9RX5Dh9jJY3kvCZjKR/1jMy6tOge5K5tRhUDnbOwXo4r0EsA5o4GHbl7GUBeIsKseTvcuDvw7WBnuNf+/4AhtpX6c6wHHYRw98wCEQFmBMiRjwgi2M9Rk/6lz9pMXK7EYVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8Hn/LMKXfQtV3rgy7V0S9c2vIPq86UUMXtQNhoA2vk=;
 b=JxkTAS2RQeju6I8uPgYsJ7vEK9YJ1XNvRe80/U7sSAxSl9+LJ3vbiQKYHTVjsZ1CMQHxv4mT/U1IcxzzGrl3cS5Suz5SWnQI+qLin6CWzPrT0EP0WM57NBdsMjXuBBVtpMUt1rXX5VW1pmoEIb0Mcom3kXADBM/u4XhXU9sjkJnV+n6NxInLvI1L6OGbNvYR/HdISDBxdRBWWwwHMBUyFjS4Y3D6OcvWuKKucUyUjGTJ1RrhRHh/jO00W4ZLhm83yOgB85Vb1FmFrXCYmk0UCeeYpIgcIFkkzinXN2lwQlnNnxogDVj5/fXLAj/tXhVTCkbBTX7lmcQokvXfs+e9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8Hn/LMKXfQtV3rgy7V0S9c2vIPq86UUMXtQNhoA2vk=;
 b=FxiDZhiN6GicpbqBomAvjrIobbc9qM5iRhGg23oBW6gPE7tl4CMo/ThtY0qiqb3RiRJVSnbMZxqSptCueajXEGIS9Y/g18eClQO45POj3APxYjR8l5HGA+BBXybTkbykkCMPBBXiMKCtWImLwCgjobyiIIkTV+hnk2Ow5Y2zAjeDBFF4k/gO6m7VTWcIYakTbONes8Rj3ULU89kK8gnqZtSaXrPnluWzrMhzRLwLAN0lx/pnrDT8QNFdCqfOq03WtCY9RpVN9YpQLvqlJ703ErZdGG/zQVQ8JSftFRiRGoK6aOesUdjGFjsdm+IsLQjVTT2ory2mXgRajnZO2DUkuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:06:00 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:06:00 +0000
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
Subject: [PATCH v4 phy-next 24/24] MAINTAINERS: add regexes for linux-phy
Date: Wed, 18 Mar 2026 01:05:00 +0200
Message-ID: <20260317230500.2056077-25-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 79462e4b-d455-47bf-f634-08de8479c11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YespgONs2DDl7GOcblybxKGg6iHJbD8qjQ7M/RLDZ2LcEJvP+P5re7NN3orYg8lOZ8y6yNmPJYa+sN4P6teiwZ0+niMg3O+Qj7VGSVYj+AVUemPFJntcYvueai6lhGShGOqAAePfHVpW5Hd2b7UIQ5lADcn+Sq4FRqKQSPhEtACC0k0DSl/ObKQAEcCuZezKy07lRktFyHBm1WQGI2sP6HwMiJzfvZM2Qk3om9FMHMC2AvfzphySS2mgkg2WdrSAMFRS50GPNiqRZUqLrjnWWA6EWXikWNKaBoEwgNZKXlAAv7pzZtMpC/JrukGGry8Kd+DL75Re+8jZNOIoDPURQrSoG8ilgmizF1AcGSSA0j139TOqyUEO2OuXk55OEXFp+Fmv4G5y3WbzfzJ4sUXIVo/AMhJ0cUkZwuN6R74yVsB7fAJZgm395ZCNMS2zQ28atWx+QWwjK8UFNgMU5N/fLXq/uKm8okMkgJBt8C/LWjB5Nqjo+gtJ/M2nm18mENHA8HqBuqanP/1KsJSFmThAgevKu8jR33v8ZsUvYVTgIIW1UCvFirxTO6DH+cjAwlrmdwNDb4FecltaqMHEPsKDKXgH+wfLXjwFu7O8Ju7cvl0Fp8+mJNVBR40T1AMLefsPKZumcoSV2g0kbpm7FE7WwWW9GsVGp3ORqrLjsZ60FO64xotYQY5bA1YavooKOaJYMhvFQU9DpWdykdF4swI9MrTv1VIWWauJr824sIcYuBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?594FUG5RmhKOO6XFFiU6HjEcrYvACWipdketJ3hfr/2KkPusQUr6eN3tF2pq?=
 =?us-ascii?Q?swwZH+MSB6Qa92LO7jG5/vHdSKkf1DAA2ap5LLQoC27QnvdWFUm55UPOnzO/?=
 =?us-ascii?Q?doMNmw1QgkPmSC7fBWCZZ18R272IRjN0rij9wY6YDl124nIKk0eGx/R9gA+d?=
 =?us-ascii?Q?bkqKrwUpiuPiSLUtU9qPOgc8XPgW2fIk7U6nlgLGrl5+Vd09l7DrNGhN1FcI?=
 =?us-ascii?Q?b2tqGgoC2UmGYALMTL0U5hZd0Dp+FaqalVW1/go3npaJtu3wa1ZwjmyV936K?=
 =?us-ascii?Q?0qnevCH0IFxuIwMfKEPxioJQ15yq3OAhuqjiuu6Zc0PPqUk+k+/nH+dkmCvl?=
 =?us-ascii?Q?fyzfLXMOAsJX21FO7Hbds4vGqoag+9N2nkfhQj8XFGX1EuRLOCdkiplr2hTL?=
 =?us-ascii?Q?A0pzknC4g4xTfoQbF4o2FprMHW6LeaxuzvObQnr+9XrjwFvsvLG2UO4vG52n?=
 =?us-ascii?Q?p1P92TIXB8XjvBG68remkpLDPcZ4+21/0EVm5xIOYOSJsRmJ1jbVYTPkgi1Q?=
 =?us-ascii?Q?3jpb+TzQbYXMfhaG1FCRUK8fto04GLsAHIEXDx3WAL8gcPX9QdH6qVvRGmFp?=
 =?us-ascii?Q?x9xDvihB3yxgwl1HCyFzHayN2wZDX9Y3yYA3Fqnr388l+ngzrUaLoXtspClM?=
 =?us-ascii?Q?XC5vEEB4ukutkyjIROegku3OfKFworWONjZy2SJjSqaOPVoqs42GnLE/h/U0?=
 =?us-ascii?Q?NgG7Q01c3yz6A7VTA+33pP9JdFYc12GgdoIw77N2qQO8Vo/umIW8warl28tx?=
 =?us-ascii?Q?3Uxaq5f6T7zcQMV2uiWPUTGtjwbcfu5KybeooVFpZzB3mQBC0sQdIOwOwZqU?=
 =?us-ascii?Q?scFwmQvnzD+jOAv20TD5FBOW49OWw4Q0wqM3Iab5Jfri4mtpIe1xRPU2eviw?=
 =?us-ascii?Q?0uMERKJNkOlEiSZRijbswHDBUQzLO+iDivkIqiWnq6xeEWP3yjyGqIq+OdS5?=
 =?us-ascii?Q?ItW7++uqeRrIclH+AUj8iOUQzjZBSsb+adEWUB2M0Esgo9bE6vjle5H1WMyu?=
 =?us-ascii?Q?2GVBc0vHdQfjlsG7Ylgx7FaK2KyyagF3dTNEx4XP+5uKMdJt90PbvOyXeWSv?=
 =?us-ascii?Q?Ma5R4IQyx143YMq5qOHOBiF27PwpbOtb7RAyeNXqoEe4AfLLYAwXi8p8eUea?=
 =?us-ascii?Q?YgrEZu/xNgTRQyJf8B31nOiE6jkGawq1M1k05BdKhKTlYQrAyeVAKOvABBeF?=
 =?us-ascii?Q?ARh+TzOu9zYPW8PS3YMY/M2deCn4rGhqD8B0Bg7fXf6fQSU4WqsWjFn9Ugia?=
 =?us-ascii?Q?fTxefy+G3Atza7+o1LG1cKQsOTb7lWNWv1C5e1iXNZHrSMqh5ZB4IKDJOhfX?=
 =?us-ascii?Q?y+6zS1qCoCvcA08JifGindOhIiOmHL/vCOZ03zpRVxHhz0ayKP/848GPLzcQ?=
 =?us-ascii?Q?WJEeDiLBLvHqknbOVjuJbcyYaNX4zkNVZGbGbpnK5uzlyyWhLc6Xo7fmpYZo?=
 =?us-ascii?Q?RApqTA4sUv+3TUU9RoWoGSWOn9WVSJZVoeAyaN0zSf4PrVVnvwitkDYtl6zv?=
 =?us-ascii?Q?M8oEO3BxJRGoGN/RrnTY3+J5f07WV0rETfcG4OT2F7pS7sSbKs3Y8kqE5gzD?=
 =?us-ascii?Q?pYFEg6vjLtd2R4k+EQuYK0HjY9GFffbQETwOhQ9/pqQ2hFC12RxYZYInE18N?=
 =?us-ascii?Q?cU9HqTMxyX8bEoo68ACw87IvIB1u46pg/0o6aRKy9IkRYg1/sR6ABqSEoVp5?=
 =?us-ascii?Q?ztonKsnrWM1YcSaM2d59f+ffq4qEcDLXTLC6IbzLa4WEVYnhlxdFEBhC0BdY?=
 =?us-ascii?Q?auBZ1aLx4dth6tyn/kc6ap544OHglYlJ/ARKrgIXOwp1clntAUQ3mIGTlzQc?=
X-MS-Exchange-AntiSpam-MessageData-1: 7NTM5pggdFSJZ2cCYG8wK+kUHaPXZd8bZwg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79462e4b-d455-47bf-f634-08de8479c11f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:06:00.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYq8izQWzR6T+6vW2KgHfT/LjN0LUr1zqCB5fJRSZCO1H5KcrLyYIv/qB3cmRPsswAjziyoG4axbKjD5PmMfsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7125-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perches.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sang-engineering.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 380C32B41AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v3->v4: none
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
index 55af015174a5..cd920f14abde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10713,6 +10713,17 @@ F:	Documentation/devicetree/bindings/phy/
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
2.43.0


