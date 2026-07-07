Return-Path: <linux-can+bounces-8068-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3iWMpzYTGosqwEAu9opvQ
	(envelope-from <linux-can+bounces-8068-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:44:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9C71A92D
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ZooWuhZr;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8068-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8068-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3D03040D85
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A93ED3C3;
	Tue,  7 Jul 2026 10:36:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7B3B47D0;
	Tue,  7 Jul 2026 10:36:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420598; cv=fail; b=tYpdjUOdIxcdOt4XYfuOTiY+ZFguElUps2iALxl9JLmWGHDzYzGJknsDZVgTL0x5PgRMvpwhgnvzziJN8WCSjiP+GjtQw5gAgx3XdEK8J3nMRwhHkm0JNs7CboRoRtdxQ7G4zSMM2p7b6TwUiw6g1C7T/ECXU4jWbB747pOGPU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420598; c=relaxed/simple;
	bh=1liwYdZi+lGiO2DE45qlWF1RGMjbmaRaPM5bGQcqSMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G6QJOv56mX+QTK2D6HPYCz2cVNVTDRyZH4RZMZpPmsNoWCFfUKo4aexl3Yjx5gUX5kEXtgv9YPc/D6tf9T+qrCvSCMIYz/vqGPfAjNWIVZEGMY6HgIqLr+ZKSZvcdmAh5MncAhfmOydeR0Mo5aHWzMKYVSH7he9bK8Lcj1afqEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZooWuhZr; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZLRmdvM/b8+NfQoMVnRiExWKsHg83T4ua9XZdPx1PFmZ4uCuOqU6H4PqhccpgvxtYzPrzizYX+Ug3hHkcVabc1v5tZapBfnm8o7tVVSn7I9zVaKgvsPIOqJBTpvJlgAC7+vQCbqX0F5xSSVI91ix5sYQYldMazyHI5tCDBlU4p5FHUIxvy3fse+WvuSC2iEMNuFEQ6gSlkGzj0GsjMudKYbeId5uGv9jVjXFZXW5ytBiWlEzhfoBwB3ZCchh4PsomqCPtZn0sKkhyDAoUYqeQh0epQDlNpAAc+SuQVr+8w9x6H4tlHwBogCEpJwsZqdck5INEGGWU4Y9RAko6UPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK0xKUpK7gbH9CCIGziXQDlUGdPZfbQD+vcFxJq4DpY=;
 b=C0joCbyQ+b8Z6GiN7yH7T27cIolJuu3znGy/LvUBeNzS386+02EEi6ga0L4m5N6QdiAK9rFkbnClYXXhVRMdnXTQUn5tiDbFGQN4hxva1Gr7vgCrgBiarby7KqZ8/7OSGfq8/cwkgx9I94pERwCTnV7WyFjBAY/3QcY9clD/2co28ra/wI3ZDruuPRmuaIuj1Kt0bBCa16Ehb0aCNOKv3wx3QZ/sAbWaR+YJ/VXOJB47Cmt8zC//jXh6Z4bGeyxZrLazojDm/40XOFoLjljNmi3SKMFo6oyIw97grE7rXmHRV/lwv2855D53QD6Yj6rtsaOF4HmNISYFkI495c+V2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK0xKUpK7gbH9CCIGziXQDlUGdPZfbQD+vcFxJq4DpY=;
 b=ZooWuhZrW0nHbTvOm0TLrwSInuqDIEcNlomffX0hDyxLvGUAlnO1EpcNcDmyGMuqBs/rokqQq8a5BOGVFq8e69kDGc+vJwrXVm0nxTAqovciH5UuyHnWOF8vmXFX9Z3JAkTcYT0wTgZqxcxtopr7+iUb9sHk0XqzT946YBLaNp3SuMU8cpK+y8wy6Fgs0pxjHFKeL17NqbKckr2zfMcUKaDa4OWaoUHeltpQDyg7uUaRi7r5jsX52/ZiMN0+vK7dGjvVvgiFF9Bdc7/Lzthcf3x379L9du9x8Myb8smfzCN4NSqqH0faX9NsEFd/VKgivEHMT40WZbyO6GUVL1j81A==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU7PR04MB11138.eurprd04.prod.outlook.com (2603:10a6:10:5b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 10:36:25 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 10:36:25 +0000
Message-ID: <1296950c-07a2-477c-a1de-598ca8be9a81@oss.nxp.com>
Date: Tue, 7 Jul 2026 13:36:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU7PR04MB11138:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d0782b-8600-4cc7-e2af-08dedc13985c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 itlxNF/GbdsrzWBx36HxQG87FGTm3uNHP3tPzrawhz6/zcv/rPwFcUQGO/moDyNsSzTv6eEPrHxwZg28rM9nxFYG8vkNcoo8MZUuHvIKLB/qGXWCRhdKljVMenYTUqepPThimwC49vZ+bJHvO4vJLFwan0N1BI+hMjcOTz+f/X+y1hylUgJ959HIui1AJc2tJkGFKuGTphHJixcaPAQGPD5NCIl/xQ95GFs8yDbDOOo78UGXkX0llSj9E7wVjswSAeN9vLNrie9JSNGkAZd0AoNjc5HDB92YiApsm3IQkhSSiLd7209+XuYWRdaHhllIFyYZiJamflJQ0aDuy4V9QIOdlkrDYTcJcMfnoef/atVUrGBFFJpggeTenPgLSYKNLTIaE67h4wJRvK28zrsWyVQKYzZtW3u++orf9VrkWANxePvXGL7Iny5AvpYQcGHf7JIeUntIY58Iv4ujCSlMIxq+QXrxB51ozRLHJtpHA7mJ3tmH5hU7kF9+7pLfJzcAgV/RXTGBeDcY6v5mr7v4LIvtL5lar+nfk2pLhyVVa/Ckeve/N71o0zu3qGBpa+MUbfR/hwHmN51mBl+QanQinNsPbt5eGPPbddSRoMSSsjsjZyKy4Mt04SPZNXBsnv6o2/TNaPudqxs93LHYNlxmqe7hyFdzWIvHg6e+dieMu1A=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S0orcGQwcVNuZFVZZnMyZlg0d0ZTY2dxbkxEYmc1YTZUdEFDckFZYkNnZGUw?=
 =?utf-8?B?SWlicm9QTStBcHludFBnQUo5RU90Z0wzK1J4K2RKWFp1SUE5TkxqL0laREJ2?=
 =?utf-8?B?cUxvdzY4TFlESkZaTjR1djUwSHJLT2oxQ3hWUTRnNnlUL1dud1MzTVhVZUN4?=
 =?utf-8?B?Z0Zzb0pTN0pYUVZjVEhQMlMxT2F4dUpPY1c4MzVBRG5GWnZRdWpNZ0hITkZo?=
 =?utf-8?B?d3R1NU9iMmpYRTZvZVNacHlVMVZiazI0MHBvZHpocms0Z3J0M0lEYitEUGk4?=
 =?utf-8?B?a0prNmE0c3pva0NLL1pKaDlkV0VBK1dlZ3g3WWJSWlNxUVAyUjVROU9jRUVh?=
 =?utf-8?B?L1V0VUt3c2hoQnB2Vjl2UHYyWWdMVkxpeGRtV2JqU1lld2JhU2ozYnk5clkr?=
 =?utf-8?B?ODFZRE0zdVFJN2VkU3hiUy9SVW9lTWhUU0hyRW5kWU1OWkFJZDZ1SFgrSWJR?=
 =?utf-8?B?SmFxQW1ra1o2NDJIUklaUlZFbFphVGFyazZOcEtyOStFcUt4ZVVtNEVXWFZK?=
 =?utf-8?B?MGkvcEhGcjNKam9mdUxISURuV2Y3WHVmbzVlYmZMeURIaElUWG0zL0U2bVp1?=
 =?utf-8?B?dE1XZUtXOW5ScVdTcmFCUFJFTWhkMlBjeHVaQkxQOG14M3pUYXQrVHNjY0pG?=
 =?utf-8?B?cXlOU21PRVRvTWhDZlBlb3BCeHNLbU5QYXZhT0FjR0U1a212anNWcWFDWUpW?=
 =?utf-8?B?eFIrQllLRktyT1NXdGhFRUJrZ1UrZktKd0hGRzJtekRQNm1QSTQvWnNBcGRN?=
 =?utf-8?B?eEt4RjJ3QW1HSUdqdDZKNEtPdUtGVktPd0JNYUd2WHNhR2U1cGMrcnJLTE5n?=
 =?utf-8?B?dXBKWTZWOHpieURsVVdOdklmWUQ3Tk1JaFdLUThpY0d0cU5vcHRxL0xmc1Q3?=
 =?utf-8?B?eDFCajk1YnlMeTBHTldQV09vS20wODBmZXNzZEg2WDhuekozZHZIUWJYTGJX?=
 =?utf-8?B?UWpoRkNGODZZaUVZcHZwQ1JURzhaSFRVRkJiSFJxajFwOU5iSS80N3hBNzF4?=
 =?utf-8?B?ekFocU9oNXBKU0FmdXBWZHZlNGZWYlkzT2dVL3l3L3EveW0rWExLb21wZ0RW?=
 =?utf-8?B?emxvZHlIYU1BODUvUjg0bjc2MzM3V0FnT0hjLzQydktpZ3lBeXFtaFZ0YTYw?=
 =?utf-8?B?ZUJMUVNrZmFBc3pYalFwWFMrR1pnbURCQ0VxcXdjYlUvQ0JjWU1UYm1RUlhm?=
 =?utf-8?B?MjVQVlU0bWdlTngxQTJDcnlVa1FYUEdHYUQ0ZnYxU0ZIUHg3TmV2c1hpTzhq?=
 =?utf-8?B?c0d5bkM4WXVsY2ErV3FJTTVmQWlZYnpqUjkrdWJ4cHhRalQ2Z0RtY1BoY0V5?=
 =?utf-8?B?enladzZWaUNKYVN2REl2QU10MUcrTWUxOFYrTG4vK0J4Q3ZjSzBBTDRWWkpT?=
 =?utf-8?B?UTdNd296bUY5cjk2djZMRFJQeDY3bFdhQmxlSGxvZEZnUnhhRFBycjZKNDVG?=
 =?utf-8?B?VG5pU2c1cTd4eTNRWC93akVoaC93WW9JQW02MlpteFZZNk13eDY1Yk5udXgv?=
 =?utf-8?B?MkpWcm4xd3FaRklnak9BWW84MTFjQ2FaelZteFdNY2ZOblAzb2RoUVozZTFx?=
 =?utf-8?B?bVN5OXBoTzVzUnphMFNTYmNRYXNVRE5rbHVzejFCUTBYSXVlRTI0eWpHWE1C?=
 =?utf-8?B?eWZ6QUlMMlgybTR3ZFg2OFNXUkVsY0V3cFV0TTVCWnZmZnlEQW9aNWdUS3M5?=
 =?utf-8?B?a3VmYkg3MC9kQmJuOFF6Y0JvYlM0bXdrWUlCemYxdnZPYW5JaVdqNTdBaTdZ?=
 =?utf-8?B?bUZkNUVyaDFxRUxLckhVZXF1Y3B5QTRDMS9hVU95QUQ2UDBqcUUyd09pNGFV?=
 =?utf-8?B?Q0JQS2E4SWo1Q3JEbmsvaFpGcU9qT21HTFJZMnVsMzJOT2FpM1B4V2RTSm90?=
 =?utf-8?B?d29COG03THYrai9TNWNGa3FnMFcyN1dHRWdKcmVnSTFzajRWWVZHRER4RWVk?=
 =?utf-8?B?THJUbVp6Y1cyNjZSOVZuakc2RGNFZGtUYURDUllENnE0d2U2YWZiNW90S3Nu?=
 =?utf-8?B?QWxBdHdhbVVqbGRDazVvc1lIazd6b0ZIRG5nLytYTmVoUVVPZU5scll1TU1t?=
 =?utf-8?B?NmhMNjhFY1ZHWjZDa2ZMUUxkc0NSOHQxSTNyaWhodXE5Y1hNSmIrRGsxWVpv?=
 =?utf-8?B?dVA5K1g4MUYrdWRSUlFGWkpHcjNmUjFvblpuMlB6WEJOUzFzbmpKb2lQQmtn?=
 =?utf-8?B?MmFFZjc1QXVvb1A2OVhMbVlFcE9lMllSS1ZrdVZDSXlFbkUyODY2U0k4N0ln?=
 =?utf-8?B?cjJCdW1UamtWYkxkMzF2ZERjQ3FLT2RTdmFDY051WGF3OHR4TFhZNklRODJR?=
 =?utf-8?B?NTMxTy9XRTR3dUVrd01lWHFHTFBCRVNDYVZZM2gra3hWNUlsajJ0blVRVVVY?=
 =?utf-8?Q?LJTwih/Kxp8171DU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d0782b-8600-4cc7-e2af-08dedc13985c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:36:25.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ9IfcoyomFApwTFdyC07O1ZEDrbVs3Ut8NGMb+k5rjUp9lL8AI+SiLls3kokzyalEhdl1jz7dQTqUxQZJfcOqbe/XAYm49GMFR5pca4HiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11138
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8068-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44C9C71A92D

On 6/9/2026 5:29 PM, Ciprian Costea wrote:

Hello,

Just sending another ping for this series since it has been hanging for 
a while.

Best Regards,
Ciprian

> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> This patch series adds FlexCAN support for the NXP S32N79 SoC.
> 
> The S32N79 is an automotive-grade processor from NXP with multiple
> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
> other SoCs in the interrupt routing - it uses two separate interrupt
> lines:
>    - one interrupt for mailboxes 0-127
>    - one interrupt for bus error detection and device state changes
> 
> The CAN controllers are connected through an irqsteer interrupt
> controller in the RCU (Resource Control Unit) domain.
> 
> This series:
>    1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
>    2. Adds dt-bindings documentation for S32N79 FlexCAN
>    3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>       configuration
>    4. Adds S32N79 device data and compatible string to the driver
>    5. Adds FlexCAN device tree nodes for S32N79 SoC
>    6. Enables FlexCAN devices on the S32N79-RDB board
> 
> Tested on S32N79-RDB board with CAN and CAN FD communication.
> 
> v5 -> v4
> - Simplified splitting rx/tx masks per mailbox IRQ line
> 
> v4 -> v3
> - flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
>    (not just dev->irq) during IMASK register writes
> - Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
>    each handler on S32G2 only processes its own MB range
> - Added received Acked-by tag on DT bindings patch
> 
> v3 -> v2
> - Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
>    flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
>    processing when multiple IRQ lines run concurrently (new patch).
> - Added flexcan_irq_esr() handler composing state + berr for S32N79
> - Ordered quirks used by s32n devtype data by value.
> 
> v2 -> v1
> - Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
> describe the actual hardware feature
> - Appended new quirk at the end
> - Switched from platform_get_irq to platform_get_irq_byname usage
> - Updated interrupt description in dt-bindings
> 
> Ciprian Marian Costea (8):
>    can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>    can: flexcan: disable all IRQ lines in
>      flexcan_chip_interrupts_enable()
>    can: flexcan: split rx/tx masks per mailbox IRQ line
>    dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
>    can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
>    can: flexcan: add NXP S32N79 SoC support
>    arm64: dts: s32n79: add FlexCAN nodes
>    arm64: dts: s32n79: enable FlexCAN devices
> 
>   .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
>   arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
>   drivers/net/can/flexcan/flexcan-core.c        | 227 +++++++++++++++---
>   drivers/net/can/flexcan/flexcan.h             |   2 +
>   5 files changed, 292 insertions(+), 29 deletions(-)
> 


