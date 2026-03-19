Return-Path: <linux-can+bounces-7148-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPR+ElDdu2lXpQIAu9opvQ
	(envelope-from <linux-can+bounces-7148-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 12:26:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B012CA43A
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 192563017025
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D23CBE60;
	Thu, 19 Mar 2026 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hS0/6XVX"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC343CA4A5;
	Thu, 19 Mar 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919508; cv=fail; b=pXgdv/XZCHpc8mqqF+/WpD1PLlat6atyf8yU1COZxaHVJd8ODcy35GCS4RhFVos14fz0bsDGD79RIZO1W61xKY6qdYnxWZvD8Ghq2U4/HMIUMb+rTfDzFaWySmHYLDYe6e62GSOD1IZ7ZIcOKkE5oBv31CmMVK4jEgLaxjhVGIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919508; c=relaxed/simple;
	bh=aj1EyzDEnxW3yXy5hIjXsAZSrL81jw+/t35ujSB7wH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MvnWZGsmDEEDOBMG8pjbAW2PM+yphGNxks33gqw2npcKGfPla5625/IqFj1Dus+VRA18iLmu2HwVMntUndq61Xasoec869NdRp0Rm/ubqHVDAKDfGXr4gF8LEu44t4+DNNY8fouJ++C6y4UvdZEsTStXsUcnSyP1MeQFSb8P+CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hS0/6XVX; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbkoBXwgUuZteJlO6Z0mHFVMNdzL0F1uDsQ406uUfKskegEGMinAKoGhr/D/FPdEbkRgY3wkBnMMZQEohungGNGD6tVlLe9GY1cZF+1wCLdyg7nNy3wW02DGQwUN6EY8B8MpXzK9kN3Aob0x9kUsOQ9VotCJZqAELNGiAaDXkUQ79g+dj7LyjvXQZZFWXVRLyvAOlZbAlBb9HaaZHiDYBuq6LIIhlWOSnE1vw3JnBPvGEvXJmBD27W7TghgnMaTXmj1GbM+D9rRhQ0WNjo4qXE7+WbRsZNjz/BFaCP0LTnPK8COhUTt27g7tTrQp3taMLFdX8bEXRjXvW7P9wyRyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbpoUYm52uf00539L3U1vpggRL/V2WeRmKWIlh/5f4g=;
 b=x8CiIaiU0TDWBTlqzFekFqFJO9UnDf8IOv8UnVJHMi7AGjS4AzUS2vA0Rf4slRx5CMCAis1Ktuc193KaXrMLY8y2cbv9IQtjRLhJR/TAzOrQl2AWoljOBHQKxpOdGH9m7Ks8qKhz6NJCC7F5IQBDZx0hFTZmuBYvLYeJUftknXVpeWTP5TefNx+b/IeYv/+lax8TmP4tRt09v0ngHDToH+YpYB3HRlg3AkBNJJ1oUx0Ku861ApgZT3isHaX1f2tevvEEL06j/0chDgpaDADa/n+lZRFFwj4B9p7gFMtHR2uy1Eaj1uRKBk2iAENxF2uT0ZtOkH1Ebp4quaGcVDkyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbpoUYm52uf00539L3U1vpggRL/V2WeRmKWIlh/5f4g=;
 b=hS0/6XVXOeFkiFaZvnxI/NoK+glZjgBlmwG1obaIP5MS7UXWE0rTqQfjcpLoAMusOHbySmV0iCTVgyK/G1CNtsVHvIgvZ1lm4hZYr+rz7WPFhdzosZ+QBmbAekh7SpQF/lTW5GrVjEB5sp/3s4M8+B9GB8xebn0ZaY36hKuHJWgB+zXw5UyQYul/vVY2PXcy7XH90dqrG0NP48l4U05cBZOZyThTJkU7Gy2tkXO03hF7kDttNrXuuxq4QdvSxtvY0txPA/TCXa1kQsurwacHGKhz+I2gh2TRGvTNnsVb4kcN/FlsyNP+ekciiC3PX1fecHI8n3r9lx8XxdExlBGCRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU6PR04MB11231.eurprd04.prod.outlook.com (2603:10a6:10:5c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:24:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 11:24:57 +0000
Message-ID: <bfef9e91-c959-4288-b605-0e83f8ce73f6@oss.nxp.com>
Date: Thu, 19 Mar 2026 13:24:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] can: flexcan: add NXP S32N79 SoC support
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
 Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie
 <andra.ilie@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
 <20260319094032.427697-4-ciprianmarian.costea@oss.nxp.com>
 <20260319-tricky-mongoose-of-passion-0483a3-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260319-tricky-mongoose-of-passion-0483a3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU6PR04MB11231:EE_
X-MS-Office365-Filtering-Correlation-Id: afaf6c7c-7390-4b76-a7eb-08de85aa2660
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qw4Q33K2OXl6fziMqXopf+t9sdrQMjixtkd2YjozTXBrdw2n4qzmgRiTDeJr8lMUmqGtrcq5PC5jAOq8Fg5ivuc1bZeN1eWAtJHvH4/aukZcPkVLJeSNiAjB+laRui8bVRqUN7sy2mS1GoQLvyy60Y2b6I2meEMKGRLN+mt86KVhYRTSIil/FEFowYoxHsRkoRHNaOKDqQOQm0/Fe7s8IFftbdF4w5Cvfx9hvQ9INPjdGtoSWW0LMpwBhdAbVQ8nM1YCUQrs5vddD688gOzreHw9mDgEHYnfWbLITQ5CLCUhLJYiE2n8jAk6uWUiZTq1W1C+3TY+v0HXrJFDocCcRhh8Y+0kC+TBngfUpX+7JN/qx38+3ZlAVOsUQX0A683vtel2yHnm+pjRvd1WqCvfZJj3IWMRQGYMftfoGVCvda/b24pExdXijrzH0hkwi8ygOZlZUWECpNrPdPzXqj2+GpL0VhWwNBPhB4DZTiqOMTRdevv7q9b0NBZ5iMGkXtZdkt34TkAcUyIRzbxAfyFv2I/NDFsM0pd4CMNkWREHp/HqFIfKjPMnPw2XQ/OuXrh+3WMaAoNpksZzNmFRTx4700fvybzOdyoVlxOzaR8X2GA9gf4iQQV4tQ/P698q0dqMhXIz+v1FmIspNWC8ch9WTCYKGpiI55biLJdXjV9VokCXmSZsNb3IPPidNGHt7TlkA8xhh7iIspWsDqe+REp+y9BWrDFMthEqDzL9dL6JZe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZXN3h5akhTYldYWmIxYjF1endvZVpxOEd5blRVa2xRQWhvSVlIN0xQdG14?=
 =?utf-8?B?NXRIV29yaE4ybS9VS3l5VGIwNGFvbVppUm11d1RaTlh6VEhBaEVoaE5Ta2p6?=
 =?utf-8?B?VCtWOWd6NEN0ODFRREFZQmY3eloybENWbERobExCNTBuaENzdkJwNXRJODN6?=
 =?utf-8?B?WFdmOFgvcXFpSm8xblhhbHFvc2RiNXpMQ1BsYXZRY3JyWFplUUdMUFd1djJn?=
 =?utf-8?B?Ri9aeWMwNldVajFvSTd4d0hocXhieTlEVHJRNDloNFlUTXZEUUQwcDlwc1Na?=
 =?utf-8?B?Qk15WXlqM2NPaTBnbXJRQXdFcitZdUFyNDhEQU1rMjJQNW5BNDgyZE1Gd2ND?=
 =?utf-8?B?b3lYT284NjBscFRQOGNWa3NoNGZqL2lqczRpM1UvK3R0Z2JNR3N1K1doUmVM?=
 =?utf-8?B?R291MDhaZ3NoSkxaUUhYN3FWbUg0Qk8yOGdOZE9Pek5ZczA5WjB0cGV6QzBl?=
 =?utf-8?B?U1ZaU2kzTE05WXQ3Z3ZjK0hHTVFKU2dyQzRJcjRXSGQzRFNIclhBTUxUSFQ2?=
 =?utf-8?B?NUVFb0tDU2lJMnFzRWoxK3FSTSs1TDhaYisxQkNaRHBubFU2S09mbzZpNnkv?=
 =?utf-8?B?TTI2a3VaZTUrZ2ZuNlNXZ05JbjZ5VEFHYjdQU1dvNEpnNWN3YTR3SFN3ODhX?=
 =?utf-8?B?K2tjSjREb2x1cTdndzlkMlFwRXVKVmVDN3BlVjA5d1I5Y1pVeTg4L3g1VTNR?=
 =?utf-8?B?NUFKREVMdmVBMGc0WVZpTkxIbUNYU2VFY09pNGdMbDVFaWN6WTU1MkVEQkVS?=
 =?utf-8?B?eFlTZng2dFhIY1RqeEVxQUdTQ2NTem92UFNDMEtJV3B6NmRrYmNWaytOcUgr?=
 =?utf-8?B?RnBMYjY2S2JBTU1TOFB2ZkEvT0t3QXN5YXlUeEw5R2lpYVRWbFJucU9QWnpx?=
 =?utf-8?B?bTMvN0J6SEliSEltb2srYTEvODhudVhrcndmSFNmR015ZkJZSjg1T0I5V3Yv?=
 =?utf-8?B?T3Q3RXB1Tjc1VTdtUDVaQk0wQllYYkZqK3g3cnNEbUl3b2djV3hma2d3dEh0?=
 =?utf-8?B?YU1jTytVeE00RDA1SlFmV1d2TlhIUXRqdVNkNURpdUM5ZDdmcG1yWGNnMjh2?=
 =?utf-8?B?ZkhQUlpnTzBIZG1kN1A0RDlvVkthQ0JDVDlQM2M4bHpvUzdGODRlVDVBZ0M0?=
 =?utf-8?B?VXdKTnNNb2k2SHliOHFhK3ErWlpjQnFNNGdaQXVCYmtoZVIwTjFqVm50emJX?=
 =?utf-8?B?dXBDazdPa0V5S25wYzBGTExwOUJMdWRxSEdjOFNieEI2cll3eTRQUTlnUThm?=
 =?utf-8?B?RU1rMFQrUmx5OG1QTm5RU0IzdE5xRmdoMU1RU2VQMk9pRjhnS3FoODZvT0FU?=
 =?utf-8?B?OVlhcWJDbW1DRjNnZkowa1k2K2xQMjFjSlplYldRRTI5VUFNNS9pajVkK0Ux?=
 =?utf-8?B?bXBzWHo1dmVyNURpWGJxTjFIZjh0Q3MrMGVRRVpGblVQcG5pYnhRNEU1NGVl?=
 =?utf-8?B?eDlQa09lUDZsY1VBMGlWWWt3aE4xVS83NldxWE5GTHF5UkNYT2NPUWhCZXE0?=
 =?utf-8?B?K3FtMjBIRHNZK2ZrWCt2WWZsS2wydEp2VTAwSWhUZDFUeHZHd2p0RHVseWQz?=
 =?utf-8?B?ZWlYQmJSYVRhN2hKYk0yZnNhZGVaQmJ5OEh1dk1MTXdUaXhPcGNnMlkxK0ls?=
 =?utf-8?B?VmZPOEw0UHFMNWZtczcxZ0RTams2aE9SRjl0Y2R2V2hLdzl6aVREbXpHaThS?=
 =?utf-8?B?NTJTVVdyQ0xFUElWeE4zTFRobjRGZE52SzZjdXdzeWdtRitsb0pUS1h6TU5N?=
 =?utf-8?B?aHM0N2NUQ2hVb01aa3JPQjBiVUtVVm04MEVlbHlHV3RDcTZlVnRMbjI3TzFQ?=
 =?utf-8?B?WElUZHVrbjhhZ3lVYXNBNFlOUFl6RjdFckNjUyszbkY2bnFSYjl5ekUxM3FJ?=
 =?utf-8?B?Nk9EeHU5NC9mY3JTZm9GQnpzaWdldERLeWFJWVBRQmQvcEdwWjhsNDNQdjlh?=
 =?utf-8?B?L0FFSzJVVExmU2JHMUNkUlpnZXJwSjB1Z2E0elJvQTlWNWs1MWFPL2hJQmJu?=
 =?utf-8?B?UUR5SUVpVXUxYUVoamFnTXhMci9vU2ZQd1hVdDBibVlHMGRQRlN3RnZ5aDBC?=
 =?utf-8?B?UUd1RjBiZzR2V28zZDNjWHNSYjd5M1BmbmQ4MDdLU2U0SHd0MVhqWmc3T0sr?=
 =?utf-8?B?OG1JNmJpdStJNk80VDdFN2RWbnNBR1AzNUdDa2tibUw2Y3g5dkkwMkJnNHpY?=
 =?utf-8?B?TmRaSURBR1puMkcwYzc1cUN3TStHcnN0cVVZV3BMbEdnbWVKSkpaNDJiOS9F?=
 =?utf-8?B?VTVEeG5YRmlJOVU1NlBqalNzQXBlc2ZvVFliMExLY3RRNk83T2txQ2Z1Skhw?=
 =?utf-8?B?ZG1TN01NbFRlbEcwQzdDM1BwYnB6MGR3bDg1cjFuRVF2K29NQ1M3TmJzeTVV?=
 =?utf-8?Q?7YjziDtTIV3uLCqE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaf6c7c-7390-4b76-a7eb-08de85aa2660
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:24:57.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IwpJLI2oG9LJ8hJQJcVK4nyFVOZkysgEGvNUUGcwTEqhaA1DwQ/T182uwqUxUgT5ua6hVcP9t1H5Ob3i6zU2uHyNuPYTxY1nXQ4X8fEZZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11231
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7148-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 55B012CA43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 12:54 PM, Marc Kleine-Budde wrote:
> On 19.03.2026 10:40:30, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device data and compatible string for NXP S32N79 SoC.
>>
>> FlexCAN IP integration on S32N79 SoC uses two interrupts:
>> - one for mailboxes 0-127
>> - one for signaling bus errors and device state changes
>>
>> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index 1d5879510adc..0f8ad666df09 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -397,6 +397,15 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
>>   		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>>   };
>>
>> +static const struct flexcan_devtype_data nxp_s32n_devtype_data = {
>> +	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> +		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
>> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_IRQ_BERR |
>> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>> +};
>> +
> 
> Nitpick: please order the quirks by value.
> 
> regards,
> Marc
> 

Sounds good. I can order them in V3.

Best Regards,
Ciprian

