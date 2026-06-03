Return-Path: <linux-can+bounces-7750-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pc3UBxcEIGpmuAAAu9opvQ
	(envelope-from <linux-can+bounces-7750-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:38:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D525636A7F
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:38:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QINVjFkD;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7750-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7750-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66663055DF2
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FAA3815CC;
	Wed,  3 Jun 2026 10:33:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC42E54D1;
	Wed,  3 Jun 2026 10:33:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482796; cv=fail; b=FBhCozMiC+w7Z9ay6czJwU2mvZF+6k2R3ScG/DVmTYrSrQlIDernf9N5+j9ecXa0oxOx62avQF/ZX+UV1/TpcHRL+QpZjeimJxGyHbKH9vGyPlVr3c6LvcOQHV5RYQE2QKaJBgrycxos2PgGkZvu8zcwzhxNLjbQzod2HSzwzWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482796; c=relaxed/simple;
	bh=/e1KmlfXQkFoHobWgk4meocrd76e95IxpNUk8PYF9/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPNpKtyNA8g5cyZu1qPJCPbIf/hIzDPbbrHb2rOWcOqDdabSLrPmivXGIWEGR1NQmhFp8DBdKluJ5lUgJd70zDdkUlT2R5Pzimh5thikWsnsaOyxpiJoHQC0XE5vZySpXrpwhXw9dSquTIiZs3eu2Pt3s0hSa9JaA3m+L89xQ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QINVjFkD; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTIEWHV9a7auCjZNhPVpfCabQZGZDbIQO4Vkwb60HDls55kV1cUAXtMo9UemONgZXRBpwelWzVnj4MCcbupS8vcZReOS//XCrY2kMTX6DaLBooYba6imAbEWDvciP7+mJ8r+WjbyqU4RM6h2kd2dg7SHg+GH+uQcwuopiv5dFx6Q6aeKDSbzLb8jTkjxrMaZNxD9JqpeHOUQ2J3UlZNhxkeG6nPtYV8Nxq5G/UgUmT4WzqmVsSrZd6DpPKuzSnRBT0ApWh/w/7bf02aVpYYW0kdWpygUoV0idL+Sm342ZOwD34QKEO8gxXDk7RkB946Za/omU6C2YiEYUp9gJAX4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTmy1+Bnh1Q98z/0VgrnDYRASEenUODU2UMGo4ASW9I=;
 b=O4FS3OPAL2qk+FdJjAc/1A5CF96AIa+uFt1E++4r0I01cixb3qbjY0eL9eC1w+AfDLGTeU71cNQ554OSM1NRd2nHiJXKseQajdnuN2ZQX1g7e7hQoLBCv9t+cyfErqM2n98LY2DMf91Ej5NGQ453WbyoJgVYLX9JlkmZVm4FZqZkEQc0/OIKrfdbILcCNA97h+HCSyT7f6I8USzD/j9t7gZ7mxn9xyXzI8CeCsxriw7Pe9nGp74nniAuYkN3Pq4gJ+R+9+1BgvgtA3l3d9U/0EKjt7AkHUI0FP1bUvTjOtElZ8s/T7xmJPdsryuWhpSz+vtz4Z9rjsUm+/LzcHqX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTmy1+Bnh1Q98z/0VgrnDYRASEenUODU2UMGo4ASW9I=;
 b=QINVjFkDQpDrL6xJKeaOM8xnUoJhiIHDwgjKN9qB8RWzXzZN7NYOEEQWaNqPRyjFvkq0hXrP8XIqsR+YTxUgoX4IuwlLCN3Bwq5Bq+h0+XFFijNU5qvseXBFpNnumcWmKZnCc4vXux77EtCX8jUbGKe6/cEuPuP7jzeVOrj4klMAWARaZ5B5sxIkRQROWUlV3FqqR+lTAPjBgc9ajDmsxYF620tkvyH7SjTeby30jUSMK2m5yD24DXZjGvQGG9L/W3M9MWCm2zR0Azar06+r7vzp76Il0Z57cS69+uw7eAXhgsCdXH1j+fXDw3JlcSDkjZYXDj/60ilDph5rIYXIpg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:33:10 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 10:33:10 +0000
Message-ID: <9844321a-59e3-4131-886d-5b884a0a1986@oss.nxp.com>
Date: Wed, 3 Jun 2026 13:33:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Enric Balletbo i Serra <eballetb@redhat.com>,
 Bough Chen <haibo.chen@oss.nxp.com>
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
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d96222-227e-4700-bfc8-08dec15b81d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|22082099003|18002099003|56012099006|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
 Snn4+c8jajAqn7aYRCusiAnvmyNNGPy7HEhjnf2+rWe/uq18tEgZmXFAjTEwAmsLe/BIz78fJnGkpaG+TdN3r/TojuiXVSV1TnGMXR2+g2ruyxWCxDa8Os+G2tzEtuR6nYVzqRCFEcaAgaoKfP0FCLZ6qCf0sToRtcHC8ZUWh7q8UVq3Nf3TkFuoly8Eu9JSkcRbEF6A8GxIMvgkgk8b2A1TNct1RPB7oMrFHpdClzmiCVoH3Ss68c2wrHEVRCvanytZT5l85BOh1X5ncqv83OnDVhKZKFN3HiW/DY8RFiaznuduAlmJW5zLrBphhcO3nDrUwh1VYTl3gLHHBM467gZ5G3fkOzG+p34L5E0IWLMi0iK7avfQT98xjB60rIdr4CjyS4DMl3+U/MPtVpMzVWhFBTLwfEn0Ofw0ab9Z6CHxee46Ivp75h1cQW5xmgKTOma9INuWbU1D2pstiqZLP4l1qXnDJqZUQXMdEU/UcIrf0xzNM1axpeN1N3gyTQ4AeRuYuQFvH8oHYa1snmfJiXtnfNn54gqfl4qi579JcIK4n266Hb5lWMwUgJHwJScRhJOCGgVH6zxfmDUM5ulgfQW1TfHo7FWiiMHm/azJ9foh4WWolHX/7Say/Nn4rPckiPJFiGcLOZNd0atWxqn1JzbGoTxr6OiUFlMHq3Tb29Pv4rRA3cJtDn3THf08ky7g
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N2tQd2U4M0JwTGRMck4vK29RYmRuRlZEQ09hdTNxTHJxOUxJRU1XVVZPL0dt?=
 =?utf-8?B?WU9NZEFBbXhoM1F0ZkZkaTdJelRPVEdib21ld1JxL0tYckg0M1lmQ3ZnYlY4?=
 =?utf-8?B?bUNRdjJTemh2ZHdneGlXazlRcFlsMVIweHE5NmpxM3FNVkRsMlM4NzNRaFUy?=
 =?utf-8?B?ZFIzYnZqYjBzNzVBUXBMUmJzSDA5UXUvbSsvdDFxNzhFUVVzT3dVM0xSek1x?=
 =?utf-8?B?MGlBT0pEcWViVEJiNXdtcHNJaTcrTXdaOXoxZWhWci9WOXdMWkJaSWg1ZnJ6?=
 =?utf-8?B?Qk11blhoOUhSMCtjanAwUzYvZExaS2E4dXFOR2d0SlozYU9uSzJDL2F4OE1Z?=
 =?utf-8?B?c2xOQURCdVRNY0N0WGkvZ1B5cUNnOTFSZ0FGTVU2aU9LWHZtcnpnczRpYjZh?=
 =?utf-8?B?eG9Pak04QS9xelFqaTBzb0k1d1Q3Y2NOUXZPdHVnNWNaMy9qelhDZGZlT1BT?=
 =?utf-8?B?MHFwaEZMWWVyOU5mYTRVczVsUGVtanVNY3RobzJ5bUo2c2g1UnJZQ1Rjanov?=
 =?utf-8?B?RWtFUzlyVUJoR3hUamY5MlNrbzd6aEwvcFFsM1d2c2VEQU9kK0JzRElWdVYy?=
 =?utf-8?B?a3hyRUYrdXpWc0FmQjZVNm01NCtSQkpSbGkzcTRKSDZndzZ0b25kYlV1VVkv?=
 =?utf-8?B?OHdUWTltQmtUWUZqTkN5QkpmMG9Mem0yZHhSYU5kaExBZTdlV3RWck1XbGFM?=
 =?utf-8?B?VXNua0NQc3YvVjVwclN1eHZSSnJSWm9LOHdHVVNQZHNzMG9BUnlxM0FLT0VD?=
 =?utf-8?B?VkxTc05aekRTY0xPTHBOSHRHdTUrWUNCT3FYM2FVbjhkYUxja1haR1ZiN1NC?=
 =?utf-8?B?Zks0VjZiTk45cWxuV21XUElEUDBpZVh6K2tTUHM1bGkzVWtVMGVQQUZiamo2?=
 =?utf-8?B?NEwwdGlrbnFLNnV0R2wyY1NqUFhPdmxYdTNJM3JJcm1vQm5HUHJ4bkR4cnJv?=
 =?utf-8?B?cFBZWVlrZ3dlNTR0ZzVvWXM4N1N1Y3JVZFRRNWE5elZzVEJpL0c0M0pqSk93?=
 =?utf-8?B?eDdFcDNCY05zM203dDZlTjNHclFvTnhMU3VqT25VaGVuSFBiZWQ5Zmh1OGJp?=
 =?utf-8?B?bU03cUk3M0xGbzNJRzZKSENtR3ZlbXI1WS9ZNVlYMkFNT2dYVEgvVHJZVVI4?=
 =?utf-8?B?eU5BM2tpMWZ1bS9XdkdFT3dlSUFaT1VDeWN3VFVvYll6NkVycjFieGRRT3J5?=
 =?utf-8?B?V0VMdFJOd3hQYVhaNVFzMjBYSVUwWWdJTFo4UWVDVHdnZ0tlM0ZqQmVMdGhx?=
 =?utf-8?B?WnFXRXpWSWo0SGMzZFpHbmp2eVRaOGdTQkhmeVUyZ1dXV01NSkhRdkt5NmtI?=
 =?utf-8?B?TXhlOGJUVnFqSXZUbnJVU1hiVDJ6WDRjN3lFc1J5RHpzRm00OXJRRzllZlhC?=
 =?utf-8?B?UStkZ1Z6anNrSmpNaGxEazRvM3I4ZHVIQWRaRDkxa1F0NmdZUE5BWDFueGtw?=
 =?utf-8?B?dlRVbUI0UCt0eVpGUVV1bWlqdHBTcnJyRy94VHVpaG95MmFaOElYaVcyblN0?=
 =?utf-8?B?am1GK3p2L2UxSnd6UzNUcFNZbEZ6dVJwbDQ3YzZ0RDlGeUtIUDIzQk90S0o2?=
 =?utf-8?B?OGFUa1laNGxoY3BCejRTeHQwTkIwMkdsR1BvM0FjY1g2V1pYcDNuTDkwelB4?=
 =?utf-8?B?ZkxHL290djdycEltYmpNaTkwTFFuZzFNUWNtTlZkVy9rdVBKdDN3VEpyUS9W?=
 =?utf-8?B?WE9EY1JBUUpkRWlrTW1ad2czc2R5YnVZcmJGdVRQOXJCanlZVHpWY3RBbXlm?=
 =?utf-8?B?OGJDRHp5ZzZQMFVxc1hpdStlVDBaa0Mxam1SQ3lrMHlRR2Npcm50TjMvdWlF?=
 =?utf-8?B?YnRlOWpVUDlJb0hBTmU4RzJ5S3E0N1MxVS9JalVBMWFBSkhNOFA0Y2ZWbmcw?=
 =?utf-8?B?Y1ZrY09NVjNyc3lOVk9FUXhvWll4dVloUWM3RHdvR2VLNnhhSjlEWmc3Qm9w?=
 =?utf-8?B?QlJGeHZqL0t4Zi81T2d2bDZDeTREd0dTMDVITWpwblNSWlhUclR0aUwrZGRn?=
 =?utf-8?B?c3NQSjU1UW1RVGFGUzRaN0JJdm5qQXNHakpKVXFoTnBERksxVWw5ZzZVRHlS?=
 =?utf-8?B?YlREcldPNUZScDNBdWQrdktMbDBSa0xEVGtSZ3N5cVp2YkZHOWk4dHhYU1Jo?=
 =?utf-8?B?QkRTQlFHbDVWU21NTlc3THlhdWZpMWhLVUtUTkJpbWpqWWc5dXd3TUc5ZnJC?=
 =?utf-8?B?cHlpRldNVUQyQ2paUkJqVXREYXIvWHRGY05oOGtWVzZxWlFsallFUkt0OUxm?=
 =?utf-8?B?S2dBcGtTL1FjbEFCeHI2d01BelJ1UWNoenFTTzlvc3B3WVRFRXZJdDlLR2FM?=
 =?utf-8?B?endmK0VMTVgzVWRWNGpxT3RZUWxDZXpwcEdWdHBMOFlpYllCeklNQ2R2Yytv?=
 =?utf-8?Q?GnAH9XGTnkKmUzY0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d96222-227e-4700-bfc8-08dec15b81d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:33:10.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9wG2KlIVYNzCcIH6a2dGlX2RRrs5rO4WFPU1IJAUCCLpHizjromX4EULhZfD9f9ZSvyOaoIJBM6p09qTBoFhRKRZTP4N9XxuToAa/B8vQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7750-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:eballetb@redhat.com,m:haibo.chen@oss.nxp.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D525636A7F

On 6/3/2026 1:28 PM, Enric Balletbo i Serra wrote:
> Hi Ciprian,
> 
> Sorry in advance for the noise, for some strange reason I didn't get
> or find the cover until now, so I added my tested patch in 1. Doing it
> now properly.

Hello Enric and Bough Chen,

Thank you for taking time in testing this FlexCAN series against
both functionality on S32N79-RDB and regressions on other platforms.

Best Regards,
Ciprian

> 
> On Wed, Jun 3, 2026 at 11:44 AM Bough Chen <haibo.chen@oss.nxp.com> wrote:
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


