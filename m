Return-Path: <linux-can+bounces-8360-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FJw0EjaoVGrCowMAu9opvQ
	(envelope-from <linux-can+bounces-8360-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:56:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B5749017
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=B2UWrg9m;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8360-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8360-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92394303E210
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084633D565A;
	Mon, 13 Jul 2026 08:53:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAD3D5244;
	Mon, 13 Jul 2026 08:53:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932805; cv=fail; b=k6gRsHnEH6RwRLs1JYCzg/YDFKC4TCu4b1WiYPgBYKwSpHEihPMkN4TK4K1OjFHpsncfcjE+ss0E+hT5jNZS8g14XXV+jVgiyosvDj3GS0OSB5GLzZr247gk3VwBwjBOiBLWTS7CCaLJr5fN21wYFA65zmrjp16F79TuuG+LVOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932805; c=relaxed/simple;
	bh=1upDEasXsZkAK0im+GIkBFqGG2oU1/fr19aNvoErZ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/6dyVed5CVviSQ98J4n3KmytblzjmUFK/o3pO8wBPo+HbTPmDqSjyco+MLpdZHJ+xbs1tC/ldfv6acF39NXD28Wr9n6y0weKDu0IS1v1caYfV65nrwN/PA84QL+IMi4qBS1M/e7cqIIgJs4nI1rnfMH43jenIahLnZYKvm6A8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B2UWrg9m; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0JZ95murCcPsoY5nISyoYDp1xOp8JAskS3JJT3WMmwEr4y6kJ2RXg9eX7aVDex76ssMtOGtz/quif/NtdncuduNyAwQV1bfbGvCxyQEEqIoTXmjMgMO0b0k0TXcVAjf47fEQ+wtiKeKdYVNvgOJfOqTFZKrTH7lO5CsOrsBs7/lhsgTVOl88VdaHyPzTPGcYdAomz/bVcPsZH/gwDCi8n8jgV5IehjwYm35Cvkb3Db8V+qB4Q71BHehqo4S4aAzNfzik8RgGhLvabSM6/s0u0k97Bs3g9WGTHh5dqAdM4eu7iutMMVn9i/4pyyC4/bivbnhFaN2m31x9gqbZsVmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=Mo0JKurCIzCAQrGNi0gvhdrBWx/qRS1/7zEIvABOrNSeiZet35r0aMnTQuLV9cSv2loNAqDzjOG56siXTELMfgSCvAGk59Sgk/ntXb0TQb1u/R0JVd5+QzQrT6J4lRj8E2qvcOBGdNK8+9Sjm+rvKfcw0KZ2tj6guezp6jYNFZImrfMcSrjELP7Rtk55zIn14+QI4CoHpL2xza0RLHb9a9DL1DR+BIZN0iS+SgLVpfwbcIEVTSNyeq6NlgurZqLaNd4WHtne3SDqNah+jHaxtpsAkA8dtJ8SahvQZjwNiGNEaLqAkeK1DWlzLJFcnENeL3FKWjA1ikzF0EfWQ3OVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfLF2os2kzzc35jZf3bjNKQLGWICLw+dnzgpzDvFcWY=;
 b=B2UWrg9mQy1Q9Etik6ZeHLeTny9wz2+H4chlGap7n4odVPBQ7F2q/cz3NYz+0jfhB6nmegf17NDkNOGLOJ/l7OX3SOk5CeWNFPxWw44OXYMpIMSZ9Vo1zatLDwdonYNFyM+mcGe/y+5VkiWCNX8G9zQkPPMh1a3EMJF4qr7fC0ckzb8LTopN5tduCCVHf9DJqZ0tMQ7E+OfjM2U5eOEn6oLnaRhXFCqzaMssdZFcS2bymQCNsQbWLar1lX5DygDSyERTB3mMivyFhGVk8Du1lR5Mf1ZU3zYBHjK7rMz1qqmJHZ+9mXjHZm8p+arjyoZT9Qaqd6BfThFEE9xXzWTIGQ==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:14 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:14 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 4/6] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Mon, 13 Jul 2026 10:53:04 +0200
Message-ID: <20260713085306.2643794-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0059.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::26) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 37bff051-4373-4727-78c9-08dee0bc2cd8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 5e3ukmQvYVOEBHx38VhCFIFCuUAHKYYM9j4GTug9A4HOQGi4SOpECNVpkd+HAxccTrdOcOz8Ke5rCFi+ecZ/YhkHxCptcZPdZfbI9oo+Tc6iiDxRCR24iR2Z7cg9f3dCtBpYSzJB+ANwHo08tgkSR92j/Vku0gLfyhN6lbFPrRsfORwfRKcS5p4a8v228rNbj6NZJdGJH+EYXVUn5w0a3Nr2uVqshe6PyBd2j+knM+QJbX6554U6lH5leWntm3tFJbFI8wjsgHvk90gafzGhoK8NY/ZI6bGUOrj2OJ4eUP6AbN0SqgbdN4aAiHLyE+js0HtEUNGNs9eonrFISDGxIyB1ZygD7x2ax9Xya7qbBqQPnG5knNbxaoKAQcigvP91jFgw4CDx7mi1he0kyazSgZoLKutP48OMfmk2jUGiRhFduUi3A8O2XDE5aYbAL+464nH2aiU+ntAjzGdXNYK+0zRsaJdQCi8p8LNl+sxByVNWNIufILP1D2jsEGz2Q1dQzL4s0NzWNS2L6late3BqjAIa4vxSWEoup2pQ1NGTFGKWrbiv0KrthHc6WAn/tz1aJY+kA60RPN2Eph1BRiqa/O6QiFeRIISC8dHuuxQXsk1MMqQNGf+os/pFn4Oo9jPme1+mCNzjwYIbP+tPxSF3N638Z6ppl2biFradtLcua/4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RXV4V0JxcEE2Z0pSVWRWOGx4Tjc4RzcyQlNlU0hlUm1TZ3J1ek5tREhGZm9F?=
 =?utf-8?B?Mkd5KytEMXQzenZKZ045R2FDUEFUT2F1bUkrWXMwaDIxekhIYWQ2bHF6U3hk?=
 =?utf-8?B?UkRiNmQwd0wraTBuQlg1MTI0ZWZGRTU0bTNOblFVOGJSS2dXYy9wZk9TWTFp?=
 =?utf-8?B?djY3QWxQbjZuckZQMXp6d01hOWdudDZkOTlDd3p0Qjlrd0l6MEpIV29MSWRW?=
 =?utf-8?B?aFZnNWNxSGhrdDNGUUdVRC9vbUdzbG9WbHJlVk0zMDhNWGFpR3lQMFdkbU1a?=
 =?utf-8?B?YXdkWjc1YTgxNmxxekRyeDUzdXZ0ajNSS3dCdUZCNHcxTklsZEFXSVltWEFE?=
 =?utf-8?B?a1NyNTFIWHNLcC96bjhPaDVKbmpvTnBoM01IVGZwQ0tXUDRjRVVvbWRFc241?=
 =?utf-8?B?RFlzdmFrdWp4bnlQODY0dGNTUUlpbFFDUEJ5ZFY5MWVKR1djYXdBZEhlY3la?=
 =?utf-8?B?TGh0bmdveXV2Si9RYkY3WWtxWkVxWXNLekYwS2FlQk8zWHh6V0E4VUpNaUd3?=
 =?utf-8?B?OUM5RFpTdE9CUnNua0NPbVAyQmdIeFljYnJPMnlRU1dDSUxvVE1HVmJObCs5?=
 =?utf-8?B?ZWZhTzJYMS9iVkZNVWUvM1RWdFZEc0Z5VHU2OFFjOW9qL1dFSUpVdURlcXBS?=
 =?utf-8?B?REthdDJua2w5K3h3cmRHcWVIajlzSnhRQk9zRVdETVhua0Vvb21pYVg1U28y?=
 =?utf-8?B?ZFF1azFSdy9QQnVYd1AxSVE4SjdGSUJmVWVSSjNMdGVUQ2lQdmxOTk5kb1Ew?=
 =?utf-8?B?Q1grKzZoT1B1YWNnRzhaMTgwMS9KaXNYM2k1amZaQmpKQzhEV2c2MExGUDkx?=
 =?utf-8?B?VUNRL0E5SlBlZldZL2hwV2Jsd3dsUFlaeXRsSi9naDAvSFl4SkZPYjNFNEdB?=
 =?utf-8?B?c1c2dXNRb0J3eHYzYkJpS3RRM3htZFE1U0lwSHFnNWt1T0s5RUNHSkFhclVB?=
 =?utf-8?B?RTFHZWp0eVhwUU1pcExxeXdmdnA2alEyZ2VvQ3FwRkJDQUtaZnlmWVVIS3ZT?=
 =?utf-8?B?dStBWVNVaHlkVDBtMndiQ3J2QW16eTcyWXJFckdPdVhKcE9uZ3ZUV0JVeEEw?=
 =?utf-8?B?c3MxaGFhQnV4TEpGRm4rSGNtVXgxTVIraVFGcFlRT1FkanhBbFM5Tzk3Nzd2?=
 =?utf-8?B?dW1GM1VhMlZ1Ymg0ZjRpTnFKQVNYdW9ESy9KMzB3T0VNSHB5V0RLcVhBOWYy?=
 =?utf-8?B?b3JVdUs3WlRCQTJiL1EyKzJBMW9vM3ZRN0M5M1g1c2JjbnpKelFvaUFMcHZr?=
 =?utf-8?B?NlRPb2lPOWYrTVBLZGdreGlRN1Y2MU05cjcvdjZmd2RNeHl3RXZObDJHYjBO?=
 =?utf-8?B?ZWNqbnhkMzVrcEFrSHhBd0NReXBHa003TEV5SEJBbmFkZS9lSDg4NEk3cjc3?=
 =?utf-8?B?RE5KRFpPUmNFVk14eTYwYWR5NngwM1R4SWRkUGdoclh2Q0pZWGhjYjMwNGVN?=
 =?utf-8?B?QU9pWmduenZqM2o2TnVuV0VZV3A2Q28vdWE4b081Rzh6V1g2bmFyQWYzRzBa?=
 =?utf-8?B?eHk4ajhVUy9lRm1tejJBbVlhdUl0M2k1RjlLNVQ3M2JSRTQveHBvNVdlY0ZE?=
 =?utf-8?B?Mm4wRFpYeDF4Q1h3bmRpNVBEOHlpc1hmS0dEZzdnOEZpV1h5SFRuQXFEcFlF?=
 =?utf-8?B?YUtQY3RSTWQ0U2NQRC9QWTFJaUFhLzhnUEtRUlRGTDQ5TGI4MjB1Y1FxeG1Q?=
 =?utf-8?B?SlJuNXFHNjRtcnB4OGw4Q2JCUitiaEhtYklsT2p6Myt5ZHBuVkhqNVZBZ3Vn?=
 =?utf-8?B?TTh3aEZYUkt1VUVYKzNLcjhCV2JYRmxQN0xnZmJuWVBEOW1laURsejIrN2FV?=
 =?utf-8?B?R3dkdzFOOUFtYUhMZDg2bXFpOHpVYkdWcjRnK0ZNcUVQNVdYSGF2bW5hZTBk?=
 =?utf-8?B?OXZvTVFreHF4UXVSZEhhREJ2bnNPcnE3Y0FwR1Zob0ZXUjRwR1NjWFBJWEo4?=
 =?utf-8?B?MDc2YzRHeWVsK1hrYjJoRzF2S3JnTnB1Y1FTaG5CMHJtSXZLSHhBMkFpeGFM?=
 =?utf-8?B?UGE5K09FWnM5TmEwemtnOElQU1Y5Z1RYTjFQTFV3aW5wbzVXd0xHck9VQzVz?=
 =?utf-8?B?d3JiUnBPYkloNk96aHpLdXAwTndaYVFUTXpRVzRsaiswcWJFOFNpamFSU29a?=
 =?utf-8?B?THRCNllNZWtmRE13THlwMVMrNHBwYjdIYmtXY0NtWWxZTlBxRnNDN2hWb2VR?=
 =?utf-8?B?d0ZSTHBpSm12Y0hRMjF4UFVJNkRROGMzb3pmakpKSTlIRlpLcm1BYStsbjlo?=
 =?utf-8?B?V0h2UFdxeTY1a1QvSkJIekR4RXBCZFJSUkxkL1dPRTJSR3pTQlpuN0NydlJ1?=
 =?utf-8?B?Y1c5TDYwcFZDRW8yRnc3VjcyMHBMc3dFUmdIV0hNUFNNNkdUWmdKSk5CSFc1?=
 =?utf-8?Q?bolSos+WHIIlH3HM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bff051-4373-4727-78c9-08dee0bc2cd8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:14.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opsynHU224+LQWczraDdIyvYkr1KTTnukgM4vp72f6C36pgsRovGZIqrubJ9//MDJC1M7wUEtYjqUaHfDu/ahmfJG3SWKhVRMPGObZ5GpaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8360-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:conor.dooley@microchip.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 029B5749017

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..d098a44c2b9c 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -26,6 +26,7 @@ properties:
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
           - nxp,s32g2-flexcan
+          - nxp,s32n79-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -173,11 +174,38 @@ allOf:
             - const: mb-1
       required:
         - interrupt-names
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32n79-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-127
+            - description: Bus Error and Device state change interrupt
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: berr
+      required:
+        - interrupt-names
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,s32g2-flexcan
+                - nxp,s32n79-flexcan
+    then:
       properties:
         interrupts:
           maxItems: 1
         interrupt-names: false
+
   - if:
       required:
         - xceiver-supply
-- 
2.43.0


