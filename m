Return-Path: <linux-can+bounces-7768-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+KMI3a+J2rC1QIAu9opvQ
	(envelope-from <linux-can+bounces-7768-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 09:19:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2979165D1ED
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 09:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=XY+WNBRn;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7768-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7768-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97F53302A8BD
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34694385D7C;
	Tue,  9 Jun 2026 07:19:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8228DB54;
	Tue,  9 Jun 2026 07:19:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989556; cv=fail; b=icX7IBvT1B1cc0jlJ3yWkB57yHj3hTmZD3G+0KdYKBWsAQHTRQsu8JqpmDL9cHZtwQSS1CEY1WIMWhaBirakMlspdsYJYFcQYFRvJTcCZnzjNVICQoHPZ1+fOOeaMuIYZUV7e0Jf56t0vVECadTjs33Fddp8YOtqnw/ak2QXn3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989556; c=relaxed/simple;
	bh=689QpCSAtBjFRUQLsuFt/k2FN/DykKln3GreVuQ1e/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhgq+DLLdgNwfNVu77jjNCLZpzGgSIYGtYbXQzpj7NI2FTIb3LZ1cTmEZAso0YCXvuxvWKZfE76XYzD25Xmuka/NCRZKeDFJcW8SQl/ZdzG2u48w1XngyIUID/2YTQzzkyu2S39ltr/IO/bwJXinkV90UrTq1si1Z1fBZ66gQ1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XY+WNBRn; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWW+ksse/3I3DXm2r3wMjNdc5+hz+kH/xo3qrsEfDWXxZI6WgxOCisdtSn3M5lFZoXR7xbWSQ6P+7VjsoIym8et4BYXdZUt8fsdw22dg+4VDfg7QCq0cwRcH4t8eVBqTsEHEv3gii4UgAXVAKwijfzJpixNsHJZSKPE8iRGEaITzGinIWlQ9Pr333/EinFMcozna8OP+GAdUge4tb2PMrhmdyXwX4nLwK+oKkQe+IBOlMLLzD72pbCTC4uL+sMpAzXh7qnIxUZMOj2d0SDPhvdZ4NRaf9U0HLCoXJtWcGluWd6oVJVlFyOHLMa9E9bmrCHHb9gLY7W9KQ+jrL9CVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHLU9Wv7U2nV/lzMd0Ob4wJkLcW0JbeSeI5RPzv4S/8=;
 b=F0BNQ2WZWIJwulGzCRQKuvWeUj3+E0B/j2WsO+enkVJh52W4isw7N+hZw/z/wiwV6i3/55VrVJYBpoEY55qGYibQ9sKe0R0i/UNFYa+Iy+SmXpuOsPV2zMCJcxNotwyxhzgdIiB6OgSjCw6VYGFFYYD8DF1fdQfl7pINYlYMeH/SD1UQgOwm+Br8QiEO6AfxM3qMoiLpKqvz23AtaF2lLXFV8TNInvcY6mAyUyYvTffrorIfHqvMd115Mw4YW/q8VxJsBfiZGebpySOTFrWt+5PQBsGyMlLNv/OOiKsEZYpZbambN3wboaLThSJk9J6oXzRfTLbxWDUkHfaifkRNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHLU9Wv7U2nV/lzMd0Ob4wJkLcW0JbeSeI5RPzv4S/8=;
 b=XY+WNBRn+rfjhZb5aVUr0rS6J+J0o4C7yIMizOhkEOvCvgmYzf+OIuuQWAfJKUCCOpT0a84Iab7XYaWx8mZ2qiGtqlrVrZjNbiEALsEe0NMgXFCZkLGpqTdk6bDhIE50Domc9/FAqv8pw4S1bglRMr9n/zI6ZYmKrUk1QAG7XcW8eIjJ/C/xnmswJPY46VCFGL6qsOeZXuRTTHAUG7ibVULztDn+G+b3QvMcYfvJ3974xqqVaqX1iAB9FKrGdnkG9vlFE6Zz7Us57GN9gcLHkB1STaqW4IwvzEF4kH2hvatour+8JiTokbGi5fspGO4BR3/MkpgtqHaOiWAKyVAQ4w==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by VI1PR04MB6895.eurprd04.prod.outlook.com (2603:10a6:803:13b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:19:05 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:19:04 +0000
Message-ID: <971e5c8c-dafa-404d-ac6c-8e52a42b2986@oss.nxp.com>
Date: Tue, 9 Jun 2026 10:19:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
 <20260603093941.ysev5do557hy2rui@nxp.com>
 <CALE0LRuqZhm03QbYg-ZOJcKe0XqCLqVZ8j-4o07QuBF-OqX9BA@mail.gmail.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <CALE0LRuqZhm03QbYg-ZOJcKe0XqCLqVZ8j-4o07QuBF-OqX9BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|VI1PR04MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e8932a-f7b9-4da9-41ce-08dec5f76343
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 BMmmMRuOc8kbea7C9r3kzpcQDr7D4r7h712vv4DlrU6Q2Y5PW/3W7EeJgKzeK6QY2v7jWh8qgbazTJoOex6z3fX3G3D5xhe5tcHQmjRidZ9Um6dlQsR5LuwtsRkY0AP0o4Jv4dJu33GzfW+5s2jR0myvvVodWwyKKGccwY/6HpSOoUaxtNzIPMIAbopG1iR61xGX6OTPIYIvl+qVp+4K0CqXMmM60jF5eyjM/AYIYGuWFvuEHfI09jkefjUXDOrrBAYrNdpdO9RCwxyb7p23sQhczMvubM4HYa0vik9nvoY5fDKtPvgFSvyVpE3OWi1gW/25f4kIeue//6kJ8fIubvmtnYMqL2lfSEsRwpHvjWw18o31IVEB9NnXRtD40fIjGIk6fd8/RrvWcjLeGlL/kXs7d45Euc/8rSV7oqA6FidZ5iG4DL7fIqZjtxO6kRFMHIwzf+G0fDgWWQXcHFS8DlKmX5bibHwcvDUyofd2HE0PXPubHH9+aaqSWCetM3Iofm1WwWjeZMC1sihMfYGW8vSjiiMObDBpyVd6n6KdNu8bizvs5Mu04nDK8btDPLAWjYyMBM2QQtkrAevV6fdsnjn+9c+AQkyFSX1cjbvte622IYIXJSBETBJZ1YggVicCYNoWlE5eMtgvau5sMgnDZZ58ciRKFWYopRDWHPuoLzqf65mT4SUXRO3zx+CH7MSl
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eWtyL0h4eEt1ZUZ1QTRaZ2pkOUZ1M1lYaGdiczV5aFQ4VVF0T2R6VEsxdGFr?=
 =?utf-8?B?OUU5RWJrTDB5d2llT2NnbGxKR0xZOC9kdldTTmVBc2duSVJpaU5HQWFIVndo?=
 =?utf-8?B?bUh4c3EySGZFcnRUdFVwV3FpSHVNOXdhVVE3UFhyVzdHS2J0djFwbEVuZVVY?=
 =?utf-8?B?QSs4WkVXYVBIZExyeWZ6MUFWUW9Sb0hrbGRZSGJYZE5qb08rNHJrbHVJMFFo?=
 =?utf-8?B?YTk0NWdlOTVqNzlMUTB1RVpnRWZnSU1kYTNDOVEvc0xTVzVXdC9nTHNLUnBl?=
 =?utf-8?B?dlNaRWYvMTY5azdDOUtvSUNCdUJBZWpOclRrVWpvU01Eb05nelkwWXlkT0t4?=
 =?utf-8?B?b2xqN3dXWkt3akFuMnNIT2YzVWhmMVdCcSsxKzVPajMzbEI4a1YyR0VxdG03?=
 =?utf-8?B?M2FSVWNGVWRheGxSMFVTVzZJTS9rRElUNEh2dVRucHczSS9yRDdCWSsrN1h5?=
 =?utf-8?B?MldCNHdEelR3K05rUVhyTVVXZUxiZG11YitpaXZmZzhaK0pJekJwV1RwaGdE?=
 =?utf-8?B?N1pXQ3BJVWhFR0paZU1Gc0dJdTUwSHBpaFRxNktmSXdrdXN2aTViaUdpZWpE?=
 =?utf-8?B?OWgzVld0elpsb2Vjdks4dk81TnRSZUpFQksvSTlRd2VvUEYvQnp6UWdqbVFS?=
 =?utf-8?B?c25CeUg1N1lNMVpweWZEWHB3ZThiRUlFSldYeGhJeVFUVjdHNzBnVDNrMSs0?=
 =?utf-8?B?bTNzTzZvQWRzUTBEdVVVMUVUMERtVkVTTWNObXFOYTQ4czJBSHNUMUFJcmxO?=
 =?utf-8?B?NytQaE1pazdUQnJKbklCRVFsVUx6ZUtlMWY0aXV1d1B4RExvem40MFRXN1d2?=
 =?utf-8?B?TjRzdmtENFZ5ejArZzltaWF5YUFMd1piUjFocEVIWSs1anZ1eEpqS2tDNkZp?=
 =?utf-8?B?UXYrZ0FpL1p4ekxVc3dKQlZpR3VHWDJ6Y0xiR2ZzYWgya3BIcmpMVVdGWjVy?=
 =?utf-8?B?YTlUaGtwdFphdEFDbGpxMGRNZ3daSUIyTUpiQUxoaTlsM0p5UE0xcERWM0VD?=
 =?utf-8?B?K2Z5aWM2MjRObDhPblBSUkdPb1BndkdZVGg1Y3QrakNEWHNMSDh2Q1VTR0NK?=
 =?utf-8?B?MklsWFNMOGJpWFhuZnpLTWFXQjUrVGVPWUF4YUZiSWxNcVl6SGE2Q1h6NWt6?=
 =?utf-8?B?RC9WL3duc2d0RnJxckpTOWxxbm9zYXh5SWlNMWNtQ0N0bnIvVVlhL25WKzBz?=
 =?utf-8?B?anZwN1I1YWFtVWxkZ3VWeXpmNG54TkwzQmNQWnp2WlZqTTQ4aFZLSE1aRk96?=
 =?utf-8?B?cTNpYm12NTBmODQrWmlHWkc4ZFZiNEE3cnhIV1ZYZUExQUVZcjlEUjhwNWZX?=
 =?utf-8?B?OVIrQS9iSW1tYnZ0cFIxT21TcHZlWE9yMnBTU01yeVJua2Q0eUpRMU9sbXR6?=
 =?utf-8?B?Y3RBdnF6Szh2a0tTZVRFU0hBUVNCSU03L1I1ODFCcUJ0QURoVlVNY28zMWxu?=
 =?utf-8?B?M1lyTmIvdWNyd2R5dWpWcktHRTVHNk1sMGUxYjRBTS9nUk91YlRxU1dNa3U1?=
 =?utf-8?B?NVdISGFyU1dKMkJJUFFBQlpJakg3U2FlWHNTQTlUdHI1aFJ4OE5wNTZnc1NZ?=
 =?utf-8?B?WithZlhRdlNSdUpETnlyc3FpN0hwQ0FHUllmaWJUODB3WXRJTmw4dHFrWHVT?=
 =?utf-8?B?eDdxWkxISm1sZ2RxTmw2a3k2V1k1WlBCM1d0NnUzS0tTZm90NjFWbi95QUVu?=
 =?utf-8?B?MzFuSks2WnBrcHVGNG5ZK2pBTmNKS21SYzFTWm9nbXBuSlpWY2JHVTVOUFFZ?=
 =?utf-8?B?TTluZ3pnenQrcGFmcFhZQmRxMVpqbGFLMmx2ZVJjSG1ZdGFjYkY1RW5hOHFv?=
 =?utf-8?B?TmJoNWJHZnJhUldwRnNSTnlNSnZiay9JV1JnUE5XZDJJMHRwZ0ExZDZlaXU4?=
 =?utf-8?B?Mm1sM3RNa1dBZVZFWFlmTVhUcks4M0hmR2QzUzZCUU5wbDlPVmMrZ3p0TkY4?=
 =?utf-8?B?UmtpZ1R5UGJ6MUpnYjJUUEF3Z2tiblZGVTJjOFdpZk1hMExscDhkelh0Z0pD?=
 =?utf-8?B?NlM4TW94VmJRSFB0bFZVVlROdmdIOGZDbm5oYmd6cWJldVF3MmRHeVB2MXNQ?=
 =?utf-8?B?aGtlVHc0TjdmUksybEE2Mk1LaW8vN3ZDRXdocHdMSUYxTGJzYzN1L0xtbGZw?=
 =?utf-8?B?bUhVYk04b25URG9sWUxERXlIbmNucllIeTVNRTI1ejZLTyt4YzdLcVZYbG9K?=
 =?utf-8?B?V0VxM0w2eTJiT2kyMjQ2TUc3SnhFaUR6UFRDaEx5UGdYVHRBaW4xSXRZME5y?=
 =?utf-8?B?eFRNWDJkeng5MjdVbFdoNzlGbkF3bmhsNVBRY3dvWitIMVBRZUIybjFyci9X?=
 =?utf-8?B?eEpPRWdvMWZGQUlVOGc0QUlPUFlaSVc0VE43cmdCM1VzWkNGaDU0a2w4U3VU?=
 =?utf-8?Q?3uVVelOs8I8N/I7I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e8932a-f7b9-4da9-41ce-08dec5f76343
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:04.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do0LAzTpXKQXmTVqJua5xwfwGhmssUbTJegHHzC/sqOn6NoiqCueu4/oadpQp9n1C1Tn2JOvsA+tE/teC6EA4QgT11MdV7tdpxDbDoJ7QEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6895
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7768-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol.vincent@wanadoo.fr,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,wanadoo.fr];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2979165D1ED

On 6/3/2026 1:28 PM, Enric Balletbo i Serra wrote:
> Hi Ciprian,
> 
> Sorry in advance for the noise, for some strange reason I didn't get
> or find the cover until now, so I added my tested patch in 1. Doing it
> now properly.
> 
> On Wed, Jun 3, 2026 at 11:44 AM Bough Chen <haibo.chen@oss.nxp.com> wrote:

Hello Marc and Vincent,

Sorry for bothering. Do you expect any more changes to this V4 patchset ?

Best Regards,
Ciprian

>>
>> On Wed, Jun 03, 2026 at 09:13:34AM +0200, Ciprian Costea wrote:
>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>
>>> This patch series adds FlexCAN support for the NXP S32N79 SoC.
>>>
>>> The S32N79 is an automotive-grade processor from NXP with multiple
>>> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
>>> other SoCs in the interrupt routing - it uses two separate interrupt
>>> lines:
>>>    - one interrupt for mailboxes 0-127
>>>    - one interrupt for bus error detection and device state changes
>>>
>>> The CAN controllers are connected through an irqsteer interrupt
>>> controller in the RCU (Resource Control Unit) domain.
>>>
>>> This series:
>>>    1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
>>>    2. Adds dt-bindings documentation for S32N79 FlexCAN
>>>    3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>>>       configuration
>>>    4. Adds S32N79 device data and compatible string to the driver
>>>    5. Adds FlexCAN device tree nodes for S32N79 SoC
>>>    6. Enables FlexCAN devices on the S32N79-RDB board
>>>
>>> Tested on S32N79-RDB board with CAN and CAN FD communication.
>>
>> Tested on imx95-19x19-evk board with CAN and CAN FD communication. No issue found.
>> This means this patch set do not impact the original platforms.
>>
>> For this patch set, feel free to add tag:
>> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
>>
>> Regards
>> Haibo Chen
> 
> Tested-by: Enric Balletbo i Serra <eballetb@.redhat.com>
> 
> Tested on the NXP S32G399A-RDB3 with loopback and high-rate traffic.
> No regressions observed:
>    CAN frames transmit and receive correctly, with no duplicates.
>    Frame reception showed no errors during stress testing.
> 
> Regards,
>    Enric Balletbo
> 
>>>
>>> This is a resend of v4 with no changes.
>>>
>>> v4 -> v3
>>> - flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
>>>    (not just dev->irq) during IMASK register writes
>>> - Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
>>>    each handler on S32G2 only processes its own MB range
>>> - Added received Acked-by tag on DT bindings patch
>>>
>>> v3 -> v2
>>> - Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
>>>    flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
>>>    processing when multiple IRQ lines run concurrently (new patch).
>>> - Added flexcan_irq_esr() handler composing state + berr for S32N79
>>> - Ordered quirks used by s32n devtype data by value.
>>>
>>> v2 -> v1
>>> - Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
>>> describe the actual hardware feature
>>> - Appended new quirk at the end
>>> - Switched from platform_get_irq to platform_get_irq_byname usage
>>> - Updated interrupt description in dt-bindings
>>>
>>> Ciprian Marian Costea (8):
>>>    can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>>>    can: flexcan: disable all IRQ lines in
>>>      flexcan_chip_interrupts_enable()
>>>    can: flexcan: split rx/tx masks per mailbox IRQ line
>>>    dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
>>>    can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
>>>    can: flexcan: add NXP S32N79 SoC support
>>>    arm64: dts: s32n79: add FlexCAN nodes
>>>    arm64: dts: s32n79: enable FlexCAN devices
>>>
>>>   .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
>>>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
>>>   arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
>>>   drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
>>>   drivers/net/can/flexcan/flexcan.h             |  12 +-
>>>   5 files changed, 316 insertions(+), 37 deletions(-)
>>>
>>> --
>>> 2.43.0
>>>
>>
> 


