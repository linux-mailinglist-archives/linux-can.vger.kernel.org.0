Return-Path: <linux-can+bounces-7782-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hzVMMfwlKGpf/AIAu9opvQ
	(envelope-from <linux-can+bounces-7782-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:41:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D936613FB
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:41:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="sB2K90+/";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7782-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7782-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A0EC30F530A
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CF3546D2;
	Tue,  9 Jun 2026 14:30:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871813537F5;
	Tue,  9 Jun 2026 14:30:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015416; cv=fail; b=COHCcH7SAC1qnn3W3maxTXvTZF/KFJJIXef3q/t7tO4/MOoxd8pCRff5570/9IX+c5cqQv2gaClfEZGw5pxL5+7p4vECvXX40uc6XVSk4JD5kJehnamBFNRsdQOSvwohlzLJ0TGEt6QL/eNrYEjI3AfNNWM+OTUCOzq6h+Wxclo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015416; c=relaxed/simple;
	bh=sTX4J3tmHnK52er7VvLi/80Gm70G3ZLbRp2Fcaf8Ijw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiDXXGgP5Nq8mt93tjyvCCpPOJDa+75XCxA5cv1ongvIijKyidfejwWEKxr2pXoalw6RJeETnZ52M7A5Sbv8WKDyzEiyzqWBm12REH+ustUWTPzwtTMIW1E8JwO0161EEyrxA9a/cGxcku2gPmP/q0Z2khqzQZUnPKgG0Tser1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sB2K90+/; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLGqJ84BixvH1fRFuRIFIw9TUDj0f96FoOXNyMjzS7gcFpA4UMCPLBzypgthW/sWYa7zDNBxNc9rtORAoR2olf/IteENJOmCx0JBs5SO2BpmNCZaRRwpJwUoetxd+60cIE0jj3QPgZe+I2Fil239EPv4YUDmrH25mkWQPH8SKfllr7jU0h1ZJKdVzwuS+JIVg/a0BlnuAMk5Ok9FRf5w8HwI41a4LRiGcSO4v+zLCmng+djLXTyw/Vecu++1GIJYl22rGoOL7QosliZ2wXW+OT8IugM8MY6wBOvhOQHr8hPX00cUITMwQQj+ralTdtF13womrb1T4QmqWzE5ltYqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXpszbiPtlboi+fcxd72/CUp8PSNlw/YaDuOdE3ImfY=;
 b=ZRgSWRleOeLRRKKwLe4ujDZUzi8uMzez4RqETOCoz3NdTzyXpFpQa5pLiwzrVbUX/7nNPHbldp+bsFiwAcKxZ4FI1P+HNRkpsqUZEgN+n/JlTWgQcyCp1AxnOAncMDrOEjZmsb+QY3L3edJo4bGTHSeoDYEG+0Nit7T+sdUUVv18pt6Igpkn8FraBhGgnJ5sinLsnHridS8gt33nyxvbFPyt7v2o68DAjY/eiA/xH3niN5JIP4hf4Re0W/4JiIGPN2im+gRCKM0c6SZnPH+hq4yUb6B7eC0xnQ71tqskgIRr0qQei99uSKU+9vywFor2x+3vpxBi1Mb9NwlJBUVSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXpszbiPtlboi+fcxd72/CUp8PSNlw/YaDuOdE3ImfY=;
 b=sB2K90+/jFH9DAukvr8oEzfxG81n6saC5GxgZGoPfr4fsjDheNeYbr6NCZUIbhlEkOrfZT/3cFFMqb9i4MSn/JULtgZWXaM6sDY1OZfaIV5eKArsy2Js7GJZBg3iqW0S5O+2eQCG2VPLCL9Ezcf6nmdNcMdyuRHbJtv1EMnBLYCb4pXQkS1iKqCtFVzt0RYx1tgamDB8jezX1I46ZxVXz2pOb8ek9K13mPddYt5pmWvvcsa05uQmjz6qh/gUThyuNKjv0Wbj6OGqM70rPj794SDQR30RHIZdRosLt5Jt2Xv3GQp61JT5i5djelxNGyoIdv9p8/RwUvQ7/hc3IFGVlA==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:05 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:05 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 6/8] can: flexcan: add NXP S32N79 SoC support
Date: Tue,  9 Jun 2026 16:29:52 +0200
Message-ID: <20260609142954.1807421-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4753d3-366b-43e5-c05f-08dec63399a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 DAlfmui1hyFZHcquGSXO01gZ8rLngatQbdvkAxvZRp1BJiljEt7DEalX5Ge03NbNc4JazAmCzdjdtB0SYhcgCHRidv6MlCZpoPB6XmT3bsvCrq5DgQNXg/qinu/6AKtTGyL1t+dc0l6QVoIRxYrrIPQ4ei1xkQfIoZv8vS1YsgiswFUsK7jY53LGOxzcNf30XryizMsjZDEzFcuAMHMlOW3LSdFW/E4NIGUH6uTZETF4mmvX7tNfCMpOldgTg5AJXtIlJS7noGglSJLewI6aansFP+N1rDhoXVp0d4C6Xw71/HjxkucKwg4QdbMJr8sfMeWPG2xJfLz4L6pTwjQmRga7Gj46KUSXRbK6Gtwt8/Z4+I/5aC6SNaWkzUrg95zuNXlWR1jPREOCGulsD08snBV/BNY6e5emOVYYHeoLwmi+Q90PBItvRUJ/nXILPHPripttPTuOYv3i4l8FumXnKvcL647k2LXTxKxom1xy6DKEX6TKG4FiNMqq2CgY9RldWeKPWMXGRbdnthIvvUbooeAevgxqNfT84V0UyCSwFlHCKos1wwnMfzr/VvLsCYTcUmX/PGeiPmNDAHgB1OBQnXOJiQIrf9VtCFiPse33CJQ38KXwpzCDFH8P4idzpgu529wqDOQ/phGjQFvEFO015Tttofb6+G1AlFFqo41WbFQ/Er5j8FBi9mGaE55fVerf
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SHdQMjdmbGNkVmVJVk9HUm9vOGtRRTZCRkhhMG1HUng5bGIzeWFzRXRtNW9Q?=
 =?utf-8?B?Q093ZzMyNHdnTmhSUlBLNjNHbGN5VjhyVlRKSi8ybVRkQkVXMHpTR3hpZjZ0?=
 =?utf-8?B?ZmVZQWQrYlhQazh1anpPZ3ZFVXhCdXF1eDl6UzlTMG1SZm15ckpmWVlTblNh?=
 =?utf-8?B?c0lsbHNIU0FOZm85YXhXZFdlUmV3czdjalRZVkxOdStXdDZ5NFpsQjFtZTlR?=
 =?utf-8?B?R2pCclZZTUFQblkvNnBPblJIb0RFT0poUUVLcXhZbTBBbjBJR0xsQktqLzI4?=
 =?utf-8?B?cUF2NERUV1dRZitvN0hMb3lwOGU2UnVDaXhORk9qZEZHekxZVXFKMW91Rk81?=
 =?utf-8?B?NzhTcEUweGJRdzJpN1Q3OVFKeHZZdGRXcE12V29rd2dneUhkY3VSTHREdGJz?=
 =?utf-8?B?OVZXcXJFQTd0czZjV1paMTlIaHRvdlZLSHUyR01OVk9IRFNPK045Ky9laWhl?=
 =?utf-8?B?VUNzMEp5alVPdmlDSjJRTm9oek9Kb3dFUkZGQ2VIR1Zmc2pwZ2tBSFp5UWg1?=
 =?utf-8?B?RGg4WnUza0czeGU2TnMyaVRESXY3SlhPbnArdUNNVkl4VjNETHlEdGR1VUs3?=
 =?utf-8?B?ajFhOXFxcjlNR3hRdk5QL1o0WTl2c3BBSmNnaXhjZytzOU1KU0xkMnMvZXJD?=
 =?utf-8?B?K0xXYTAwbHBSQzRuTXlTREtXSE9pd0F3RnBJM3BSckpFeDNLcTY3WHhxWmIx?=
 =?utf-8?B?d2ovaC9YcThSSGdXVk80RzVOaVpNMTZMZ3RjaFFiaDRkNnJZU1JNRy91RUZo?=
 =?utf-8?B?N204TTNvYjhEVFhHYzZVeUVibG5nQ3VIWHBObXRKUVNpTlRJS1h2azd3M3c2?=
 =?utf-8?B?TFBWR2QvOEYxZWt1clZrc3R6ZVJsVUFQcmNFcUhyK0tQQjBmemxpbHVlMW9D?=
 =?utf-8?B?V3pWQkNqTnQzcGVOc0Y1VEw2TTlWQTlMYUlzcWd2emFsYzJsbXNyeHhqMjlY?=
 =?utf-8?B?UDJiaXYzOXpESUo3ZzVYWkdBL0F5bWVmSHNMNkNwQXI0NkgzbW5KeTJHYnZO?=
 =?utf-8?B?cEJpNmFvY2I3VVRCMFVKN1JJR00wSDRIK0tFcjVxVHlSZk5Ea1lZcFpiZFRQ?=
 =?utf-8?B?WmE4eXZMWDdzRm5wcWtsajRESDl5OFYyZ2ZJRi9abS94Rkthbml4NkNOWXZY?=
 =?utf-8?B?Z25XZXVVcG9Ec2p1ZmRqMld2Tmk0bjBlanZMRlhFdW5EQ1lBRU5DU2lCa0xE?=
 =?utf-8?B?YWZjSjFWSXBMazkxbWJoZEF5cmk1WEs2dUpTYVJyb1Y5dUdPUG1ncmRIM0dp?=
 =?utf-8?B?ejBJRWd2bEkyMjVpbnhhL2JldVk3dDdnNytGZEhMQW55Nk9JeC9pTmE3YzNs?=
 =?utf-8?B?SkQxR0JZUy84UVluanR5Y01RbHhBclh5K0t5NGs4UzFVNmc0dkFLeDg0eXdL?=
 =?utf-8?B?UCszYlo5QWNZUzZkd3hXbVdsSWZTWkd4WW9UbDJDZDAzMG85Wkt2S29KMDhC?=
 =?utf-8?B?TkViZlRveHBsQnlnVkF2c0I1V25WejFMWHRlOXdHT3k1WlJJZVBHQzZ6WU5m?=
 =?utf-8?B?VnRlRDNTSUtBb2ZlMFAvMjhFTzcwbzlHZkwyd0xIWm1EL2o3ZjZrcmRteGcx?=
 =?utf-8?B?SUtxN0tvNnBxL0R0RkFtdVVabWprdFNuTFNqZXI5d1JqZTFsK21MbWFXTEs5?=
 =?utf-8?B?RTlCdE85SVhnbTBtUEhtZFFobHgwbjQwcTNCc3BvVWx4SWxQMkI0U3E3RWFL?=
 =?utf-8?B?dkVGT2FOK3BCOHFrYlZOZ3VYQWdKaCs2Wk4vQzhQdUMyZXhyNGhWOHNJclkx?=
 =?utf-8?B?YmVWblV5b2RsaWtDUUtNcFZ6aVhINS9YaFVkbTNwYTdoNzhjMXI3N3FLK2JK?=
 =?utf-8?B?aVF4c2ZJVDJ3YVZIWlU2eXJoZmJpZHNzdHljR0lnK0IwMjJzSlN6em5GSFFV?=
 =?utf-8?B?aVhQRXJzUThvWHR0M25YTVR4bVBwRGQya2gyR0gyZ0hGYkNkOTRnSUwyc0NV?=
 =?utf-8?B?OG9VeDlaZ3hDL0lzcUlFU0pVRTVuOEp6UGlTM0IwOUQxaGNnUUZabnMydjRj?=
 =?utf-8?B?VCtFd3BZMXVxY2luakxYUjVMNmtJbUp2ZG13T3ZuckJJTFhuWnFGTW9mZnhP?=
 =?utf-8?B?RDJRNFcrTkFGRjBxV3owd1E0dDVrVXl6MFRSRkF4Q0I4ZUtCT2J4ZGVZV0Ni?=
 =?utf-8?B?dFppeFFUWTkyOC83NSt4RFoyRll4bDJkeUZrcHpQbWE1VEdSMFBhSCtSaGtT?=
 =?utf-8?B?bXR3YkFqNFRQZWx5NEcvSkRVSnQ2UG5pN1VYOUNxV0VlN0pKbkRPejFuMmVi?=
 =?utf-8?B?Zmp1RzRpb1Z5TFd5eTcrdnJjWVVVUndMMm1VVUJtSjRzT01mY1dHVXM5dlpO?=
 =?utf-8?B?Z1Z4RXpuaDNKWVo0aWxGN1hIZ2Z0VGxnMnNTU21iUGdPUUlVMmpzM25Qdnl4?=
 =?utf-8?Q?KqI6H8cUzeoBWUrc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4753d3-366b-43e5-c05f-08dec63399a1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:05.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCmlI+4MkqTJyTPZS4JTGV7HqsYl0Yj3rLw0BusyaUiokMXBM7THkF3Gp2NGHOdx5gGJhyjqr0mz9zL7OmemNgSJmCh2qXTHCralcvJcsS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7782-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41D936613FB

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device data and compatible string for NXP S32N79 SoC.

FlexCAN IP integration on S32N79 SoC uses two interrupts:
- one for mailboxes 0-127
- one for signaling bus errors and device state changes

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index adf3af57fb0a..b43d60fab4b6 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -403,6 +403,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
+static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_IRQ_BERR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2222,6 +2231,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
+	{ .compatible = "nxp,s32n79-flexcan", .data = &nxp_s32n_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.43.0


