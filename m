Return-Path: <linux-can+bounces-7905-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oGl1Biy4PmrYKgkAu9opvQ
	(envelope-from <linux-can+bounces-7905-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 19:34:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BFF6CF6DE
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 19:34:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=NikBwIwg;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7905-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7905-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED387300DEF7
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646A3E2AD3;
	Fri, 26 Jun 2026 17:34:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3B30B535;
	Fri, 26 Jun 2026 17:34:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495272; cv=fail; b=SgadcZ+VM5bZ2Pf2fKs2iagk1k5joJbSr8yP9ycCJf94W87tjy3btFm+k3F/Szugqo7DLW8TPDD2eqlFMH+gYLzj/3tW6NiMYnwnWMb8MFE2qw72DydYl0rfMUzviWT3G6jUlbfAkXo/Um5YFUqI3I2UvQRac+L4SSnE3LnPOk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495272; c=relaxed/simple;
	bh=EntOof8aF2c9f4V9vYdXsGL7L6bBXw/e2i6rEPFAEzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQs3izwx2M8Xw9w5vmx+OAkZjm/UtkJGyW5PJ4M9a9ui7+SC2uUwy3eMky5vB6romokG+A/wtTualzc1sI7UsBGxmA5mDxlUDRztjNMVygFS6T/S6mfe1UlRsOiyEHHnr8JNxP5e2KiAM19dyCj/+w4yigabvFA+EGQ5iqTc6Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NikBwIwg; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w16/J2zDNN0yw/Th8qOfnR1j6njzI4LpwS22j6oRx9EJC4TqV0msE5mOQbpyiotCvydpI8GZ9r6MJ34/BOFo9EZ0vqv9JQQIGmoUp/HsnYuRIpvjc6Yz3nSTTZsWALnmpdwYkanw+ke8WC0uw/GvrblXyz8BlvlqLU6q4bV2mziLEVJa5Lui2yj87E4yk6pAgzrj99IhqZpuc4VrtYTn0UKMFUpMHDgZ0+OCzIWHOnq7TQja+EpblEwZYbKfUvLI4BcZf8PXIS4WcLaNiPzDUmwpPSSwxrau1UUD2OfoijFhyX8LyYj3+FJEiTrlG14aLBmTmuUfSYZVZo0ErB0Fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umwU6+OlXyre6F8JjF5d/ANAKiD5+8ZJUz3r839+AQY=;
 b=DNN87GfUmVKc516QJx1hssZlXW7NKa6Ep9Zc2DjQqCvQ0gcx80xu2V4dx4b5voOhqY0vSTZESq6AToH/oOCszLbo+CaB9cFQeAaALCLqyxHIGlxnQ+NKlYJrESTdq9uW31Rbeygoz22TV0e5dSidiFOS1tS7ha0/qTAl3Q77HxflCXyAtL5yCjvJjnqUYqVazLknaHUNK3a3DvidjQkGyi5iC7hwVf7wTqTVKOmCF6OZAGzdpgA+UCh+47rLYRzNQPzuqV5h0IN0tqlGmg2QQT7gtLu6D4YYA+huTFxgAnBaUYC7+uxWmYEVXtmqjUyq/mr6tlQC8SkGf7c5e+++dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umwU6+OlXyre6F8JjF5d/ANAKiD5+8ZJUz3r839+AQY=;
 b=NikBwIwgULuYj+71nMmncJqZ2lonGZyBwXvT08lR3SXFpmncjRH7fqcWiGQPUxcHsbKwLUwVxM8rQS9JLugmWncLzchVNsUHn2To3WBgwlEx8NShwlIS/9IHmf+ekCCSJaHDuylzGKan5Ap9KZnxZfrVVabq3rTGbB1Bsh6sJ/WdwDscipLVaxOOwiOFYYb2TjJXkI/aIR8td+wE1OL5LwLKSgw49rW8pvkAPiPCAnsIYnUtWcfZdoKhR1sqfs8jcpiE0rzA2e+Qd5qXIGasNHJxyWr191W5dKFtHB0HfDVeXDQO6nb0DEFqNuflztpjb/lACdzhpTokdJJga74Cbg==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 17:34:27 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0139.018; Fri, 26 Jun 2026
 17:34:27 +0000
Message-ID: <c1b47453-694e-4bde-a9a9-c7498d8df8ff@oss.nxp.com>
Date: Fri, 26 Jun 2026 20:34:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 27dcf9f6-ed23-4bac-8b8d-08ded3a92a75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 7TYr7ypQGRSQriwTZWtC/0UHnkL0lch3CweDpCuUnqW0jSDDgz44MOCx9mjbE33A50IH/I6qkqMEMeuzehlVcv2iroarbJuTAPMmE85J6B5w/4yUznayMq+K3735ySt4joUOaPE1/YkDzrfUCc/gI5ZG2AjsOWIuVSqyQWk34hux2mbTqY1G+/sxIuxyjBKF5ibS/O4fiz5i9GFcr0ssWAw7xXPcHRqfJodHSBdmp3HepxXmfXH8QS0loVQHctLR0vvWSbOh1w7yt6YBPhjP60bcLo0095FDCTZcz6Tkne/zxGrnxDvX3SQipanExSCYVR8L6Zr4sCQoixiep7llraLiCSLSUvintBb9OZAwcXWc/pcYe7hhMdp/n7LlewJ3k08DMg4y1stYWO8sioAbWAa90lA1dKHkHgVkUMccupFTx5Mhlat9PHatTQh/Puu2E2fgioWlkZOjWeWLu8xHbKXIk/hcThvjSbhxsPGa0IBhzsdLPeE7OW6SMLYDOxYOVmwGEyg0RxiyulJbAjpffJGlf5bBkvNOThZuiGhBHYllFzMeY5o62H1XiUJbRSZZh3by4FpudrQOJ1P5BLGXO8w57JiDnUnEp8IfhIJC5FS9gihC715MR1p9PseWEhXWtMVkuYhw88plKz9Lk/zDvI27Oz4Ko8Ailk9IzK5Wl1g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OXJWUWlYc1psaVNzTE5zTnFOQ3VpSlM0V2x6K3h4WVQ3aWVLTlFaUU5HZTFj?=
 =?utf-8?B?LzU0OUFCOFdpc3k4MkRnV3IrNXRhS3QvcDRtTWdJZ09VZURtcTV4M1Rydi91?=
 =?utf-8?B?eDFIQXUxVEN6VzM5Y3hkOHc1QUJvdmZZL0R1cG1jUk50bktkNjZoUXdWZUpG?=
 =?utf-8?B?YmZibEExV2hiSlc0YUpnLzBHbzZFUm5WM1J3WHFWaXczMTd3d0djcWFGV1BH?=
 =?utf-8?B?TE14WE05Z2ZyZCtIbS92WTJOWDBRY01iZnlOcEV6eS9IVXVFSnRVVlk0UEI3?=
 =?utf-8?B?ZGdnbE5NMG1yczhJVjNIY1ZXaWtFLzRnM0FjTnEweURBT1lvV05rOGtkSlIx?=
 =?utf-8?B?R3hHRkxwWjFzZWticVE4TkZqZVlJVzFwNC94YmtGS0hCZTB1WGkySmlKYXE5?=
 =?utf-8?B?ZC9HSm9QSk1IdVdiRk5ISElXVVp1c0RoU2RWdWtmNDdrZzFlK2gzbW1DVnB2?=
 =?utf-8?B?N2xuZmk4Z0NmU0xpQmlkVjU0RlY0ekFwL21KeVJManFqWGoxQzBVK0dqTzFB?=
 =?utf-8?B?WG5Za1NKVG0ya2piUkhvMXAyYnNTVjBMVlZQTjgrbjhMOGhoSzY2MVlMR0Vy?=
 =?utf-8?B?cis1blBXQ2FIR3ZaeWJCYnRJNHJZZE9yL2ZScHF0UHJid3Fmb0JDQUg0cHB6?=
 =?utf-8?B?Vmg3U1VmbWFFUytiN0dYZ1FHZFAzOFFwNE9FZG5DTGFzOTdZSFdObVJYdjh1?=
 =?utf-8?B?UkVKZDJHMjYwbktkWlhMOVlrKzlBZkQvS0hxQTdQSGdTYS9uL0lyaDVYanpO?=
 =?utf-8?B?VlhmQnh2NWJ1aTVyMFZhWlFLUHZvSVArc3pQQktvMWNCNDJRZXZpUVQvc3cy?=
 =?utf-8?B?dkJrcVVkMFVrTHk4SXZhZDJTdDE3U29iUGlFTDJLSWhZVTJ6djQ1SlgxVnpZ?=
 =?utf-8?B?eGRLbjRPM3crWklVYmJId1l4djZMa0x3TWRYc1A3VWNDVWEvY2hMWDIvNG5l?=
 =?utf-8?B?MjZadDVGVGZUcTFOZ1NOOHdSWDBVWVIvWGtRK1VHekV4VCs4N054V2VWR2Rx?=
 =?utf-8?B?enFpQVJSOUN5Yno1WEZOYUhtdTFadVR5ajhta2twby94djZmKzRxUGdoRmdr?=
 =?utf-8?B?azAyck9ybFBYejVsVWp2bW9vdmNuOVNxaXhqbk1tTUt4dHJWKzV5eFZLa1Ay?=
 =?utf-8?B?WVRYQ3NzY1JHcjdrdXAyczNpZHpDRTNWbS9lVEJic3lGT2dHeGJ5VmFYYnNM?=
 =?utf-8?B?UFlMU1NsSkxZa2RiMnA1VVlObTA3Umljc0tYYks0R3o0R3lGMnQxUkRLQTVa?=
 =?utf-8?B?L0xHQ2p0Nmh2aS9yTy9EK0pEbDZWMjhaMzU1OWVMT3VrMW5OTVJrY0hWMnZR?=
 =?utf-8?B?SjBQbzFzd0pnSzBIeDhoZFBoSHo2MGY4Mk5HVDArM2l6U24zWDg3KzhPdjJx?=
 =?utf-8?B?UDYrWWllcmNQbUhlbVZsc3YvNmxnZVV1MnMvL3FvcjFsb0ZjNW4zV1BBaXdY?=
 =?utf-8?B?Vkp0ZzEzNXN6UUtlM0ZsVHlLNC9NZktwWTlOcCs4b1pPaFBFR2lkRFlRblN4?=
 =?utf-8?B?eTBuYVgyV2hDTVZJNVY2M3poMkptQVVIa3NRKzdTR0d6R21vOEhWMS93OE11?=
 =?utf-8?B?bW5rWm5HaHFqb2ZvWkVQclI4VEdvMG1oMlBYYU9FMzAwcGRPeGFwd09LU0pV?=
 =?utf-8?B?bit5WWI4STNPSXc1cXU5YUN3OVR3Um0zdHBoUXlucGV0SVhMMkhQdFJrU3Zk?=
 =?utf-8?B?VlNqSENBNGFmQnJFWWZMT3o0N0U0Y2I1L3BLWjZJSmZPS0FtMlIyaFU0bHQv?=
 =?utf-8?B?Y0YzTnl1TXpML0d6dWlub2RIZkpYdzN1VTZIUTV1SFhrdlVKSHNBVXozVWU3?=
 =?utf-8?B?ZVk3a2tqemg1azJsSXE4SEtSNGJZWERGN0dZMDhLSWdON1ZWN0xkRXlPdXVu?=
 =?utf-8?B?YjlDb3I0RG8rUVJKR0Q1UHVBb0tYcGVNWnR2dkU3VjNxZ2tQbDdlNWltWVlH?=
 =?utf-8?B?aXp6RGZwb1ppVVJxWC9VU0VKbmlpUUFZdktyMURRUFpPUmRYT2cxMi9GTW9s?=
 =?utf-8?B?dU1keFNJTFZvQ0FoaHBaTWdSSG8ra2oxTVd6amNYd2NUQWRnS2pXeWhTWElY?=
 =?utf-8?B?aVZqZytiQU5zcGNFcm9xMDBWL3h3NyswZFlWVGFCNFpOeWJyTWhiOThYUlZT?=
 =?utf-8?B?dUN4c0V1b2tvUUpLWmpQSWtXaFpoRlVUcWFsSmM1N1lha2ZudVpVUUd6SWFK?=
 =?utf-8?B?d1Y0MElxT29MSFdUYlZzRzV0NDJEd1kxa1hhWThWSGdYZTlYZ2NnbWRyM1Q5?=
 =?utf-8?B?TE0rQzVGUjVyQmdpQlVxS280M0xMVWNHUWg0RVllT0pEOXRTOVY1MkhqNXg4?=
 =?utf-8?B?dHhDL05hRzk2S0I3RDdGQXNhR2J0a2JvTDAyZDM3MkNTZGNkTmNuY3U2SU9v?=
 =?utf-8?Q?cptgzwsMwOG4zWZo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dcf9f6-ed23-4bac-8b8d-08ded3a92a75
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:34:27.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Es7iFtVsC7dCSuPECA4OLmERq6oPCmMb9FgrOPiaU2kFbJOmIUq733gxzzY7Gh20qIi+MGwBzJEE1pX8snRxuDIJh4twwdD8+bxcvEvess=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7905-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:frank.li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:mailhol@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,lists.linux.dev,lists.infradead.org,nxp.com,redhat.com,kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5BFF6CF6DE

On 6/9/2026 5:29 PM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Hello Marc,

I just want to ping for the status of this series.
Please let me know if you expect any more changes.

Best Regards,
Ciprian

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


