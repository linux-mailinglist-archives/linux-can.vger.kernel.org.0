Return-Path: <linux-can+bounces-7737-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IDJ5GqjUH2poqgAAu9opvQ
	(envelope-from <linux-can+bounces-7737-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:15:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F473635130
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=R54Xj8OY;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7737-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7737-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4F3B3048207
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD239902D;
	Wed,  3 Jun 2026 07:13:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AA3955F9;
	Wed,  3 Jun 2026 07:13:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470830; cv=fail; b=iS5ODWEOzInxOynUbVCIKKuZcrS6/FTZB+twDeDXJGjQ+XxFQkocbO2j+b0xk3FLoq6eqsOWZ48fJfFEE/uBBdbhOpNldDHqBd72Eej5eHeC6eLNfZJBAwxIsy9Iy6xHJYr/VcQsfieexE+LdUqIH9uulWbsj74XQ5qOKrlBV+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470830; c=relaxed/simple;
	bh=Zm3ptvpQhDE782aiCSoVyFyVihJlbDFrV5ltrpuZJiE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u3egJ4o7Mi/Pm6k2P58wyuNwPzkKr/zjcZA/AGq4Xmm7MVK2Tl7mQPyMTqXIaaQ8uCgOSqSl8o/7bsrC0KmB/o0j5FFJZenslj4odH4WcpIwpHgYEf6wSv4kPpDbyjM8ovbBu3/XrMKNyyERKfNJKn5Zx/2nuhbb5lC8iQcurwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R54Xj8OY; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7pesPjKhahJljlvPjGJIAFS/3iORk9o8OdLOMp5WimTqEMjVvxFxnCUV2ggmeGUaodP9sQ5G9R4Jmw6NuVNHdABItZOfUTMjZY+hJHdXEeTnzbqVQ9P9va5w4VQ8MZPns0115vW+c/Rt9NdB/S1n8RTkWKx5X+KjPYA9BLBYg9m63y1MONk0MI8kOUOVkGHtfieU4xsvCPNWf3wkfX5X/c0xdy8k1EBCzGidy5l2tr/E2aPS+kfRAKk3BeWUT8DJi3S0ZHP1yW6WxOxyFnCANsQCpYYV8mv0YowhYSAxYgVuxhEdtIrTE7cNChJMU+ETi4xIICewGXnIEC52Gn67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrc9KkrT2cLU62y0xbay03DEnmjCaXnOa+oNEqr+A8Y=;
 b=VJ+dg88JrHVgxJ1L4KO67X7PvGJnqCWsie2ByLvdWF0bIWd/fjQ3+2xGc9VP+LDBri/HRIL4y3gDySdb7x7l9qU3sPpg4GqomOvGc1+kT1unFmBgWVuXHTf7jL+pE38EL815OJ/uNHuQeDJg4xUWdPOUusbQD8bbTGTUQaI+qdeO7xAf48pnwrYzq+hw0CWv7vqPXwg7pZ6EElr6Owp5XMo9VEOp2BOCR7ugttc0ps69Rl8EZwMQw4DTgBqpr56xHi9TmIIwhUik3MP0yAq2MV4PHQfIFwhA8sPO3NkmpqtgE3x/vETZr2g1ySBwDRkXGezkwQlwMbjVgBcnIHBAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrc9KkrT2cLU62y0xbay03DEnmjCaXnOa+oNEqr+A8Y=;
 b=R54Xj8OYX9Wto7jPEsRpx1g4vxWv8ow0EoBXCYC1i5rU3m/0j9M7z5wY6YonueXCJl7d3VVIfremSUY6tS2zt1OsHPD8lmOwmRmfALBVU6o1hNr2YNwpCo0dDIzzA2gR+1tsAVHUJ/K9Zk3Y0y0WXknr8kUzJT9aI4KY/cDJKTHr2fn2NNbTlLgvJ0RzgamegB4AaIdDKTOtBYTSYtz2M2+chLSpH2To5s2STNfxzkI1wVvlsUbhiCDWoanhbJwpgETWC00Ih9NDKq72rYPKemIrPpJa0BIjh9VCWlMhAX9Kc36GOHE2eNOZFfHie6nxKOODjsMP3d5Pg0SUCOiE1g==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:45 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:45 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
Date: Wed,  3 Jun 2026 09:13:34 +0200
Message-ID: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: d0324b00-3866-4965-0d5c-08dec13fa5fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 6jjSuVWSgifgZtfAgA8NX5QhdBawyFCQ5dfIOgmhDLz+VUXUA6tJUlqUzyEmJXALSk3Vrdif6Ut2gk6OFAc4auCQ1AqpEuZiEPiR0khZ3LadTv0Y248r8AksKUMPDDtrjjlIWF3kIsQoyd0OOw7X8eGMwBfx7TzokBXrWsvraYjVby8exh2iVtvvNQ14ELn1cLe6DR4ApBgEcHsfRCEkDIRWqQQVhL6IHo1YKMMWE8luCeOI3L0pL0DjzCNet5cSyAFhBus1P+nKRyNyZvN0uPOHTOyrwNf5lMad9CMD0Kg7askuNtiFoVuW5WbKt40hT04+cf2I3fdgqMgmV4k1xAUc7GqoBvclRSQOl51g7J0x71C9VTwp5HUszvnKBZnhaH+++FWJ5dTBUpnduz0+q00asjGnV9ZIW/frmVroBm5eg5zmVhw1VqycXRPYKLls0WSgtAelzKh3jPAqVfqi1Yk4syOe24E2AExdPYM00/xxv+ZZn6T2vDWu7yNHGoT+Y4DHSPQs4HjDXJn93T0aMoAO2n5AZ8XH009+3EvZubh1oW9Gr7OSyQP25pn12psu9p6F6ITBt0LcXoMJtyohRUme27h1YsBoFHP+cWwyIXi4GHlDKiXv6KGpmMwxgD24JPNPIpsQOOJ4M7iAOhI8XtJs463rn29f4rIVJVmiFLFaEmo5GUd9u9vW4dKx1cOV
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OVZvRDlJOXhQR1BoeHZWc0ROZnpkd0RmZ1BUaWM5aGlkZWRYRkdiTkY1a0Zx?=
 =?utf-8?B?RXFLeHRwblVsRVNRQnhaQjRJSnBGekw3RUQ3TXJqVDlkMkFhYVFPT2pld0Q0?=
 =?utf-8?B?aVAxNnRGZ2NsVzBsa3ZRSW9tempTYkRiZlVSbmxSL0dmZG5saFNOT3NnaXVB?=
 =?utf-8?B?NzhDNTd3bDMxeFBTcjN2OS9IZEMxV3Q2R3lEU2tSQzc3QWpRZ0ZvMks1b2xU?=
 =?utf-8?B?L204ZUhQMW9OM0ZmcnZjTTByd0tMR01IYkxaWGdSd0JOQTdWc0NOeGIrbysy?=
 =?utf-8?B?N2RyeUExUENFOVlrNDhuSVBvS0pSN0ZCb1FxRkVIa0FTMk9pMzhUeW9kMnZQ?=
 =?utf-8?B?cGRYanBzUmxVQ3p2T0l1QXNBRzl4dmpqYk02R2JGVXNyRGo5VmRRcWIvODBN?=
 =?utf-8?B?MjcyUWU5MndocHpXcDZmNE5mekM5eUVIamkvWWNGQ1ZNTTY1Um16N0VDeFd5?=
 =?utf-8?B?bmJCbzJIRlNCU3laZjFwWW9JMnQzYVpNWENEaG5xRk9LNlZYVld1SEJGaGlt?=
 =?utf-8?B?ZlR6anFKRktJWWxGMjE0WFduZG8vTjBiTERrL3RZOHZQTkpBL1lpZTd5QkpZ?=
 =?utf-8?B?M0xQRWwrNkFBY3FKeENKKzJMNkZJQ2xqNUlXeHpCZU45R0Y3TkRWZnQ4TEQy?=
 =?utf-8?B?TlJTT0kwcVI0YnVjVkt1dGVSejcyb1lsak1odHZuMHdMbm0yUDB5VDk1UUVJ?=
 =?utf-8?B?L1NhRVZobmNjU2luVGlYeEcyWjIrbUZKMS9tY0FLY1g1eXU2TlFVdk4rSW04?=
 =?utf-8?B?NllPcTdDaGRNN0UxOWhFMmViaVNUMTdlZmZOVnNrMGRjRGlzREUwUHN2R1Bj?=
 =?utf-8?B?SEthbkFvWllrQis5aFpWWEN0M1ZlRUNsY0NHZXNoQ2dvTUFhRFFNaUZhbnB0?=
 =?utf-8?B?Q29TVmRWTjFDTnFwdlBCTUxJaG9jTndmR1AvS0gvVm9jMzhiRitTd2VVOE1i?=
 =?utf-8?B?Wm1zM09iLzRVNVNjemRQUng4RWYrZUMrTkF0SFkyUWRCakJ2dkdCN1A3ZGZm?=
 =?utf-8?B?cStxSWRZemlOd24rb0ZqdURpYTlCOFk5RkVaQXM2YkdqS3NZWDRJczhUYlQx?=
 =?utf-8?B?cW9nUHBab04yczRTa05sbk1aRjZhdVZ4azlNTURUM3dpOUJnemZta24yRjA5?=
 =?utf-8?B?b2ppZFpDdlFLMXV6ak8wUTd4TW52MVFwaE51UlEva3pjNncyUXRwMVR2Qm82?=
 =?utf-8?B?TEZSZzdHbEk1UDh3MW1uRTdmNWo0RG9QeFBEQklDSnpmY3pPMEZSZk1pTjJ2?=
 =?utf-8?B?RlRSVUFhbE5aZG9ybEJJY1FPRzBkVWJZL3Z5TVF6Y1k1Vm9FOERHYXRFazdO?=
 =?utf-8?B?RjBGMVZzR2NwNGxiTHJmQzN1Y0Y2SWgyeWVZQ0I5RW9mcmsxeXgvZ3R3andk?=
 =?utf-8?B?WXhjNlZ5dDFxRW9JcExWR21jNENtMjNYNEljM21UNS9ZOWtyT3RjYW0rZnl6?=
 =?utf-8?B?ZWdCb3Y3WDVGN3JwMDloYjRIbm8wZHdONFFqeXN0TzBVeWw1OFJtQXFSamdj?=
 =?utf-8?B?TXJQYXdZYWJzNG1uNU5qMm0rZjdUekhkV1dMUUhIZjlsVklzc0gzeGo3Uy82?=
 =?utf-8?B?TlNwUEFaVGVZNHRqNWNHOUZiRXdJUzYxOTVOaTdTMVZzdEJRU3VYdGlzK0ZX?=
 =?utf-8?B?WjlGekxienpoQ25aNUtnVHU1NWNreTRvODcxVVc4QXpmUk0yL1RCMjdEcUYw?=
 =?utf-8?B?MTdiRW8xRFB0UGhjUFVFNVBEVndvZlJhWTM5VE1CUUpWTWlnY2FYN081dkdo?=
 =?utf-8?B?OVNHS3hrbGV4WTllbHVpWGJmUjRHUUp3ajdxUDBMQmtYUWRNNWhEQWlQSkZz?=
 =?utf-8?B?SjMvc2ZJZm1KZXVGMVF2MHVtRkV3ejEvVWhzQ3dSa1JXMmxqSHMzVndhOVh5?=
 =?utf-8?B?RzhGZElSNGVWN2hSMHpab1U2VFRJT2MzNmY4NUJtTjRGQVVuQ05tWC9GaXhx?=
 =?utf-8?B?bFd4Ky9HZTNSK3dlODJ2dUFFdmMvWVJUSlFkRXl1WGRBUEFHb0F0Sy93Y2w2?=
 =?utf-8?B?bm9CVWdvTDRRalAwWHdQVm0vak9pZjg2Q2x4bUo0TTdVdi9nMlozNG05VEx3?=
 =?utf-8?B?Rk9aSmJSeWwrcGUvMUx2NGdibkFtYUxENTBhTlpwVzlMYVZHOEpkQko5S0Fa?=
 =?utf-8?B?aVB3Q0lVWXp4Nk5tQy9PV1RRN0lZWGNiSmJkZ2xKWmdNam5Ha3pWaW1WdUNL?=
 =?utf-8?B?ZEN5SkQzRUcrd0ZwMmpOVVZQUTBWRFg0bHdxN1RwMHdPRGdZbzdDcE8wc2hw?=
 =?utf-8?B?VmRBZjg0MEFaNWFpYnV6R1p1V1EvYmRPZlY2Wm45Q21qTGliTTIvNGVNWTcv?=
 =?utf-8?B?UTdaWGZhalE3Q2s5d21kai9LOFJDaEQ4c05CVEwyWUl5cjFtSUh1Z1N1T3B2?=
 =?utf-8?Q?3xAa2y/qoq6xhA+c=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0324b00-3866-4965-0d5c-08dec13fa5fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:44.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOhSFephKOzuvLh00XKTSeRgAzUlFVbheTpHxZnmTENs93YAewv0KZBaA9f85wfyi2HqfMrnboBsLG/upUVtmVVj7CL8jclf1OiI5su/Wu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7737-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F473635130

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patch series adds FlexCAN support for the NXP S32N79 SoC.

The S32N79 is an automotive-grade processor from NXP with multiple
FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
other SoCs in the interrupt routing - it uses two separate interrupt
lines:
  - one interrupt for mailboxes 0-127
  - one interrupt for bus error detection and device state changes

The CAN controllers are connected through an irqsteer interrupt
controller in the RCU (Resource Control Unit) domain.

This series:
  1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
  2. Adds dt-bindings documentation for S32N79 FlexCAN
  3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
     configuration
  4. Adds S32N79 device data and compatible string to the driver
  5. Adds FlexCAN device tree nodes for S32N79 SoC
  6. Enables FlexCAN devices on the S32N79-RDB board

Tested on S32N79-RDB board with CAN and CAN FD communication.

This is a resend of v4 with no changes.

v4 -> v3
- flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
  (not just dev->irq) during IMASK register writes
- Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
  each handler on S32G2 only processes its own MB range
- Added received Acked-by tag on DT bindings patch

v3 -> v2
- Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
  flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
  processing when multiple IRQ lines run concurrently (new patch).
- Added flexcan_irq_esr() handler composing state + berr for S32N79
- Ordered quirks used by s32n devtype data by value.

v2 -> v1
- Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
describe the actual hardware feature
- Appended new quirk at the end
- Switched from platform_get_irq to platform_get_irq_byname usage
- Updated interrupt description in dt-bindings

Ciprian Marian Costea (8):
  can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
  can: flexcan: disable all IRQ lines in
    flexcan_chip_interrupts_enable()
  can: flexcan: split rx/tx masks per mailbox IRQ line
  dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
  can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
  can: flexcan: add NXP S32N79 SoC support
  arm64: dts: s32n79: add FlexCAN nodes
  arm64: dts: s32n79: enable FlexCAN devices

 .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
 drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
 drivers/net/can/flexcan/flexcan.h             |  12 +-
 5 files changed, 316 insertions(+), 37 deletions(-)

-- 
2.43.0


