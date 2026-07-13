Return-Path: <linux-can+bounces-8362-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1CAHF2oVGrPowMAu9opvQ
	(envelope-from <linux-can+bounces-8362-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B02749031
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=cSl01qZ0;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8362-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8362-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D8043045081
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DB3D6493;
	Mon, 13 Jul 2026 08:53:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059063D6461;
	Mon, 13 Jul 2026 08:53:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932810; cv=fail; b=MaMFAc2+KJnjafJbjtk78BuO4K4pgQyFnGi2p0+hlKvo2RgFfpLTO6YEcXg7NdTZazEnwDlRkz6w0ASggQZzZCwjjJ+cPCy+1XcFXomqBD9OjwHf1fp5G4zOfvznnhk8OtxPILOmmmuUw071uyd4I7H7QRhj6QYFXcHFyek8tqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932810; c=relaxed/simple;
	bh=9ygVd/9wOYBvYuQKxlnmXiqG0N3u51+iaQgO8LhlNIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3HWLAqKdkX41grAXGDVyiUsZ0CaunDCgkqYueJc+rCDTqRJtAgxoug8e82SWs2eMgw3/smMZbzA+xdZk4kZutUj9KtJh4Kl8uKSq0vQ2LDJcFQG6iD4UEotMJhpgV6vkj2d38gVHVy5jbCWYxuSZVEisM9p/cMV1EpmmSdh2V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cSl01qZ0; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htoFUmDeCuVVW1S5jJtpHCZ2NPxi8R2jo0wX3sWqxUJ+QeynzT4A3Ss+wQIomU00QTFa5pfyO7SE1MqB5KCcWRbHTtE7Qs0/R43UeD6MDCW4tPZwFp6/a7hAn1m//7xjsVB5bRaF+BIocb1Ve0t8e3LDBvhn6J7L0Xn0QYXC/s2ptcNggvkUiKS+2EK97+vIFrCLxRiKL95ET+0cDXkFlcE/pUqhVmwBUVpQhZC5BQ88Y1BAfuikj2rY/dip+BjyILBXkZZfsgi78BCdkcay/edCaKx+X76h8aL78A5o1r2sEsVVrBLyON/C8sqaIpE7HKB0sgtZB+qlAmrl9CBnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BICuwCHVHi03s3I2/r7mErJ4O70LPSuo2IX7EewVGyE=;
 b=KpkNdU96AUZ2cL906aHDgc82SmE7YuOhQhEEnodx7RHjmCcDqoRZ+8t733E7qrEMaPaU060btSPAE0PPjZz3OnMU7X8bD3UYfm4xCxdHB4FDbuFus5+MdSPT6FBQnsIoEd5+jRXlvp9Ho1jYEa3NmnJQebWxeODE53Wol1WAbBbOCBnHz9F6+A4Y61yQbh1Qzz+YK7BMHGvN28I4ToGD39m4DyPn86rOFhbWhh4seGR7feZ3YabBGsnsBHdFFeauD8TSSIWvzpMLitzin9UqwLjEwLsyy7C6FT4WK7B3LBXuh+jg8EsPBA4GYadwqopVFnmlALeF9c0Vsgga9du8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BICuwCHVHi03s3I2/r7mErJ4O70LPSuo2IX7EewVGyE=;
 b=cSl01qZ0/Jb7tEG2u4LM3DKO676/G404fZ5M07Kwsx8H0u2phORet4rW+c1YHH6wMlKfsAmCLuOgLR4JfuV9rlJXpg2yQ4ATW3cuqecc6kx4MRpUU3V+/soFQQSCRQNeNyLtLRbDHUomgvTMml3Qp9NyJRG7GkP6+Zwdg5pgLcx6dElZ2Fub42ZP/3IdFJtaQeaYFCo2UV1oOeHjNXSjAs6h5j33oFHigT9vlQfmJIhw62sLqnZk5StR/ZHay071Jtfhc6LrI1Jn86IU15l7vNB4fMD2Aw2DKyiJ/WfsYhzTp/yef9tvzWHBPWg1MsKK91he15XP402btNI6TV6Vxw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:17 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:16 +0000
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
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 6/6] can: flexcan: add NXP S32N79 SoC support
Date: Mon, 13 Jul 2026 10:53:06 +0200
Message-ID: <20260713085306.2643794-7-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0069.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::15) To AM0PR04MB5858.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1ae66843-288a-4590-1936-08dee0bc2e2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 wgF9pszZeJgMpeZRQydxn9aCupz807U2sZifa9fEadDaVqJEldqk++YUytvv28tmGOBuBH6HlZB6IdWV4WLkV/HjYdxIjh4RMeCJXliAbtgKVrI3/G4+WAHmDH6uRubhZLgucZFhs98Xc376YmpkFa486h7aJyh+3fFDKujg5kHazvioKsBJ+LuzvFNj5VIk7DavBZlL38/V+FYlXuXplTGjKsOG834LLGhrzqasXMjkAtJKhtaT9JuqsP7fXj3wkCaveSsnoASB1tWC9OxaPRpS/8YthtZxzhYCO2mh/haDl+VpxZHmfwhhlD7AcS2ikcPySU+iv514GZxe5s19Yde7U1e+CjQUHbaKDbw80qSyfwugmautK3KnyZ0eei0p4k+omz4Nw7Tek1YovzSIWBT+xC2TV9DeqxqcyL5xxcm1Og3CMwIes7gXRhGUvQaiyQ0/e7QuvtYVBeQAoyImizYIDnDwbenCwzJ+kacaxcJoLtDXvL/lyzZ8kWDpeYdogV2VbaDM8/QkZbusI8HjdcYAhsk167q8ta7+U3h4OnWchdnsyGV+/wCp6GF4V7qn1nDW3RSa3MRpqdJk2djOx+4aygXjPIFUr0/d/dBmtmt11uNXe6ZFy9/oWDOVz39pFEMZM8c6SG4vV+UA6kpPF+5VyprldSQtNm0AOC2x+Ww=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K2pTZ1VWUUc1S2NoWHR3aTJmU1Z4MGloTGZWOUt5RU5DTVZOT3ZGV2Zqc1ZQ?=
 =?utf-8?B?NThHVDZGS2Fib3ZyZXVudnlud243NWhuYTJ0VE1PVzdvVFlqQWFrWWRBeFdw?=
 =?utf-8?B?bStBL0FMcHR0Q1ZjRGxvQ0JpRkRXdFZsNnNmWVFFc3dUVFdJM09pVmpVeTQ5?=
 =?utf-8?B?cFJzZEZKMkRlc2MzSnVvZHBEVWw5YTFmRm9Ld3hmWnVEbGlCSWgxS2VqNWdY?=
 =?utf-8?B?SGZVeTRLOStLRVBnaUIrRXVoeG5vd1JxTEVPVUxLUnpzQnd0Qk5Ld04zeHlq?=
 =?utf-8?B?YXhyWEE5ajdqeVF2S1dlMC91UGJ2VHI1bGJlMGFZYkh4QStXbDN1WjFkUktC?=
 =?utf-8?B?dFY0MEpjNkZENTJCMHpjdWUxLzRaUnBRQXVRMHhlK2FZZzMwOWg5S3pUTW9x?=
 =?utf-8?B?YUJSaXVONVhmU1A1VGRwWGZEYlNkTXlsRU5sblRBNC9qZ0I2QzJsZ2llMmtq?=
 =?utf-8?B?QnVQbGcwbEhIK1JiY2w2U1QvQ2loR0pLM0oxNDJtaGxUSDVWcGxEaUhDWlFr?=
 =?utf-8?B?L0lLb0xZcXg4T0VKRkdXVjdxT1pDMTZETCtYTGxBSUtabnZHaHlTNDFDTGh3?=
 =?utf-8?B?QXppMnNNSXVYSXl0KzVWL2lsOWsvdEw1cVpyU1J3RmxsaUI2V3VhV2drMmVS?=
 =?utf-8?B?ano3RTVvQ1hhZElaWjIwSDY5Y21SRXBBQUVqZ3F3Q2Zsc1ZLWUtqV3A5YVdX?=
 =?utf-8?B?Z1l2eVJNd0x1UlpjVUZxcmhITC9qUVE3cmI5YWE0L0V0cUdqSGhRcjgweUpl?=
 =?utf-8?B?MEUzSFlOQTFWTmRJN0Zrd0dBZlAyNGpNK0ZjTHhWMkdyMEFaN3QyYlllR1lM?=
 =?utf-8?B?eXlRRjlvR1VpVzhlcklFNWR0YjVmR1BVeVhOTHdLTFJ4RVU4M0k3czZWNm1I?=
 =?utf-8?B?VVJZOUViNFlVMEJLT3NmeU9rODlmcnJzYU9SN25CK2RPTnBNOXlIWVZrNGY1?=
 =?utf-8?B?cUdKZzBXOTZaZE5XcTZiWmt1WmxlY2pBd1dsMlIxanZQSGdSdnRzSGFvMEM4?=
 =?utf-8?B?c3NrNzBxUzNDQ1pDUTJzTGsxY2tNajJpSU9XU25XcDh6bTg3b2I2NGhaeW1Q?=
 =?utf-8?B?RVgwbkRPS05MV3UzTjY1dzJYaXk2YjJXZTl6M3lod0dDQUMwR2RTZHo4bXpt?=
 =?utf-8?B?ZzRtekFyeUYwckwwU09pSlg4QW1hQlpyY2NPbDBsd29zdy85K0JRZm9TclFP?=
 =?utf-8?B?QXY4NUxCWjNUcDJqaUZqOFZwN2VsNlFIL1dHOGQ2TWNwRW9RaWlMeHVZcDkz?=
 =?utf-8?B?WTlmdHFZOGdSQjFhSm9CaEVtOWt1ZXpIT04xS0dUYytvT2RvdjQ4TS9Jc2dW?=
 =?utf-8?B?bTBCMDhxMit2RFR5V1FDaUZlVFl1Q2c1Qmo4N05wYzFvNDBUV2ZtUUp0ejRl?=
 =?utf-8?B?ZkFndjI2Z2JiRldVNG9oeDd2blU4K1l5bTlHNmJ5ZnBiY24yMGYwSEJNN1gw?=
 =?utf-8?B?Y21hdmRMbExqRjRRNmttdE5DTW5ScHI0RjZaN0hKbVVoRDVCYWxnSExxcndt?=
 =?utf-8?B?VC83S0ZaNFFnRGUzT2hUekVPazhQKzMvd3hSNTIvTWRwa3lBVmVyQjhOeXho?=
 =?utf-8?B?RG40TXFFMDM2S2FzdGVKZXBWeGJKUkNjMGoraVArUGx0UkpyUVFqZktPUFBO?=
 =?utf-8?B?YUxSTDlsMHFUVU9vZ2RReEFmZ2R5YzVCTHh5UGJudHVwQ0VIbzlHTjQwTmlQ?=
 =?utf-8?B?djYrWlV0NDJiV0w3MitGVU9HMTl5azhDa0tQOVJoY3NqU2FXRTJhYmw5b2FV?=
 =?utf-8?B?em5UY2hHUXA1RVRZWDgyNDRvYnc1MmFnWDBjZ0QwYTIxb1dZMnBUVVFaNlRs?=
 =?utf-8?B?RWY4MWZlZ3BPV1lLbHVocUlENG5QcWxoWDBnWWkwYWRqTGF3aGRldGM1c2Rp?=
 =?utf-8?B?NjJmNW1iR0NhK1pzMGgybXB4enFwOURKNGwreTJ0STVWbDJsOWUvMjF4ZDRT?=
 =?utf-8?B?eGVZeUswRitLeVA5UWNMRU9ROWwzSWtqNkZWUjZ4WWhiNzBDOS9aUUQ4STYz?=
 =?utf-8?B?WkpOTEVSb2cvK3F4azZ6c05yNThTVkZ1d214Y1hUVjdpWU5BQlY3VGRoaHlE?=
 =?utf-8?B?YWE5VGk4UkVOOER1Z0VqOTg3aDVnVVlXYmZuc3FOZHUyZjBRa0w4eUpwajNM?=
 =?utf-8?B?KzJvZjU1WVJnUkhkVTdncmpHU0NWUEZGa3NsWCtLaG5iMmVDaHAwZHEzN2Fp?=
 =?utf-8?B?UndsR09HeVNsVUNtWkkxOWk2bFd3KzE0TVRnLzNoMlNMMGtCMENCaC9wc2kr?=
 =?utf-8?B?QkZPSk9ZSlpnSlQ1enBCSXRlOEdKOGFJTnBhY1ZiNktlRmpVc0RJZUVBbGtp?=
 =?utf-8?B?K0tVMUhDVzkxM2FnUGk5bDdnOEYrUjdiNytCcGpVeDRHalFkdEFyTi9yRDdl?=
 =?utf-8?Q?kn4ZXatUYhCSKt0k=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae66843-288a-4590-1936-08dee0bc2e2b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:16.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q043nVh6Y8H55GhLE/jGclYxjYqs0aTNs3zpOm4jDFkEtJ7+0ZLgA1/FH8jOPXlX9O/DquaqEoWRbe82PO9X0kD0EixwzWz7wDsbooEHPu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-8362-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B02749031

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
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index e7e3fb41f55e..54279b91cf5e 100644
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


