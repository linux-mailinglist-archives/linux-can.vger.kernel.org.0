Return-Path: <linux-can+bounces-4704-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E821B57B42
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C23AFCB5
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3830AD14;
	Mon, 15 Sep 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IQq8BUUM"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2065.outbound.protection.outlook.com [40.107.114.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455830B514;
	Mon, 15 Sep 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939883; cv=fail; b=LnjCmTBAkofoiOHedeasgN72OHbGdC3esMj8NmMRFDBr2QFKMfa+G8fZTTaImkgMnEpmE40XoUPbKcY7B97Xq2Wzh4z4hyMrLoJh/eetsqGLPjPH9+ZeBAfVYCE9Vci9MaO77tOavF3+3MCAsUJ1+XXsKjVrRKncNecv95CgYY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939883; c=relaxed/simple;
	bh=vTk8hF/GUUAO4C3KEmAFUgLhsheEYtvz4UyLkQmnCeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR83jGqpj+dSemPdzu/3BtKrnukQrHXwrkJQ0EfFrD0u5gbBpyvEFlWzsJLrVeyMR0PgKPbUfxtQdLLVlcWvnjb2F9QYTTcjC+Dx4KsJBW1uExIkx+wU/6AbcQjQ6VREu56bgq2mlDh+SbVxkpmPv7Z1yQZwGAogfnlmMSPO8B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IQq8BUUM; arc=fail smtp.client-ip=40.107.114.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+BT+CiHX9MRQ+8mu8xKzFiZKuOOsusK/mzdok+gUkgT4+1XSRg3MjdTy7t//yw/ZoYU9qzgIZ7bPiU36ppGeQXmKwgGeppdj57blyXzBCWywr3Ags9UZA5LFnfEbv1sc57PfDFc+dOIYv+8zlNu83sgp6v/IS0iKHXJLiYEO0UaQA7Spv/9LHo/Yr+4CacDRSHBo9Fb8iZyMkBgqGg2ldSXnsZWg9Pp0N0WjqxOue+PbRZ09WtvBoShy7QriVCmpRjeowL9g02ZoVGedQeFbHYwj4LE+8Lutd+/NFoWQ4s80nUoKeXZqfWqNYFpLaP+n8Da2XJlS94T+mrRJQ0zNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTk8hF/GUUAO4C3KEmAFUgLhsheEYtvz4UyLkQmnCeA=;
 b=gHWnuXdneLYdYnPlYlL0WeINvJjIhuyvE+XSjix6ZcvMBvIAXKEPzdF3EWzJSA/9Xt896ouo7yYNZzqQVSkW4qaEc06rbup398d0Rx0OrM7STzbG1jc1bxXfZukKgPcjOtgtEnbDRzQxeoTzlS+eZON2cYWqdhpAoxi+59sghvFHN7gmuLJt/E/4smpArKKab4XKZ2jfY+CjtdhRyTLwV+HP817u5B8WFXMzNM3v6PQHWI2aDKgLiDbYYzbEAvOdsFr9cfmUYWsiPSQejO57VTldL16sge3WzYKGtttzMzlv13aMiEhaAX5qRI+SwzCDwostE3Vmv7cWNPRMWA0ctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTk8hF/GUUAO4C3KEmAFUgLhsheEYtvz4UyLkQmnCeA=;
 b=IQq8BUUM1wTDLom+IpnAd3LUJGGHikcgG+RC8UC0V8pa7ZChxR0BFcx+j+sdErMbcitMU3mxVhBxRgXAmjW4KBDpZyUJ41aciUCuzxOxl2wNdMl6xmNKQagIHSEbOCVp1ROusMU6lVt5CAlDPpGaMaQCwGHQqaP/v5EzwqEwJFw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12916.jpnprd01.prod.outlook.com (2603:1096:405:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:37:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:37:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 0/7] Add suspend/resume support
Thread-Topic: [PATCH v2 0/7] Add suspend/resume support
Thread-Index: AQHcI9KoqkaRlcbvBUqixmJwAuo1VLSUKwuAgAAH1rA=
Date: Mon, 15 Sep 2025 12:37:49 +0000
Message-ID:
 <TY3PR01MB113461FBB064E71820BBB0ECB8615A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12916:EE_
x-ms-office365-filtering-correlation-id: 1cff13c3-587a-4d3f-9b9f-08ddf454ae4b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3d2U0lHZndxYXhnb1ZmTmZ0V2xQdkk2eFYwYU4xbFBtaWp6R2NxZ2JMQkZ1?=
 =?utf-8?B?VFRjZ1hkdzZGL0lHWldiQ2RYdW9lK0xBMXVSK0ErNVVVcUhMbVpXbG5XMXRm?=
 =?utf-8?B?Z1F0dE81czREVE5CbTFacWtBeVNJbDNTb2s1cmhBSjVqaFZ0Mi9zVFRCNDJ1?=
 =?utf-8?B?blI4VzJ1NUlTekNnbGxIVmtJQTYzN2w5Y1JQK21BZkcrQzR1UUlZNkovaXJY?=
 =?utf-8?B?a3ZOQVN1MFVuRlgvQ25TaWRzZXBnVmR5b01wTHUzL1ZCS3VTL3pBd0Zvd3p0?=
 =?utf-8?B?ZnBtMXBqdkw3NFU3aW9Ba1RHQjhtUDFnMlNFcnovcEJpTm5LczRJclNxU25t?=
 =?utf-8?B?VE9oODVNZmorVmZ1M2V1KzNkY0RhT0ZiVm5QL0FyL0xlNk9kT09qaldvSHEz?=
 =?utf-8?B?cEVKQjV3OWZJUHhXR05wcmVZY1lhNDV4MHF1ODBZY01lbGxGMENJOTRlUSsr?=
 =?utf-8?B?TnZhaXVMOEpQRitVVDFTVjhmVXdKb1lIbjhQbGlocHVWUjNlVjY2Wm4wcVdq?=
 =?utf-8?B?SjFqQjdFdExrc2lkMDRHWnovRkxzcDRaN3E0bTh1dkkzU2liT282emlGbzlJ?=
 =?utf-8?B?N3k4WDAwVCtOUmQ5aUZtS3drNmlHcXpmK3ZsWU1lWkdrSE9ZaHN5RFlxYjlF?=
 =?utf-8?B?R3dmdXFod1ZnMnh4QVA4bDBRQTQzL1FjRUFxWWtmL1hnd1FjM01tVDdwQUxi?=
 =?utf-8?B?bUVMUjJjT1owRzFsdU83a1ZUQjN2V0pVOWpreDQ4YmZKY3VMb0xLb2dkLzFw?=
 =?utf-8?B?aExFMzBEQmM1S2YyWHhXM2VrbVVRcnc0TmNBUk5UMEhxd0lOalRUQmdIRUps?=
 =?utf-8?B?eWV3aFRxRkdPd3BYMTZpV1lVTGxyNVFHVFRmTHdjSVZPRjVjdGlicVliTmUv?=
 =?utf-8?B?U3NIdW1UQ01ETFgvMmVKS3ZPSENJV2hxdDNmVjcyMis1U0FIZlFIUzdJbVk1?=
 =?utf-8?B?VHRRZUtmdzZVN0FGYW5oU3crL1NtVFdVU3BCM2hkeWFEaXhYM3hKNmc5M1Nq?=
 =?utf-8?B?RWQ4M3JSNmFwZm1lTDVnbktkVjN6TVpucldEcitRdzZ4RjdwUjZQSDdBbXFO?=
 =?utf-8?B?amZRN0d6UVdlNERnTXJoMzhOWm50SGo0MVY1SVYrZFlneFlLL3ZUMG84VFoy?=
 =?utf-8?B?L2d5TmgwMDVZb2JlSnpSK29VdTRYNGRaT2RuTnhRVGsvUjR4UWJDMTFiSzFu?=
 =?utf-8?B?Ykk1bkUxakNSZTIvMkJRSnQ3VmdqZWIwcFJLSFplbmVhbFZUeHRzSFlXSmY3?=
 =?utf-8?B?UXdiN0hzMnZiZktvblk4Z3QydS9OeGhNYmF6c1JaVXIzdE05ZnJVTHhoYTlu?=
 =?utf-8?B?UFMyN1JiYzVzWWdqRmxlSUZ6ZlkzaWFoVWMxdVRNa1d6d2QwcDczVEM3UUIy?=
 =?utf-8?B?QkZXa2gxQnJPd1o4QTlmRWxDM2NKZk15VzN2b3VCS1FXUnhtRklTeDFvM1ND?=
 =?utf-8?B?Wk4zUHZmQ1JZUlBobFJXU2VLRW4zSHlPenpWWXd5b1E5STlwbksxMEJpY0xV?=
 =?utf-8?B?bHlmQ1J1bUtGblpUL1NTUUdoZS9xeStxb050L3lpd1JRSkN0aUM4Qmt1ZUxS?=
 =?utf-8?B?ZjI4WmpuZEdwZk81VEsvV2lrUU5kUE5OTU0yYkg4ZDc3enF6dk5ickszbktJ?=
 =?utf-8?B?UzlrS1VjZk1SVGpoUVpvZlNBYzcxelM0cU1JcWNBRStwWWlCL0FWYzJ0U1lv?=
 =?utf-8?B?eFFFOGlJdlFpd1VqQnNub1FsaXJiK2NXTEhPeUFKTVhKczJkRVFMb0xRYk9p?=
 =?utf-8?B?UkN0bDcvRURxRWl3eGZyYTZVN2FFd3dNR2dMazRnc1dzL2g0dlZEamcybUlo?=
 =?utf-8?B?RDlQdmJIVnBmUHBEckEvaVYvamJrbm9FUEhpdWsvSUxodzczSWRJeTVycmVs?=
 =?utf-8?B?SDBFK1Y3MFpPQ3JFMWZ4Tk1IdUUvWTBERnlWY2s3bU5XTTlwc2VJZytFMFJD?=
 =?utf-8?B?UWd6eG8raGF3QUppOXJMZGV5SzY2YVRrNWEwR0ZENHA2TVVFSVE4MlE5ZDB0?=
 =?utf-8?Q?xgCenZ3hb16ZpCrSVFMnQlT2rrw1xU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1QrUG4xeWgzSVRBQzkxZU1KQnpMOUplUnJ5d0Y2S3RHak9LQzdQQ2ZGaWxr?=
 =?utf-8?B?TFBqWjZnV1d4U0dFZlhHTThmR0xjK3l2UldmcVkyb1JBa0gzcC9IbllBa2pB?=
 =?utf-8?B?RWpPd2RsZ29PS3FvTmZPVXpoYUV0VXZiUk9tY1VTRUQ4c0s0MnhjeGZ4MHRT?=
 =?utf-8?B?Q3lsd0V6amdsL2hidDhrbm1ndURPSmxEc281eThvUTVRKzJWQXhtbzdORjZs?=
 =?utf-8?B?TS9ENGxycVNieU5RT0tqNHh3Rnl5Q1J1S01pdkxxcjF6a0lad09tU0NlQTBO?=
 =?utf-8?B?RFZmazQzVUVmbGpaZjhMcytkZE1iSzF2akdBUTVlN3BPRzMvK0IxWXN0Y3Iz?=
 =?utf-8?B?K3NEK0VTeDhkRVI5dHhZN3B4aU95YVArYVh3N0J3YWZEY01iSUZ2M3FIbW1l?=
 =?utf-8?B?cDNQYThRSW5CTVJZWlBwenJvU3hLNHZ2VUdVaC9Tc2xmYncvbEFRc1hvd2FQ?=
 =?utf-8?B?TXdXVDBNM2FtbkxQeDJ4ck9CdlVPKzVEQWRWcHQrVzRUWGtab1VoTXlpdGMv?=
 =?utf-8?B?WUhmSnFraGZMUjl2dFJyZEZwV2EzUlR1dEFJUEt4djNxVytEZzBNRHBDR0tQ?=
 =?utf-8?B?MGNrbnYxU0w0VzRVajk2T1gvaHZYTGFYOW1XOUVQamFyVDY4OHVaYWNZRGtv?=
 =?utf-8?B?RDJPOTVvZ0RTQTcwU29JNU8xZUt1bVVFcSsyQkR1RWEwY3d6UE9oZS82UG82?=
 =?utf-8?B?eWM2Wk9TVHF6OUtEcSs2VGM5bk1jY0wwOWd2QVV3Sk1PSWhzTmN0ZmlXbW5K?=
 =?utf-8?B?UWRhRkpra1Z2V3NXRmRweGZ0VUNiSk1jUHEvSnpjeTJTZ01vMVhiWjVvc3FV?=
 =?utf-8?B?N1lGMlRldW5jZmM5Yjg5cW83M0g1ZFBaUnpOUzNTbk0rQTc0UkZzNXlueFdE?=
 =?utf-8?B?Zml5NXc5NVltanNsWUJDSnhqR1V5TW5kSFcxQlhxeDEyT3hMaWROU2JGOXND?=
 =?utf-8?B?bnErWURZbFhCSk1KZmd1T2plcDk2ZlQ3bTl0VU5nUUVudzZoTXYzZXp6Smt6?=
 =?utf-8?B?QkJKVkVoUmtlSzNWZVVaSEVLMGF1ZkJuRUl3QTV0R3cxcU9UZ1lMLzF4V09G?=
 =?utf-8?B?a2ZSV3BPaFY0a0FkWGdGZk4rSmtWWnJCNk13aERGV2ZqaW5hdFpqZ1E4NWl2?=
 =?utf-8?B?dVk0TzRCb01MMmtTY2Z5aDJKcnVTREdIakVQcHo5cStJdjdCSzgwaklGRlhF?=
 =?utf-8?B?bWV6Ry9QMUNZdnNpOHU1R1k4RjFZNVhHMDJQQmJpQjQ3RG5UQnF4Tm5Eam50?=
 =?utf-8?B?VGowZ3U0aUxDV3U2TGhRN2c4b1gxRHdVa0s2c3lvQXFyMTVMcVN1MEFhMlM3?=
 =?utf-8?B?QUp5VUhRUk1DU29yZ01RUzRBZHhRdTQzTHJaR3RscjlqZWU4d1R4R0kyMklU?=
 =?utf-8?B?eVhkaWlXWnZNVS9uWW1YMWVsRzMyQ2c5djhjbUpGdVFQTndoOUUrRW1OdGEx?=
 =?utf-8?B?bWxuNFVUWVlkYkgveU5EcUFDYnc2VlFEQnh5RlRFRDNRT2h3ckNxSnZNQmxD?=
 =?utf-8?B?a0hHU0toRFpSbWpRV2xrTFlCL3NvMkhOemlJdWNiSVNrc0xXRUZ6VmhzSTF2?=
 =?utf-8?B?QXdGVHF5RHRkQldMeXgzQjA4WWo3SXZ6L1h0ZVptdDRwT1VacHk2U2EwQTVk?=
 =?utf-8?B?OVhuaU40aTF3KzZMTFk5SVZQUDREQXlNZ1JQY0kycXkvKzRkVVA2N2lRUmhU?=
 =?utf-8?B?UGQwU3BXbzNTR1ZGQklQczZaNmlpUDAwQ3hOUkJOcm5vNGx6ZW5YWTUwMmVl?=
 =?utf-8?B?S3EvdVdlY0R5WmZYeVVPWmFVRENYUENNOXZoKzR2Ry9PcC9Ed1U2M0p6Mllk?=
 =?utf-8?B?THdVdnlSOGE5UnlyQXk3bHdpQVA4Z2Z6b2orVFVFNjBsbmh4blJCaHRQMnRX?=
 =?utf-8?B?MUhHdFFGVzJaR1ZHek4vTjNwbnRhY0NoS2g5OFVJVThvMDlmVFNPM1czWGE3?=
 =?utf-8?B?ZFliMVBtL1g4dW12dkxKQlc0UmdwakNGcVVNNlpQK1k5R0V5TVIvRXNQUVZX?=
 =?utf-8?B?RFNEM2dtUjZNZmsySktZNGVpbkpld3VZMjZHOWpLTGozcUR2QmpyblI0KzM5?=
 =?utf-8?B?NzBYZ2ZLcFpwUkNSVkpWa3d4UFJBTGhZT2Zjc1NyRlhQSmx0Y2tYUkhZSVND?=
 =?utf-8?B?elNYdjhtTFJkU01yYnJSOGIrZjZROUtNaWlBM0x3ZE1GWnVHcFZTektZZ0NS?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff13c3-587a-4d3f-9b9f-08ddf454ae4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 12:37:49.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kZ8uWNt1K92Ne1bQChW9PiSpGU1OpbJ/V0CgIKUdVKv8w8LDHz/5GoJ9ZVJB1e84PUBB2FBT19ro7pmeEJIe9KYrwJRlyUWuetoCpFRbNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12916

IEhpIEdlZXJ0LA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KPiBTZW50OiAxNSBTZXB0ZW1iZXIgMjAyNSAxMzowOA0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDAvN10gQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQNCj4gDQo+IEhpIEJpanUs
DQo+IA0KPiBPbiBGcmksIDEyIFNlcHQgMjAyNSBhdCAxMjo0NywgQmlqdSA8YmlqdS5kYXMuYXVA
Z21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMNCj4gPiBwcm9wZXIgc3VzcGVuZC9yZXN1
bWUgc3VwcG9ydCB0byB0aGUgUmVuZXNhcyBSLUNhciBDQU4tRkQgY29udHJvbGxlcg0KPiA+IGRy
aXZlciwgYWZ0ZXIgdGhlIGN1c3RvbWFyeSBjbGVhbnVvcHMgYW5kIGZpeGVzLg0KPiA+IEl0IGFp
bXMgdG8gZml4IENBTi1GRCBvcGVyYXRpb24gYWZ0ZXIgcmVzdW1lIGZyb20gczJyYW0gb24gc3lz
dGVtcw0KPiA+IHdoZXJlIFBTQ0kgcG93ZXJzIGRvd24gdGhlIFNvQy4NCj4gPg0KPiA+IFRoaXMg
cGF0Y2ggc2VyaWVzIGhhcyBiZWVuIHRlc3RlZCBvbiBSWi9HM0UgU01BUkMgRVZLLCBFYmlzdS00
RCAoUi1DYXINCj4gPiBFMykgYW5kIFdoaXRlIEhhd2sgKFItQ2FyIFY0SCkuDQo+ID4NCj4gPiB2
MS0+djI6DQo+ID4gICogQWRkZWQgbG9ncyBmcm9tIFJaL0czRQ0KPiA+ICAqIENvbGxlY3RlZCB0
YWdzLg0KPiA+ICAqIE1vdmVkIGVuYWJsaW5nIG9mIFJBTSBjbGsgZnJvbSBwcm9iZSgpLg0KPiA+
ICAqIEFkZGVkIFJBTSBjbGsgaGFuZGxpbmcgaW4gcmNhcl9jYW5mZF9nbG9iYWxfeyxkZX1pbml0
KCkuDQo+ID4gICogRml4ZWQgdGhlIHR5cG8gaW4gZXJyb3IgcGF0aCBvZiByY2FyX2NhbmZkX3Jl
c3VtZSgpLg0KPiANCj4gVGhhbmtzIGZvciB1cGRhdGluZyENCj4gDQo+IFRoaXMgc2VyaWVzIGJl
aGF2ZXMgdGhlIHNhbWUgYXMgdjEgb24gRWJpc3UtNEQgKFItQ2FyIEUzKSBhbmQgV2hpdGUgSGF3
ayAoUi1DYXIgVjRIKS4gIEhvd2V2ZXIsIHRoYXQNCj4gbWVhbnMgdGhlIHNtYWxsIHJlZ3Jlc3Np
b24gSSBtZW50aW9uZWQgYmVmb3JlIFsxXSBpcyBzdGlsbCBwcmVzZW50Og0KPiANCj4gICAgIldo
aWxlIHRoaXMgZml4ZXMgQ0FOLUZEIGFmdGVyIHJlc3VtZSBmcm9tIHMycmFtIG9uIFItQ2FyIEUz
IChFYmlzdS00RCksDQo+ICAgICBpdCBkb2VzIGludHJvZHVjZSBhIHJlZ3Jlc3Npb24gb24gUi1D
YXIgVjRIIChXaGl0ZSBIYXdrKTogYWZ0ZXIgcmVzdW1lDQo+ICAgICBmcm9tIHMyaWRsZSAoV2hp
dGUgSGF3ayBkb2VzIG5vdCBzdXBwb3J0IHMycmFtKSwgQ0FOIGZyYW1lcyBzZW50IGJ5DQo+ICAg
ICBvdGhlciBkZXZpY2VzIGFyZSBubyBsb25nZXIgcmVjZWl2ZWQsIGFuZCB0aGUgb3RoZXIgc2lk
ZSBzb21ldGltZXMNCj4gICAgIHJlcG9ydHMgYSAiYnVzLW9mZiIuIg0KPiANCj4gTm90ZSB0aGF0
IEkgZGlkIG15IHRlc3RpbmcgYmV0d2VlbiBDQU4tRkQgY2hhbm5lbCAwIG9uIEViaXN1LCBhbmQg
Q0FOLUZEIGNoYW5uZWwgMyBvbiBXaGl0ZS1IYXdrLg0KPiANCj4gSSByZXRyaWVkIHdpdGggd2ly
aW5nIGJldHdlZW4gQ0FOLUZEIGNoYW5uZWwgMCBhbmQgMSBvbiBXaGl0ZS1IYXdrLCBhbmQgd2l0
aCB0aGF0IGNvbmZpZ3VyYXRpb24sIENBTi1GRA0KPiBzdGlsbCB3b3JrcyBhZnRlciBzMmlkbGUu
DQo+IA0KPiAgICAiSG93ZXZlciwgdGhlIHVuZGVybHlpbmcgaXNzdWUgaXMgcHJlLWV4aXN0aW5n
LCBhbmQgY2FuIGJlIHJlcHJvZHVjZWQNCj4gICAgIHdpdGhvdXQgdGhpcyBwYXRjaDogdGhlIENB
Ti1GRCBjb250cm9sbGVyIGZhaWxzIGluIHRoZSBzYW1lIHdheSBhZnRlcg0KPiAgICAgZHJpdmVy
IHVuYmluZC9yZWJpbmQuICBTbyBzb21ldGhpbmcgbXVzdCBiZSBtaXNzaW5nIGluIHRoZQ0KPiAg
ICAgKGRlKWluaXRpYWxpemF0aW9uIHNlcXVlbmNlIGZvciB0aGUgUi1DYXIgR2VuNCBDQU4tRkQg
cmVnaXN0ZXIgbGF5b3V0Lg0KPiAgICAgTm90ZSB0aGF0IGl0IGtlZXBzIG9uIHdvcmtpbmcgYWZ0
ZXIgaWZkb3duL2lmdXAsIHdoaWNoIGRvZXMgbm90DQo+ICAgICByZWluaXRpYWxpemUgdGhlIGZ1
bGwgY29udHJvbGxlci4iDQo+IA0KPiBTYW1lIGhlcmU6IENBTi1GRCBjaGFubmVsIDAgYW5kIDEg
b24gV2hpdGUtSGF3ayBrZWVwIG9uIHdvcmtpbmcgYWZ0ZXIgdW5iaW5kL3JlYmluZCwgdW5saWtl
IGNoYW5uZWwgMy4NCj4gU28gaXQgbG9va3MgbGlrZSB3ZSBoYXZlIGFuIGlzc3VlIGFnYWluIHdp
dGggaGFuZGxpbmcgY2hhbm5lbHMgMiBhbmQgaGlnaGVyLi4uDQoNCg0KUlovRzNFIHVzZXMgY2gw
IGFuZCBjaDQuIFNvIHByb2JsZW0gbWF5YmUgc3BlY2lmaWMgdG8gY2gzLg0KDQpDaGVlcnMsDQpC
aWp1DQo=

