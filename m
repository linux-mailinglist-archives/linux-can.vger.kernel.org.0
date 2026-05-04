Return-Path: <linux-can+bounces-7477-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EPSNDVL+GnusQIAu9opvQ
	(envelope-from <linux-can+bounces-7477-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:31:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BBC4B95A3
	for <lists+linux-can@lfdr.de>; Mon, 04 May 2026 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C0F3004252
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2026 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981892DEA74;
	Mon,  4 May 2026 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QdYQ6DgS"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA922857EA;
	Mon,  4 May 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879857; cv=fail; b=O8POtDf16Rf4Rzj7S3GovUnpi8SlKTfHyQU7Lopgbj330Lpty3DdeXTP1y4r/vpMUdX2udBSXTz7UYon96UzCYQNSRZ+IBdelV5Gt9Xi8zaX6Tnek7chivsYMY6Tvd7vPQNS1C5aY6y4OT0xdXy8J9X6hV2gzeBV2+AGd8DWAlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879857; c=relaxed/simple;
	bh=4hXpFf1piJFoSJvuqX/GIHAswmdMuM8Guqb8mr+MGj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AyexJdblqG3WbOl46GjxmhyvOE5NdMHpeeLY6zQb55weUTULqe2pS3V1FoVjhQ9m1PdNN9v6xjPqrn2wbGiOXF/D0FzKAW2M5gF8qAwbEkzEWC4SLWJTLCIvCsCQL2gBEWTUugz4ko0pxdiOQs6VaQT2aysd9SXjyDnsa9ATvEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QdYQ6DgS; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZTSbbTLBeCP77nzVmWP+r9i5HiwPeIoAYHonrdRUNp+hR1PBDOTobjUoMKPUTwfkNTfdSmK1ywlgElsW6KSoN/IaiU/hcC59buuZk3GpUXKzNMJE8808QCrmq0MxyntdO0ssRJazOjidHYnkSa0LBZkMO7mp8s9rIdHLsf4MhaMgO4Gsoyw/xMh6v7vvEMSgBJDis1HiNnNxpC0HDDw6T/ogeGeTiTnNKnNeCptpGveJZHY1CdZpXEjsvpFLhOlp0xeHBc/STS/C1wjaPbO83kMpEwcKnyl7v8Ieqde1HDkdB9jXV/ciUNZpCbGwBGbXkbarcdoObSY0u97zCizJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fwetLc1jZcAJdxL2IfCRi48MLO7Kpbn/HXFxRl0BMo=;
 b=Elir37yKTkrklQqEP+YF5zWRFt2kKEwaOg3QdkBCoc0ddWdxuqKROYGrwfkSF8TbVIQg9aIO+VRtqfDWbNs2rStjqyNHy7e8ua/a1njdBCLmEjlPH1Bp3twpZXelSnUu9yVfAgW8VV9y+MZN7yvPYJnqzX1jrlTLtSxzzmsyb9F3H+HzASwragVw8y9GTxUYnM9RvNt62mL1EUc+c4dpV4KHB6eJt48lptxBZ4+F2XHsG4XLDPBuxRO8A8Y0GovGezpxCYwZReIQ9HIx56Hgq1pYJ/p68+pzo2M7db3TArz8381IPrq/7Ob5BPFia8YoCthk+vxPXVyU2kQj4gu+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fwetLc1jZcAJdxL2IfCRi48MLO7Kpbn/HXFxRl0BMo=;
 b=QdYQ6DgSVQO+LAr+Digua1pLMzmWmcIlgbpAB4eRSmCBieaFza63n1CLFlRHpLzVbDkLwovDTolF31y42pmDNMga2gwbWf4mHCqg0UPu0UA7Bjjhend9aiza5593Y1NIovuWz4u/z4NfI2HClQmmFtXEvGZbR9DGqfZCmcwI3GLYcYIrX2ElRTpBHundSwfcY+shJFA7dCUhY4EDJSaIrs1uNztaWu8oxi5+t2aIEKoNZlR2mWSkGkKTCKFQteSlvJA9qlNrqXoZ/FWATTIrq2NZ5wVZ1zI4mf4dBNG8uKgVIhdrLSyue+QZnhfmxPLYHUqGMmXfUByEnFvGu/JMfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 4 May
 2026 07:30:51 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:30:51 +0000
Message-ID: <c7a135ea-eca3-48a8-800a-c7f97a993c25@oss.nxp.com>
Date: Mon, 4 May 2026 10:30:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
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
References: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260421102603.4122332-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c57732c-13f9-4e06-c02a-08dea9af1198
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 55DaXsiJfSokiNtJKkLFit8lXz4E1qe7hp3u72t0Qvm4q9o65ebwIhFayo905eECHuVevNKxrKtxez6cz5hywz4nGHgLCGOOkDexbx6YSr62iAKCYtn4VETrb/eeoiJt66smGCxBNdmD8Hl1tJnOL/bkKw/6+KNSvZVTX9GhG4vATt4y7D8nfwdjrBo/Bhy466hSezK/IKsPb1zSnN6yb5L3+KMcXjdBRaki9wSqyf5CF6C9eByOXHU0L0sYEk84oOlB4nZnNAYzr3gp2K33GkyCBEEjhQrdY+ECTrF165IJPVhJjmu/kQZTGfx12No9Bf2jFiLMnd/sSBMklfFkIdk05zTnsNBnLaTtwlAbXRVxUyo8D6f0P//9wlusGTTtty6AevYnL28yMjVxEmV5ABAhK7qvpQQQ1KWat3WL/9DOdjUsWSYowFrYqnRj0F2S9GvH6bg9/UCKBAwJUpOfJCPVQpg9mbn/hRAb8SwqqB/nmcFPgyh0yQ3ddR4x2hTwjQWKmlSGos8JuC0lHYxhAfACUd5eWBI3fbGHAmX70K+UR4DlEiWvi0GCC2iSWbGQqQDtp/5lC2mni9PsjWr7YGV+jVuYo9FzHD8IRwn/dMuLewh2pTslIhmVSQAQlUCJ8GtbI0adEt6FJKyqaQILht0NC5IgckzFbg9uaQzFWzxZZQy9QwMx7YxPRIB2FHv0
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SEU0Qis1Z0srd3hGcWZheUFNdzVCQzlDdkNGeGpKSDlibmthVHFWeVl1SjRh?=
 =?utf-8?B?UURKVlpha0FGLzBYY2hSQ25xRFpIeXU5T0dYTTNyUnpmdUNUSWNUUTJxZUpI?=
 =?utf-8?B?Z3k2bE9mS2tScnJaaWJPRGhpZ1NzMTlTeDBXNkpZeUxMemV1SzBrNHV1b2gv?=
 =?utf-8?B?SlQvZlZjaFc3cTVCTmFiVXY0b3pTanBSNTFLMWs4d1Btc2ZFWStKRGV3T3dH?=
 =?utf-8?B?UGZqRGlnZjRCcXpyR20vMkNDdmUvWElONzlBTG1UdTNsK3ZkejBrZXJ2bG95?=
 =?utf-8?B?MXlLVzM4TzlHckRtTk9FMCtMRWpId20rYzZBOXRUdnhzZUdLQVZacWpSa2dI?=
 =?utf-8?B?NWF3b0xHcDBkL2pWUktRbVRKOXJZMVpPL1o2Q3JiSGdQV1Rhc2lRb0xQVTBs?=
 =?utf-8?B?WmE4cThERGNQeEs4eXJYaDZVQW9yNWM0WFRQb0hQekJ3Njg5bjJnTHRCaHRY?=
 =?utf-8?B?UXk3TnJqNHlORTU0NS9CNHhWWjBkYXJENmlNbGdFTnFaaDBkbElwcnVFVTdh?=
 =?utf-8?B?Sk5sYlFkckNDQzlkSkRSRklvNXhxQk96L3BNc0tLUWNkMS9HZU4xTEcvZG5C?=
 =?utf-8?B?bGI0TVNJQmhSUUluWDJXNFNJSUVpMmNZcytETjZwcFptY09lQnNXdGhnb2sz?=
 =?utf-8?B?MUczcFR3T2JIQWg4YkVxZkhMZVVvYUkxVVJiKzl5Q2RRN2Q3SHhjQlcwMUJR?=
 =?utf-8?B?VWdNSmxuaXVOdmRERklWNnlLUzBpUzVsRGhyZ09qSzZndWxBcnJwQWRNamZ0?=
 =?utf-8?B?UnhENkhuVTNUYUFOU2E5ZlRDaG1kcDBCRThyb1VhS1lYaGZFL0Zzc05OOHJQ?=
 =?utf-8?B?Wi9MY09rWTY5Y1pxeStlNUFGbm5TNHJURFp5U0tSRGVRVS9WT3pPQVdVYmZQ?=
 =?utf-8?B?cFlzTklQNFRPK3g5Ty9QOHUzRTFhNW5RbUYvaDhDRkpwL1dhc05wT3BoWjQ5?=
 =?utf-8?B?dDVjOHQrajg0cGxocUtXaUpEc2FaTFZ5R2xtd0V4SlNPTVp5WDVRZTFXaFk2?=
 =?utf-8?B?blNCcmNuSk9VMDh4ZUpOZnc0OWFlOGczM2JrZ2NTaVNYVU9qQVNGOFNrbVZa?=
 =?utf-8?B?QVBVcUhYZGw4YTdERGpkcDg2RnNvZld1SHNUSlpFOE96ZnA0eVpqTTg5QVd5?=
 =?utf-8?B?aEVmN0x5R1hhL0hTTzUxWXM2eE9ka2pMMDFrVHZMakszNzZ5czFEVS9LUlBp?=
 =?utf-8?B?bDhlSUswVGFBK2xIU2tEUzZzbW94cWxmSFRmdGRDU1pjZHNtSUxZWFF4MzFy?=
 =?utf-8?B?MTB6VldLMzJ4MzlnUDZReHo3ZmFYODJZY2pua2RnMzNZeENjQjIzOC9LUFB3?=
 =?utf-8?B?WHNhTkI0TzJpTS9BdjNjeVlpS3NrS3QxRTB3NDZ2azZpQ3oxeWlGaGJsZWRI?=
 =?utf-8?B?TnZ4UmYzUk5ZWEpsT0dGWkZNVmdoRmVuYlBWTHY3SVhrOFVuV0JCYmZvbE1Y?=
 =?utf-8?B?YmlFM3RUeXNMTDNyNjdFWHZRNEdIeVhoL1ZYdWZ4UUZ5cWZxcTBxRHZmSWxv?=
 =?utf-8?B?WGpZVnpWS3AvTmZ2cTRILys4Qi9TMk55KzdXL0J1MUdvL2FaQjhCcDdLamZY?=
 =?utf-8?B?bFJraGpENkc5bWR0RWI2b3lNaEZTK3pnQ29uTVBxL0o3M05NMm5oU3FrSmZT?=
 =?utf-8?B?b2pXS0lSTDk2MGRCRlVMNDMyRzUreEUxc1NMSmZNWFJUQThnWnhUSHFaUUR0?=
 =?utf-8?B?VUczZDVhc1pNNlNKNFlsdTlzMXlQK09HTUtKb0I4eERqSjN3ZWtoUHlERUF5?=
 =?utf-8?B?QVhXQm5XMDkwTFBpN2ZRNHZpWnhGaVljMXRCMjNwN3dMZlBqbGs2RXl3cmpP?=
 =?utf-8?B?VFZwNGtLT0UwVVZSSk1kRUtmOW53ZzJRcWdXMEdwenNycUtPZEVuNVRjaGlO?=
 =?utf-8?B?RXJsc0ErTkRVNG8xUHJkc3pjZytKc25iMGdVYWZXZk9mN1FiNmNtVFdzQ0JC?=
 =?utf-8?B?Tk1EVTRScFZZQm9rMFlwRWpTbzk4bHk2eWlzMlFweUlNcCt0MTBQeWhQakhR?=
 =?utf-8?B?akxhT2lDTUFpN3hKYnRzY0MxQkdrQzBISmZHdEVoUCs3cjdNRjZQVG15cjE3?=
 =?utf-8?B?WWxxYTZ6cTRpYllFTTljS254c3RzbUJ1Z1NxVS9zOEl4OG1aZzlFZnZUODJo?=
 =?utf-8?B?U01NWXp6Z2YrdmhURXYwMjl3bXlaQmRNUnpMaEdBOTZPNkJGOXExUlhHQkQ0?=
 =?utf-8?B?K2x6TXQxaVhZZzE3MkNFenZwVFhSbjlEQzlCak5nVFFmK3laVFMrQ0dNZTNY?=
 =?utf-8?B?cElFMDNXZ3oxcGIvbUJBQWdWWU1xZFJNL29xODUxT1gxemZSMllDSXJsM1VX?=
 =?utf-8?B?clpwaUkrN0Fpb0dJTVhuVG1PcUw2STdRRWJUVjlHdkFNSkNSY0hDVTlVMXNM?=
 =?utf-8?Q?dOeXEHxxeaPX7vHM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c57732c-13f9-4e06-c02a-08dea9af1198
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:30:51.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7zPDLMeBp9tFw6n7YJNg6Jzw3iyO3EdYO+8SfTT0YbDNyFpU8pC/IYf4crU557336Uqle3jk1GF4bFlZPfValijmGK9qOzQHZ1pbjK0vMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349
X-Rspamd-Queue-Id: 43BBC4B95A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7477-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]

On 4/21/2026 1:25 PM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 

Hello Marc,

Following up on v4. All comments from v3 have been addressed. Let me
know if there's anything else you'd like changed.

Best Regards,
Ciprian

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
> This is a resend of v4 with no changes.
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
>   drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
>   drivers/net/can/flexcan/flexcan.h             |  12 +-
>   5 files changed, 316 insertions(+), 37 deletions(-)
> 


