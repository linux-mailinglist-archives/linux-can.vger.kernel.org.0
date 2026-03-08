Return-Path: <linux-can+bounces-7022-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBMfC5XirWks8wEAu9opvQ
	(envelope-from <linux-can+bounces-7022-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 21:56:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F2232388
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 21:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C96300A3AB
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632D3559E8;
	Sun,  8 Mar 2026 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dstguewP"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C5328B58;
	Sun,  8 Mar 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003393; cv=fail; b=T6toPlM+3Ky27v7yNFZpIlgOkYQavry/Lb1krjQJ+fnbRaKDk5JJl+CZrIcw3yZEWf5zyo2Hm6uwYGDl0WJPB9L4tS6/JLwxZBqJIwZFzKS1BuV/4FDGNOZFV6R+U4Sg6xwaAu8DSRG9W+1utpn6neaEiNb138tOPJzYzc1sncQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003393; c=relaxed/simple;
	bh=Lu5FL92CypXBlymOj3P+0NA1LHmcZGrX69EnS95Pw+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmJ3FE6Rmpl3Daha6hnDxYXl8Efe6TcDviqhdBtIy4lstiweEIKOsM8KvKaIREAFoK0vSgV5JXIqFCqzLM1o9twvKIOqkin/IcIr29nmPtXfhZPvo7/LsdJNggBuBPYnTD+Z+btFEuBXsMM5eZcXr2wjiy6XiKkgWH0ymXNbr+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dstguewP; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo8X9iE0eELA/OhvLtUFhhssqBDZHZiJ5xChzaw393s8RmArAET3iLouBghW8ZeG0zW1N7UffrGClCKKBB1tHpEraea9Hhrrn+t9I5qbqCk29EGYla2aZ8O+rvUc/ggDJWOcgnRbxTHQvdBMybTCKJ8/smgqcExdNxvoJ9yPO1uCQ/FWis2lG8Yn7BdA/TS1oiQ8bjC0t6ObVN305jX6vPEAeglkRq6ENMhzoIiKNPZd1i1pDCi47quKNDDqs/C//q4fGwaf9cLktFJUo7k+OKWk6QVNnA64RIu/G3Z5ULpSYV5/QCY5ZCVAK4mp/kccAD1JeFmoeL9aWa9FSfYfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiKjX9b4qTdw3LK0Vrp5VK/gMgqjsTVPze0p47BFYNo=;
 b=uJ+Nwzj25OWA8HZ653TIwP1z+/j1ApzcMv2kcIFG9PT4+GfQjhAimZHsZVhhXbcC5dLjROdxsyB22SIgnKOwrDjyi3rBCkIVLk+BUSIb69wHWPgNaEJ/xjXEU0G+FJLujIbT9twgJ2MYX09CKbENxkzERO6vhadr801ak4PScn56vVaLDnrcvy/26DTTPDlpQU4GNUlC2QVC31vKFSP1MI9fTxzwqs42llrP1IjtGO/Na/zSe4AxLhbgMOecszKzGruZCKApztTx8bMOjHv+SioRSha23TT7krMwupgKw4fg+g6HqmEdD0UOX17ZuqfsjtTsNjI8AQ0DLKU8h8+V0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiKjX9b4qTdw3LK0Vrp5VK/gMgqjsTVPze0p47BFYNo=;
 b=dstguewPE/Q7m1vwMS9UTIMlTHkH5N5MKq0Aa6xhPT+/aHpk1Q93ogGRoQg6W8W6wft2FTY4un3dgTkiBfvCxW50IPCMgirwmumBj9Tk9INnY1cryYQMLcU8eRqvVzzKCshf2BphbzEPBB4354reEW7rd5chVwQOBfA2Hligu+23QcnWFyLIwWdwwpJxeJVlBLvQBVWT0OD3RUkqwsL3h5RzHk3mkbms0lqTOFnoaiZnB/Yq8frcdl6NPI7ntHzF4cz1KeOc0fgSoQqudiXRY0SwqYsVnLlxFLMzJwZQ8/G1JwHdyjGnLW+fPAQJY+Pj5tS/grJAKskjmglLgNZDuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU4PR04MB12129.eurprd04.prod.outlook.com (2603:10a6:10:643::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Sun, 8 Mar
 2026 20:56:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Sun, 8 Mar 2026
 20:56:27 +0000
Date: Sun, 8 Mar 2026 22:56:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Joe Perches <joe@perches.com>
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
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 phy-next 24/24] MAINTAINERS: add regexes for linux-phy
Message-ID: <20260308205623.5trrqdmdrzj744hi@skbuf>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
 <20260308114009.2546587-25-vladimir.oltean@nxp.com>
 <ca170cbaf2f8bcbc89bbda68914d8e0d7640f0e7.camel@perches.com>
 <20260308191017.kcyi7ka5pktq5jl4@skbuf>
 <8c4c5d0c5d014d5cc19eb10906ca1bd83ffb3ce5.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4c5d0c5d014d5cc19eb10906ca1bd83ffb3ce5.camel@perches.com>
X-ClientProxiedBy: WA0P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::27) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU4PR04MB12129:EE_
X-MS-Office365-Filtering-Correlation-Id: 317a3d24-7599-4695-9d39-08de7d552abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	xrXObWncWD0pm8w97wNTtsEbOQoInE71snSZ5upiSu4AXezV0Wyes/620mdvd/owynHyLgob7KqFoIWP7gwuSiEQXw93uHTK+7nLOscE0MIbPHfSM4R37Cc4/fXOpmJvKxbcfRvDVEAKfOKK+PqfyIzc9ddphye22sbu4DrY0Ql1f9o3faEl3TAN28+WXsoqejjUHX6St5CavIayu56Ot3ImeFMvo9E1cHaSGHChOj3nTdt6mQVvJX6YdYQ8RjXVFwWr7D/zBTuTrF9vhEqK24Ts2mvHSipWEgMgD37k9LhRJlyTFBJ4fAEW9XAf79ZtXeVMVH9FZccKoq8xYqMb9T0dY1bIbxhg5PuYtqFCu8vxtq9cHk4j3TxjxLn/Ho5yVv9WAuxxGOYXxHDRu9t9QebCviMF6m4LauHBVfqnafdxU3inj6qK6eDbBww17q3IG8lk9hegESc7Fh7ZsR3kRgeOisbF5Z2aIwUpIXTvzJ9S9YzmFS5qm/nzHJgibONH50S8uzQ9tv8kMw8xpwk8N4Hx1j7oi9cTvMduKoLaTBaMqmW+rAM7UVoqHbsf+6QsvqH776XBTDKVaHoyRz02bxpLTPXHlbx42Mh3pU47EjL8f65Aclgx3knDB4qs1n0Bl/6jCYPlxbmGOJRLJOeSxgaXat3cReZKAf/3S1M4MZ/30yDa6TOJVnnlMvr+2/LzCagnhxRUkbbYDwVgzR9bYGYd6GU9kmLG0EuBwVwMmj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TZZFdSjQSRqrzN+PWIULUYPdD7LwNgG/xURVb9lxkVOaPEZI3CGMmPVWa6J?=
 =?us-ascii?Q?e3IBkUCANygTUHSUrysJ/241Fm1t14JwyRCg52VLUKOkFWqjOm/TCUX6cXrh?=
 =?us-ascii?Q?xG/65On7sxcIneZs/5JCC/syoWkpbGCfN70LUOJVHIVnGeFb+wttTkAfTJfX?=
 =?us-ascii?Q?iuAnm5jlUq8YNH1I5b/01Ar7UA33ewpHLiDsOo1fkUucR04belU35XfBILrB?=
 =?us-ascii?Q?ti7NLvniuN4hksKzCOR/2LGGtgoZY/m2T+fkjKsjycRUfzE+REDETHoYf3Xo?=
 =?us-ascii?Q?iXqWuknF+n+NA2GgKb+N5qlv1bZp9/TQRCx7ul9bwsICxqG2cnGuXEyVximo?=
 =?us-ascii?Q?CcIsRKeBPf8G4/XCxHZhLnlZJZfoY2tZet6CavznIDDU5Ylg/5HHmf9l0JBa?=
 =?us-ascii?Q?OAnRFNjVQZlpF2TfYM+rlk2nsh8N0oQX66CFFsM7U3VwiFw56EfkbcMbYqnO?=
 =?us-ascii?Q?C9p9Nua/rA9Mk2TaqsqsLD4ATJbKAUMamedJo4NRdC5BqiTje0YNIkTuNpyX?=
 =?us-ascii?Q?wPDLfcouyJsGJalReQnkukO1pYM7melPq+kifYF+r3SNU1a29ioIzidOAsTF?=
 =?us-ascii?Q?5FgJPpLH5QCPF+YVNJH7GjJ8ZnioY2OIUcGKWeJQkE9OZpcBnARCmXcVIjpv?=
 =?us-ascii?Q?HGtG4ZBoFzhnhg60y5dJ9Gxo+30RA25Y9d1WTiak2C2rUL8GL7KZLgdnr3uI?=
 =?us-ascii?Q?O2txQShF6j6B4kSSm1WixmF5lzTV1dC+Wg1DCAuevgd8rH4KRJuyg4WRS2Qr?=
 =?us-ascii?Q?aIGzqOrWk55bOGqJ5roBPV0cgWSL8Fw6YFu5DRMwmgXFv9rZtWNzrGewXhS2?=
 =?us-ascii?Q?1z7HEJrs/niWvt5k9dyjOoaQfc/L7AIBbkXkeEyXpGR41f8D+dVVBuMY16Ue?=
 =?us-ascii?Q?aSYRFx7HdZqfkX9R3WMk0L51qNf4CZVa9U3DtuljR5TEOZ92p/udPiJConUh?=
 =?us-ascii?Q?DFSTkQMJ8MI1/COs25Ey9uAzsIYO3QVM0/iXHcFHpI8L8RMfJQL03UTYdXFI?=
 =?us-ascii?Q?kimG4F4mqzgnnyKAmvgOEWDd7FbZJVP2EDgB1lstewjd0WkXmBIWUx5+fqA6?=
 =?us-ascii?Q?rNbhbwZUdHY3Quh0fKFPNKXR1asJQ+1f+ialo2BUBGtzTcn/whYjG3LiL+7S?=
 =?us-ascii?Q?zezTECVzZrK7Xxmte5JbiwgRdHYYkeAgqIbO2lmCu3oFpC6LqWXcT/rmuN5Z?=
 =?us-ascii?Q?isUWw9IfejnQxp/563n9Mtzfcd36eRsNZoW03KRwVpKq+VYCNUFkhvrTTVz4?=
 =?us-ascii?Q?b1b4eADkEDEP2z0Yuq8eaZ0T7b4qYV5OPJNs4XIOMLOGc2ZEzOyDuHEhPFM2?=
 =?us-ascii?Q?z+O6gkmSFR6KUW5QOcqqSWEPhDXXg5GnnprnH3d9T9k+NuZFXlAJNKL0ru13?=
 =?us-ascii?Q?9c1V9mqT5CCFjhTPJy+dx09BcJQBSYG+rDtBT9t23o52aOYZsA4G0NtDx4/+?=
 =?us-ascii?Q?N4RmGOBMIGwZzkyrrY3RN9z+nZdBFyR1Ag4ctJsXTSS2foctorpv1LCEq2EY?=
 =?us-ascii?Q?7ME11dUrXLjlTYIAlI/k04d06RgwY0PdEb+JKX9I7yVVKLl7yI38Xuxbrcpj?=
 =?us-ascii?Q?F9eZ8DMXWfCdosBLa03HmZ1HTwNRtFPVmompdYVbTCZ2S+C2iMfdPufVLGzL?=
 =?us-ascii?Q?hsisAJr04wrC1DExCnF+F2cVz0AjVUTHMx/HdCn+q1BrZtx5Kbdj2NtgnYwh?=
 =?us-ascii?Q?OceY5YnywSuXXDn8B9STHU4wtimjp8oi1AfAU3LivadaSQJw60VWDR/z/JEe?=
 =?us-ascii?Q?jJ+qsZ1a9TT7Zo4o4A9v6svqzAiW63e0sMVQru2ulaij2kpqj0Ai4ltismu1?=
X-MS-Exchange-AntiSpam-MessageData-1: GwLrVc9O53HfrJRFbQ1wVrU3GFHBz8Tx1Fc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317a3d24-7599-4695-9d39-08de7d552abd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:56:27.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkRNQKH24zPNX4TzSn8Cl86XbIIIqGg5fBVErL113YLX2Q9D/Y6IZq7Vyuq43RjMx9K12jtHOgmGocv3cfPiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12129
X-Rspamd-Queue-Id: 829F2232388
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7022-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.949];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 12:25:32PM -0700, Joe Perches wrote:
> On Sun, 2026-03-08 at 21:10 +0200, Vladimir Oltean wrote:
> > On Sun, Mar 08, 2026 at 11:40:44AM -0700, Joe Perches wrote:
> > > Perhaps if matching only the include uses:
> > > (/ is escaped because get_maintainer is stupid)
> > > something like:
> > > 
> > > K:	include\s*\<linux\/phy\/phy(?:-common-props|-provider)?\.h\>
> 
> > Why is get_maintainer stupid?
> 
> The get_maintainer code used to match keywords is
> 
> 	    foreach my $line (keys %keyword_hash) {
> 		if ($text =~ m/$keyword_hash{$line}/x) {
> 
> so it seems the first / in the K: <foo> regex would terminate
> the match.
> 
> It might have been better to use a different delimiter.
> Maybe:
> 
> 		if ($text =~ m{$keyword_hash{$line}}/x

So why does it match in my example?

