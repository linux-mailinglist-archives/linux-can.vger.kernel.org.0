Return-Path: <linux-can+bounces-7989-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZRudKu/FR2o+fAAAu9opvQ
	(envelope-from <linux-can+bounces-7989-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 16:23:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F051570361F
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 16:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cherry.de header.s=selector1 header.b=aHyqosBg;
	dmarc=pass (policy=quarantine) header.from=cherry.de;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7989-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7989-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3264304890F
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285623D9031;
	Fri,  3 Jul 2026 13:59:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C63D952F;
	Fri,  3 Jul 2026 13:59:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087198; cv=fail; b=O0ryGy7upZT+3s5ysV5xEGBpheMqOpi1n79ORLA6XpRjaB+nUmOqa2X3bC/MHdxRBPCdNArii6QdQoaa/BmNkyNeYo19pp4Aa3tkrdI7sdASvp2s+GLccnCnPcxOMEmJORQ/QdMG0kJkSWJ0dmbh/mzDddRhEddGLbbBqzWTp+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087198; c=relaxed/simple;
	bh=okb+rZTUXsjEYDqnoh+SJFi8KycEGrqmpyp0MKczMBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqHNZ9G1yxltNZPoB4okUwhpxKxgIJB0JeJYobh5YZZ5PldtsQScAjJNpSm/VPuW0URQYS/YEJ4tTZ4ZLaqZXp7UTstNZ5gn+pAgEzHYDP43uBsNfPXndbAbVTi+AMdO+3sWtIKXEI/wqNCXO5CaI/SaFVKu0tdpauLBMpb7sW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=aHyqosBg; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQolIkdtUW798ArCYHrm7KvjK9mw/FjXjVhX+K7N7m40K+QvjwHYlipijmS39DdpNaD1MU9gNhXmwZ/hEvgFlM0tcEsIklBaifQ0LvtMielTdEuyHEm49yRPo/XYyjEgtHYuzvZtu/UL/k7DyMZ1rVngWf3Tm+xDXzvM2J/g0+/6oQq+QR1VRhLXf/+LtI5pimMvN7ArTP4LXFJBB1/iIubmrl19qaHbRgSMDxcaOxMye37alW3AEc12ig2pg6Ry5ILjosivN7QW/HTMxhB7oC+XivfurW51LU5JiTS7PJzkvWepdMUQHjTkNdt8NvYXhtPZ2WJjIEVfTQSdIVzETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoUOh64pOK0N2k3aHaaNEJDWmAd+zqG9lemti22xCJg=;
 b=fBhMDuX6ayWh8zkTmE3EYP4fPf+sD3t0sjvOr0tZSnj095SanKAEkkWTtbyGVmcJBvzIoEPtxxx2aKwkokx9CkUA+VBlxJoiJLPt8l2QHTUlPKrQ7oFPJJxfOGyPxFKjcRWz0+HYuTDmq10sH/Li4PySje0149LqV65p5Z1VXMqxgXsEQEeC+1ZqcxWi0VnhQDWZWWNtydLFJbPaxbx0VRRdA4expGd/f/n5kzqlne0lGeh0/O6FOX9OK0OamwuBD3pwuvYkBazS2Itf9qeA2DZHtxrtEOkFEpO6p6oKiRNy/MkT2k2bbQzj3ZwgcqMB5JBpzPJaoZcTb0NvqNTuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoUOh64pOK0N2k3aHaaNEJDWmAd+zqG9lemti22xCJg=;
 b=aHyqosBgfltba+9gD+We3HcHYWieOphyH+tnotO//eHXcMUjiOowIYBnWl+VWutTiaP1cViadNzlZAApfidtaLM9kgaXF8qJkP6YaxvngH5FHFoOz3E1FjDg11DdF7XTmykQwo7UwKSZsFzxVYNcv7+xVQ623unB5qJRoI2vhU0=
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB12075.eurprd04.prod.outlook.com (2603:10a6:20b:740::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 13:59:51 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:59:50 +0000
Message-ID: <8c5be502-c520-42f5-9f2b-c49c04e99f6a@cherry.de>
Date: Fri, 3 Jul 2026 15:59:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
 <tencent_48121342466E02301067FDB89BEA68886509@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_48121342466E02301067FDB89BEA68886509@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B9F.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::62a) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB12075:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f5685f-c362-4817-98cf-08ded90b599e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	1tn/OD1Ol++6sMvLrKSjIePFSiIOdT/zJJ/vcq2zxnhmVPNlnLQI41JxDliczjZ6V1h/i2q/A6YY/W6BBHTfuPIqVXbYyozxh7AWxxTSKOfJ7hE48srk8xZGDDBi8gjrgg6nFXew+HTLjjiPnoKo75HzYLuobMupC/jlFkIJ25YzjOveKtkehUwOUz/4pyvcCa2SokEsN3koOAQy8pv7Whsm9MwHT6vKzh9NjrEWVlFhstrrrlQNywoKnrZtMZ0a8CLFtdksz4EsfElghO1uM7Uf5UfIh4ZO363q3evodolLG01+PqR1n63pa+blie4lMmsotnafjHYBFstX/Sh2nUqGfdxUREOxlL1Vl/JDppmAiddojsdPZzW176Antrtj/QQytL7Jabt2k9ZPkVNpQNjG1LRkn+JgppEXZK0WTF0y1aO1qF7mb/6VLkx7e46K5SQVrdD+SuURknCwuo4m7G5cXn1D0wmFBX7+1s41EitnqgTrH4vPD94k112EEAdAag9W1mYtfj1w3MShcfPf8yn7HnQU1VWaid/H7wOhJhK+JxlofktjGg5raDlSXyDDVYjK/9rVZ4SZulB+jwSpy5oWOXvKlLARvWTjYf8RTjOokiRHW370jibIMhLApvCOgQfJh0Tl0/kf8MTfDS8OsTZoFHtealBGV3yX5AqgFNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1FKaWwxRzd3ZjdFZHJja3k2djE5RnZrdkRlVGhTVGJ6aWJFeWMxSUwxbGRT?=
 =?utf-8?B?Qm5QM0xBQlloNmFRb1l6U2dGUHArUzBzNHdsam8vSnF2NmpLWm1RQk80NU43?=
 =?utf-8?B?N2pWMFB1NDE5cHZMR3lJRlIvS2tMRnhtTDQ5ekZhWFdLTkNOUEpXUG8rMVZM?=
 =?utf-8?B?MDY2VGxQeHFQS3pDR0JhRXFJZDJzazRhcnltLzBYQjJnclcvSzlJUzc1UDVU?=
 =?utf-8?B?UHBhMXlxUkFpMVNlWDFVS2dOVVBrM0xIMVlSNTRuYTN1SldZQ21ZSmx6QUFX?=
 =?utf-8?B?bE9CNWF0dmhoV09LcnA3N2diMnhTVXBGWWtrU21wY1dvN1NrR2V4M0JzQWEr?=
 =?utf-8?B?eTN2SDdDVjBmUW42U2tvUHV4alpsTHNrMEY3aVVtUWhiV3NTTW5EQTdzdm9V?=
 =?utf-8?B?ZCtXM2wvemdKZWJScUdtWC81Qm1FaHQ0WVhFQ0FyNldyenhUOW8wUmJkaDlH?=
 =?utf-8?B?SmZVNWVGcCtWeFJPQWtRTytPQ3pqNnI1MzBGOTRkVEowVUYzMWN5Qm04Rzd2?=
 =?utf-8?B?N2tkU2E1TVZVaWZ5YjR2NjIya21IbVI2SFV0ZVVpcEJrT2Jmcm0wNmNmUFUx?=
 =?utf-8?B?bDhjZ292YWhoY2grOWJvRlhuRkNkUGUzUXV4Z2dXcWhoS1pwcG5hVHZVL0hr?=
 =?utf-8?B?QkQyMjBoNzhsU2VSMEcvZnkrd3NDM1pUK01uRnArWmNXMTE2MTJPY0dDUTI3?=
 =?utf-8?B?UStPUEw2QjBhclFLMEtlNlgrc0xMSWQ1UitRQzBaRVpHbm9wNWtvNVk0ZG5t?=
 =?utf-8?B?N3AxV3pnb2pVYXlGSjloK2dvMWl4SDZKZjhuMEtycDhuWXhubnB0aWNsVCtX?=
 =?utf-8?B?a0sxK2NHM09SVytJYXR5M2NGMzU0d1RMbEcwRXZkUzN0R2lpY0pRUHZIMndG?=
 =?utf-8?B?U09uNmtmZzc2bGZMVTRjM2xsTDRPR05JQUhVWWFwUjVmVGRKQ0oreFJsdEJX?=
 =?utf-8?B?SEhLd3JwMWM1dGtnMm9OSjJHdGlrNGdxRkVqZTFUUFZsTkJNTkZMUnBBM1pv?=
 =?utf-8?B?VFJmN3pySG1NTGlHaXVoc2Z2d0J3cTdkRmpwNTVtSXJuNXdJVlVEdi83a3ln?=
 =?utf-8?B?UFJBUHVyRnVQME1vZGhsOEJTRTUrdGJ4NjZVQ3hxSkFaNkJneHdmMTJWenAz?=
 =?utf-8?B?eUdjU0ExdzRSY0pTdWprTG1oNU96WlFXZVhWblhsc1NxWjFvTUlUOG1qdkRI?=
 =?utf-8?B?NTl0azgyZUJBSE9QSXpSRXR4Nlk3OFVjNUNsZXlhTkNFbXo4cG9lMmIrQUJI?=
 =?utf-8?B?MlNnSzNVbVIrbWllT0xWL0l6Q2JBNVVUdDRrQ1lrWGVrR0hkTnI2eHRvbHZS?=
 =?utf-8?B?OHhpMGcydm8rYUN5Y2FSbHBvK1hFMzBYQ29FLzlmeTJ2OTYrSjFrS3RNYmIr?=
 =?utf-8?B?Tm5JWHlaTXJwNXNNa3p4cGxGalZLZzhHUmpmbzZCQ3NTS0VpdytHNHYrWlVv?=
 =?utf-8?B?VEJNbnB0alhQZERKOXRwUjNGVUxTY0pEUjlreDJMdFhpL0JpY2xYNjdGWjR3?=
 =?utf-8?B?aVlMbjJ1V282SW9nUE5Na1M0VkFMWjZuY0pUbDY5OVpwdnJYSXUyZ1g2Mlgy?=
 =?utf-8?B?N2VTV2JrMUREWEU5Q1h5TDB6N3FUU0N6NFJraWFEVzZRdkFCeC80azdWMDZV?=
 =?utf-8?B?S3krVXNGTCsvaEkxV3hmVUZSZkVHckZZK0NsbUQvalpETElIa2dYYWExend6?=
 =?utf-8?B?RWd5azFZMVdMN1VFN1hBeU4rQVJBYUxLYkZ5NWNWU1o3MHNteUpoRFdjUGVK?=
 =?utf-8?B?RjVjczR4bXdsOVZXZWZUQ1NUZTd3anNWN3BwYXZjTGgwYXd2amlUSVdVMm10?=
 =?utf-8?B?aDlSNjJsUktrMUtuRmhNeWVuakR0OXJSYnlkSUFuRFVEZnhZTzVnSlYwQ3Ro?=
 =?utf-8?B?TjRjTThHcHlDd1dEbzY2T0NYOGpVZFVBK0hUODFXdmd2REkrend0YmRKNlBp?=
 =?utf-8?B?d3p5Qll3YVlXek5kLzh4dDg3M3FUdy82SXlJUDd0VW5ja25sOWtIb3lmUHpz?=
 =?utf-8?B?bTNRMzlCRldFc3pYMDF2ZkJOaVd0c2M4Q2VmQk5NZ0loR2laNk1pN21vUW1Y?=
 =?utf-8?B?UGFHWWx2SUt0L0w5dmllSS9HUEVVSFYxczVoYllCb0JRL0lNVUFYQzd3bjRM?=
 =?utf-8?B?UUpTYlFjRFNFYjZSSGpnTFpWQ1BaaVJIL2pJRXNpS0lZTk4wY2RLaVcxU05R?=
 =?utf-8?B?cklTcVRmdGJmdFZQKzEycThxb0srbC9DSFBIb3poSWpPczRWWHJER1ppc1pn?=
 =?utf-8?B?VEM3bzc2djQ2SHdxYW9hTUJBWkxPM3p3eWdyOVhuRGxmT3hzYW9HbHhaSWtV?=
 =?utf-8?B?VGltcVBMa2hnOEtsWi9UUmExOVFEckNWQ21PNTVJZnRya1ZJVExzUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f5685f-c362-4817-98cf-08ded90b599e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:59:50.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEofXrmPaiRGI6ZwEOepkT8rdBToeriMBJkAY3JmzTs7PUWoU3FZocPbaqNrjrt1W4YTlkhi6Fu/qzW4tv6u2OcJz/+s8bEamDrL8JKgBns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7989-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com,pengutronix.de,kernel.org,sntech.de];
	FORGED_RECIPIENTS(0.00)[m:1579567540@qq.com,m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[quentin.schulz@cherry.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cherry.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cherry.de:from_mime,cherry.de:email,cherry.de:mid,cherry.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F051570361F

Hi Cunhao,

On 7/3/26 10:01 AM, Cunhao Lu wrote:
> Describe the three CAN-FD controllers integrated in RK3588 in the base
> SoC .dtsi.
> 
> Add CAN0, CAN1 and CAN2 nodes with their register ranges, interrupts,
> clocks and resets, and keep them disabled by default so board DTS files
> can enable them as needed.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

