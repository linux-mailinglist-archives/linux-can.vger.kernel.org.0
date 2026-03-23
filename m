Return-Path: <linux-can+bounces-7233-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGQMMpzCwWkHWQQAu9opvQ
	(envelope-from <linux-can+bounces-7233-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 23:45:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA42FE790
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 23:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96D230541F5
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B3382F27;
	Mon, 23 Mar 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcQ+Ul7W"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8702381B0E;
	Mon, 23 Mar 2026 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305725; cv=fail; b=p23L+CMCrLhTTZPpOrp29jcn8yvaV9XlgnapEMzWbTIj848ez5AlIqDz+9+9qXLBvaifRbvuDV5j0tdedH8eLcqVsAMZzV2nA8znpMwkic25A+SxoYxBmyDxxAteesDQ3srcs2Npck/RcZDsIX7s+18K0pcgd215VVEz3a4/Cm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305725; c=relaxed/simple;
	bh=OnPWJJpMfukX61AFwAcYGXDDLyIPpG0UtWajnhyiVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e32H5UO+kERF1nwWMOZUBg2HNJaMYTQ4VZDG+tzjut4kZGmkewCIRJnV/jbAVnEWKqZnaQaxXJQOk2SlDyv7sEwZJOR4MJdVfrniyIVkOyHfSIAX7pvKBnCjedTuoJgyDaVI1n7JH8kI7lMwJxOg3wpWKQ0n6ype8b1Z4w9Bs38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bcQ+Ul7W; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEC/VOclQf68OGMyxx8k0ErnssgaHCMV8vZ3ZbxPby/8oaawCB6SM7sTVY01lHyt27GhnDecGVsqazVICrB10RJQgcBemqJIsdts+lIPRii6QrA3T4Q/zzcJ2hgMmR7++XMtBn9U8VbiAtgO+j8/HYJeseNmVU496N1TURYvfssYoSGFOY4fiAby9UMQqTyPO5D/5E4o2TiFIEgV4cOVBJuENPd1lnnv/x+gFVmB0AtKuzpiDNH6dOH3R/ADSNAfntcbsnFSyQis3INC8FB/CWGnouGO50UmSKqreIdNyyGWlWQZELVGAEnYz6gefg3Vhj6aKHCHfpv8L2Sqpxtmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnPWJJpMfukX61AFwAcYGXDDLyIPpG0UtWajnhyiVHk=;
 b=TCN3LpB62HUmjAIMqX8IDF83Za6iRyee5b/YVYNezX4k5C70uzFEs83PzoGEK/iuxjalKBFEN9ZICHgu83vyT3KQ5DeBHZpnHq1q3sUZr4JBtDeD0jel6U4rpxYV7/YKL8m7Qaa4LYB+S487xq7YCz3DhGqIaB38zKo5swcTQWTmI8O8TxX5R1YwvL5eiW+Rv7JtXve05wFEkIXQ3wdKZo0XzyT/+ee92M0p6L2T0AfNLu2YpEMTpxTDaORfYtUrG7AyYgoCXZaL8qhGgCzinVtFYNzASw4CVTVrEm5hGMxQYHMpP+l7xTwqTyVF+4w/L1osx8OXG+IPxLX2kJjvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnPWJJpMfukX61AFwAcYGXDDLyIPpG0UtWajnhyiVHk=;
 b=bcQ+Ul7WyyTlPY2BifoIe1Ev51k8C6E/KWxuaPH9ruGgt+axhPQkOl/H9HO5G9eWo90tQunhHoyI38u4Wc7yhhrzdwuJefmkCwCTNt/mp/xB5Otk9yum7ZwJgB4Z8jlfczkJ3yqIvZ2PixHvDlu0ckTOwOxabcryWBoupdxIVeIPavnw8OzJVYjSx6f1S+HI5ogZyHXhHH67FpKKOf2N2oBxGk1kZSJzyIdyw0P0Yd641TOcYtpCgTv+QqQpCenI17JlPGspXi72P3l0H/M+/ddL/WfMX2Vpbm7cohILZmBY9+leN3qvCkl4mL/8NdO/OC7zazDzsJXB3EazfT35lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA2PR04MB10376.eurprd04.prod.outlook.com (2603:10a6:102:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 22:41:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 22:41:36 +0000
Date: Tue, 24 Mar 2026 00:41:55 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: "'Martin K. Petersen'" <martin.petersen@oracle.com>,
	linux-phy@lists.infradead.org, 'Vinod Koul' <vkoul@kernel.org>,
	'Neil Armstrong' <neil.armstrong@linaro.org>,
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
	'Bart Van Assche' <bvanassche@acm.org>,
	'Peter Griffin' <peter.griffin@linaro.org>,
	"'James E.J. Bottomley'" <James.Bottomley@HansenPartnership.com>,
	'Krzysztof Kozlowski' <krzk@kernel.org>,
	'Chanho Park' <chanho61.park@samsung.com>
Subject: Re: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Message-ID: <20260323224155.5vx6kqnu4q7y6tz2@skbuf>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-10-vladimir.oltean@nxp.com>
 <yq1a4w3l04g.fsf@ca-mkp.ca.oracle.com>
 <CGME20260323115859epcas5p10177db12a2e8aee9578271ff1411137b@epcas5p1.samsung.com>
 <20260323115848.ghdu4sbk75tvggfb@skbuf>
 <1891546521.01774280282025.JavaMail.epsvc@epcpadp2new>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01774280282025.JavaMail.epsvc@epcpadp2new>
X-ClientProxiedBy: VI1PR09CA0145.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA2PR04MB10376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf01aa1-a350-499b-4bdf-08de892d5769
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 U41ZxIpbwkq6sJwBugn1woWYjg8p/rAc1o7U0C4JAclVBH9hEghR4UT9+azy9yfEmklHvqPXrmA7RkPgRx7mECmcCkGZl3SJxPPFIkU2H1dfQQzNPGzR2Xv1eoTWLraK7SoqsaLyoVLgqI6IapOeKYPO2KqToUbuGFRVqbB+UTjP8S8vALr1TZYkPw3oOocBIWa89W0pPc8pA0MI6sIq/xF8tfEo91oTeP4DhH9Wcy0TJQTkgN/PGq7nd7H0jGuYNIRUHfxs4WyckI3wZGSzHwddiMhl/6LMkz+8uxOe30qNRzrr4giBX8RgNwj3jcjeLusBG4SXTn+OGrjUvBhrsC3PfKdfG5V5GhJdRo65ccI+QBVRB0AdPME3O+zpeRAuDszh+ozXHt0L5C1Uk4HNpjHwV7ikqVUwvlJ3AM8SWT96XvlaTSUDYpnsp5MUcvpOxQ03nCOTzpFCkoqjXSTjRrS7ARXU6s/yllTFnFXDa3bDVbWwJkSFTy9oC2Kn38wuHVheY05VgrULzz5Z6TMUg5orrqs17z/hMczlHa40dUbmKxCc2Hj++GiGJLWHhRPT6+JkizCyX1ZV7u1Mcif3FBa9arKxYu5dp105HXOeCQMcVaBPmktXIb4SUux2dBJ1emK3s2EUaap97Ekw+PED1+r/ZcC/m2JgriJv/6dglyDAik3H8DQ1eaiCzKBqAgGjxvwcMABXmgCSWPZr41XPjuVzbRu8AGY20uVHUZufjQg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?0TVCxG5sfXlpq1mETN2UUIKgXF+JAISatRz6N1xi0hQormOkJD2nmkwvzkW1?=
 =?us-ascii?Q?GHG2ACQnJdyzgoi7AfobGdr2GmW6dY5eEkOGvWlWEjkAAvvapPC3V5Hjg6ly?=
 =?us-ascii?Q?257RQvJy50Nh+9CBXIpF4ucW8iptDxdHkC5Qc42Zt+3kfvbVvpVeXu+cd0y/?=
 =?us-ascii?Q?TT8GV3Eq//GIEI07y/tHuNtcnBszsYxT76C64bCVFDdWzgDrb8eZfSiTlZKl?=
 =?us-ascii?Q?Mp0MQmdQgA2OpyuRsWthziyMVthJuYbNA70ZSQFSUpEVC11XB+X/Dtqq/6uT?=
 =?us-ascii?Q?n13coWj8PevmcK8LlAejz75jH5bLxQso9g2L6plVugEbumIDHsqBSN5tIgWO?=
 =?us-ascii?Q?ZCDh/CclblDgzYVIW3kWVsDzd4IsJkC9aaibJxVbXmb1R4rZ30MxpZQgivSM?=
 =?us-ascii?Q?xAte9W3t8vNY7BR5yEBN57zvi0wS0umzMrEqGm7NYszymvemo2C2mkef4ZuP?=
 =?us-ascii?Q?uhb6nG4wRuEY7HzoILLOo3Dv8jVKgNQrHy+eruY7P7e9SPWc1bNyu2ijebMu?=
 =?us-ascii?Q?t1yBwHpgUqsG2DcVWccF0cNk/kss+EnCVcIZ2PJBB0sQGSvmdr50JEQ7VGGw?=
 =?us-ascii?Q?wCHrlkW6z4EufNfStrO8dUjKcZu+52TXOMwAkQZY1xOST8z1ejrIBfHv8y21?=
 =?us-ascii?Q?SBwAWcGglwY8DmBto58G7wUK7uY0NzlFxy2LtyXH3JPF6lRegGRDMnUXfTeL?=
 =?us-ascii?Q?mhyMMKZYmF/9/WLTM6hWn89OiKBTUd2HNBDvxPw3dmtUacfiL6510VGhMQ/n?=
 =?us-ascii?Q?kqNfS/SZMjk28QV/khs+pQ8J6VTL44MzQuKbhNzZbd6IX8PE1n1cTk+HX5f4?=
 =?us-ascii?Q?euS2bV4yoRzT82Hv5EAUld0cfz/KB+bZ5GByLniRHGdcijpM3zXp6ISHH1XW?=
 =?us-ascii?Q?Jf/tZXukVHRrvZrRvoD29S4G/M2gJtdkIYjIshW4Vx8o9hFab3PFpNSVZl9x?=
 =?us-ascii?Q?12tgoUx9ZKp2pECKAok9qgjLOa3y/6VHFn0VSybGl8jCp1eiSF/kYQg69+AO?=
 =?us-ascii?Q?yR0epQt07YLTZWWfVvF+xuN7L31ghpcVCjUvsKWJM1C0Zpx/yKM20qMwwCmJ?=
 =?us-ascii?Q?8yeBKQxKb90065jSH81o9DN3W6a5WoDByoE28kUqpj/zLuF6Gs0lZVQk2mnh?=
 =?us-ascii?Q?Mmr1lr2vAsrEV3Dp7wclHHXBy6D3cqVFpgcRc/UIf83wNNKVrBUraQWHc3Ii?=
 =?us-ascii?Q?eK/gRKflVxZZ1pOHAZYd02V5JOWkN5/sRxpmFLdPU7KOthL/8s/L51XiIZfA?=
 =?us-ascii?Q?j1PP9/ntBObCw3y5nUBDzTGzv9Q7W7TvX7YP6D01pyIn9w2xbXP7Bo1PF+e5?=
 =?us-ascii?Q?cOgV3/4qcJ6JfFFh3iUbmQbo+aFrQ+tNUMj77eTJ21McMF+ntZkHmwG8fuA/?=
 =?us-ascii?Q?VPuRjAg3C1PLHPKn/IrEsvDISeTBNToD0RSOrsG9YDiyAM8il+BAokLEykfV?=
 =?us-ascii?Q?E9d1cEzA5tPBl5x7r7tOyAQf7+jgTVTmBcgRLkkWm0Gmh147ugx1SSavsd5F?=
 =?us-ascii?Q?R4dcTbWdg0NEQnNWv2CMIc80gccXiVZQSwHY62/5dqaBT6fe8r76/xzvGtzh?=
 =?us-ascii?Q?pyc3kuE48DXVgGQKnR6TqDbugUGMvFT5D2g9scugUir5PWyiJ9XSuH9bsNjA?=
 =?us-ascii?Q?6BYZefF74g5c+VqfXraNxaAsnQarzBO0fI0cb9XWv1NPgcXGOUhKXSs6bWPa?=
 =?us-ascii?Q?Z+frSdtMmePtKKa1gZ12PCyZW0DFUePTMsjAAFP6WUEUxWUVmCMG9gmuewcx?=
 =?us-ascii?Q?zWx0ihgBLV5wddrzdlSrX2Lmv2+9IDI+lnzsSTlemYh95yj0HRk68xf9GNrC?=
X-MS-Exchange-AntiSpam-MessageData-1: 7t0SISdxYT2pFMbEXyoY+GuzV5YPKyMP3n8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf01aa1-a350-499b-4bdf-08de892d5769
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:41:36.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mErGdwGcJOUBf17JGSORAgKN1SLrIHLYD+CNuyd2rAkYspxlXfRU6rm0qWQJx8cozbQksDeKC4gMYOIsvZIhRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10376
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
	TAGGED_FROM(0.00)[bounces-7233-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74CA42FE790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 06:05:36PM +0530, Alim Akhtar wrote:
> Will review and possibly test on one of the board later tonight

Ok, in that case I'll wait. Thanks.

