Return-Path: <linux-can+bounces-975-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C5931C8F
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 23:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256E928271F
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768713D53B;
	Mon, 15 Jul 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TK13gMg8"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7513C9D9;
	Mon, 15 Jul 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078859; cv=fail; b=cMgJgv7lYpoL/H/u1G9V2Lxr3+X20fU+3IZ22B4EEVKO39I8X4eMzm0Ajgk+iqQpxXDHXIWoBuL3DECKhYMH2UHHb47SQJOaN4RQCpVPb8SmuKahJBjabBWhaOw5d7OAMiZcvJK+Y8PH4A2hgH7If81+Wly9Dx70cVzBLE9mV2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078859; c=relaxed/simple;
	bh=SW2DaK3gA3JGIfjd83d6VfSubovWT1+ogF6Mv/ASmx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h1GzaPQG46a49k4XRYrEqU48xiE/RA5c0OHPuLfRfpAThaaIq0wPrAurhoYY/mFTZ3PDWI6LXItf2q0JNTkFCqd1B/U/AhNkVuo8Pb5G/ympVqeiUdXDR9o//AYeXeBUC4jBu4sOnJuwRwsSTpoSYYAsH/Pok66S/DsWiUwaTJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TK13gMg8; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn/NtkQlw/E6VUJaGnu9d4L8ldugW7dNvyU8TTPDpc0Y4awJiXIR5nvUPsU3lM6jF3yqeZnMofJ1mAfpyp41ayJBSDGdrITGA1DulAYs2bA1Ei2J8T6SEyiGuDYvsjE2mPR+TrJBotoufSYKV49mx9lvUZbHhoLMpeuqGn5bSPlhzw+YBq+L0Hpv9apn1aqGE0Cp3B2UyqCrIOhRbUEmZs9w12T1MlrvH0cdPR/PiaFoBRv7pFecNcpBmOy6wMPXqPS0nj7KV3jlSaGkQOiqSZYJuJHhsQ3tgoRPoY6a5gj52LwCKqrWlWKsiInBKhUOpd7NxfQM4HoQOo6XHW6c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgJI3AiLvTPxBGYQBB7FrV90UfRpnZPmPDjyhDbf3os=;
 b=r2zrFv5UFRIr6zfmiJaShY2OmQUx/DMoRm4zkACLQGWHzJNrlY/Z6TCNcNC97kFhKp36iLAIsplUJkJ+f5+FF0SKIv6t+FQnjjlnUgly70MTnZbBz3BOKKSWGxf6r24vpf9fYtQRPICoUBFjpBSEhjcpdobYXhY592sTjsb8eMevHa9O2TbAWYMiVI+P7p8aEFsyyedl5FGEg0pvqdEm3dJtiz5r7rRIuG8ZZUf64+QewJUMRH3oVL8mRQh6Jt0SkUn8smftUTWvvtMsviwTxOA/ew1P+KJbS1ATCQ+RoMNlpdHaPzL7Os5R3tyxKzoZ11uXZBg2M109qKn9ZSLvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgJI3AiLvTPxBGYQBB7FrV90UfRpnZPmPDjyhDbf3os=;
 b=TK13gMg8R0NRidd0/fYrryYbyg92FEt6ZIC2XAeK9M0xe7FxQDU/E8Nf9iKPJ+57SAAqIHuvKOWeCqrk5buglQ9jTZxKVL6o9Sywz/7WlYwpVv7VbJ09QNOt3DZ2MucK2j/RxQRcGHSAXZ2Yo8csjKWLGuMiT13WYF5goj0ThVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 21:27:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:27:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 17:27:20 -0400
Subject: [PATCH v2 1/4] dt-bindings: can: fsl,flexcan: add compatible
 string fsl,s32v234-flexcan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-flexcan-v2-1-2873014c595a@nxp.com>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
In-Reply-To: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721078846; l=824;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SW2DaK3gA3JGIfjd83d6VfSubovWT1+ogF6Mv/ASmx0=;
 b=5RxoczcCCf4MitjhvAmD6lEVoD4mkTVXwCUnx5kk16lsT0n7GhTGDNUqhvy/ab9lR4bD1uaO6
 Q4FnGh03NOOD4+mSUro5pGlUxfRLkWTYmy8QB8flAEmjgKbcVWQh89e
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: fab03f9a-b243-4ffd-ff64-08dca514f26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHdyVVpqbDlvbDhpaDNycGRBUHFYZnpMY2VZWXovY29NdzAxNWJBN20vNTZl?=
 =?utf-8?B?Vzhmemg5ODgybkw5UVkrMG42SE9pNWhMR3lsMjJiZ3VYNytYWU5xenNSQ2RX?=
 =?utf-8?B?UnhDdDBWcGdhSlFvYUdWN0YycXZ3dUo5NCs1cVZXeWpPTXUwaEZjR2pXWWFS?=
 =?utf-8?B?R1p1dGR2Y0tmQlNtTTJ5Rm9PYVZmb3o2eVhqcEFWNmJhcG44L1hSeG1ISi9Y?=
 =?utf-8?B?bkFvUHc4RlpmUlNHK3dJbGdKY083TDBHeWRoVDAxMjBrMGFvMGZnd0hIWDdI?=
 =?utf-8?B?a1FUdS9XbjlRZW9NMFRaY1BWcDhlT1BJVS9ySGtza0ZDU1lrM1dpdkR6RXRP?=
 =?utf-8?B?WmJGMDRuQ056MmpjdXd6YnVYcm1OTkJFbTBSSmhBcTVsNUMremU4STRDaUV0?=
 =?utf-8?B?cUN4RWlGbmpyRG11NFdlK3hGZnZjUFpmeUxxRVUxdlJNaEhpT08yTzNQYVV0?=
 =?utf-8?B?QmpRcDdVK1JmTTc1RW1lK3lxaU1qcFdzNHJJeVdrRW5UU2FoaHBmbWVqSlVQ?=
 =?utf-8?B?Q2phWkhsWkRFcnYrZVR2VGprSXUrSm9xL1d5Qld3a241RTdtK0FxMWxpTXNC?=
 =?utf-8?B?U1l4d250UnJBYWZ5Tk9Mb2txYS85M01NampZUFUyVnJKTXlvS215WTNWdXN2?=
 =?utf-8?B?MHk5YmZzdVhqRWlCMU9Da095T3pENnFleTVqVFIxMTJOUTN2d1lSZmlkWERt?=
 =?utf-8?B?Y3BCOU1tcXRwY0lVeGZaME45cTRHaVUvQ2RTK3lIbmJzUG4vQjhUdGJOWk5X?=
 =?utf-8?B?dWlVTVZZNE5XZFVsOHM4ZVJuUjhBNU1mTU1OVmQrbDdHNjhzOGRFUjlMdGh1?=
 =?utf-8?B?NFh3L1FBZWlnTmdYZ1VEUHkxMkg5cXZ3Sm1kUFRLT1B5VmJ2ajZYakhvVWVn?=
 =?utf-8?B?bmxKeHlPQkhTOGlpQ0JmcmprNXRKemI5SVBZYjl6Und5Y25kbWtZMkJaOGVl?=
 =?utf-8?B?NzBwK2VoN3RwNWEzNWNGSm9HUmw2dG1xZEY2VXA1Vm52azNSbXhzNzJwS3l4?=
 =?utf-8?B?NUtHeS8vay9Sd2FON0ZFeWFmcThXUjhMdXc0aEVCWFZFRXMxZjJNOHZFeDFO?=
 =?utf-8?B?UDRuekRJWHpvY3RyUnBTazN2SjgyV1k1NE5XN2NtZW9aajVrdmlsc25ONjAz?=
 =?utf-8?B?elNKL21mdjcwamhkQVgveXZWTnRzVjA3Ni90VnNtV0JsT3h6bHI0cXlkcjNj?=
 =?utf-8?B?SzFpYmhseVk0VGlHSWN0dFhXb0czRnFJWWJrSDc2Y2Q2d0d6T0FOLy9SaG85?=
 =?utf-8?B?dzllc0JsY3BqNFU1eEl4K01vN2I4dkFjM0NIZG16M1hpWnlIYlhPZ3YxeGR6?=
 =?utf-8?B?RXppbnhYWUtpQjY4ZHJrbjB3ZC9jbkQ2WHdWbXppam0vZE5JSnlxMmdBMCts?=
 =?utf-8?B?MGtENzd2eFNHVmlON0RIL3BhSzcyYTR1V1FDVWlKSGlYT01aVkxtVHJaTklU?=
 =?utf-8?B?N0s3Zzh0eUxSVDdMYm9aNTBhWlN4Y2ZQbzJJb29ySHNLYmF1TTBhWHFxMXdU?=
 =?utf-8?B?ZTVsTTVPT0hrS2EvUmtEcFBGaDYyRlZPTzRCdTVxNmUwL1JCSlg5bmZLVDlm?=
 =?utf-8?B?UCswbXk3cTRCdnFwODBnclpnOGVpQlRTdE4waHd0bVF0LzlBVWY4ek1rcUFp?=
 =?utf-8?B?ZmNBc2JOTXl1eVJGYlIycDc5c3kybTJ4TlVGRE1Eb1dJMlIxSGpFYkJ5d2JZ?=
 =?utf-8?B?WnVrWmt0MUtSaW8vQXdGYXJhUVQyNlRVTjVMUWt5MktBMytSeFhERlpIQzVJ?=
 =?utf-8?B?ZENCQkZtOGMvaVpvQXZNZStnN2xJWVowUDBVS2VpbXpDdVYxVEhYOTNpU1ZX?=
 =?utf-8?B?eEZ2N0ptUGM5VWIzd1gyeFdiM3IzRnFpcGJSa1FDRmhDY25BMXlITFlWWkFU?=
 =?utf-8?B?RUJ6NGN1SnRuUnBmQ0grc1ZIRmJHVkZFWkZXZEQ5S0g5ZGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXI5Wlc4Q01sS3ovb2l5YldwZUZaTmUzZlBKTmJGNlhKU3QzczBGcW8yWkpY?=
 =?utf-8?B?cEIvU3JkQUV0WEowblVVWWRNVXlKTk0wSlpZdVNObkJ6MXBPaUFnc01tTnh3?=
 =?utf-8?B?aFB2elhKT2oxRU5zSSt4Y1d3cmw1WHZzd0ZtcGliRkxyYU52WSsxbVNvZjBj?=
 =?utf-8?B?NWk3bGhVeE1RMWtxMXV6Q2ZpMEhWMEhLbEoyNlhvb2U0anRlcmxHMWdSbmFo?=
 =?utf-8?B?bnpRcjBnMER0b2FCY2lSWXM2akk1cFZybzVrS2tYNVV2QWRocVkzcVZ2OXdk?=
 =?utf-8?B?d3p6Yjl3Mjc2eWtOVHN4L3NvMGRZR2k1WjhlSGpTYzE2RGZVSTkxNXVCazgz?=
 =?utf-8?B?bW02Mi9yekp6SWZWTzlhSGRrOXlFMXZlVkE0Q1pLbUpyVkZHdk11TkNKNDU4?=
 =?utf-8?B?YXAwU2dINC9MaU5sSjFabTVUaUdvRTlCQjNrZ0VacXZGSGs2a3NEczJ5VndN?=
 =?utf-8?B?Y2NEVUFNTUlwNkQxT3lHbWozY3NYS0I2RklrSkRRaXl5MTJIRUYzZnZSQXpj?=
 =?utf-8?B?R1RsS2VOOVJyVTRWOFpkQWh4UHZpTlVMNy8rTWJ6WDZxTC9taGYwM1kvZzhM?=
 =?utf-8?B?OGVPZjI5UTgxam0vZWp0L3ppUm1nbE1VbDQ4VXBxUEptNU83dDdPZ2kyalBP?=
 =?utf-8?B?MENZd0JzTWVHT0dEdyt4dzkvOFUyMC93VDVCQjNsMmRwdHk2bGdoU0o0VTRP?=
 =?utf-8?B?d0RzdURTSDlCd2Y3TjZURm9NL0hSdGxPbXV6dDVxNUNKak9pd3JGTlBqUXlP?=
 =?utf-8?B?V2w0YnNDWUdrS3NTMXUxUzhKTmVTcVcxbjRnVm5QN3p5SVI3OEQzeTZnMUJG?=
 =?utf-8?B?Rmc2Q0dRNm9UYm5BT0t1OEFkWGl0SCtMZnNXUHlqamQ2V0MyRGZyZDE3QjRI?=
 =?utf-8?B?SDJrSkF1NzQrdlpRZ0FVcTAvdEM5cmxuMEdqenppSm05ckYvbWhLRmIwZGdi?=
 =?utf-8?B?OHFjV1UyaTZJZ2JyRmoyNGdsTHJHQjc1ZEhNYStDdkw4bTlQUDF1RVlkUWM2?=
 =?utf-8?B?WjNzRnJQUmhXVUhPMUNtR3FXN1FKMW1EWTZ2SUdubldEbllnUEgwNFNxTGlT?=
 =?utf-8?B?V21pVW5xNGRlTVVlVjdxQ0FHVU1QZlNxWHcrYm9YWS9NTDZZWGZ2cGd4TDlJ?=
 =?utf-8?B?ekxpTitGV2F2RHcrQ0dONDB1RktpNXlYV3VtTmwvT1V6dURxZ0VVeGpGTWha?=
 =?utf-8?B?eERLTnFaWWhtL0djMlJsbGVYVEtYZ3pQTEV2bGJ5blRKR0QvTVBmWHQ0a1VX?=
 =?utf-8?B?cWM2Rzc5TXMwZWd3a3l3K3VmOUpJQ0l4N0xBWHAwZHNDNjI0RzJ5VFpQUlVU?=
 =?utf-8?B?NmdOdmV3UUlLdVBoZUQzSGdTVUI3dHJCelZZL3VtTnRJSTdRL1MzaTBYVWVF?=
 =?utf-8?B?RnNsNEJPdWtKWlc5cmJ3czA5N0hqcnNpcXVTYmI1ZEgrNnVZa0ttcy9LMGQx?=
 =?utf-8?B?MDQyN1JseUp5ajRndE43YXVZUnhkRUh3NFo4UXBEOE5Ed3liNENxbkN2K1c2?=
 =?utf-8?B?VFVmRjBGMnZMa1lmYkNHU3FOSjA0NmRHVmJhZXJvN3lvTlEwZkZzWjhDYy92?=
 =?utf-8?B?NG5YVXhVN3pDbnY3Rkp4VVBwMTQ3WWFMQ0VBM2JOV1JNeEUvVUYycDNyaEFm?=
 =?utf-8?B?NTNaVjl2T2NSRTZyMVViN2NYeUNXaWxjOURYWXovQnBtWEJNOWxNK3NtN2tY?=
 =?utf-8?B?WlArQ1hvN0pPM2VOcnFIVVl0Ky9aVVNOKzN5VDhGd2M0azJMVFY4ZTI4THo1?=
 =?utf-8?B?STVobzVBSXJwYVRLU3NPanQ1bnBOdGpVTzVYVlR3M0NyUmtUaUcvTmw0RWRm?=
 =?utf-8?B?UDZnZTMzOGJMakRnVyt2K1laNXIvMGZVb2I0SHprNWdyUGw2WEYwSis1TFRj?=
 =?utf-8?B?bnRhZFNodlZsVUpIZkY1RWs4TExMaFBDSXZlNEtxaGJmRERPYXVPUDFnM1k5?=
 =?utf-8?B?MXZFTUZORnZSTGlpQnYwaEkwdTYxdmFuOFViNHFjUURkamVleUFWUDF0TUtT?=
 =?utf-8?B?YTI3eFh4eDQ0NlFyTmR5QlVEaGdNVnA2V1ZrUyt0TWtOY0djZEU4UVdJWUwx?=
 =?utf-8?B?VVcvNnZzWmpYRnhUMkQ5SlpMNEJsY3RkMkpucXhCdHRsSEVmMVpRZzZtZExi?=
 =?utf-8?Q?DNbk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab03f9a-b243-4ffd-ff64-08dca514f26b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:27:36.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuKPKQMZ2feJLlz8MeumJ9PBN6a2tp/tI9Q3XwdWyxEE+uMvHHizhKaJ/4NZmGuf36LuwEU/WZ/e+5yVYKFCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

Add compatible string fsl,s32v234-flexcan for s32 chips.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f197d9b516bb2..b6c92684c5e29 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -27,6 +27,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - fsl,s32v234-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan

-- 
2.34.1


