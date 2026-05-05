Return-Path: <linux-can+bounces-7499-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJWKBCTF+Wk0DgMAu9opvQ
	(envelope-from <linux-can+bounces-7499-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:23:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102E4CB152
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5819E3078A16
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AECF3F7AA7;
	Tue,  5 May 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xy81EUke"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F693F23B7;
	Tue,  5 May 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975567; cv=fail; b=qPBjR7M1vRM4VV8hP/aeEN1ij6aWKAyto2BGN1RHRjYjrzTsLeJ/UCyrx/tuH5pWktENMtJATgarmWo7DafvRPyuhvp/sPBQCggh4Zwx6QhJ1NElacUw8RlNqpHqOdOF9kXxrUOtq7e6ovUGNZWBZ4hpUFefdkJtHqsNCYE6QmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975567; c=relaxed/simple;
	bh=EuyYu4j2h/hs45g8aUk91fBW985c0hIc40GVq60dTfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fntv9mFE0dh7FusiFYvctQf3t3yw6EQtTWjmQtjrRmlztctZBcomDgM+yKUFcBQGhSOnHaavlNGTPdJmF5g/tBLIvhOcriHQlcH2rkhrFswd4Hr82eBP0VsLVEtj+zMyTkMvzOJSxyw7kcDR16qlbxxaDP5mU8lwQZf1Jr7txgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xy81EUke; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e94PMQYPhHi00IMVT8SMEYyIeRGLLKf0R+ujgE66F60vU64z0z/OYyQqWQARUu0iFT5tiPewLXVlGGUdck6PkvNx0oCd1CiQ235xTVHe2ixRAKpUUkTHgU2ZfuDVDgNzPVzDP13+Nq/i+hVs+8XrSzV9g0u0RhpTpx/Bu8kxETTI+zvkAHElOrMwVY4HBiprBw0aEgm+mjDOm4r2C33RBOIgxN53XSg6uQkGs7jwZtXf4zjH2wIOcxaJvPimghZQyCOWUw/UWbTxDhqdgDG/lOrgCP6k+pBXoNB7M4KN5UKW93ONuqVyoMpYov30aE/SGt9DuugEhP4OZR+OhHjhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSRCaU/T/RHpwudJD39b132C2AOlZdafTfBCJ5GHb7o=;
 b=LIYJwy/2D8Rwm9OnL7+oFsyMbrMNLEuc3Q1Xv5dy0ZC3nbd+tKfVUM1pyqxOs3p+Cn1wZNqjZuj7t99JP5gc0XIJL7vTBpTA8et9Q8kCGyvOgofPILD/bhS/JRp/V3vpIOX7WocUwgMeB8NcljH1wZeOqSXNBbMNLzeqLuRSNS5wzoYfD90ECmB8ZDLJinz3EOlwckm3eY8bxVSgDZfLjLMVzPSyAd+VHFMlp/p6XakbjyV65s70R352y9A73sQccl+IRw4frJVvUL1dZeUe0soNDvXb/LNVSzHAn1/ikn3L6Lg00lH7SSHsl2pk9GNMQ8oyw1CFdCupQ875JMVg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSRCaU/T/RHpwudJD39b132C2AOlZdafTfBCJ5GHb7o=;
 b=Xy81EUkea+ev6aXZQ3kig6eB6QFfeaxFmYMADmQLIjKEaJtc6GTk9XBnM5ntLJfQdUfHVdGJn8EPguqszt2SPuc2jfexfSwRgKBX0BDkzjXuA/tmF2l6WLZ1FayHqVL1HXLl2daM5N9k2CV8R51JmkwiBJer45tnpw67gpZUci3SJaNVVZrRFx43QrOzV8xzNJOBwZOM4GZ04GfIG8QPbhZVdK+HlMW3MWOB4SMOP+YGw9cWQFVfD80lNCX7nIodUWal8ri2U/9zVM7q7PqapBGz8x/WCLjDu8FPBOJ6hDxp1xc/qBDrWF3LVrjWbb49bu/EvKA8MY/rZ6Qnc6qLxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:56 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:56 +0000
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
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v8 phy-next 10/31] scsi: ufs: exynos: use dedicated API for updating PHY bus width
Date: Tue,  5 May 2026 13:05:02 +0300
Message-Id: <20260505100523.1922388-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd1a2e4-5c9c-47ea-1f93-08deaa8de615
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 y5JvMxunJ8txVoYYgW9oeeWpwH6jTW79Ae2Z5uOaRb5SrixMXaD46A9tSMCzq9pnDUpnAw5AT4izCzbeQ5xZjFhcKBNu8x93aWGNqBljCFErsZYg2cquL44XgemR7r7JAGIAEe9cLc8uYLnedSDJL9xqqMXxrTqcXSEsG4vreNuMSp263nrwSxSXeeKldLK6hvskq7zQS8YZ8Nlq98L+fUUXE0rmxcESRRXzWYCfxeTbQkaE7KD57a/aMFyLK7PuhM6TvZmmFRl+WOv5YN71tXprg1USh3qw2cJZUQwQj9/cMohqmuqsc0k8/MBZrn9qvHWnSOqOB/wnlc/lpiL6UaxjYDhHWOegVco6p8IS72ekDVEOgiye4vAYoo5JB4IU13DleGqSdhk1t/c6o839ztu5VZXhu4Z+dpWou5+EVcJ0LAEtmTEq/+4Q303Ea/Hda3z+5AtRiXB6RPKz8V5lA6UrHEhI6FY2xEYmYQJeknY7ngDW8cG0Bfx5j+OycPgJzBwOFjHIq80yZmi23/C5uoj1R73XYzGOhVi9h3zPzacJmbAcwLINTNwtJzQTHs1LeWWEC1A+5Rus92su0l4QWoM7IVa0Oo0bb/kzQJxVXoWyIDoNCJNq6ek9TFaoeQwVBWkmOsH0HzjVFJhRegcKGA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Xa2B1pH6ppdSVcK+2eNSe06fW/myPWKtK9mJyaLNQwcTr7cRhUrVs7BhPoFM?=
 =?us-ascii?Q?YpKbg6MqNAuBgqLUQTaLFUG7QY/cfBwZhBy1/7OfORZMq8EK8s6WPooSpK/s?=
 =?us-ascii?Q?K8YnHj95aYPPg5mfYzlvT/+hiTO/1w2m18woZhOUKZ9SLy8qCQQyKR7ZHhQ8?=
 =?us-ascii?Q?FUW3GU4UcqvcNFKNofrKyri+xEXboMt1e/MAy1MkYnTdhSxx4KX/HUDLs050?=
 =?us-ascii?Q?V6CnuHr8y+etpOSEF0IkDsOpMf07bnw44Vvd+af4hVl6wB34AMPK71ZARx35?=
 =?us-ascii?Q?fdFQYV5m3KUcCKz7S3bqynrfqWRMCMWxhL9JbtkxLpZHLBuGDQeJokVnABRJ?=
 =?us-ascii?Q?NqSwImQPwK3XaRuRAN11b/K2fEsaOvZUUnYLmIW580ZkjWNJWdROkd/kcL6C?=
 =?us-ascii?Q?hTDjoqtbOoqokW7iyaX0C4LO8bkxZnSmBHXJ3l5HHUnIcPr82k3Coaq1agAq?=
 =?us-ascii?Q?+dJ8LK4mtNEUxpHhgRvkm9t/W7o7Ks57k7gx3CQvN4ldCt5pgoMTiDif1Frm?=
 =?us-ascii?Q?Kq7Gj9jMM8aWgLU4jpnY+5A5P/aT8V4Er9vaV1lHgr/poZ8SWqME5MvKV7Vt?=
 =?us-ascii?Q?JrBrqRz74TPunkTPUUvQlo2ZCoLtdBlca+Oh6wT2Ic/XNbO4TdZUoXGHHvwT?=
 =?us-ascii?Q?qNCLvsAIjdXNw/sg5INGtEC9fovnhXxU978prHMdD5uSDP335XSyhnAMWCp3?=
 =?us-ascii?Q?is5FTRGjZvv5mmCAa4LqZqh9vsN9O7qxWzUw7RbUFxdW1VklW+v4DTAsvg1B?=
 =?us-ascii?Q?JhabrMJ+8z4YTjOlfX1OWNU6cfDBf1aMHNE1WiyP1zjJKM8AZ4r7PAAkq2zu?=
 =?us-ascii?Q?da+2pTMmt6LN3goE3/gxcAD6USMesh2K0K/wJimysca8XRENBHCZRg7OimTF?=
 =?us-ascii?Q?Mh+m8kzOqwffYWb6j3eGD3XKgQMqGmBD3yPvbb3Z+63/JZMuc2O4l9oQOmhI?=
 =?us-ascii?Q?PxnEHtBaG7c6PEH/hM2JxDxS1ZSH6wCsR52iyEUfNBUxcZBXmreNpjswcO0t?=
 =?us-ascii?Q?x3opTl2I5Rb9+z0HYOTw0YPIZmcwbJcifEMLBPeP3FSkcj3cW7b9HRkc9cqR?=
 =?us-ascii?Q?z5AUCgTcWnI9+MfIKsy2ZMMHTENwEYrOlI9LUIH7CeiO+ItE+X2Xbu/fmPrk?=
 =?us-ascii?Q?2gNY3wDj/Uav8XgrmTKDrFG/kGcoX50kF0BRA9OxOqNbnnPyqVWUMM/HPrOE?=
 =?us-ascii?Q?JKcm4RZvpVcSCmZV9POyKHCNBmv8opktrCWF+V0wT9e8coFFokeZTYFiNVkQ?=
 =?us-ascii?Q?DB2xL7Pt69zlRb5KywkJ2pRHEPGttZ2XYHFQWf0Be6TrOddpNC7NZ7rN6i13?=
 =?us-ascii?Q?ONd0hVMbkVAKByLCC12h3ODNbINsz5yU4y4CoolWWk+i8xlO36oN8hGlcaGG?=
 =?us-ascii?Q?tHMiHMP9gTCKZcWEVY2nCW/0pRbe91y6J+qCYJ1DCj0fUAGsQNECSE1JlDUV?=
 =?us-ascii?Q?Zmi4RO5xtQDf1eHSjgN7FDlM/UD+MqfTsqtGwIQMrv8rj3WLDHEBuLCCToyj?=
 =?us-ascii?Q?oVbQ3+5047pXZGJLkMvuI5iHzLLXuJ30im6Vq3trBj6YQ/H2wXOjnYfJVUfb?=
 =?us-ascii?Q?NBVxtpeXARGKs1cCdsng/hLIqMLgjXTvxB4gZXU+co8AySSZbbtU5LEZ69Cb?=
 =?us-ascii?Q?ice4ldLssTU0wuyim80sM3tano4qnU4ljFtemuplp+4LeCyzyqFaeuMQ0gKu?=
 =?us-ascii?Q?QhYq/ruvW/hUxsEdfCTLjqbt3VTXYggYtARNu34rNYvBTu7q6KwkaqhnKiIf?=
 =?us-ascii?Q?0vPMRbVgTw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd1a2e4-5c9c-47ea-1f93-08deaa8de615
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:56.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkHMvoPaohs5q6ZoRq9I17MSTz7EWznPzirXt/mWLGmuVGAtG/9Eki37GOga3Oh8t0r0/b5J4UCl3o0Q8xy72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 6102E4CB152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7499-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,hansenpartnership.com:email,linaro.org:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,acm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

I am trying to get rid of code instances where PHY consumers (like the
Exynos UFS HCD) poke inside struct phy fields, in order to further turn
struct phy into an opaque data structure.

The ufs-exynos.c driver interacts with phy-samsung-ufs.c in order to
power it on and to update the lane count. For the later purpose, it
(ab)uses phy_set_bus_width().

The phy_set_bus_width() function is a PHY provider function, not a
consumer one, and I am calling its use from ufs-exynos.c an abuse
because
(1) commit 8feed347d33b ("phy: add phy_get_bus_width()/phy_set_bus_width()
    calls") clearly states the intended use.
(2) phy_set_bus_width() only alters phy->attrs.bus_width, and does not
    call into phy_ops at all. So a consumer that makes a call to
    phy_set_bus_width() can not possibly produce any hardware change in
    the provider at all.

This is where the Exynos UFS HCD driver decided to be creative and
hijacked phy_init() to pick up the change of the bus_width attribute.

This requires a very careful dance where the PHY consumer needs to
simultaneously juggle multiple requirements:
- the UFS PHY needs to pick up the updated lane count in its
  samsung_ufs_phy_init() handler for the phy_init() call
- phy_init() calls need to be balanced with phy_exit(), otherwise
  subsequent phy_init() calls don't make it into samsung_ufs_phy_init()
  and just leave the PHY with an elevated init_count
- phy_power_on() can't be called without phy_init()

The difficulty to observe all requirements is why the following bug fix
commits exist:
3d73b200f989 ("scsi: ufs: ufs-exynos: Change ufs phy control sequence")
7f05fd9a3b6f ("scsi: ufs: exynos: Ensure consistent phy reference counts")

Currently the UFS HCD driver tries to keep the PHY init_count and
power_count in tight lockstep, but even this is error-prone. For
example, if exynos_ufs_suspend() runs and then exynos_ufs_exit(),
the PHY power_count will underflow.

If we address the root issue first (phy_init() abused to pick up new
lane count) by introducing a new PHY consumer method which actually does
call into the PHY provider driver, then we are able to absorb the entire
UFS HCD dance and update the lane count without altering the PHY
init_count or power_count.

This allows more consumer flexibility to call phy_init() from other
places, and same goes for phy_power_on().

It is common practice to call phy_init() only once, right after
phy_get(), and doing so will naturally balance it with phy_exit().

We can also leave the phy_power_on() call to be on demand, placed inside
exynos_ufs_pre_link(). But the UFS core (specifically ufshcd_link_startup())
may call the variant operation exynos_ufs_pre_link() -> exynos_ufs_phy_init()
multiple times if the link startup fails and needs to be retried.

For this reason we need a consumer-specific "bool phy_powered_on" which
ensures that we call phy_power_on() at most once, and that
exynos_ufs_exit() only calls phy_power_off() if phy_power_on() was
previously called. Using the phy->power_count for this purpose is
undesirable because it is going away, and the PHY API is not offering a
helper for it (would be a foot gun, because multiple consumers of the
same provider shouldn't interfere with each other; each should only undo
the effects of what it did itself)

Inside the new samsung_ufs_phy_request_bus_width(), I've sanity checked
that the bus width is either 1 or 2 lanes. This coincides with
samsung_ufs_phy_config() which only configures LANE_0 and LANE_1.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanho Park <chanho61.park@samsung.com>

v7->v8:
- rewrote commit after Sashiko pointed out the new handling is still
  not correct:
  https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
- removed Reviewed-by, Tested-by and Acked-by tags from Alim, Bart and
  Peter
v6->v7: collect tags from Martin and Peter
v5->v6: collect tags from Alim Akhtar
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
 drivers/phy/phy-core.c                |  35 ++++++++
 drivers/phy/samsung/phy-samsung-ufs.c |  27 +++++-
 drivers/ufs/host/ufs-exynos.c         | 114 ++++++++++++++++++--------
 drivers/ufs/host/ufs-exynos.h         |   1 +
 include/linux/phy/phy.h               |  11 +++
 5 files changed, 151 insertions(+), 37 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..634ac07fd1f3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -606,6 +606,41 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+/**
+ * phy_request_bus_width() - request PHY to change its bus width
+ * @phy: the phy returned by phy_get()
+ * @bus_width: new bus width
+ *
+ * Consumers can use this method to request the PHY to update itself to a new
+ * bus width (typically meaning lane count). Can be called from any init state
+ * and power state. PHY is expected to use the new lane count as soon as this
+ * method returns.
+ *
+ * Returns: 0 if successful or if operating on an optional and absent PHY,
+ *	-EOPNOTSUPP if the operation is not implemented, -EINVAL if the
+ *	requested bus width is not supported, other negative error codes for
+ *	driver-specific failures.
+ */
+int phy_request_bus_width(struct phy *phy, int bus_width)
+{
+	int ret;
+
+	if (!phy)
+		return 0;
+
+	if (!phy->ops->request_bus_width)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->request_bus_width(phy, bus_width);
+	if (!ret)
+		phy_set_bus_width(phy, bus_width);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_request_bus_width);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index ee665f26c236..b09a35ab6acd 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -165,7 +165,6 @@ static int samsung_ufs_phy_init(struct phy *phy)
 {
 	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
 
-	ss_phy->lane_cnt = phy->attrs.bus_width;
 	ss_phy->ufs_phy_state = CFG_PRE_INIT;
 
 	return 0;
@@ -204,6 +203,31 @@ static int samsung_ufs_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int samsung_ufs_phy_request_bus_width(struct phy *phy, int bus_width)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+	u8 old_lane_cnt = ss_phy->lane_cnt;
+	int err = 0;
+
+	if (bus_width != 1 && bus_width != 2)
+		return -EINVAL;
+
+	ss_phy->lane_cnt = bus_width;
+
+	if (phy->init_count)
+		samsung_ufs_phy_init(phy);
+
+	/* If the init_count is 0, the power_count should also be 0 */
+	if (phy->power_count) {
+		samsung_ufs_phy_power_off(phy);
+		err = samsung_ufs_phy_power_on(phy);
+		if (err)
+			ss_phy->lane_cnt = old_lane_cnt;
+	}
+
+	return err;
+}
+
 static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
 				    enum phy_mode mode, int submode)
 {
@@ -272,6 +296,7 @@ static const struct phy_ops samsung_ufs_phy_ops = {
 	.calibrate	= samsung_ufs_phy_calibrate,
 	.set_mode	= samsung_ufs_phy_set_mode,
 	.notify_phystate = samsung_ufs_phy_notify_state,
+	.request_bus_width = samsung_ufs_phy_request_bus_width,
 	.owner          = THIS_MODULE,
 };
 
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 77a6c8e44485..b90876b268db 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -931,11 +931,73 @@ static void exynos_ufs_specify_nexus_t_tm_req(struct ufs_hba *hba,
 	}
 }
 
-static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
+static int exynos_ufs_phy_init(struct device *dev, struct exynos_ufs *ufs)
+{
+	struct phy *generic_phy;
+	int ret;
+
+	generic_phy = devm_phy_get(dev, "ufs-phy");
+	if (IS_ERR(generic_phy)) {
+		ret = PTR_ERR(generic_phy);
+		dev_err(dev, "failed to get ufs-phy: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = phy_init(generic_phy);
+	if (ret) {
+		dev_err(dev, "phy init failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ufs->phy = generic_phy;
+
+	return ret;
+}
+
+static void exynos_ufs_phy_exit(struct exynos_ufs *ufs)
+{
+	phy_exit(ufs->phy);
+}
+
+static int exynos_ufs_phy_power_on(struct exynos_ufs *ufs)
+{
+	int ret;
+
+	if (ufs->phy_powered_on)
+		return 0;
+
+	ret = phy_power_on(ufs->phy);
+	if (ret) {
+		dev_err(ufs->hba->dev, "Failed to power on PHY: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ufs->phy_powered_on = true;
+
+	return 0;
+}
+
+static void exynos_ufs_phy_power_off(struct exynos_ufs *ufs)
+{
+	int ret;
+
+	if (!ufs->phy_powered_on)
+		return;
+
+	ret = phy_power_off(ufs->phy);
+	if (ret)
+		dev_warn(ufs->hba->dev, "Failed to power off PHY: %pe\n",
+			 ERR_PTR(ret));
+
+	ufs->phy_powered_on = false;
+}
+
+static int exynos_ufs_phy_update_bus_width(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
 	struct phy *generic_phy = ufs->phy;
-	int ret = 0;
+	int ret;
 
 	if (ufs->avail_ln_rx == 0 || ufs->avail_ln_tx == 0) {
 		ufshcd_dme_get(hba, UIC_ARG_MIB(PA_AVAILRXDATALANES),
@@ -947,30 +1009,11 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 			ufs->avail_ln_rx, ufs->avail_ln_tx);
 	}
 
-	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
-
-	if (generic_phy->power_count) {
-		phy_power_off(generic_phy);
-		phy_exit(generic_phy);
-	}
-
-	ret = phy_init(generic_phy);
-	if (ret) {
-		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
-			__func__, ret);
-		return ret;
-	}
-
-	ret = phy_power_on(generic_phy);
+	ret = phy_request_bus_width(generic_phy, ufs->avail_ln_rx);
 	if (ret)
-		goto out_exit_phy;
-
-	return 0;
-
-out_exit_phy:
-	phy_exit(generic_phy);
+		return ret;
 
-	return ret;
+	return exynos_ufs_phy_power_on(ufs);
 }
 
 static void exynos_ufs_config_unipro(struct exynos_ufs *ufs)
@@ -1055,7 +1098,7 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 		ufs->drv_data->pre_link(ufs);
 
 	/* m-phy */
-	exynos_ufs_phy_init(ufs);
+	exynos_ufs_phy_update_bus_width(ufs);
 	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
 		exynos_ufs_config_phy_time_attr(ufs);
 		exynos_ufs_config_phy_cap_attr(ufs);
@@ -1475,12 +1518,9 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 		goto out;
 	}
 
-	ufs->phy = devm_phy_get(dev, "ufs-phy");
-	if (IS_ERR(ufs->phy)) {
-		ret = PTR_ERR(ufs->phy);
-		dev_err(dev, "failed to get ufs-phy\n");
+	ret = exynos_ufs_phy_init(dev, ufs);
+	if (ret)
 		goto out;
-	}
 
 	exynos_ufs_priv_init(hba, ufs);
 
@@ -1490,13 +1530,13 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 		ret = ufs->drv_data->drv_init(ufs);
 		if (ret) {
 			dev_err(dev, "failed to init drv-data\n");
-			goto out;
+			goto out_phy_exit;
 		}
 	}
 
 	ret = exynos_ufs_get_clk_info(ufs);
 	if (ret)
-		goto out;
+		goto out_phy_exit;
 	exynos_ufs_specify_phy_time_attr(ufs);
 
 	exynos_ufs_config_smu(ufs);
@@ -1504,6 +1544,8 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	hba->host->dma_alignment = DATA_UNIT_SIZE - 1;
 	return 0;
 
+out_phy_exit:
+	exynos_ufs_phy_exit(ufs);
 out:
 	hba->priv = NULL;
 	return ret;
@@ -1513,8 +1555,8 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
-	phy_power_off(ufs->phy);
-	phy_exit(ufs->phy);
+	exynos_ufs_phy_power_off(ufs);
+	exynos_ufs_phy_exit(ufs);
 }
 
 static int exynos_ufs_host_reset(struct ufs_hba *hba)
@@ -1728,7 +1770,7 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 		ufs->drv_data->suspend(ufs);
 
 	if (!ufshcd_is_link_active(hba))
-		phy_power_off(ufs->phy);
+		exynos_ufs_phy_power_off(ufs);
 
 	return 0;
 }
@@ -1738,7 +1780,7 @@ static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
 	if (!ufshcd_is_link_active(hba))
-		phy_power_on(ufs->phy);
+		exynos_ufs_phy_power_on(ufs);
 
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
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index ea47975e288a..01af84f97608 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -93,6 +93,7 @@ union phy_configure_opts {
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @notify_phystate: notify and configure the phy for a particular state
+ * @request_bus_width: request a different bus width for the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
  * @owner: the module owner containing the ops
  */
@@ -143,6 +144,7 @@ struct phy_ops {
 	int	(*disconnect)(struct phy *phy, int port);
 
 	int	(*notify_phystate)(struct phy *phy, union phy_notify state);
+	int	(*request_bus_width)(struct phy *phy, int bus_width);
 	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
@@ -275,6 +277,7 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+int phy_request_bus_width(struct phy *phy, int bus_width);
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
@@ -456,6 +459,14 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 	return;
 }
 
+static inline int phy_request_bus_width(struct phy *phy, int bus_width)
+{
+	if (!phy)
+		return 0;
+
+	return -ENOSYS;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
2.34.1


