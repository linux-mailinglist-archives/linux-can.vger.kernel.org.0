Return-Path: <linux-can+bounces-7744-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ss/eEYfVH2rGqgAAu9opvQ
	(envelope-from <linux-can+bounces-7744-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:19:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8280635210
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="RppTPrZ/";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7744-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7744-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE5E3121C2F
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8613FFABE;
	Wed,  3 Jun 2026 07:14:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1D3FF1D8;
	Wed,  3 Jun 2026 07:14:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470847; cv=fail; b=ZbT5Omat4hCDd3LPRg3UauicQQL60rxB32O0D0J5bwfcdtxpN+OIjshU2Gw3vxFHmrR8VUEJQVjJMINwe1dFwiutZcJ5dDdFWuVjcvyOS3f2h+OTn7c87PyOTr/zWcSvYCvi9llnoDRAP1z0E7m7MAO/pJSjNxbvBGuXj5S5QeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470847; c=relaxed/simple;
	bh=AmkQXFLaAgioZXQr+kr0ifiAPUfa04f++MCQqAML8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9nUb0yvoOmtf71GWqU1exynPgvdN34qDjiHDUIqn8kvoLe3zLSFQBGIa6UNB24PxUh178J/P4BXV37DtweMhizkZE0wzdhd0es5l7zMCJEIv3rJMhAswnOpww4c22vAlQaCS0bHGJRvQKGNXPP7CzutrbQl4IcIV9mrFuuJq2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RppTPrZ/; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6PFdmRj1qyuSmRXllJY8hMJbweZU3L2mrVA0iDdYgIK7ydMpPHOM0XtPeS/S4hhfYee8Z8shn0AOcYll6ttqNs5Dv7RVa4C+YXDjZe5K8eKN65K2VmC5VA+IRexHBUc56ESaBmwZT2IcIcir4pOcSjHWYkVzrFEGLYQ+mJNMyxFlx9AjEsqtGDnp8nEutEnXAAttVXwIDwTh4cKEBJC6a60SM4sbhA21kl2eGpCqVt/dOkdGxGCxbB4lPLRI3MSzrzp35M9eovdRRZcXCyE9N77///+jxgkS92J4A1hFnH17xduc5cCkoTl6f5PX9fo1muwaEIsuNYd/+pn7LBVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=Sz5rN4ALszA9AqyRnFhLc0uy7nFwKRByUcrtAKzj1mN4AipBDqolk9sSfH2DWM/djRng0f2q0mGWcYgSGoTrMok64XFhcLyr2TELFQtH59GF34B5zzAHBeMd2G6o+qWvPgSgQnCFMdVDWpA3xMUiPfD25GvgScUj4fYQI/aATyqMWDJi6Jemb9yJ/NHaWmFB9WftRQinfqlnCw633YtdQ5Aao3ovsVPmcCmVjx8he5dusXodMy4RGhc4kmpTy1bSLrGlsLNKbj1IeJhbrba9ofTZYiEi6+2dMcrczKgtbNKxFe4JHrcLP32sYCtm5rUbvdSAZuvkip2+M5l1YZRgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U12gOewEf6DEQLWhQ0GYz+ip2neAn9Tagkuag0OJu1A=;
 b=RppTPrZ/0JXsOVZAEGaa7Wp3IjELD7sQlhTsOUeCAab0FAJGYBpeVkOKS0skUTUVQbI/0UvEozaJVFaOEy3eVcZD2hqwbIzIYdVeEx+z5vj5/OJik+5KBGrO+1WZVInM17KplQBCDd+HDVR7IeQJyj8ZedhG85gdYRmn9CIk+9ORjqpmRURdAoqN0xKtaquLheoY6tVBFBWWE//ehv5hS5/n4r7G/hPZ60S1TKAK02T9NmHVZNK01JXLs7mkLlK92YqFnI0GD2p9nlrs+g7a/U7Ns4na15RoLcjDwWMJ/B+QYx9RmUbboWvdggMNZmfAFdufwLmw+WsuDS92LYNh9Q==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:14:00 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:14:00 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH RESEND v4 7/8] arm64: dts: s32n79: add FlexCAN nodes
Date: Wed,  3 Jun 2026 09:13:41 +0200
Message-ID: <20260603071342.641874-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fd23fb-8600-4452-d75a-08dec13faee3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 1HWE47z1s3A9fIVyJgJHd6TX3vzODnOxcLX3zgPYp6awIhA7DASDg23ILOfCe6A0CNjgSnplxyMMlbPYE+nvU4O7cH4Th9PpCrWCFSQF+GVtDKD3VHIaqlif0QULgjwpbxsZlLC+XOopNdy/+WuY9Y8JmH3F2qOlKVG6FNPq5JjHGVD5/9j+bWvPkUFOzApJ/YOFp+oqC0e/WCF5Kkz9SB4MMdULQJ4vyFvP45fh/R9uIsNE6O0Tlfwaou+gpMoT+LNzjuQPEqU/cqkrKcu16FwcEfFC4Es7XPv/oddz97kLqOIGpSsE2jVyPKHJJewVmcL1WY7/hwVnZoo8SqX1LQ1OQDnRCfypTrCBYNkvskdnJCPGV54ZLFB4wnElk16bLYzzVsS3e5Q1B/BD9Wr79WgUCP2OooqyYL8vnFTK8Bh8EYuCgzJIRtKvu5CIY0rjSthFZCHi47rXCVLCev6bSZGFMlsMcIBQFoh2tg3r/YLY87HjjAqqr0v/1yR1j0O8doS0d8uxMsqbxhNnDxJRjDz+s7zCnoWKTCd7WeTVpo4ZEyB0NKjoF00+FoFjlCLbHasxIsVJDolF1Nsx+GTFMnLsLvnS7y+BFqR8/SVlyxv+MpDpLoR7w1NToUXIrcHV9OpbmqPPOXdOF2811QcMDSPb8MI8fT5jFPUy5UTovQiw1QLvXGGf1k7dyJLjP/fp
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?REY0QzRqVnBEZVhYL001aE9ZSitzS2tGSkxUeEI4OVd0WFdRV3l3MTBHcGlK?=
 =?utf-8?B?TitCaU9HK1gyb1VwSnBwQ3cxVnZvZVJhSDlNSTc5Nm9mWTh4ZDBmQmxrOW9t?=
 =?utf-8?B?S0w0eWxaOEVlOWtHckV4QTBoS0lHWTgrTnN3VmRFNE4rdWZISjBnMWF0YTZS?=
 =?utf-8?B?RkNhTmRDSVNKeDNkVnZ6K2krd0dlS3g2bGplMkhhcjdycFlCaGl4N3VIbVB5?=
 =?utf-8?B?QmhnMjJWZHN1SlNFYTdiV0dwb05vZkN0SHhRS3VicHBoS3RLM2V4STZQeGRR?=
 =?utf-8?B?Uk9CVUhEdzY4dDZhZEs5NE50OVUrVGdwa09Qbkxzbkw3YXp6SkpLb3hpaWNQ?=
 =?utf-8?B?NUdpSUVhZ2VZUGVxUVpGaUlwTDZzNTQwamhnWHVocU1rTFEwcllBMFRRVksr?=
 =?utf-8?B?N2J5eUd5UzlrczB4TzNTTmRVWkk1L3ZzaGgwY1J0cmlDUE1MMjhJNWlpWjlH?=
 =?utf-8?B?OFVxTEZ0UENRZTlyV29pRXZzMGduVGpkNldXdzBSdnBDVU5SQlE4SkM0enUy?=
 =?utf-8?B?bTJDcTZJbXlnbHBrMzZwUXpPMWVyeGtJSjhMSzgwUG5jZXBCTjdOOGRlNUNG?=
 =?utf-8?B?bWlocm9QTTZmUkpXb3N1d0pjbTRGT2hJL2NjNkdpK1FpOVNreFVNcExwUm0v?=
 =?utf-8?B?RHBvekUxNlpqTUFUYUZpd0xlWW0rUkU5d3Y1NTVoaUFBRHZHcXRWTXdvSGVX?=
 =?utf-8?B?NTJ3SmpEOTVVcnpGWW1PWkdVK2ZRVnlPMDBya0lhSnRpQjFJVFZDRTV5TDJP?=
 =?utf-8?B?QUQxMmMwL2dlUy9qSExTcGlZcUllRE40dXU0amM5OGZwNXN1dGFWYWl6VmVB?=
 =?utf-8?B?V0xySEVYMXFsd2tvMFlmM1Y5M1M3RHJOajRNSFc0UVpEM0J3dER1ZmJNZE56?=
 =?utf-8?B?VmNqRjV5dlhkdFlRZDZkdUNPWDhxeVZTMG1oRllMU3hyM1FkVmFobDFXSmhR?=
 =?utf-8?B?V096V296eDQybnRPL2ZkWHI4VGtLaEE0dTNwSnZXYkFLSEwrRnBFblhjM0c3?=
 =?utf-8?B?bEdvdEtFbzNNT2J4UkdadFdGdlh5ZnpYa0dKUzlXZXJiZFNYM01QcnZ6TWdp?=
 =?utf-8?B?M1RsbU9jYVlsVjMwd0xzejVGdE5jZTJJdkVTLzdEVFltSGdVSHR4MG9XY3hY?=
 =?utf-8?B?L2xkYXhZUlRycmdGWE1UK2dudXh1czJaSXhlVHdmKzN4Ny9LdUlSaDM2M3dO?=
 =?utf-8?B?eHFUNUpXYW5CTTM1R0dGeDRvai8reDhVYVJZWXI0V2NkeURLc3p0NDZDSGU5?=
 =?utf-8?B?WGlVS0RCRGhCNVVmZ1RHa2tPVVRtWjlJREprazBscXJGbi9YaHdCSkRueCtW?=
 =?utf-8?B?T3k5cDNkSTM1L3JvSEdXWjJlcEVTS2o0Y29GdXdVUnA4Qmp0WVFIUDRvdjFS?=
 =?utf-8?B?L2ZHdWZ3em9mWmIweTdadXo5b0wxcFlwUlIxZmNxQnQ0QmppYkdxTkJBL3Y5?=
 =?utf-8?B?SHovU2tzaTZGZjdLQVF0UUJVUzdNSExZRnFWdktzN0NCWnZUWmU1azdqV0dE?=
 =?utf-8?B?TzhIeVg3RTFGSDBqd2lEVHBRU3pGZzlUZTZudnY2VWNYOFRjeEhZNm84TVlX?=
 =?utf-8?B?dGZOaEtiNHB6VlBuRS8wTDF3V0c5T1RmaVRta1ZJT2FFZHBvVUo0c0FZdko3?=
 =?utf-8?B?VGpVYld3azdiNFFCaStYL25QNk1lR0laakxPbFNUNnZMY2ppSVM1S2VFeGhV?=
 =?utf-8?B?d2hkU2loc3ZxZmE5SXRWK0VPb3JGb1Y4bTZLTFhPM0JTa1Z4dXByV09Xc2Vh?=
 =?utf-8?B?cTVIZzZ3SEdURmFhZGRjcHNyTnQ5RlUzL1oxRkZTVjBKZDllaHg1bkx2TVJr?=
 =?utf-8?B?UXV3ZzIrSDExSEJHajBIcTVGekJTYUx1dWhpSllnV1oxMkZkcG16VnE0WHRE?=
 =?utf-8?B?bzUralowbjlDV2RuZXdmQUd0MXNuMW1jb1FScUttLzI5UmtCcWpDcUlUekdR?=
 =?utf-8?B?WnkxN3FZMVVyemFLMEFTdUplMURuVDR4YmR2dzFnK1ZXYk5ZMXNlejd6VTNs?=
 =?utf-8?B?QjhXeEVOZytuZHVhdTB0WHNCajNzemI5eVdNcmFLc1cxOXlRYVdjRjE5WXh5?=
 =?utf-8?B?SGNoemJvNWxmL3grTG1WeGpsSzBtUk1kUVdUMVlGRU8vZW9pMHRYdFhIWk45?=
 =?utf-8?B?akVjSHlJQ3JaVUpPd09LWWF4MjVNanZyQWw4MENrakVidWJZTTlVMFljYXc0?=
 =?utf-8?B?Sm9iRzkyVk9KRTZhNjVLdGdhZHRYRFBtMk5jNE9mdDBzWUlUZzF0RzBQRjdU?=
 =?utf-8?B?ZHMxSlpyVkNWeXFxd21jdFBYbFBuTUtVbDJ2RjdLalo4enNFUHBlaUhZcGJ2?=
 =?utf-8?B?RmRjV0NFRmwxdHhtTi9yQUFXeFhJM0xuOGVkTm1ReXM3YW05MVN4WHJnblUx?=
 =?utf-8?Q?L6mDCQK6hNL5IUXQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fd23fb-8600-4452-d75a-08dec13faee3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:59.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jec/96q0+tAt9FI0uP8NHKiY6hwb6+IB7vfKZcqimQM6OoH2o4jQq7Bjk0Ssyas8QhgE4fWSZE6VOKGK/Qxfun/NE3/XHJfwSYUAluNrZ9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7744-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,oss.nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8280635210

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

The S32N79 integrates multiple FlexCAN instances connected through the RCU
irqsteer interrupt controller.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..c1a4fdead91d 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -352,6 +352,56 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rcu-bus {
+		compatible = "simple-bus";
+		ranges = <0x54000000 0x0 0x54000000 0x4000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		irqsteer_rcu: interrupt-controller@55101000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x55101000 0x1000>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0xf9>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+
+		can0: can@55b60000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b60000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <0>, <64>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@55b70000 {
+			compatible = "nxp,s32n79-flexcan";
+			reg = <0x55b70000 0x4000>;
+			interrupt-parent = <&irqsteer_rcu>;
+			interrupts = <1>, <65>;
+			interrupt-names = "mb-0", "berr";
+			clocks = <&clks 0xf9>, <&clks 0xfc>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


