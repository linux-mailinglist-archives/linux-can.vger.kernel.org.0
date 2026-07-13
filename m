Return-Path: <linux-can+bounces-8361-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9M0uH6unVGqYowMAu9opvQ
	(envelope-from <linux-can+bounces-8361-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:54:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E426748F96
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="w/Ywa1mn";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8361-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8361-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C7533018D12
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC73D5C1D;
	Mon, 13 Jul 2026 08:53:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BF3D45DD;
	Mon, 13 Jul 2026 08:53:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932807; cv=fail; b=JOTlIj7gIzP8tTrCK2RZollSoVW9D41Jp8sTNP4HL6mRYtncjiQ1LYlPh47esGVqdxs1Hd29Q9lI/Cq22DuHsr458H4TjpTGcUVRsxKc6bdppEyAtZmVyghRbWqir/gR2XTjPJu9hokmEOvDUQReBiy4O6CLdruBoPf8IhKgokg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932807; c=relaxed/simple;
	bh=L2GeK4P9A0OCzaBg3VY0hDTGq0jlrEjH8CorYuCjNb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5qsDjz2fB7JPMlIIHacNtwyzE4heq4ZHaIiqINmzRT/QAjnBgcX+l/37GPHrDZ7zsPIaPJ/RyU/4rhWUOiRdWYyTD31Jz+V/7hbcBCsvn+4gMbaZKouWos7JfIKOHu78OTz9MvuDOOvvzuXmhqDovMv3sMbXn8Lag9KeIuH1m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w/Ywa1mn; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfGSv2ZqCVph7B97rzJRp/ni47QmftZ7OPSHtUnLFympAcnZuMth3pRJBUm7eic0oLOuS3mj2FFwbek53/nbo34WrF+hgni5SmgqW41o0A5jFc+aeM7EyCer0jyStGAP0oGhfiflavIfZmtY51EunGYpBJEvrL1T6JuMIeQD2iHrVSjrqci5G63OFWsmMucaBcMovyYQ6DZI0iOQyazITa2TwbG1+mJLEK6Fcvh4dwoE8YX3Xji0XAfT/RHGkNjZnVJAxQzcfCtMfOtdYcAc79p+DP7He6vJBNkgBY42Au6+FZBzn+j9j8MzquTtwmqIO9ay0YCUvzNtsVT4q0vvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYysnO5TUDX/ijxoCX0C5JjYD7tZK3PMESQ9/aXD9cU=;
 b=YmRSzU+7f2QURKjPek0eI7MikheTTkZ9mr0f8E1qxA+Q6MX/fMFzMKFD4Ujpk5vUT4dDhygGdy9DLVnLRPHQQfWfN4H5eaTp51uPABRnpoUU6MX7FFK3x6ah7mz3QShzjoZOKTtEHxBQSSoI4OEXQVIjgIagWECB5MPXkOnBoWLjPoeqXbnsJmIxx/DFaldimwk7BQcRTAChdMxchl5L1C/k+sNtGaa43SBWqYxhni0Fa6UpTpJ2Sh02qB1nDM3mGrc5jB1m7Is/YpYhfcgPmdBAAF8tpqKlsa6c4cVRhxqKHL/kQXd9IBfWNCbQv6aTYaudn7xuml2OMJzDg+8tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYysnO5TUDX/ijxoCX0C5JjYD7tZK3PMESQ9/aXD9cU=;
 b=w/Ywa1mnszNeFt+JfmMS7EVHQwQ8O393O/ZVoSwGkCPOprPjYGkM/Fg0/jsFqb0ZLYi65D+jAHjkIxqjM6qtSwlUwt9C2uQHhY37plbf6ID/gtvBEFbgzrIZC+q6sBc/Jsh9P9uwTWKGzKO6YuLBgohxrNYTln6p++a+mkxgM94GgfFlzp/qla8h9CXiMVwL6muNQsVyKYRIgkrecM4zx3F9JRka+p+7WZ/f1xghMykRiuUerKKgXQ4Ouu5vDmgDWvsN+n0Xmk90gaRYg96QkzHoWuBm8eKGQiTbV3coCEmqtEK38+tVtIfRs+Hp7VNakEKC8RI/juVxwzAky+JJVw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:15 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:15 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Mon, 13 Jul 2026 10:53:05 +0200
Message-ID: <20260713085306.2643794-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0054.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::18) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: a893f518-6c9c-4c64-6428-08dee0bc2d84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 LC3E8i9BLChyRaiBS17J+E6IR3oBkm9TckJz7FsbaiqQiwL8bdIfzFCpDGmxbchL7zkxNaP8fTf/sMVZnybEoy1u8PQnFRMOuFyktGrVzgsc7/PcIWCp4zPvTfHctSG9tG0jATsWVLgSNA414gcZeOHDr7YJ9f9foV/vydk1HQdYGwAO6Ms+hqLwg8uRYog3TOD2CtuK3ET9FtXCNuuXyPUjuTlI1K7VY/Ep8VKM9EaEmDPKztFZ/B60yjCO/OvT7TGs65ZxYTBH5zonHytp/51JBrEz62C0gFR4Q6lRJJZiiWUiRl5wkubLzKR8NHqKVyLol6JihaTZESmU/jL1wl17MMt645CQgHBOoHN6eZFTtLuOyNxaKnIxhJPv5IG0hxGL4MeaDawLhJY8s1CrR0Emj4Ci9LUbceuq2vqBhsFtb/NKTC9qEwcE195RSjOplJAHaMsTfaooa0A45cy5UZ28YrColxYpGUTWgCGVQAwveUlsusP9NhPGW55X3GnXvXFde1fUIuEymLwImj4CkgE3h4mzMGgexJ+vrRN2Oici3u21h8Yo2AWhUySQ+Zp2S3ut6a160ulL2ERg/aZynXPIA7Cux7JNM3/LNbnV1wZRjHkMHH/ps99NjHg5tR2EJ3+Bnoy6VzlRdofUC3OXYu/pfGFIjHk2KuIGCjLJGgo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(10063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VC9Gdi9aSGhhZ1htWkNGLzNKdWd4ZVNNMllaY1ZSdzN6SGVXb29sSlRkR2Zz?=
 =?utf-8?B?Zmx0RjFUZVJKVU02RGt0TDV1ZkJtNGhXK0tRQTgwUkZqeUJIMW5oVHA5c21o?=
 =?utf-8?B?eXJOa2FhUk9EWVVTZ3QycW1tai9wWGVqWXBQLzMzZnlXMllkcGoyc2JkTlZG?=
 =?utf-8?B?RlZsWjkyQ2ZTdkZmcHVFU2FRYmM1TFRVTzYzeHRGOFB0RW5hUjBWT2IxcUZT?=
 =?utf-8?B?cVJGTWdzZWhScXRxbXF4VTIyNU14NzF0SXlIMTd5dUFSaTZWRlExUjFNQVZx?=
 =?utf-8?B?RitQVy9rVEFtU3QrSktyTEJzenJhUjJpKzVKQVFYaU16d0VOY29uUXVvZkgz?=
 =?utf-8?B?RGFWUnk1SkZFZTZQRjBIY3M4clJwaFp1U3ZyUkFXdVBZT0VsNllsU245QTR4?=
 =?utf-8?B?dlZkT0RIdjRYYUdpSDZSeEFDL3k4VzJ2bitXTW9JSzNvUVZRSis5enhqN0du?=
 =?utf-8?B?KzdGcnBaMFM3RWdQQ2NVblQzVUtGeVJaTG5WZ2I2WHphYm5uZmdNdHRaK0xj?=
 =?utf-8?B?dmxoamVmTHRlcE9SNy8vTUJ0WXF6OFlZV09EeFg0LzZTQ2tCK0JFeE9EWFFP?=
 =?utf-8?B?d0w2WFBWT1VuMUdxNHpQM3BoYnhHSHh3bmh4dHBFa1V6anZ6QXJlOHB4Vmxn?=
 =?utf-8?B?MGNNK2NkTVB3MmplSTRYYXZQZ202dm9ndklWbkdITHZVd0NVcUhGaTJuZmxo?=
 =?utf-8?B?enhRSE12S0lqYzNpdFdONWdxT2lSdDltWlNlMSs3VVp6T0w2MGF2a3BORlhC?=
 =?utf-8?B?Z3JNcWRhVVk5VHBYTzl5TXowM1lKaDlqWHBBbEkweWRGRzFaYUduV2ZvQkl4?=
 =?utf-8?B?aGJZemRTMjJjQTVJRXpTNkFtV0swbC9kMklwM0VLLytJZWpNRnRoNGh5a2xk?=
 =?utf-8?B?Mm9peERLQWhpSmhXaGl0a3hKZmxOZFJTZjhadm1TSHpDUzdIc0xSSVVpaU01?=
 =?utf-8?B?M3NYOGx0STJRd3FFM3IwL2VWeStWT0JrcGFjZzMvRWZzVlc4NWJURDhvclRy?=
 =?utf-8?B?U1o0WG5TZWZya3hxT0hOaENwcXVnVndkNU1uZUxBL1dsOE0wcHU4NFF4bGlo?=
 =?utf-8?B?d2czMmJ4eVlCdk1rOHUxOUxUZ1VzcUFiSE4zN3pyUWFHb093eVJZdVZTWCs1?=
 =?utf-8?B?eGV2WGx3akhKb0VJcWRldW5KdGpVdkVqK0p2Tk9OZFFCM2dKNXRuVzFCQkxl?=
 =?utf-8?B?WnNsbzQvZFJsWFRWSGU0YlQvWklOTlB4Q1JibUhCZTBsb2JqL1g4QlFMOTNO?=
 =?utf-8?B?QXFTQ3daS0x1dnlsNWEyVkpyRW55QmloakUxcnVsdmJpNE9hamczTzloakoy?=
 =?utf-8?B?TXFpcTBXcG1EdXFRWURhbGY0R2tQdHo0NnBXdVV3blRQV3JPUEU5UlVpRVo5?=
 =?utf-8?B?T3VvL3o1cDU3dWp6OUQ1L3JPc1ZreTlubmxKdkVRLzRyMUhDRy9BVDZ3ZXFn?=
 =?utf-8?B?L2FObDR3dytOSHlZTXo2UTFtS2dzN0k4YjJDV0puTUN0dHphZFA1ZnBFVFV6?=
 =?utf-8?B?Unp2VUFHVmFFaDFLK0N3WVpuT3R5VGZKSmg0SlZSaFdUZEFqMW5UTzlhNEJu?=
 =?utf-8?B?M0JZQUN6Zjh4SzhoMHdiTXZYak9wcCt6QWswZzJXZmhoanJqcXdoL1VNd04w?=
 =?utf-8?B?UFl2N1J4TEo1aDIwSlVPSWNBcHN6cUlrNTM4MWtTVVU3RmtJM25tekY1bmpk?=
 =?utf-8?B?T1E0dnJxNzZzT1VaNEdTUlFCWENaK1hIQy9EcnZWOG1Scmp0bjRvK0NYRFdm?=
 =?utf-8?B?bkFsRVVIZEg1RldjK0pSczdlY2dLdlZSNU5CMHpadVAzWk1jRTEzRWZjc1VW?=
 =?utf-8?B?VWFMYWxkd3VYQ052Vm1xUC9TR2hkRXJoTC9rZnNDcDJEbG1wbUZyR3VkcGpr?=
 =?utf-8?B?NzViWWJxRllJTHo0dUUrZjN6cERJU0NBSzJrVTYwUktKRHFQUDhacWk1NzJa?=
 =?utf-8?B?Vk5rUXNTNU52Z1ZNMm1ld0FwSWVFM0lmZUVaNERYUkpDNDBicFJyQW5wcVZw?=
 =?utf-8?B?K2c4UTRDRDNOT2wyY0UrYkQvRnNYL1RSeDlqSHlZMEZnc1VZdE4xM0xLMzdO?=
 =?utf-8?B?RWszZEt1eUNla3RoM2IybDdPbGJTckZBaHBaR0FIOFBTYnFvS0JGMVNkZjRv?=
 =?utf-8?B?OWozNC80OW1uVmdwWGozK3g0YnBvM09nancvaWhvMmlQKzFqU0JIT05pc3Za?=
 =?utf-8?B?YTFoaXFVVUlsMGwwMnNBR3BZVGFCNHFoaHhqL3pzZ3lHbEhpS1E4Y2xpR2FO?=
 =?utf-8?B?aU05dnNweEVWUmUwbkhoRVBlNVVVNndrL2U2b2NTZVU5Y2VNVTl4YXVZTWQ4?=
 =?utf-8?B?Uk5rM1o3NnVhaEM0Y3B6WEh2NFg5UXM1RjY1QXQybmRFUEI5aXZkOUU3SUN4?=
 =?utf-8?Q?9Y7k1qghdo1sBG60=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a893f518-6c9c-4c64-6428-08dee0bc2d84
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:15.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWbHtACn5pu1X9UxWi98RIp3YSBFcd5iz/SzR+W0Ybz5NoBtEAqWBVCb3s5jQlRGnIzNZtFh647TwIsVI/DwvPMXEVGn8DlNhpTOKWdywj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-8361-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:larisa.grigore@nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E426748F96

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

Also extend flexcan_chip_interrupts_enable() to disable/enable the
new IRQ line during IMASK register writes.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 53 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8b70952f7f05..e7e3fb41f55e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1540,10 +1556,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		disable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		disable_irq(priv->irq_err);
-	}
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		disable_irq(priv->irq_secondary_mb);
 
@@ -1554,10 +1570,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	enable_irq(dev->irq);
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		enable_irq(priv->irq_secondary_mb);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
-		enable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		enable_irq(priv->irq_err);
-	}
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		enable_irq(priv->irq_boff);
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
@@ -1881,7 +1897,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1902,6 +1919,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1916,7 +1940,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1948,10 +1973,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2338,6 +2365,14 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..bbb1a8dd4777 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0


