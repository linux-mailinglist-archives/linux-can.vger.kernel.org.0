Return-Path: <linux-can+bounces-2335-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925A9E3911
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF112B23D46
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0261AF0C1;
	Wed,  4 Dec 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kLMIsf2g"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108F1AA7A5;
	Wed,  4 Dec 2024 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312341; cv=fail; b=WuNTh7zY9vjLH6wPckRXTOErh8b3pHBkeJXFp/m0XLmgMe/pc24z42QCV/YGbd3NSdezBO9skfsOo77soUmaWxypDV+o5y1EeSOIsUOuKLUO5CFTm5UXbg4uh97IhXNem2LxILGlD+8x7MoVIGBXxs3sns+LRGRJ0PwO9PowxuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312341; c=relaxed/simple;
	bh=u0PZilb7i6WzKK/efLhpD+XTIZ66xcFEXkcSvg0xVAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KP7l3ybJ7cm5ksWrczaImIc9h6rf1EO8UN+fFH68Iu7BSp9qUAXv1J+Yfub4TUiYWUXH9NBhMeSesoeHEKWzB7xY4BKwySaIZWjb0B7DQdulipYnEq+eotXaxDUXZB9K0QRxLcqE7LAQxqiYMtEJa6cjReeHtWWBlNi6yTiB0EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kLMIsf2g; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIAHbHctqlpCUtVogwtSNC9II9bZvs4uKqviZynn/ofas9aICGlXXQnfMMYUcMLFV1wB5/2kfEywW7WHalZr0Fi3mqJY7jZ7ixo/EX23nW9ITKlP/i1XxlxtGk2e1irLaQNPwM7pwAkN+5vxVzhXeZhM18tmtbySyaJ4ATaAs8c/VW9fbxj4nNt2EwD+XRPqS+CtvRAK+Qn/hEn7ZE68ojYXTEGR14p/RchlcE77jc7lLff5XYRuZTppNMJm3dVOoDfgwNIFvE58IxL+TzZB8oOaVZGSd864mHKKCJwEIP4e46XAT0B2g0WOVlZNT2Y9WivzvO23LDKxE4Nd6O2Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=watkwHPwTiEoif9QNXwa0iZ2OwbNFMnr5DXIyI+6LcE=;
 b=TPwZvwn1r52jkK3g+NYRMBY8LxbruxL96ZcQOaT58HiC2ANAWTEOND9/8WaP3+CfxVCu5Cdd8RUGQ0yyzvywit8faNS+593HxLAlhxphlfoo6xvSmIpgTh34qPKuajp5v76mB9xetvNs76zwhm4pxfA0+9uOqmFDfSyXnZNapTJpwboTHvjHDTdzzoRERlWhBNYYXeNel+v4VjDpWRf1VBT2srnljVWR+eQ05d05SWm2b/+4Ad99eK4ApnfqnYQ7qa6v8F2wkfgMbRdVXcFkVYx/s4la0NG199u6ZgE0mjdnxzGgkAOk+FiHkR3JRrQ+k3EUrXWmgO1Uym3MzZwLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=watkwHPwTiEoif9QNXwa0iZ2OwbNFMnr5DXIyI+6LcE=;
 b=kLMIsf2gIe4xX6m6/oP4h4EtiX6f5Demc2Na7Phue/g6TFHMb19d41E6RZqmHkkuLA97GPGru2BBSd6CT46S8h2MvPTKu1Mz5FVFhTDdB/smAysx96xSEOy5fzMufT2jDYzC5pvezzx2y9Fj8RGYhhIWn1BcTHyZJF4SGdSrNc/G75ahARR1YnOi7aSBPHmyXlYUcB+xPn83CyiztYPFNBQajgj4APvw3n+I4iMBK+TYnizmuRYSumU+abX/rLNqBdUwFYfvwYv26ct7anBrO7Gnt15kn2BNEaDxaZCLV4X3sbRTMXdIPUCCMuSsiSZAIQTLHooEOumh5axDGwNNwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 11:38:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 11:38:55 +0000
Message-ID: <1147e8d9-b6e1-4290-9cfa-888d93f185e9@oss.nxp.com>
Date: Wed, 4 Dec 2024 13:38:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
 <20241204-chipmunk-of-unmatched-research-e89301-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241204-chipmunk-of-unmatched-research-e89301-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c73a47-8df0-4311-2d39-08dd14583c05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHdrSFIzb0haRGt3ZyswMlVPaVJLM01sWTV5WUJYNkgxS25kaWNxTmRMbkZx?=
 =?utf-8?B?MjdnSHVmbjM0ak56dGYyWTFWSUZtaU94Wlhmb2FKcDM2d1RJOHVZYS9TUjlB?=
 =?utf-8?B?dWt0WHZSZTZCUllZN0cxT1haRDRBekpjdU9FV045a09wdUFOZHVJdCswN0VT?=
 =?utf-8?B?RitiTU1ERjUyOURCRXdDUVN1cTNPQkFMZUlxMi9qQVpHSkp5cUFWRlE3TEZq?=
 =?utf-8?B?NXBLSnVqVEdzTTZXUEFaOTQ0UW1RS2QvNXZwTUVzY3Y4aitwc2F2bFl3YmM4?=
 =?utf-8?B?U3k2OEY5RGljRHRJNWl2S0lEMUVnT1Y2T09VNmlxT2F3VlJ2Z3BqQTFUUHBG?=
 =?utf-8?B?UjNBN2g0MEJ3MHlsVHlSSDUwYTVzc1FWVzJFZnVsZWZLZ2RTVW51dnhqWEEr?=
 =?utf-8?B?am1FUWp5czIxMmhHWnZnNnhlOHlhTWNWdG1sUFVzTWRFRGZYOW9Ib1hjaENC?=
 =?utf-8?B?WndyZHhsdEgwT3lXSGVCcTJGd29HSVlXNDNWOWVOM3pUdkVyc0JqY2tGOGcz?=
 =?utf-8?B?N1AzSk5DOEVlekNSd2tHQ3JJWWh1SWdLdWtEbnRWOE5iSFdsUVZUZHFVRlZ6?=
 =?utf-8?B?V2VJQ3RwK2lEL2R4enA3M25lTG8zMVNsYVhtSzVwbk9iUTI4YkRSSjlXY1Ry?=
 =?utf-8?B?NW9uL016TFY0Z2RBY3M1dzFScWF5ejhvaWtjZ3VPOFB3OC9kbDd6T0dpdmxJ?=
 =?utf-8?B?ZDh2dUUxcHBEMDZoemZBb2FydXVTaUU3ZUdmbTZ2cSt3VUNta2xPTXJsNit2?=
 =?utf-8?B?Vy9Cc1hvMWNUS3VqcVZUeEdDdEgwKzRmQlpDSmpzbXpLWG9aUjVLNUpPNzE0?=
 =?utf-8?B?U3hZYlRIUFhwajZoTWFRYVZnczZZSDQ0bmJiNHBqQnR1ZHl1ZHgyL2tjZTFp?=
 =?utf-8?B?L2ovdGxaY3hneHRRTFRPaXpDbXRzZDM2eGxFSFJoWDJWc0dyWGYvamwyT0M1?=
 =?utf-8?B?U3FRcDVBOVc4ZWVSY3ZFV294b08vWDlnZUpaMyt6bkFEOU9MazZLVDY3VnA3?=
 =?utf-8?B?QWQxOW5hdkM1Si9hWGFadi9mZ0VUWTQwZ21kRnZmNFFIQXMxWDBxY3lSVSt0?=
 =?utf-8?B?WGRxVVRqdlJwZUNXYy9aYXlEb1V3eVl6dTM5ZjNlWHRVNnBsV3l0ZTQwL0hr?=
 =?utf-8?B?S3lUQUp4MU00YU1ER0xRVGRVbWxVTkxzYzNVS1RMaW84a2x1WGxnekVSYXhs?=
 =?utf-8?B?MUxWRVgvVk1MeGE1Wnh4Z1E5SWFoQitzSDhlSVg1U0tFZC9jREJlRjZDTzFw?=
 =?utf-8?B?UXRXT1o1VTFxeisvbGJlc2RRMEZNbzQ3ZDRoaXJ2RENYMm8zTTQ1U2dLQWVa?=
 =?utf-8?B?ZmF1OGpFT3daN0FMQ0wrODhQYjZhWFJzMXNka2piVXRuTDdEcVpaVmlOSVdK?=
 =?utf-8?B?cytTOElqbjBBNUhlQjM3bm93bE0wMFFRMFkxbVdaVGxzdndyNjUvUEFwdjFZ?=
 =?utf-8?B?ZS9xNXczQmQwSmJ4Znd5Slp6WWlZQkYvSjBTbmlJMjAvd3d5anYzNXVxL0ZO?=
 =?utf-8?B?RjVETkVNRlc1OWZ4Wk1DRnVyRnY0RlpwNDE4WmtOckJQbk9OVytpZm9DUHJu?=
 =?utf-8?B?eHZTY3B5ODNTdEVSYmdtNFNmb1kvTnlLVXBkMWZTc082eEgzZ0JDa2ZDWFhh?=
 =?utf-8?B?Rjd2STZOZ0lzMTBOSm1scjVMVGVDMGJhcWk4QkI3U2R5VWFJYlpRaHpSK0p3?=
 =?utf-8?B?V09zRE5KNURUVlk5aEcxSHdaRFJ4SWs2ckRDeER1eEtUZXFyZzRadjM1UDlF?=
 =?utf-8?B?Y0JBeWRtemM3VU1FdTlQY01NS3VoUmJkQkdtR2hrUWhLNDNCN2ZxYjNCZnhY?=
 =?utf-8?B?MzBIV09JdVE0NUJOQnRUdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aThGQ3FGS3BTQ2src1lzZzI0dDdDUUVlZlBYVEFHZ2xqK1V1T1FHcG54R0RI?=
 =?utf-8?B?VTV2NTJvUFExcjdXREl5aVZpWmVaaVMwdm05TWtpZXZndmtzcXlBVmovNTEr?=
 =?utf-8?B?SFB4LzlRY1Z0WDdnSTU4R3pDdmJsbk1JQ2VtSXRVbU5mMTlTb1VjYVc2aUEx?=
 =?utf-8?B?cUFZeFJEMXh1M2FmOENxQ0UxaGR1ZmY5T0ltejdralczd3FuTEhIUkxOSnhH?=
 =?utf-8?B?bDZRQjJ6TW5SejJPVU5vT29pUHNpbnI3eDhkVUkrNlk5ajhBT1hPSnBIdTZB?=
 =?utf-8?B?bDJMaVdTQ2VSSG9tNG1jOExuNFpqdGJyK1liYmgwWDlQblhJMmppYjlPWndN?=
 =?utf-8?B?cWkvQ2FlOUR4VE8rMjJsclJwdFZQVVNDa25kL3F2TUhERWRTb0xFTGV4UC9F?=
 =?utf-8?B?RGhWU0Q2eTMrSXo0Skx0bDNhT3NJNXVnckgvYUt6UkdzYUFMMVRvZ2xVempJ?=
 =?utf-8?B?bHBOY0FFQkt5RTdOYzJOQzVtQzh3b2ZPOG5qMURYbEVGSWpoNW1LWXlyVjNz?=
 =?utf-8?B?SVgwZ3UyK2VRdzU5NE9KQmcxVE41V1pzWHZpcDVlL3B3ZTJoZ0NMamJsY2xr?=
 =?utf-8?B?Mmtad1NRQnZYdWhjRVBicmxqcDZWdWQ4eHlkYjBnUUNQQzFvTTBnN3IvbFdL?=
 =?utf-8?B?a3VSVS9DNGQxc0FIUW9xa2RiQllzZ2xnMFZJdE9FUFhrYkx1NUdBd05sUldl?=
 =?utf-8?B?cUxOdFFBcVlBcGZMWVV6Nks0TEVNdFJyYk5GSFNrdjQ0a3NzWGYvTi81dkVN?=
 =?utf-8?B?eTM4NlpHRlZBVWZJNmwwUmc4UDBDRy8zV3hheGE3NlhqY01BZlYyQ1orRkNL?=
 =?utf-8?B?NWtYN2dOYm45MmRRNzBXT0g5VFB4Q1dkeEVhZTY0N1ZTMStiaTQrTzZaYXJV?=
 =?utf-8?B?ZXdGMHY2b2V1QjJ4bGMvTVJlM3BhTTdDVEJmdnF4TWZtSW9VYXI3eUNlNUl5?=
 =?utf-8?B?TjRLMENDODZ1S3FXRUtuVXpUUkNjMjVhODVRbFcrem1sdEhpL0ZCRVVzRHNR?=
 =?utf-8?B?bGczTEVITWlONnZ1ckV1clQvb0lYV2tKQXUxN1FkekJVV3BncnozOGl2VEVN?=
 =?utf-8?B?M1kyUkVaTlVLOUpmZ0pVM3c3dzNtWnlVcnRBNVlFZjRnbFJ0bGhwTlIwMjZm?=
 =?utf-8?B?alRRQlVrdXcvbzBabFVyQmVBN1lMTEFnai9uZ1l3MTdCc1VUVzA5OUUzWVlN?=
 =?utf-8?B?YjZ0VjRPTjdhN3VpQ3dESmExbkZyUkV6ck10cmp2QmN1RUVqakkrVUJZVERi?=
 =?utf-8?B?S0lnNWZaZ0I1N1E1UUNaQUM1M0V3WTN5TVMraXVDQ3FaRUlTTVhoUEo1YkhN?=
 =?utf-8?B?aDNydzdEZ25pTXpRWDQ1QTVjd01DMUswblRKY3ZIdEd4RVY4M29WU1Q5M0Yx?=
 =?utf-8?B?NUkyN244dUN5SXR6ajJubk1ZK2VqbGxQb2NhSTh2UEIvQmt4RUhmU21Fa2ZH?=
 =?utf-8?B?WGRyM25kWmJIMW8rNjVHenFRTkdSVGE4cGlWUXBVcm4yOWxHOGZkVXB4cnFp?=
 =?utf-8?B?SkM3V1MzaWdYVStsU0FXc1U3RzUramNoYUM4THFsS3Jjcm1WNXExUTh2bllO?=
 =?utf-8?B?RlI3L3lZU2wremtFN3ZJeGZKd1RFWSt1MTJVWXpmaFVYbm1tNlMzc3dCTEhq?=
 =?utf-8?B?S1A4SGlaWHlibXFWMldRRkFYdDcyNHptbUEvYjh1MUFnQThNK3RnSVB3WVNs?=
 =?utf-8?B?RXdudk5nZjV5cXdCQWNEcjJiOTZHOW9QOXVGWnN3Qm1vN3o5aUZrQlB3M3FP?=
 =?utf-8?B?ZElBWkwrbmFERUJQRFo0cS95Y1laWjlRdTRpQlVUTnc5S1lDRVVlblZGRjNs?=
 =?utf-8?B?TkpwRlRKd0ZjVTdVOHR2MDV3NWx3UVFiZGVpdGhGd1ZZb1llbEZBblc3Y1Ez?=
 =?utf-8?B?Q2JBUCt2bzY3SG5zbDFoNEdBYy9MWHRYL3ZyTm5vcWdiV3dWL1hkYWxHWE1Z?=
 =?utf-8?B?UndvWlRFVmxrQWVqeGVyY3BjeVpQRlVONlYrdnQzY0FrL0NveWVpa1ZCZUZL?=
 =?utf-8?B?QXEvZCs1bFNFZXhwb2puVEtvTFd6R3p3Z3VsTWxZZHo2cEs3Q2xTQURJazJv?=
 =?utf-8?B?OFFleFRJUmkzZ28xUm9iVWpQRm51b0g5UjAybXVwMVNUOGFTWDJGOHh2VmZ5?=
 =?utf-8?B?cVNVV1VnN3pqK01JcFdkMFQ2U0h1OHorZXBGSGIwZ084bkthaWVhdTRJWGlZ?=
 =?utf-8?Q?tEsfZUay8+/3U68y70mrEEc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c73a47-8df0-4311-2d39-08dd14583c05
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:38:55.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfOmotfMvCLIcHql2Vt16c+f2Pubp9DonG1llaKMsPzuLeo3DjFHlC768fZ+jDwNFH4NCoAXXRHGneVdRZWCLsVDoNWCBQlUFa3/KNq5Yoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

On 12/4/2024 10:05 AM, Marc Kleine-Budde wrote:
> On 04.12.2024 09:49:15, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device type data for S32G2/S32G3 SoC.
>>
>> FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
>> management is different.
>>
>> On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
>> errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
>> In order to handle this FlexCAN hardware particularity, first reuse the
>> 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
>> support. Secondly, use the newly introduced
>> 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
>> separate mailbox ranges are controlled by independent hardware interrupt
>> lines.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
> 
> Looks good to me!
> 
> Unrelated to this patch, but I want to extend the "FLEXCAN hardware
> feature flags" table in "flexcan.h". Can you provide the needed
> information?
> 

Hello Marc,

I would say the following S32G related information could be added:

>> /* FLEXCAN hardware feature flags
>>   *
>>   * Below is some version info we got:
>>   *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode     MB
>>   *                                Filter? connected?  Passive detection  ption in MB Supported?
>>   * MCF5441X FlexCAN2  ?               no       yes        no       no        no           no     16
>>   *    MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
>>   *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no     64
>>   *    MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
>>   *    MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no     64
>>   *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no     64
>>   *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes     64
>>   *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes     64
>>   *    VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no     64
>>   *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no     64
>>   *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes     64
      *  S32G2/S32G3 FlexCAN3  03.00.39.00     no       yes        no 
   yes       yes          yes     128
>>   *
>>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>>   */
> 
> regards,
> Marc
> 

Would you like me to send another version of this patchset with above 
information included ?

Best Regards,
Ciprian


