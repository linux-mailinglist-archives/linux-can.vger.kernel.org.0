Return-Path: <linux-can+bounces-7438-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB/aKt4482mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7438-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:11:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E14A1834
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EA40301F56F
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72B41C317;
	Thu, 30 Apr 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HlqgIwbJ"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0303DB62D;
	Thu, 30 Apr 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547242; cv=fail; b=Fn++HLI9KjmX5a2eyqBRwYFMDbXtGDoceFEWTEePuqFkG/4XjoKAA3mU/nEONv85YI2KHmKTCu4i/33MyY1SmKIUNCBUg+/od4hlSzK9kSzviKXa8QvvmTQ13/NGXsbqChqIdJqUwvHCN6OoOs9lPuhf7skcmab3y/45IFNImDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547242; c=relaxed/simple;
	bh=yvj5998aJtf3Q5D3t2lV33gj2V+Ip37XLsJ1kVsI56I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TShIlmxHP7P+AcPN5Xp+hdhcJQqk+2aFxxoUB5QD+i0Qp/WnOS5AhxIhfLRgd3++j46dktbon8nP/rLVhKKW+wz7N01WbDwBDtqVdPrT4pnYrOX6epsZID6Zh/MS4eFJBzuSvQCuW4ME462S04wXkhIrrNEBZFAybDUKc+s85eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HlqgIwbJ; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7HyCAvH062Au1WiHUg8kN41qQseCTt/ApwOsXn75hHp12Rj59mRtv0ezvgXmAKqO0bbxQN2iMTsQ86bfYvAeqdR8tsqHskWvKhRodkoJH7gQXeqjJlTZdBnR2TOets0xc/k/yINRtijdAgpJcbLWJioAmEa3h9RgweG0XT4zkNVufWwi4RIHDqBB+AwZHwioROc6z6+y8oMnAzgEQI280wDbKMZzwx2K22VS39jCBplGw72Tuv5MY/aeUzI65dVWe1kX4Ny14h4xx5Kw883En1C7/mtR7rnxifRHnn1r1P74Mkp9LNy+VUu2KA7ttLP/7Uadj3S05CH8qWvmHHaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QJPjyyLXnZdF9yEeSZ4NvwxeNHOna0J2SuRHf1upYU=;
 b=mGHYtVzeb/fQ/FF9jOrwnp5LA2kIx4KNcn9s2EEKaf+5KO+z2YatAm+yo3J+Aftzc2VFe6vs/g4fNMPwSAgiiTnHmg//Wsq2px0pv5jZP7s6BugqUSgE27Gxl/aPRPCN8Aob6gJbjcBbbt+dznGce2/pWP1UuOMzUHq02+YXTPH16E9muWPmCdoEUdEUUMePc97YkAHfvs7j8wc4a20xHMtDP/qD7w4znxeKjQ9q2/tbyuytGu9IsrYkOjaqF42DgJkTpwIKqpkaleQmEf5Las27EJrIwqKKQ9pzER8UVDrqA0U400bcCDK9eoFA7UETnlvUMt+bt3dlOjZUgqx3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QJPjyyLXnZdF9yEeSZ4NvwxeNHOna0J2SuRHf1upYU=;
 b=HlqgIwbJowg5tfJlIWS+c+7JNj1xSQwHdtwDCuJ3L1USxzomt5moma6Y5nqC1VtGAgYvVu44M6NA1FtiR4XcvjMfngtYHxA6N07nddPA0UuJZ7s3mHuYLsRqgtddug5dnB+Izdd06dD3HmyO9OMIFhKmBusTzkFVTP5osTf4aAtZly1kAji5L1lEXe8WEcLrzkDJrYSEGakE6sGO/j+xsWoC6xyE5a7TRvxBRBBsgabSvjnDKP7A7WJCil+Z4f6thQfwzjQ9PTtYwWRCg4DCtqHF/atCugqEpX1ZAKUU3cdmAl+dHktUafXCGV0pYQn7HGfvqFD0raYFHbR+MXMYoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:12 +0000
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
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v7 phy-next 09/27] scsi: ufs: exynos: stop poking into struct phy guts
Date: Thu, 30 Apr 2026 14:06:34 +0300
Message-Id: <20260430110652.558622-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: f3262e45-7f41-47fa-29fd-08dea6a8a11e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 uQ6BRxv4JcHbS+k38O0AjKarOe+huf/EtXhvm8ji8sHBbMWtxLl0DZnTQlgxbZn6xAG54feJ6ZerCQnHZ0DXTwUBWRMH073iD9cYCIEwGPNfk3lNoi8AprLQY6OkgIZWVLLwqelZqVg8LYThHBfPV7G1aooVbimuL9aI4w/vVADugSCuMhpKZW7KCaAop4BhWaM6/gO+VhHdaK4URPgZurJZCSMCIigFifqhuRU9AqL/Qx9MHdpZhzlA/PAiqqGAtQSgedngWT/TErmmb8qpnyW6dqi08RppIsUM2QSJhb6X5hUmS1RCfBJT2avjGN4nETlPqnqeL6BjN/5gjZW+UPuf8qzwaPd5BW3hheKaUsu7hcZggDwWTxat4Ef43aUI8+bjGVMWYg7ETGP96nDjSlJm5yGkihEkC0B3Xn424/0ogOOwcZCyY1CAIOJ2hwp0XN6n3OfcEZYeLWP99N4a4vWabNcn3E9YvmyiQ7ueiKhvgFyo1CG6ct0gjVVFU23xMHe52+LJR18nPuHjo4XeiLSzuSDfMIFJv1U00tW+n6c54l0A4sIu9kTaDaBb7fEPyzp99zkiQi/sR3pUWesMfE0DnRgLQk1QGf/kZrl/+VQY64rW/xe0WDi+UoqfOhovWRsPV7sZddGO/2V+AN4mT94ZodvnuP1VRMaPaujGMO8/mia+mSUYRK61lXGLI/nNCBUuFqWl4vaGOL0+x9JcpTtgIvB4Lvabqn0PKfMZbEg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?pgDZnIOlO9Sx4kbYGpXGMTchYlY0VoxyFBF0zPxJ5zEx1n3zjCDq5wspqXZD?=
 =?us-ascii?Q?NnoAzYFUXRHTCH6at1/Bqs87vURuw4BnFJ/Hs5eAVzAz+jcbjVoxSP+RvMkb?=
 =?us-ascii?Q?okXKZQ5kLQZDD+2XvkU9wpL9nTyc4hl0cVWvozSGca69kFrA3pbvYhyaNA1S?=
 =?us-ascii?Q?VlhAdcPokY59j6qyIw6WvS8qxV9HIpJu3exvLIP7CFft5faDNluSNNxUVW9h?=
 =?us-ascii?Q?p+Ki46pAU7NvBWhoPLTcr4FFSa3yQdmj3M+mFR2jA7FI8GTm5GeYUCvhjSZO?=
 =?us-ascii?Q?dzDmMaXj+JWZRnynamhHLC2mbpD+500LQCzC9e8Y7zgJMaUA84BIKveqGAfW?=
 =?us-ascii?Q?KKUs5RSrsUWJfP+iOuUPuBN73dFwSv7OPEyozXwpgBXDQvMF4Y+CaMdpw10c?=
 =?us-ascii?Q?73m4DFrE0dYh9Fk5DKEDIiRC0LKAJYFQhGEIsGAcToEM4TJJ9/Kg9w/QQRV/?=
 =?us-ascii?Q?Qxt9SlVDPYgmRMmz11ji4726YnLYmwb32L+VupwNHRRNuG1K1x3ClUV6GxP9?=
 =?us-ascii?Q?IuNUxM9O0Dbd7e+h4lYXFkPlk/h8G9wLvWNNDjuwrrKLfnB8a7zUpcWNi1z+?=
 =?us-ascii?Q?WgrEbNCtFajQ4NTaSGtP0TVnfeWwPDjEX0tOmDhPGthDe+ULUYprxBF2hlQ5?=
 =?us-ascii?Q?rVp/kuQVvKxcGbNDV0ujBI3yqWO3cJcPWTP/hpkN79PD8xpdsWa2yepyEIEh?=
 =?us-ascii?Q?FwrYtKMqmhaIfeWbhnk44rxAR1H65QDjvhinKp90ELYTwD8u9Y/NopbDKp55?=
 =?us-ascii?Q?daAkYHXVlvGQgf+mAvfESwynovOsgD7o0mAgbB8HEQi7LbN0gpEApi/CQEkO?=
 =?us-ascii?Q?WhYgXkpsJE5GC1niHQZ7wICXw7OeezAzGgjRClCpYQxAvT7M11nabgf9+WZm?=
 =?us-ascii?Q?uu/zao2BVQtZaS4ZxN+yAWcRYoVCx8ooMMw7EpeIxhkxDpypGo4fl4Nevkoy?=
 =?us-ascii?Q?4kQvdmN3a0Bj2Q2iU+nqPy1bdSxL9ICwr11c4ZI6xjGsyt6lwNOqS5vphAII?=
 =?us-ascii?Q?g3CM9nF5qLg3gq31l6gzvGKYjg2W8BZd6i1p4yv/5OR55ZvTHcMZ3GWWvHyp?=
 =?us-ascii?Q?ZOsp5fj32vfum5+O0LAxNCMqZRpD1Xg1z9YEHvmJ5jvByOuKCj9QuKWUw/5o?=
 =?us-ascii?Q?djSxSUoKkPRmsRMlwop28MyaeG2GMU1282p/h+hMvqAg+t1RgmzXInZgdiaq?=
 =?us-ascii?Q?eF+SUdY6kwvtUWK2SLTUVdgHfJkAucn4wrH7LlD/RinC4y6/40KB2rMNulsm?=
 =?us-ascii?Q?rbpNDmIYFPp3TmShWrgd1jHTPn0hqsHab3fez5kdQwdwzo8o+NsZWTA1j/yW?=
 =?us-ascii?Q?fALU//S6Rye8LO+O1ZSzC+zJ0zv83pbXHV5CwqfU90N9IuLrAXqwuQi0gcwa?=
 =?us-ascii?Q?lEVSxdpUf1tXZ0Q8STw7UidSlygXB5gbYv1g4qLBj6T9z5vvuNQn6+6uaAiV?=
 =?us-ascii?Q?4RNYO37ReJqsPpDmP/lFu5iWUaCTfVKyKkWhWuJofqdbEnjMdPfLeLFC/swG?=
 =?us-ascii?Q?nF0fcmsiywVGD2C0TbjpeV5Z/s2quq9Kc8eVUaah0fJwKvBH65DiJYVWfqYd?=
 =?us-ascii?Q?BcsQJz9rM1Dl2KEQHlrj+RZd8v4aAK9hLm6t29Qms4uz0hD6I2NUrpJcy7zO?=
 =?us-ascii?Q?Un+ITjapRFqxJjPcUfuY8Bjhh0YQml5X/Vpj70fKQXigGFJMDKvU0n8algSq?=
 =?us-ascii?Q?ZBliWb1JD/396mvLWgvCJB0bE9WNy2RXQggQbIov4bz5mG5XeNmxe/TxOx5B?=
 =?us-ascii?Q?lDiE3Ao3BHR2yrkPymkL3EIUcAAefh4oBeKfZFbkdvzRPn6SLYod?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3262e45-7f41-47fa-29fd-08dea6a8a11e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:12.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIuQtmxuE5y1843gN8NLwBWzm3OllBERGCKiFhD8K3uQuUmQSult87soW07Qbbzrr0rsMwbvLMhQOo/nCSl5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 672E14A1834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7438-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hansenpartnership.com:email,acm.org:email,samsung.com:email,oracle.com:email]

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
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chanho Park <chanho61.park@samsung.com>

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
 drivers/ufs/host/ufs-exynos.c | 24 ++++++++++++++++++++----
 drivers/ufs/host/ufs-exynos.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 77a6c8e44485..be9bfde915ce 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -949,9 +949,10 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 
 	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
 
-	if (generic_phy->power_count) {
+	if (ufs->phy_powered_on) {
 		phy_power_off(generic_phy);
 		phy_exit(generic_phy);
+		ufs->phy_powered_on = false;
 	}
 
 	ret = phy_init(generic_phy);
@@ -965,6 +966,8 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
 	if (ret)
 		goto out_exit_phy;
 
+	ufs->phy_powered_on = true;
+
 	return 0;
 
 out_exit_phy:
@@ -1513,6 +1516,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
+	if (!ufs->phy_powered_on)
+		return;
+
 	phy_power_off(ufs->phy);
 	phy_exit(ufs->phy);
 }
@@ -1727,8 +1733,10 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (ufs->drv_data->suspend)
 		ufs->drv_data->suspend(ufs);
 
-	if (!ufshcd_is_link_active(hba))
+	if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
 		phy_power_off(ufs->phy);
+		ufs->phy_powered_on = false;
+	}
 
 	return 0;
 }
@@ -1736,9 +1744,17 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
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
2.34.1


