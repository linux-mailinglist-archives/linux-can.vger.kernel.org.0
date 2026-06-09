Return-Path: <linux-can+bounces-7779-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWk2KSwlKGog/AIAu9opvQ
	(envelope-from <linux-can+bounces-7779-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:37:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403AF661344
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:37:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=E1QegzRK;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7779-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7779-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BEFA304A03C
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEE342173;
	Tue,  9 Jun 2026 14:30:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B99345CCA;
	Tue,  9 Jun 2026 14:30:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015410; cv=fail; b=SnU2xi40wa5Y3Erb/xkcRseTQucPX5O7FGL8v1ii7ePRJI862Q/VX9JyCrWj2lLgu7WWSCn71VySZ0lIGyAswOfdyPC68nSBaCCPxaqXCZxLtOAk7+sOQO3KwXGnW1iCKYt/utnOLkOK10Pz//BH7TOl8BL2mgMSp28pq/TWz5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015410; c=relaxed/simple;
	bh=7eKYA49tbx+/BIXFqZlln8IoXN48q9SkYGfKr1mUY5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVlKOW1XWEfPCq6z7Ysm+srsXeFCdMD7gvL50QMtxYEl8a0MIHDtB5W0GOoNtf1pkkaRV4ziIyuDnpfwOoLVDSYfmcnaa4irFi+1Ep0BjMrcDia0hRJYgH3uAav5GDQDtTCImCDU9wiceOm+2UWQWYY/jbEYBzIe8l/iAW3nn7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E1QegzRK; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo4QlWQonPcJ9UijSfUmOz7SFyRTznNg8IsscXpTH/XMgmODsMuQ2Dae3HXjHjvK30rlJ7qq5W8bcxxs7jyHUY1k56nsrWnCovp346GZXBFPAHZDQDnojrBSg6Rfnllo+Y0af7dBQp7yVgT6dpgRRuM0KIHGPbC8ilM1doWlIZgbzdtad6ar1F/j+aGmEwwhcAT8nBJOdDo7ElcVFkHUUTCwCKnWNg+NBnC1aueznn+vC5UV9hSfviScnAaTTqlpGxSvfxZljhZey76L8D+ujcMNdxsK2YZa/qPlnH2SQ2rbWvnmpjqNRf1Fkg7wQaa+XUqTex7KZmr/S3AToUSHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vN9VnTNJVtY1c5Yj09rWYJO/BcFlEGABjeIjd2gzv8=;
 b=IV/uv33OXpmE0XE1UuwvIVs4n4homEQYYqdVdXW3Kd9sTys23Ox3Y7y97ZrxRkteNHNxTUqc8u5+JKutfAxkwZpi63snxGP64zoIf/CPmkbdlH+MVX0PM3DDbY1z7SDX/GRElg/YHVICvuNk26pH0R17EzPjyyOStU2N5gd4Hqdy/zGRlFpW2yXYOxUZ4bq8bknXXkNJUvTKEHN9nzqfBzRfioET722zXxrtyV3u/Li1egmS91jNm1wScUEhFbyfn/35u+V0gVIQBZRSViTUOK6eLSvpI0HB/e1ILwQP0O3qyKYOiCqPSDmtj823Q8c3/YI2MKrQH7UdQUAt27Pb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vN9VnTNJVtY1c5Yj09rWYJO/BcFlEGABjeIjd2gzv8=;
 b=E1QegzRK31xFUZuL+sJgrN24NDnHKcCHrvZ0fHn5mSLkrQ4GEOqgLElnaCNW6kUUT9OeZZbAQA5Yb1Rg++qbofKuckCMs8DCPdg4JkASFALWDnKw3Nk7qeBNtB+97cvNePACz5miWKR+U0p9BRpMdTl4zFTQJ69CKNn6jydSkIONqVueElLW/Z8//9/FxFL1Zu4EY7dyPkiy2SXi0sbbDTpZbIvpk0O38EUQmWz0cimlER8VWa5fhMg/HDA63pTXfWXAAVtLa1QJO3smPhFryA/e6p8nqcKfuN75H3CNRS2/ajvVn0F470LBU+8QHB2yGeM6wJ0Cc1o88EETfzA3uw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:02 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:02 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 3/8] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Tue,  9 Jun 2026 16:29:49 +0200
Message-ID: <20260609142954.1807421-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c3a93c-9cfd-47bd-2483-08dec633975f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 GIQ6mcsOlFsYCCUj2C3ra2wTx+WY2Uvk9Yl3VteZ3iomw4mpEg4HebeO6ggiiqr4ZwpCJWLzJ7xGpuglLgdhXpuGdou1/A3ft+WueFzgUseZkdcrzlD7TsWXEszq+/YzJBSh/WmcaPzQ3G9MtPHucnKBhytBOenAcCdqnoIivziEQNBIVqu9oKvSpTLFQn+0gQMUwdNn9O6uGyTnFfyN3uRx0AY7DS1zOh7ZnBhuOtmqt9SKa/apJ4VZdyrLNBXIeWqpKsTxa4qcCZIZ0AHKsS67Sd+pzpVrXWv5IIT62hvCg8vub7aNorYkg/a+eFkrQ/H/UR7yPydUJeQ+xrt+LWhVdtJh0gqJOwrKRT9waReaNMQ0bypCExjQybWpHnNOpxo95nFbb69g6j5Gbf6m5noKsUs97ozTAAWlrZioO5sfCh6xlTdaT1LzIl3hANg1rakQGZpWcy97ski67LXXExeswpBOHCgEpKh891woxhJ4RfwL3M6mZeZFTyBAAl5wFjdyKwud4PV8vYybXpyLyx/zKDIu8ocn8b2MSQ+zxZNKSvroINF7yx3RVL9dKqzvh+uEIWgtKWoiE4/sdrQ660S/Rl7sG+OK1DjRg2glelbd/GaeDMNhlKwuvzoYwX0sJNzM0TCXWJI0T85nUKMClmjhAwAee/cpxNcqCVLHXVnzz476EOKe9vRHEowpRa6+
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a1FZY0FVWGd4aFI5cGNzQ3c2SXRFcnBWUVU2dTJOMTkxWWRqTmNKTFgvWXJ4?=
 =?utf-8?B?alNEdXpVbUhPUVZzNW90MGR6amdNMGx6WlhpNHArbjFQM3BnVWxJbmxKdy95?=
 =?utf-8?B?VCtYWlFUWjNHTFZGRWxPczBuV1NvWHZ0Nm94QW9USnBLWG5mZldMSFlZSWYv?=
 =?utf-8?B?aXl0SzdjVXZaRnYyZEQxM0FoVXZIZlpvb0l5T0JSS0JxNjdxM0dZc0E3OXJN?=
 =?utf-8?B?SWlXaFp4bWYwN21xcnRCUDdTTFVaRXdMRUtxbis2cDJaL0VzTDExUFVUMmty?=
 =?utf-8?B?UDB2Yjc3RXdVbm1tQjdUcWd6UFRya1FqK2ZkbFYzNU5MWXRwR0dWelFGRWpz?=
 =?utf-8?B?cjF5QVRRY3pzQnM2cy9MT2N1dVJWUHUrSk5SbitOeU1qdWNGM0s4VXVtNytv?=
 =?utf-8?B?emVpSWIxMEtXVE9mRGVOdXRhbU5hT2JMSCtKQU9iakdyWXdKT2s1UjlYT1Q1?=
 =?utf-8?B?eGpkQW9hQTMyYWJYUWVNK21OZmhTS0pVRkFhVVlveGRmMk1rUTRDcEtMWDlu?=
 =?utf-8?B?WmRmdmt6UE1uR1dkdnFvMWxUT21WMGdJckVCUDd6L3hjbFJNWktuaW9nNWx2?=
 =?utf-8?B?MTVnUjF3SkQwSXdvZ3VrQmIxalkzbHNZSTczdHRWMzNtODJCS1lpbnl6WWVq?=
 =?utf-8?B?RTUxdTlTSXJFV1R1MysvZWxNb0NFZ0JDbjRMUWZhbXRwWkY3Q2hyT1VvbndE?=
 =?utf-8?B?YUpRaGplN0EvZXV1U2UrZWVTeERnL0V6dkV2RUc5VnpUV0tiV0JTTXl4OEFl?=
 =?utf-8?B?ZGRlaTcyQ1hwL3VHTG9pYzdtN1JRdmxhSUdBUGF4Y09SckZLNmVCOTZTSXov?=
 =?utf-8?B?MTd5NGRRc2NFakl6TXA4OXZOZU5kS3lhWFNSUmE1bmJXYzdGMWJvd0M4Z1hJ?=
 =?utf-8?B?L0VQcVRTZE1SWWlKTnBYSkFPOWd2L2I4TVlPQ0NHekxvMHNVM1poQllnWW5R?=
 =?utf-8?B?RERCV0lueUR4dEpZS3BONzZPYUZXNHM4emNTRlVtYlphWCtNTFNjVjU5TEk3?=
 =?utf-8?B?bVV1UGlOcjBqdkovLzYya3pvWTVCQWtwTGx0SDdvSGE1QkJiaGdvaTFreXhQ?=
 =?utf-8?B?cGhkZFJyQU9tdjV1ZnhSMXV6cFZaM1Q5VmdURGFUMzJjTTJ2YW5mUkpnbGNV?=
 =?utf-8?B?L3A5WlNScWhGQVBHNlNTVERKcXd2Z0ladkluWXo3N3pPWHZ2ZGhpTEZlVEZJ?=
 =?utf-8?B?eXZwSGRXZW85MWJNcUl6WGxFOWNGVlVGdXhyWUl3VW1ZRnhOZU5zb3hyUmlk?=
 =?utf-8?B?RWF4eEdTVTRzaE96bHI2d2M5aGZrdFhRT2Qrdks3V3c4bjluU09rSHRjYnpn?=
 =?utf-8?B?R2hDbkJBb2wwN2VrUzVHNzVCZlZVR2NuQVR6anBmR2MzMGZnc1dnMlljL3Na?=
 =?utf-8?B?M1lIYjJDd0plK3BxMVQ5anFqNnpOTjYwcG1PT0hxWjVlakUxeEdZMjFtMDc5?=
 =?utf-8?B?M2Z2QkMvMVNNUGRiQ0ZWZU5hM2txK2hvVXlTTHR6Ly9aQVc2ZnFEZUFVQmc3?=
 =?utf-8?B?WnpWMStVVkxTRzQ0Ymo1TnRxQnFYcTlBK3o3Wk1vQ3RpQW9yK3VNZnhOcXlz?=
 =?utf-8?B?RnJxY1ZrejFob3hwUjhSMExiQ2NmSElISDJDWVR5S0ZSN2J4UjVPaGFpblZj?=
 =?utf-8?B?RE5PaEdtRVQ3UUhldFJka0hWeEdjd3RycjhJeDRPZkVlaHY5bnVTRFYxM1I4?=
 =?utf-8?B?MTZ6V2RrWG01aEQyTHFYRzFRL2NJVWNrUzdmbGwwejBjZGp0dkpRYitCa2Y1?=
 =?utf-8?B?MjZkTUhuRk1TT1BTc1JuYjhWZWl4c0grK1hVeDlmM1A1UVJ2eVdQMklZS2RH?=
 =?utf-8?B?QkJoaDNHbi9NMjdmdjk2KzV6TXAzNlpnck1LRWkwaHY3R1BNSkluakVRZFlQ?=
 =?utf-8?B?eFZQWTYyY3NOSFFsSjdSZ1JSN1NLbDBGc3lONlV2by9BMnNNS2hMazltUk1r?=
 =?utf-8?B?R1ZlYVlZSFk5aEV2ZnR6Y1Nkdmh1SU9NZit3enV6Rnp5MThkbjV2THM5U0VI?=
 =?utf-8?B?dTBnR3Fkbjh3NUg1SllUeCtzQ0l5cHhTNUROZ3llcGsreWNsdnMzZkNFY0g5?=
 =?utf-8?B?VWQrcmgzVStHUHlnamkxUGZScUhKSXJxRE9WM2RHRmV4ZWdEdmJSVnhLeVNE?=
 =?utf-8?B?UjhNK2JETzYxMXoxdXhLT3BRMHRRQnJvbWQ3ai9pVlI2c2JlL2lBMnA1eGJ1?=
 =?utf-8?B?RllyQTRxc3BGa3gwSnpHMFRlR3JIU0hRNkNJUVBzeFFKeDU3UVQrYmk1SU52?=
 =?utf-8?B?TGhOSFkya05lNlhFbW5paHhXRG83ZDdxWUwvRDJoT0lwdzVNOWZkQ29EVTN4?=
 =?utf-8?B?WDV2ZXlySFBEOVRDd0MyQ1hTSzc5OSs0ejQ1ZEZSVVFhdWNoY2pNd1ZpRUVP?=
 =?utf-8?Q?Ve4xkeSEMydL+NaM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c3a93c-9cfd-47bd-2483-08dec633975f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:01.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvdP++TPtR+9dHKL8uTilFngFW9IPyPKqJr2S4lrsfCYtHptUjLPnr2ntzFsj1pqXtMzNiOnxhUKhgVQa/Z5+2UCarWX6kFtyWWgzAjBRvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7779-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 403AF661344

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-63), both handlers currently process the full rx_mask/tx_mask
range.

Introduce FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK and
FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK to describe the split, and pass
the selected mask to flexcan_do_mb() via a new mb_mask parameter.

In flexcan_irq_mb(), the irq argument selects the correct mask: the
primary MB IRQ uses MB0_MASK and the secondary uses MB1_MASK.

For single-IRQ platforms, mb_mask is ~0ULL with no functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 39 ++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..0ed838f0719a 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -182,6 +182,12 @@
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
 
+/* On platforms with FLEXCAN_QUIRK_SECONDARY_MB_IRQ, the MB IRQ lines are
+ * split.
+ */
+#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK	GENMASK_ULL(7, 0)
+#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK	GENMASK_ULL(63, 8)
+
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
@@ -957,14 +963,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,12 +1079,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev, u64 mb_mask)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
+	u64 rx_mask = priv->rx_mask & mb_mask;
+	u64 tx_mask = priv->tx_mask & mb_mask;
 	u64 reg_iflag_tx;
 
 	/* reception interrupt */
@@ -1084,7 +1094,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1121,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1136,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1239,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, ~0ULL);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
+	u64 mb_mask = ~0ULL;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		mb_mask = (irq == priv->irq_secondary_mb) ?
+			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
+			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, mb_mask);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
-- 
2.43.0


