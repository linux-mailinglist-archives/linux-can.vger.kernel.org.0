Return-Path: <linux-can+bounces-7481-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCN2LfCH+GkZwQIAu9opvQ
	(envelope-from <linux-can+bounces-7481-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 13:50:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628044BC9DA
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 13:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D87930056FB
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC803C13E9;
	Mon,  4 May 2026 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYbtJvg7"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AD212FAD;
	Mon,  4 May 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895318; cv=fail; b=o8/XzwYye3d7+sHsOBbEy+3Fk7ypN3qw962rhv4n8WCkNEEWie6kqQPw6QwW+E+4ToyV+JUsMm4dowNAp5q2bMyMI5f3Q7XqG+PRxve/M5Gmdm6s3Qo2ODU+H3a8hzEqlyNJ6/9C3SIeFqyw0JOm0OWWSF5ajxKwDNd12ht/VP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895318; c=relaxed/simple;
	bh=0z0usvvJxmIeP0lSVniP1a86lhKtOVSjXfvDBLv1V4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=niPo/JmrbfmIAVwLgNfmagRz4pRtH13Q9FGq0/fKAo6Bt/6xmYYeIi6MRBvFBWwsFunLTVXQgsARJyUZwjIrVe/VQ9jlXF/S+4DbRtAR0pi78G1162WHqwfTFoopzbzZ2+Wk6O/m48k8YhEbw4BxjUQtDzwCX+w4AHa9LGbJRRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dYbtJvg7; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQJulNwV79eiJkukHZtU177gTLEEzbXtSPnDwgYMvyne3+Mh8AQXCXx1dwJyVFeAcqpdKJ537BAq1bVtfJQkeiXQkbu5+yaGzI3cRfztQE0MVDPFa1gaNHRfFmp0E8WBnE1X6QVkBfcy8LdkcEBm388ADdHtB+g706Hz2ZyF5XCrjM5eF5O9lvEFLYaDCbHzPVcJFWtm5AnMmuK6eT3/GE9rlKPDnS6jJ6r+elcHDAZMO0OjIddJp7dPVKikPDK6jLndrGP9OwUgcjyvYNF/JPQ2XV4FdZiXKoVmfv/ahXiHXIUneSSdMyEuydzsgRRcHM+9hjjNL/BRNyloB484tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuJ5TrsI/7xa0NUQqdrHUy+n3N/zC1iSMjSRl4BbBNs=;
 b=uWmBYV8wL6vN/aaTb0heieb4Ntd7G3A9WXZUtaa2ueos5GMMffFcCCed8F75DOG1v6usXYwOyt/s8WZvpWz5Uo2IzhZPBR4cNWU7vrolT4esPg4L4Mv9J9bsVyCaoKSyQyIgLTvc9n/dB+lnN7x99bNKSjJ9pkueDeAHJeT/EL/++61MVyBW7ZfjCaWUYsxKYBmTht09rBt9eMiI5m/SO77TBef7PsNKPmtNvyYtRnFJRF9Qktj0S2kdz8WDHHEfLecKIZFrGnUaDmppwP/tp2tvXNgN1H6yFbzI61V5exyFXqP/714DSpW0Xs9wpJR/rSXTRlWOcBZ5X6988rec/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuJ5TrsI/7xa0NUQqdrHUy+n3N/zC1iSMjSRl4BbBNs=;
 b=dYbtJvg77mI8SWmWDrlL7pWGMAg96UvtIle1GKLgLMaNYc3UfmEaCPrVKCq5qOJ/pW6UXWZQTLwUhJNCd6eXodFZ0hnAHvGjXUOHg+jhnmsV45U7qU3L2QqpsP1GHw+mc4judm1guQy3i4SD7Ef/36Twlp1eZLQSgZ4gPN9J1CGoPq1C9L1ZnHaCqIp3lgKpqe+/sVGwQk3N11VtwkptDylaoCqCEHrNYj/c97b57icmY4SG/oH9xfG/SxC/yYz710AsBixGJkQP2H+r5dGBdKiqTAv/PV9VU1GfEPcLBIbUA0Sy35hnNEZOwN1bw+gHNaLtWKOGV8sMHbEKpET6xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10286.eurprd04.prod.outlook.com (2603:10a6:800:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:48:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 11:48:32 +0000
Date: Mon, 4 May 2026 14:48:28 +0300
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
	Bart Van Assche <bvanassche@acm.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v7 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Message-ID: <20260504114828.n7r7kujaegusdkbw@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-10-vladimir.oltean@nxp.com>
Content-Type: multipart/mixed; boundary="oquvkzttypru676v"
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-10-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VIXP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10286:EE_
X-MS-Office365-Filtering-Correlation-Id: fad5a451-f99b-4b4e-5a49-08dea9d310da
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|6049299003|19092799006|7416014|376014|10070799003|1800799024|4053099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 qDLPZu5qYj9KN27LUIv3EUhwOORB6LjoJgGq88OqyxSbx4QbMN6GWl4xaxhh7CBm6Paj9Nb3+Fb0q6S8UhgFEti0SUMIINjAafDJWeUWD9OPiVrlPEeFeLW7IRyshjpySWcoFlTOLOXGA6jTmV8r9Ri4YOBI9hP060w0ViigKdG0vp9owYHWlpRQ3/fPWwpPfK3CrmUr+ZwmfrTE+OduX3EjD3fVoV7y5nJZ4H5jgAMN9YikY0LCVj87hKi5gqoiEdcs4STC9WZEHeOuUA9uuqGcYgYmIH6Xc6CP2E7NFo/t+5TXCSEfTtnx0MS1mf3Jm2WZrd9vySsMe6mWHJBwoFC2HebuAWSEvSF57fbSp/HdDSiD0Lm9q54Irea2rnSwUItMSJMFz4xt68ZGiayi+a/qHWF7Pa2kRUMaLkoZe2doMtXvSuWRYpH2IDOL6zb/6sMwSWUXjESKQNciEcCyqjQZwfFNOdeWVoB8S523MMUvqOBRvqrQcAjvj3RnN5EGeDHh/5+1AzA5Qiuppwa7Omge/+17eAjJUGKkvwNkuJzEz5etCinwDvwJo2kyXS0cSxrw/PnozTkX6xtaVb16u6LQwDKypVszkDZJza17dx++i09FW4qClFDT2zaHPO+L/J3M/dp8ILU+ANb/MThLmMu7a0OZWp4Cp11PqVuIyGG6iMrKUxxz4Ez+8nbyKELh
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(6049299003)(19092799006)(7416014)(376014)(10070799003)(1800799024)(4053099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?b+vjs4nLpKCTHK7OBy8RtNuxJBaaLoShYtumy2aCVMblYmFrZR86GQUXpSK6?=
 =?us-ascii?Q?oepI6W2vxB8SANoZEkfaWJcwYFznGh3Kom6KmvFkPXhQnsAJyyG9i4YXt6Nq?=
 =?us-ascii?Q?H4eheO3rSp2c/XcceJJMWETW3qOppAAa87+4exocQPiKkmo6EG9Dtl2Ap4iG?=
 =?us-ascii?Q?QTSR5XHeOaphAHzwNbeq2dBObQh2aiM9vbtSvmDdHBYkz8zxVSdgxmXkbEQ6?=
 =?us-ascii?Q?9Wn63hI2PBL+dHzHMqn3xET61VSq63SElL8bctKPNFg1n2RJz2+KSONlGiIo?=
 =?us-ascii?Q?kpM6k+QoDqqIQw5DqMEpeg3hIkinVNDZEOwsFpqPlAObq9/KSRrBBIWNlD5e?=
 =?us-ascii?Q?/ymSAT9uUjVL6fsIy/qT8B+7d91L2uNyDeNxI3F9MARXODDF0xsZ4fnVOJ8V?=
 =?us-ascii?Q?jsUwMLLrmxB28Vcu5ZSAlmkCrW7QLnEFAKTb/dF0BRoh6fMBMACMHp/TVFM3?=
 =?us-ascii?Q?WC+Sxw3PFtHLNw9/DA43E47HY2gUv2T5pVwsk48CqZjBnd7QZVPlewf8ezw7?=
 =?us-ascii?Q?iov1MplVQc2xgtTOnbT425h0UBUzaVW0WWnbwc5Pa0lQDbOazNqhxU/ha0UM?=
 =?us-ascii?Q?imlUpbK7NPmZYv/p9mQXW+uQiVaT94AFeE0Mz2ZkZKeJqJbZnI3ZcYJ77w2B?=
 =?us-ascii?Q?pGm7J26qYV2KtPekkjSHAz+v79JyEn+V1PbzJFdZc2vaiAh+tcmWdG/6066p?=
 =?us-ascii?Q?chBIdIkiexDzS1SxRQzkMZelQIUAH54/ZF7SJOd4mWQmABasusKuLF2zmXrI?=
 =?us-ascii?Q?ivBquIRIIRE3pKLQBaYaGxTU+HeiZzN9DknUbUglEYFLGOMeEOnTz3DzdAl2?=
 =?us-ascii?Q?CYH/Cd9JBo4iiDQ+9mywmQNKV1kz5mDAKh3u4StYUPXJac2m6iZP6qWup8o2?=
 =?us-ascii?Q?lI2rlbxGekw4lqz0Q2agXYCrbsJwrjh9BWh1RhFG1bgH2Ra3upFgxSFYU+PM?=
 =?us-ascii?Q?UDQoORL7wdHFEGIxukdtX7kIsr8cfRoYVpKupKwXOR6u3/SYQS9oW9ceJVJe?=
 =?us-ascii?Q?QpEZFHQlA4UpOX7eUu9iFrVwFTNIFaJ0VxZQXB2Q6SSBUkbhmpZRlEal0Dff?=
 =?us-ascii?Q?VtHJZH2SnaXnVAc1Rl1LmBimecCaaRwuZEpX19UvE5T575uX7/xmxL2ufTaf?=
 =?us-ascii?Q?pydJBEyiayWk2nJ8FGEwVsJUUwTu+FEXFJXYHRlH2uQQG9JtRPI3oGhX8iF1?=
 =?us-ascii?Q?AWNsvlmlc91oCSzaLRziIxFVXIkwhdTANxxEOkBcSbeOOBq4zyv+iRyi+eJ1?=
 =?us-ascii?Q?69F092bXIedwiwJmbBErphD3pJQmdRLPgjOiE6c71m84kHFPX8IYVLXOC0bb?=
 =?us-ascii?Q?cUvwfcYoN7HNS+eQQsfn3ugl5y1et5fCagCoN7eu7y1VgLrRDOEzO5hFwqRg?=
 =?us-ascii?Q?NmSbNCDXn7PCT9v+xwy8wX2TnGG+Y2jhh6k6KnLhh090Y3pdy4xA02iwGvcH?=
 =?us-ascii?Q?SXwWQ+Jchp1vOBpe091eSo6khn84VTZci0nSN7RmtoamNSsV3+mb7HZLf2Qm?=
 =?us-ascii?Q?PPSCAgQfySin78HBVuaCJwsQC+saeTnat3ZNB121ZMrfYtItvBqGO8qMe9xz?=
 =?us-ascii?Q?EzjOtmJU5T4nud/PxzZHWVILtmitdCI1XV88i4IzMvuf3tt3HyQ3GWav8Qn3?=
 =?us-ascii?Q?g2lrLaEXN8UUxfWO2ocs6QvLAE3Rpg1vf0Hw1kvgRrjNoR2ZTRh29dOxjZb+?=
 =?us-ascii?Q?/26ERto3tUOVzlIX793VFUu55jjQzzN0jVig9a2um6+MyRV6NF0ECiWjh1Jn?=
 =?us-ascii?Q?wyjbhu/w9kEhsWkUq8XmeXThly4hrxUfLU1Mn1w+u419+L7DI3v23aMbEj92?=
X-MS-Exchange-AntiSpam-MessageData-1: po77R0ECpxvMqA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad5a451-f99b-4b4e-5a49-08dea9d310da
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:48:32.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owIwq/kM2PqBPikT4lRxifucAefCEGeCRaQpBogOvxGbkXJcadWu7qrGZ9IJTp3cZ8/zuiJ1tGZGUaYa6Mx+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10286
X-Rspamd-Queue-Id: 628044BC9DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7481-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,sashiko.dev:url,oracle.com:email,acm.org:email]

--oquvkzttypru676v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sashiko says:
> commit 76ded6c0290bdb192c2ae1af9a2e6a47fc39c9a1
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> scsi: ufs: exynos: stop poking into struct phy guts
> This commit modifies the Exynos UFS driver to stop directly accessing the
> generic PHY's power_count. Instead, it tracks the PHY power state internally
> using a new phy_powered_on flag to properly handle link retries and
> suspend/resume operations.
> 
> > diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> > --- a/drivers/ufs/host/ufs-exynos.c
> > +++ b/drivers/ufs/host/ufs-exynos.c
> [ ... ]
> > @@ -1513,6 +1516,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
> >  {
> >  	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
> >
> > +	if (!ufs->phy_powered_on)
> > +		return;
> > +
> >  	phy_power_off(ufs->phy);
> >  	phy_exit(ufs->phy);
> >  }
> 
> Does this introduce a regression where initialization resources are leaked
> if the driver is unbound while suspended?
> Looking at exynos_ufs_suspend(), the PHY is powered off and phy_powered_on
> is set to false, but phy_exit() is intentionally not called so the PHY
> remains initialized:
> exynos_ufs_suspend()
>         if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
>                 phy_power_off(ufs->phy);
>                 ufs->phy_powered_on = false;
>         }
> If an unbind or fatal error occurs while in this suspended state,
> exynos_ufs_exit() will see phy_powered_on as false and return immediately.
> The initialization reference and any resources allocated by phy_init()
> would never be released since phy_exit() is completely skipped.
> [ ... ]

I think I've been looking at this issue all wrong, not considering why
the UFS HCD driver calls phy_exit() -> phy_init() at runtime and what
can be done about that.

I have replaced this patch with the one attached, which I will be sending
for v8.

--oquvkzttypru676v
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-scsi-ufs-exynos-use-dedicated-API-for-updating-PHY-b.patch"

From c687a8568c6c7837bb0bd539bf14343d7d0c63a1 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 4 May 2026 14:00:51 +0300
Subject: [PATCH] scsi: ufs: exynos: use dedicated API for updating PHY bus
 width

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
    calls") clearly states so.
(2) phy_set_bus_width() only alters phy->attrs.bus_width, and does not
    call into phy_ops at all. So a consumer that makes a call to
    phy_set_bus_width() will not produce any hardware change in the
    provider at all.

This is where the Exynos UFS HCD driver decided to be creative and
hijacked phy_init() to pick up the bus_width attribute.

This requires a very careful dance where the PHY consumer needs to
simultaneously juggle two requirements:
- the UFS PHY needs to pick up the updated lane count in its
  samsung_ufs_phy_init() handler for the phy_init() call
- phy_init() calls need to be balanced with phy_exit(), otherwise
  subsequent phy_init() calls don't make it into samsung_ufs_phy_init()
  and just leave the PHY with an elevated init_count
- phy_power_on() can't be called without phy_init()

This is why the following bug fix commits exist:
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

Then we are much more free to call phy_init() from wherever we want, and
same goes for phy_power_on().

It is typical to call phy_init() right after phy_get(), and doing so
will naturally balance it with phy_exit().

We can also leave the phy_power_on() call to be on demand, placed inside
exynos_ufs_pre_link(). Because this call can be made multiple times and
is not balanced with anything else, we need a consumer-specific "bool
phy_powered_on" which ensures that we call phy_power_on() at most once,
and that exynos_ufs_exit() only calls phy_power_off() if phy_power_on()
was previously called. Using the phy->power_count for this purpose is
undesirable because
(a) it is going away
(b) the PHY API supports multiple consumers for the same provider, so it
    cannot offer an equivalent helper because it doesn't want consumers
    to interfere with each other

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
 drivers/phy/phy-core.c                | 18 +++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 30 ++++++++++++------
 drivers/ufs/host/ufs-exynos.c         | 45 ++++++++++++++++++++++-----
 drivers/ufs/host/ufs-exynos.h         |  1 +
 4 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 21aaf2f76e53..6305efe210d6 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -606,6 +606,24 @@ int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
 }
 EXPORT_SYMBOL_GPL(phy_validate);
 
+int phy_request_bus_width(struct phy *phy, int bus_width)
+{
+	int ret;
+
+	if (!phy)
+		return -EINVAL;
+
+	if (!phy->ops->request_bus_width)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->request_bus_width(phy, bus_width);
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
index 00e570d699f3..5d7b842bff1a 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -161,16 +161,6 @@ static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy)
 	return devm_clk_bulk_get(phy->dev, num_clks, phy->clks);
 }
 
-static int samsung_ufs_phy_request_bus_width(struct phy *phy, int bus_width)
-{
-	if (bus_width != 1 && bus_width != 2)
-		return -EINVAL;
-
-	ss_phy->lane_cnt = phy->attrs.bus_width;
-
-	return 0;
-}
-
 static int samsung_ufs_phy_init(struct phy *phy)
 {
 	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
@@ -213,6 +203,26 @@ static int samsung_ufs_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int samsung_ufs_phy_request_bus_width(struct phy *phy, int bus_width)
+{
+	struct samsung_ufs_phy *ss_phy = get_samsung_ufs_phy(phy);
+
+	if (bus_width != 1 && bus_width != 2)
+		return -EINVAL;
+
+	ss_phy->lane_cnt = phy->attrs.bus_width;
+
+	if (phy->init_count)
+		samsung_ufs_phy_init(phy);
+
+	if (phy->power_count) {
+		samsung_ufs_phy_power_off(phy);
+		return samsung_ufs_phy_power_on(phy);
+	}
+
+	return 0;
+}
+
 static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
 				    enum phy_mode mode, int submode)
 {
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index fb616d1599eb..b90876b268db 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -959,6 +959,40 @@ static void exynos_ufs_phy_exit(struct exynos_ufs *ufs)
 	phy_exit(ufs->phy);
 }
 
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
 static int exynos_ufs_phy_update_bus_width(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
@@ -979,10 +1013,7 @@ static int exynos_ufs_phy_update_bus_width(struct exynos_ufs *ufs)
 	if (ret)
 		return ret;
 
-	if (generic_phy->power_count)
-		phy_power_off(generic_phy);
-
-	return phy_power_on(generic_phy);
+	return exynos_ufs_phy_power_on(ufs);
 }
 
 static void exynos_ufs_config_unipro(struct exynos_ufs *ufs)
@@ -1524,7 +1555,7 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
-	phy_power_off(ufs->phy);
+	exynos_ufs_phy_power_off(ufs);
 	exynos_ufs_phy_exit(ufs);
 }
 
@@ -1739,7 +1770,7 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 		ufs->drv_data->suspend(ufs);
 
 	if (!ufshcd_is_link_active(hba))
-		phy_power_off(ufs->phy);
+		exynos_ufs_phy_power_off(ufs);
 
 	return 0;
 }
@@ -1749,7 +1780,7 @@ static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
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
-- 
2.34.1


--oquvkzttypru676v--

