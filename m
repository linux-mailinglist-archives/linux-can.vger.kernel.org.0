Return-Path: <linux-can+bounces-7136-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDsKAiiXumnSXgIAu9opvQ
	(envelope-from <linux-can+bounces-7136-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 13:14:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A08842BB4DD
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C53030DB4B9
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074D3D523B;
	Wed, 18 Mar 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X+gkFdrm"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E23D3CF8;
	Wed, 18 Mar 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835922; cv=fail; b=jJkcPqb58BzNJ80Ufbwcvjn3ZkiMHeyvSsoPWt7QRYGLR3gYQ7bmbdJKqGaWGWGjowCi6aFuoIYxUizLbu8TocKyZ7gt/iLeEUUIJY0+R48kptisZsK1fB1NLj/1BJ0ClwzzZAPIAs0kRPBM81lC7j63x+kfnUWG5tGoRqirjVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835922; c=relaxed/simple;
	bh=uZN0yktD7jN+CEvpMISzN/2ckwyyNdg9YPcZB9oHGCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mv2Iy2tXZmfV13+VAAmIuJ43iGefBqdOVAZRfixcHhACkdZxAyCKUCflSNy097g0U2E9EUQrduKxCJIB5ElDfkiDx8WE4viJzKPvfKnkGa7F4Tgql0gu/zwnlT77/SsMvq5YXlZQk/jI75BotjKhPPJ8BefXm4xxO/B07Ty3XKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X+gkFdrm; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fN+YG0kkKHHb8m58jHKf17NktKzhEYFAMb1eM8J99yhsiMWYf7AO98WQ3oOKGPIvFeyqoNEHUY1AON+U129KBuHs1LyGvHSilrwlPxFkdweKAdBGNhjW5/Ka662S6qWb16nQt+zvn6adXVRs3zFyrTF9gTiRk9RVp9M+DJ6Po3WxZeWTSmudsPoZkQ1CZF4vvI6Grr0JtzjWbtgNVX2uuKVsxv4PRZ1ZcjNQgJl1NgtAtVA9MmKnsHppydKGBWWV1jDo4jk376JTZfkXtYH2WXG80MhnWDtn16PI/rPZOwYi78jb4Mkjv/Pgz4JmKaINccTLK0DFFzipVxX2cNMP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVxG6YqcKJRUjvZrH700GKDGGYgOnoDTMbbcyno7Wmk=;
 b=CleILBopKtsMNlKXxORzaqXVfkX6yHB2VqCmchesw0yHQck2cD0BBbykYnyMmYD7yvZxIho2fIs1Dfuk5o2NqqPPiBqpbmu3xChnFUF7a2fMEW/kVJR071gsRg2cYVJmTxYu8ejjHNCBkU/0HodUYEQBYbX3mBLv/hSiAvv9smZMK+VaNG6uuRl/tSqCzKNIeKgJAFEdOnHeMA86OullVHNlAUcThnRub49lwLfiIRuZLdmPQxAG+ZWym+qETd9pam2EfIb+xzo5iBpQ4+yUMbqSgammpantrjooTBnX0BXYqdeWILohu6upDiPVEjBiLf3IWBLIiyIHQfiRqqkZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVxG6YqcKJRUjvZrH700GKDGGYgOnoDTMbbcyno7Wmk=;
 b=X+gkFdrm7ueyi8eTZQAk/Gf23xCQQ7at4uXJxgDNTPW85FKGsugdAI1vYSwNQwT44fqd9ERSOtZ1SDBQ82boRNMmIlDN4VVTP59xFXsSQ0l/Zhw1oieW+6xxN/tNXh5qc+UtJh2yZU/xG4BzWE9gzI44MS+e7wzoaEcpkdXsqeNd4Q2SLSOkPRTADtR3S7HNvQwHiETGC/athdZWBNYVzLtrpfY8gMRq9ZDDMa7MBhzOrq19csN6KMuC3CECMtmTWPgIN8zY9jeabkytrexw8cv50qycAb4e5EGuy/nJyQA5qEZ5M52b+7HMz7Dm/+XVq28IlV+/ZD4Ry2usupgl3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10712.eurprd04.prod.outlook.com (2603:10a6:800:261::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:11:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:11:56 +0000
Message-ID: <a00d3f73-8a0d-4bd2-8bec-0cc2efb990c2@oss.nxp.com>
Date: Wed, 18 Mar 2026 14:11:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] can: flexcan: add FLEXCAN_QUIRK_NR_IRQ_2 quirk for
 two interrupt lines
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
 <20260318092215.23505-3-ciprianmarian.costea@oss.nxp.com>
 <20260318-meteoric-tentacled-chupacabra-347f1d-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260318-meteoric-tentacled-chupacabra-347f1d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10712:EE_
X-MS-Office365-Filtering-Correlation-Id: e590c4ff-3fef-44ff-cfbd-08de84e78c58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1XmioFZ6roHu+g1KtGh0/dF4y1QVoE9YW58zK47Z2PuGcYoo7YfPrM6cQTM6Kdr2FSMP5bF4IGpaEbaN8+DcIsN/uDtE1CqnAypQyHnSHBjon36P8YuBX44/FxIvEZPiqHLBoHSNV6QjqPGM1gJPCs6BNQJJnUTOqauZDQb3z3M41wYoL6G0u7oq9qpCQL3R8q0x+6YU0RuBuJ+gfK8Rnw3kINWZ7lTQU7fg3NQu5a0Q14D5Dh8ikXZRnFTsUizQZtwi9sstdwav4JQbjGDVyBFd0y5jHjWuDTWBF8IKpGmOX6SoNDTuSNx0VDzV73oDa/w5JCMzkMkI0D+r8TSRb39rpoyVzhn3rLpwfYIZkmdjNWZyVvlPwabb97mk7Zp/JYe5hqp8cITDyThFw+FvQLgsdkgG7dCNNkcnPCf4Ech6xpISFSGHTcovbyK1Fy/NgjIh0zwTtE7cCy8mN5MomdgP67HnYmNR1V+UNIZws7jlaxq/rQGQt+nFq8H6yObdJNDf5yZoNekBG5wYvBA/sspzrtdbv282nweDQ0zBxlM5GwpWMJCUGQwRKjziQeM0gUIfJBObeHD44D96ii8294WSA2Y0duQQzmyYQmVwspqNWEWzvYYFRCEoEyw6me9HKCSiC73qw7N5zWaGvbXYXg0cWjfYRPvCIOu9ZclgAT99luY3BuNkj9moVQ1tpduJCOUmpGvOmtRoR+dz5E3NKnO2eAUZoD8HAJkunsZNO2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRQUVFYdlVnL21nV0dOSDRBRXlrK1ppd3ZWTVNESm0yTVVrNnRQR0FIVzM5?=
 =?utf-8?B?S2VCUldPaHdqdG54bjRhdUhRTTJiNGtoQ0hrdS9YVjlGaEJXM0ZlNFVmSUFG?=
 =?utf-8?B?b21mTmtsM0llVTRSU3NBUjFCYzdSTXU3Q3JIUVd4Z043cWVVNEd4QWJOWDVQ?=
 =?utf-8?B?d2VYQWlqSzBxTmg1K056QjRqclVCV1VxNEUvelFhZVZNVm5XL3VvTzh6WGx1?=
 =?utf-8?B?TEVydVBwaEZBTFhzd3J5QUt5dmVwOTV2ZThXUVVJZjVkYXgvUXBCSGtva0M1?=
 =?utf-8?B?cmd1N3NLd1BNSHdrKzBQZ3hpRTZNRHl3aHFuZkF6dzJBQ2RWYU5CcFhEWWhG?=
 =?utf-8?B?MGFPdnBPYmRlRUNrdXNyRmZhaHYxKzhPU2FydU9SMXBzbkRrTHZyL2tBeHRq?=
 =?utf-8?B?Q2NBQ2h2T3hOdVkzNmQ1bFhrQjJnbTF0Tk1VdTJER3NzRGlhRUU0NXVzb0tY?=
 =?utf-8?B?Q0RMLzFWbFFrR2xjM2dremlMV05zOFk4bzNSVnFLbEtUTlUyOEpjWTYydk40?=
 =?utf-8?B?UXZPVWNvR3Y3bXVsa2FMU3FyK0hZNU85U0JFMStxdjhsaEdTeFlOcXNzUXRm?=
 =?utf-8?B?QWdFcXRFb3FWcHJwMWpSOFp5ajNrVlNnVjBENlpMbTlTVlYwYjNwSk14b3Ix?=
 =?utf-8?B?T3hNMWgzRzFVU0F0Nkcwb1BOTDk2Zytjd3hCSUZ3WW56RW9FY2ZKTXo2L0xp?=
 =?utf-8?B?Y3k4YW1rYzFSVENubFliak5ibUtvQTVKNVFOZllRMVdicnlveFlkNnVQVE02?=
 =?utf-8?B?aXgzVkVWUUVaL2NMQ0JpS0cxdWNOK2Ftc1BGR2RjcGhUZDZoL1k4ZmhFRVo4?=
 =?utf-8?B?RWlqQ0dJNHVPYk5ZbFd0RytLZ2ROMnNvUDJySDBqV2FjM1Z2UTk3NWtoUFhB?=
 =?utf-8?B?a1BCU053RzgwM0EvMCtLWUhVdHN2YW9yaGdUbjhaVDMxeVdSWTNmRVJRZU1U?=
 =?utf-8?B?TXhmdVozU1pvWUgyb3dwVEg2anl0VHBkMTZBMER3UDNhNTBHTjRHOEJJWUNP?=
 =?utf-8?B?UFdZQk1WbmxGYkdXWmFVR05rSFhGVnE2UUk4eDdWRXpLUURLaFVIakd6Tk9V?=
 =?utf-8?B?VjhDZXdOcWZGVk16NW1aaEh3cUhaSFF5ZEdnOG1OdjlTVFk1K0srTDcyeWly?=
 =?utf-8?B?NGNyTUhRZ1BKcStsQytMcEpuY2kxZndqSVE1akR2NzVpYlg2aFdONklEcm8x?=
 =?utf-8?B?ZEdUcE9HQStWTHFzbzh4RDZHclZmdXhUb0NxVVU3VXhMS2FGMmpFNVlYa0Z1?=
 =?utf-8?B?RGQ2Wk5CemJvcGlIeXFKL0RGeExMN09mWjhIcmR0cVpkRi93T1FONTVqT2Q3?=
 =?utf-8?B?b0RZb1RBcGgzYUJvdGtTZXBVdUIzMnN4MFZEN0NianJnbTVtMUMxOWdpbmEz?=
 =?utf-8?B?UmdlZUpPcjh1eElSQXlJVWRNaTErVis0STgxcDhCdVNqT3hKUVJldDhHbmhT?=
 =?utf-8?B?aC90L01PaVdlL3drMHpTbG9IS0VSUHBMRDA0cE8yVitRZXFXc20zZ3V3QWlj?=
 =?utf-8?B?TnJPVW83ZDI3ak8yMk5DejNnNklNWkc2NXZYcHN1cHFtQ0RQTGI1N3R6THNx?=
 =?utf-8?B?Y2V0akdyWnlzdmVSeGNQMkUxYzkwc2RpbHVUNGg4VjBYcWxsUXlJNkxET2U0?=
 =?utf-8?B?VU83cFNSbURiNGxIcStwTDV5ZkQrcDV0aDdGbEhZUHZ2Skd5T08xT1RoajAy?=
 =?utf-8?B?WkoxRmRxWlUxdFJZZ01EUnZSRFdmOUNIYTROL1MrZkhBNVI4OXg3OXdKWGdV?=
 =?utf-8?B?QXZDQXhYZHRjOFR5QWtvWXpFNkUxQU1uMVJmbEtHeWZxVlZQZTV6eHVHdEF5?=
 =?utf-8?B?b1QxR0pTcVNHVGc0MWtzbkUvcUswRFVxMzd2eFhuYk5WbXpUWDk1a3R3M3Ba?=
 =?utf-8?B?TkF3bDYrSnBtUjdWUFdoUWZhK0cyU0Q1T2lpQzhzZ0p3em4vMTZFTmpjYTNt?=
 =?utf-8?B?RGlpcCtMVWtPVGdjNTNwSWtyV1ptN1VHYSs5TndrQld6dFlEbytOUVhBTjhU?=
 =?utf-8?B?U3NMd1ZyZHZwT2k5T1Bld3NkRGRSYVJjOXFJNUJiamRXZG1RSXN2c0tpRGF5?=
 =?utf-8?B?V3NMVUZQSzZ6RnY0NzdsNFM0aTl3S0VndkZFYlpQazNpQVVzWE1CYUZ6ZkE4?=
 =?utf-8?B?THJyUVpyd01qSThxNHBEVjJHWXQ2T0lHUUJSWWtPZm0rR3AyMGNZdmxaMjQ1?=
 =?utf-8?B?MW9JNWhtMjlEZGFoMjhld21KOCtvQ0dkRzh5YWhJcmZxOVZwaHZmd2FJa2w2?=
 =?utf-8?B?dVE1OXNlN0F4L2pWNnFNQkRaeFY3NFhSZk9RY1hSTktnMWFnb0lzclFUWVNm?=
 =?utf-8?B?VUg1eDFXNnF1T0tnaUg5aXZVZ0o3OHdhdStNTndxcTRKQkFVcytlaTRJRzBJ?=
 =?utf-8?Q?K2VieDGB5Q+/JM4s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e590c4ff-3fef-44ff-cfbd-08de84e78c58
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:11:56.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31F2ZtkToT651QrstlpDe0H68thkb59ZXjcwL+8nVcsZaegyUtEbwXB6E4lfMdnP1oL6oF9d4iW652FapeMsQfRA3Rxi/2VB565JIrYDpLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10712
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7136-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:mid]
X-Rspamd-Queue-Id: A08842BB4DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/2026 12:42 PM, Marc Kleine-Budde wrote:
> On 18.03.2026 10:22:12, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Introduce FLEXCAN_QUIRK_NR_IRQ_2 quirk to handle hardware integration
> 
> I understand, you followed the pattern and introduced
> FLEXCAN_QUIRK_NR_IRQ_2.
> 
> I think it would be better to describe the actual reason why this IP
> integration uses 2 IRQs: it has a dedicated combined bus error and state
> change IRQ. What about: FLEXCAN_QUIRK_IRQ_BERR, this would match the
> interrupt name from the bindings.
> 

Good suggestion, I will rename the quirk in V2.

> In a separate patch, we could migrate the s32g compatible SoCs to the
> new quirk. But that's not subject to this patch series.
>

True. There is also 'mcf5441x' SoC which uses 'FLEXCAN_QUIRK_NR_IRQ_3' 
quirk and needs to be considered, besides s32g.

>> where the FlexCAN module has two separate interrupt lines:
>> - one for signaling error and bus state changes
> 
> Usually it's "bus error" and "state changes", as the errors happen
> visible for everyone on the bus, while the state change is local to the
> controller (every controller has it's own state).
> 
>> - one for mailboxes 0-127
>>
>> This is required for NXP S32N79 SoC support.
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/flexcan/flexcan-core.c | 21 ++++++++++++++++++---
>>   drivers/net/can/flexcan/flexcan.h      | 16 +++++++++-------
>>   2 files changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index f5d22c61503f..a6b15496853c 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -1770,7 +1770,10 @@ static int flexcan_open(struct net_device *dev)
>>   				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>   		if (err)
>>   			goto out_free_irq;
>> +	}
>>
>> +	if (priv->devtype_data.quirks &
>> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3)) {
>>   		err = request_irq(priv->irq_err,
>>   				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>>   		if (err)
>> @@ -1791,7 +1794,8 @@ static int flexcan_open(struct net_device *dev)
>>   	return 0;
>>
>>    out_free_irq_err:
>> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>> +	if (priv->devtype_data.quirks &
>> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
>>   		free_irq(priv->irq_err, dev);
>>    out_free_irq_boff:
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>> @@ -1823,10 +1827,12 @@ static int flexcan_close(struct net_device *dev)
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>>   		free_irq(priv->irq_secondary_mb, dev);
>>
>> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>> +	if (priv->devtype_data.quirks &
>> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
>>   		free_irq(priv->irq_err, dev);
>> +
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>>   		free_irq(priv->irq_boff, dev);
>> -	}
>>
>>   	free_irq(dev->irq, dev);
>>   	can_rx_offload_disable(&priv->offload);
>> @@ -2213,12 +2219,21 @@ static int flexcan_probe(struct platform_device *pdev)
>>   	if (transceiver)
>>   		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
>>
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_2) {
>> +		priv->irq_err = platform_get_irq(pdev, 1);
> 
> Please use platform_get_irq_byname()
> 

Makes sense, I will update in V2.

>> +		if (priv->irq_err < 0) {
>> +			err = priv->irq_err;
>> +			goto failed_platform_get_irq;
>> +		}
>> +	}
>> +
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>>   		priv->irq_boff = platform_get_irq(pdev, 1);
>>   		if (priv->irq_boff < 0) {
>>   			err = priv->irq_boff;
>>   			goto failed_platform_get_irq;
>>   		}
>> +
>>   		priv->irq_err = platform_get_irq(pdev, 2);
>>   		if (priv->irq_err < 0) {
>>   			err = priv->irq_err;
>> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
>> index 16692a2502eb..f05036ca54f5 100644
>> --- a/drivers/net/can/flexcan/flexcan.h
>> +++ b/drivers/net/can/flexcan/flexcan.h
>> @@ -58,22 +58,24 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>>   /* Setup stop mode with SCU firmware to support wakeup */
>>   #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
>> +/* Setup 2 separate interrupts, main and err */
>> +#define FLEXCAN_QUIRK_NR_IRQ_2 BIT(12)
>>   /* Setup 3 separate interrupts, main, boff and err */
>> -#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
>> +#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(13)
>>   /* Setup 16 mailboxes */
>> -#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
>> +#define FLEXCAN_QUIRK_NR_MB_16 BIT(14)
>>   /* Device supports RX via mailboxes */
>> -#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(14)
>> +#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(15)
>>   /* Device supports RTR reception via mailboxes */
>> -#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
>> +#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(16)
>>   /* Device supports RX via FIFO */
>> -#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
>> +#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(17)
>>   /* Setup stop mode with ATF SCMI protocol to support wakeup */
>> -#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
>> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(18)
>>   /* Device has two separate interrupt lines for two mailbox ranges, which
>>    * both need to have an interrupt handler registered.
>>    */
>> -#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(19)
> 
> As I want to change the quirks anyways, just add new quirk at the end.
> 

Sure. They do need some sort of ordering.
I will add the new quirk at the end in V2.

Best Regards,
Ciprian

> regards,
> Marc
> 


