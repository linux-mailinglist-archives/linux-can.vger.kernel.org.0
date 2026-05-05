Return-Path: <linux-can+bounces-7488-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PN9I1K7+WmTCwMAu9opvQ
	(envelope-from <linux-can+bounces-7488-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:41:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF14C9FA6
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FEF9303DAAB
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83321018A;
	Tue,  5 May 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fNqw//8o"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75E32D0CF;
	Tue,  5 May 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973983; cv=fail; b=qSi1+XRpsDMr9PE+vRO758EXDHMMk6WolHWLmPDiiGOtGf0XQkDEHdSWml0dJqNi/5ZapP08E+ErjqUCT0B39mLDwoJAD0FjFU0was2y5/gCDCU/RV1Z9q9ukM84P/D5hJuAxKxLYwytDU3ZS/Gda78FRttuGtZZd4rQ1YRtleA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973983; c=relaxed/simple;
	bh=PIh/GC/2BJYDMm16KJGL4R29T4pbgIQzCQ0cAXkT7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SC08KkA0Awnnr/+vhVDtSYBh07f+aNQdbTH8LhIGlZ2r217eQ2sNup/SEYFuUQoTr54Cj+koTQGMQXRKt/A768rBiiSEbO9IyfcpIl+w8uIXk7CDTSG96IcCdkkbdvOnzVHNDJ7FEM26BOSmRvHcx/YyxZnx0tLjtdoP7lW88Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fNqw//8o; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMYYUycoO1/gMQEFOOA2EIYDiMz7fsLrlHDNvhteZeZGOLwmLfWrk+dJsLoqU/Ik/gnzMRw6wjqTHknJsiq8pLY/NUFBwNy3j0VMQFun0rP9Uby8md6rBkCO5AMmnmYRJmA3op6FjTyFHh7EmG/P9A22n7zzk2C/qCoKwFs08vMhiBGBvABIwAd6CXljaPEKhnCFjd0WJXnRG4ZPoqut35dz43aaX+Yc0cYH3Xab5Uyg46LTVaPCRcl5V3SqxlFNcV0Z7XSWMK6MYSQGnjnuFRfta7mzJa55rFrWo/TtBZlruf4o5LGq5RL2KP0NU+6J1KU1QNQ3szdScugm1TIoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277qg3AObcu3QT1JVkFDQjOH+nMDqxM36gB1RSDct9g=;
 b=NX3AxIcRb0wHi8ZwTBtfJVqxe7s1kz4XqExsy9RKWDAlGMYEh9y6YPPYn1tHFNLkY32tfB6bC0IbQ5OhUROBlHkfWVzU3tq+3Ebjvy3x/QtZ5N77eaTYm6b8heOyLWOwDNeGbTdSbpsNBIl4cvDluqAgnuODDXyS/9KkD86/cQSx8TnWJNT87eoyLhYoXMVGjbdiLS3hprI4kLv++qvSjjqsYoPrKAauzMia6JkMdI2UdZ65cA/xZ3AEXMUrWFz2448SS2IOm3YpCxC83rfdCNVycrTZJ5+4cxlV1qSRbW+7tM3TcqWk5ytLiCHBjDXf+770E9YR1wwE24ZOVdSwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277qg3AObcu3QT1JVkFDQjOH+nMDqxM36gB1RSDct9g=;
 b=fNqw//8om3zPuQkqPxH1WCNobvsnO2S6X+4lBJZYxc4Mlyd0eGnnLI28KuuNt1iISSS0jTSG2qsrEKNqfvkmlkqw8aUfRPTyI0oznPvF9h4MdCvcZlXB76WacZQ6R7mnaezdCN2Ilay6QEBS0QmrViDEQO8a3B1JlRNFSU7hHlUTBRg383Uz44XO4tpQOrWersV2SeBNX6FxvZv//erM9q8oPqugT7K7giczhwFTG6D07nDJk7qLqa/9cUmKhWR1n+F0Ovh8Nnu6h6OcVx09altFVbMzCJ3I/tXyfxBFdH7IiY/NAT2sNpvaMeg7wN/2ezpAxhsGz691YFR6JJd3JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9430.eurprd04.prod.outlook.com (2603:10a6:20b:4da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 09:39:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:39:29 +0000
Date: Tue, 5 May 2026 12:39:25 +0300
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>, Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 phy-next 13/27] usb: host: tegra: avoid direct
 dereference of phy->dev.of_node
Message-ID: <20260505093925.c3rshtu7hcuwglbp@skbuf>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
 <20260430110652.558622-14-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430110652.558622-14-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI6PEPF0000022E.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cc615d-4d54-4a9e-5d9f-08deaa8a3440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|10070799003|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	38M2IT60LoJeqjadxDMOTV49Rz/Q/ZTfKrCI1Im603XgRFxDwVr0mUxjypsLyS0Gjdz1vDqnzlLz4uN789cnJUTJ9gquU2wFTkP7Ga+NYna0oqB2ekBgE7w0sDMWZVwuZo+JVAnlQsyYUXbZWVmfe2UgMcG6yO81BBbglXMNXuoo06+2KbgfofhuCHMJUA7mIfrSk57ZLJVzoUth2ERIREAIAXdyrXnkgpJETc819ZRpg4HdFQNBNXuL6hkBXQZW51VvQTq4/Gz/YXwFMhqsB9RmP1ybBN+9uctxAIw+gRlcF//+4ODiiGharJ5q4+0m1n9KK6DO3LHuAUHADCjcpACUCLQ0JTYS72m9ICrYtk1aDpiydNwyNn9c0QAB7Or39+pT/tbFIXpx1Sh9HJ10KT1aglLlg5gSL7xFb0RIokn5mjO8ogVVdr/tj3A5ibYF6DhV5fWtFqRlh5WfkAURzIbnrQZDYEQ0mE7pc3wfR9ce82/UP7A7GCIG/RkRB3bJVfZFNHoP90hvknZq+IyvFX4+adKOPZZ1UMfhZYX6xR4yvYFgfrMqsKfrldshi/emWOuYZ2EHFSomA0RGn3JfFlk+AoaCE07H+veryofOfeBP4K1wKe11jvtb0dzdh7kAsg2bobMMWjsHvg6rpdmwQGEtP4ykfXUPfZGAlB16Zqp8U32Afg9OKbq4lz+Dc5jS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dPTaA+5r5psx7V5alPpED1xaxZ8uAkbUB4Dmgay5In3tuslKjiWYA0aieZHA?=
 =?us-ascii?Q?I/zGz9lp1AEyX1Gw2EQyxcWrblJNGohKxGSOMDojq1YlsQEtQWleE3ZlaNB4?=
 =?us-ascii?Q?MFXyCDFAP8Dw2GNceW8Sn4L9G+/QZ6poQ2u0GxsgN9CFv7rWKr1MjMLf39Hq?=
 =?us-ascii?Q?ATt3rLyg0tkuk1QCHs5BnUfMFoXc785WiFLtPnMj7bRSrA5qf2zXyxp7T2Mx?=
 =?us-ascii?Q?/bueFnctbE/sjc+qszllg2zhx9IJr93Jv9XN2gc+qO6F4AKPPLug2+S914xp?=
 =?us-ascii?Q?P7jGVAD2M8FchLiGanNysUGqirsURyLog0EZoI+zwSBTb/5nnMClZoLrNaqE?=
 =?us-ascii?Q?5IDX8asKX02/F0wAd9t1P4fWQJDqTN97auqbs3/xUaHZ+o1Ostv2bzeyQoUJ?=
 =?us-ascii?Q?24V5HNdpJbdizVw4+N78spKb8LMZzaspeKEh8GxZy/a9oovYIlN4URgX7hEW?=
 =?us-ascii?Q?wA3GMF8nXjzoQ3iMRqzPEfrNtIi+RoixEmXptkRW/CdceaKQr+DMdLgaLGfg?=
 =?us-ascii?Q?LorNyhD0wCkycvDuTO9UaZ4xPgrfEMCRPMWnE2Zlt12Agy5NUWt433qtVBnM?=
 =?us-ascii?Q?N9apVO5c62io7G2UYqICXOvHYcfYuhdwVxIS/DBsI14xCMAqIMXUL7rCWK2X?=
 =?us-ascii?Q?E4hiiaoIWkiyS3y/bkCJ6v1aSd+RDu0OWsUl6FIOzdhxNE2aU6ZAwYjgnwIJ?=
 =?us-ascii?Q?0hKY5lQ/XmslMneDOK02tpa7fMqhzrP5F4cZVTdEyc6I/TazsLjeWhA2tN9W?=
 =?us-ascii?Q?pJSA/AtHvoFBtx2hTH+kTmt1MCdQDe2E8mni82gNeuSNCAMlh2GQdrzw5cuL?=
 =?us-ascii?Q?/XyzNOo5to+m4He9VnoOsQsGeHeoQPcbn/KwoblvZl5Qu4xEQbO1pvPUai8e?=
 =?us-ascii?Q?jXghIQ2WWb5p8eM8LPhio1vSOTjNJqWdbWsN59a0Fz0Nrh4sDiyrIJrtqHCq?=
 =?us-ascii?Q?k+edNJ99Rdk9cUXT7yISwPO7eoBxepKe3jVLZUxA0AGT+PJxKrT/RgLVMd/x?=
 =?us-ascii?Q?Yik11HVxcQwGT+jdHBFElrS7jGGc4GjjtXZMmq41AIwhdNrZzOAKTnhF1tvk?=
 =?us-ascii?Q?H7Sx1VYgeB5Cc319/L+qWmbzidU90vj5b5y7FaotVUcnlWHBVLDkdet+K/iu?=
 =?us-ascii?Q?81fU4hupIT+A6fy23dFKeLxWgGnavtx65m+UG+dK9onav/+dEplxLI6EXTlr?=
 =?us-ascii?Q?ara8SIL/QV7D1FcFGZJRS2TQnh0bwCi96pYl4nF09Jtlr24wnJlIkf6PWJYz?=
 =?us-ascii?Q?/AAunJaQPFC6dHTjkk8XNFwEJiWr7KmzuneTxc+Mq7T358CcrQR2asYpkaeJ?=
 =?us-ascii?Q?LtfH2AFpWKSvsEuF3ylHSS46/pdFuvyuSub7Kskl0nWRhz4gxWCfy7DZY+Nl?=
 =?us-ascii?Q?VXUaRsJj2HU5T9aTWct2njXy7cuvKPhzZqSLitlt6WQW+wz+Vlhtqe9K14ky?=
 =?us-ascii?Q?bQ3YBho23lpvwxOXxJz4bJyK4K93t89gx+Z+bG8nZi1LohOonzpNqx9of8/I?=
 =?us-ascii?Q?2j2kMTP9TD1QeyDqFkaaZp7f69u64uMrbqcEW+t5KcKPnQZLCYlhkVgkNmru?=
 =?us-ascii?Q?kbOuhFeza9D9O+in9KA6NQ+B3QieHnItV2RWHE4d0VGZmjIXXdtd8GOSbqGh?=
 =?us-ascii?Q?y5emVwD7G+YxpeyYgvVrpEqijjJ4clX/9A8nrt9eq7G02Rtzdh4s8vHIPj9K?=
 =?us-ascii?Q?jqeP8DYmtAn53EO8bOlCifAaT3Z/oeImi7VbcOi+dVySEiyNPl5AwPFC9xoF?=
 =?us-ascii?Q?z/MFIpP5iDsOtmbnGBxWzsj36f1To1Qrajuh5ip7NdqnOmZVo8iZEnqEoWyF?=
X-MS-Exchange-AntiSpam-MessageData-1: sVhd5/P607flHRTB0MsDHPGVfpJkh3N5wRo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cc615d-4d54-4a9e-5d9f-08deaa8a3440
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:39:29.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqrZzUd7S4DMQ9zrpvq8vb3r/2wrya0Fl3CMZ/igUH0ZP0EbFTryFtMftkVQIWXPrZMvoKZB1Z6MbAIUvrDz8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9430
X-Rspamd-Queue-Id: E7AF14C9FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7488-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,args.np:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sashiko says:
> commit 037a329bd1e70f26b8d861fb06f3bbc539fb2c49
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> usb: host: tegra: avoid direct dereference of phy->dev.of_node
> 
> This commit updates the Tegra USB host driver to retrieve the PHY OF node
> using the "phys" phandle rather than directly accessing phy->dev.of_node.
> This addresses an upcoming change where struct phy will become an opaque
> pointer. It also simplifies a debug message to log the array index.
> 
> > diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> > index d2214d309e96..99b0ac9763f9 100644
> > --- a/drivers/usb/host/xhci-tegra.c
> > +++ b/drivers/usb/host/xhci-tegra.c
> > @@ -1491,6 +1491,7 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
> >  
> >  static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
> >  {
> > +	struct device_node *np = dev_of_node(tegra->dev);
> >  	unsigned int i;
> >  
> >  	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
> > @@ -1504,23 +1505,33 @@ static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
> >  	tegra->otg_usb3_port = -EINVAL;
> >  
> >  	for (i = 0; i < tegra->num_usb_phys; i++) {
> > -		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
> > +		struct of_phandle_args args;
> > +		struct usb_phy *usbphy;
> > +		int index, err;
> > +		char prop[8];
> >  
> > -		if (!phy)
> > +		snprintf(prop, sizeof(prop), "usb2-%d", i);
> > +
> > +		/*
> > +		 * usb-phy is optional, continue if it's not available.
> > +		 */
> > +		index = of_property_match_string(np, "phy-names", prop);
> > +		if (index < 0)
> >  			continue;
> >  
> > -		tegra->usbphy[i] = devm_usb_get_phy_by_node(tegra->dev,
> > -							phy->dev.of_node,
> > -							&tegra->id_nb);
> > -		if (!IS_ERR(tegra->usbphy[i])) {
> > -			dev_dbg(tegra->dev, "usbphy-%d registered", i);
> > -			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
> > -		} else {
> > -			/*
> > -			 * usb-phy is optional, continue if its not available.
> > -			 */
> > -			tegra->usbphy[i] = NULL;
> > -		}
> > +		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
> > +						 index, &args);
> > +		if (err)
> > +			continue;
> 
> The call to of_parse_phandle_with_args() increments the reference count
> of the device tree node and populates it in args.np. The new code passes
> args.np to devm_usb_get_phy_by_node(), but does not appear to call
> of_node_put() to drop the reference when it is done. Does this leak the
> device node reference on both the success and error paths of the loop?

I've added an of_node_put(args.np) after devm_usb_get_phy_by_node() for v8.

> > +
> > +		usbphy = devm_usb_get_phy_by_node(tegra->dev, args.np,
> > +						  &tegra->id_nb);
> 
> Also in tegra_xusb_init_usb_phy(), the single notifier block instance
> tegra->id_nb is passed to devm_usb_get_phy_by_node() for every USB PHY
> being processed. Because the struct notifier_block API uses an embedded next
> pointer for its singly-linked list, does registering the exact same object
> to multiple independent PHY notifier chains overwrite its next pointer and
> corrupt the lists?

If this is a problem, it is a pre-existing and completely unrelated
problem which I don't have knowledge how to handle, so I will leave it
alone.

> > +		if (IS_ERR(usbphy))
> > +			continue;
> > +
> > +		tegra->usbphy[i] = usbphy;
> > +		dev_dbg(tegra->dev, "usbphy-%d registered", i);
> > +		otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
> >  	}
> >  
> >  	return 0;
> [...]
> >  drivers/usb/host/xhci-tegra.c | 42 ++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 16 deletions(-)
> > 
> > @@ -2168,8 +2179,7 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
> >  			continue;
> >  
> >  		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
> > -			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
> > -				tegra->phys[i]->dev.of_node);
> > +			dev_dbg(tegra->dev, "PHY %d remote wake detected\n", i);
> >  
> >  		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
> >  	}
> 
> In tegra_xhci_disable_phy_wake(), the loop counter i is declared as an
> unsigned int. The updated dev_dbg() message formats this variable using
> the %d specifier. This isn't a bug since the values are bounded by
> tegra->num_phys, but should it use %u to match the unsigned integer type?

I've changed to %u printing for v8.

