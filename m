Return-Path: <linux-can+bounces-3270-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D2A74927
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB5E17CC2C
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2F21764B;
	Fri, 28 Mar 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AheSKJi8"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2C2144A0;
	Fri, 28 Mar 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161088; cv=fail; b=RUSPwdRhf6J8VCPOa31DmSNICTQHhqCUVtl0moeEnXGYXZTtm4htlLIeq2Dcd8PtYj/vt8/PtSEUh57gK57OFJXJcmDQjIfqCwI3sa/D036zIuRHnP1RuqTIK/UoF+gV2ZmZuOJA62yBXXuClr4k6ai7hRXjuEzc+8Qb5ZuSnxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161088; c=relaxed/simple;
	bh=01vX/p2DZ8/b8sqEfmXTiRidkbl8CP7QVjwpBlVlrIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvGi8ysrEs/CdfYKK00OXJVIc/T63ITA7TVlHdrfagsoOK3ECtyCMybNawKmX8Er4AvQdjtJcJrr8BCaZXfFW3RPm5UQ0e+NK+AX/V6RG4PJU6Q5hK01ySTmH/4IYaboyxp/upwrVWToUQc06MXCf/g86JwuR9lgV1lQuLFQUb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=AheSKJi8; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AympUmppKYZWHvnCKIcvc2y+r3248cdUiJLYlMcWJ3YwHHO1jGHwqMyiSgvXjJWGNBdhGDfsln4k3JjFByRth53NAa/VssRxGPJuCISxUU56S+oKq5fXA7qI79ar2wxkYb2O/YLkZ4O46yr7L0EELN3snwMdATb8oUQ45pBa93BJP1d0l9ewjr4T3wFEBmYQVnWjXIDtKc06wsmQyewFoa7KKObjvH3ANGJdk6MsfXUuJoqV1VmYFMg/XZEqBMgyb0KP8FvRTb/ZPjv5VH3wO6rV6EnPFS+BLrrHAYyQfP7vPn7tnyhgw7abdvEBO0DeVFjwcjWzaA12rFcBcNM5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01vX/p2DZ8/b8sqEfmXTiRidkbl8CP7QVjwpBlVlrIw=;
 b=rYYHba1lMg+HdfiYjBxLQSGsWv0Kr/gcfot+VtA8ewcZ8S8vr5ED9jc7cCReMSx2R8WSO79LF3sAjpy/LudHFX2jv4S01LAODASEirpcTc5SJRx6Pl3KZO4Z5FrUjrWw1VRomUrh03WQs+Yhv9ybV8Az+qiFr7v3Zh0CPAJFIjsQ0MGB0mFWZRoIk0LWDIQwGjXhyO7kUYEzd1tbZGo3HwRW+TyEYaCJNk2oMrs6CjWcQwYoSG3KPifS6n3+ElbS8IOd028NtSQ2JQtq+g2Kcp5T0GaJh7hBa4d6+2ez2jnDjJfRlHUh8alV9okypfVX36x9EcLEAistyU3JyPtENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01vX/p2DZ8/b8sqEfmXTiRidkbl8CP7QVjwpBlVlrIw=;
 b=AheSKJi8//iZi9wTlqHKltUkbgITL2u4TMl0ULpciow0jIYUSR17XKbADh9Y+cxA9q4iHEPKs4ekxZewZBxZYWKxT3TZLzaHLdBF+clXJLUqSk1p9RDDNQmaRD/87UewCV8lyCrrDwYCi8plREcN2xtJPBa90NUvouv2hBLG5Yw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6753.jpnprd01.prod.outlook.com (2603:1096:400:b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:24:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 11:24:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
Thread-Topic: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
Thread-Index: AQHbnkmA0xYVo6ORm02TL+SjeOOwZrOIXquAgAABGvCAAAqTAIAAAHUg
Date: Fri, 28 Mar 2025 11:24:41 +0000
Message-ID:
 <TY3PR01MB113461ABBA051C5EFCC83C70586A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com>
 <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
 <TY3PR01MB113467D894782F210DA15345E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1c797eda-658e-4902-8257-5b24fce0274f@wanadoo.fr>
In-Reply-To: <1c797eda-658e-4902-8257-5b24fce0274f@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6753:EE_
x-ms-office365-filtering-correlation-id: 69be2597-6e75-498a-21e8-08dd6deb2241
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDdrUENFMW1oZlRXVGl3MUIrQXRqanlBRGF0eFVNOVEyZHpkK0x1WFprcmVq?=
 =?utf-8?B?S3E1dEl2ekcwNWErbVVjMHpoRHhzdHhIckk1dDBaU1ZUNkQ1ZU9UK3d3aFV5?=
 =?utf-8?B?MWtNcE1DcEtzT1A0Y25GMlI1RmpZWTNkOHBjK1RDS0w4c2xUakV6VWd5OWlt?=
 =?utf-8?B?ZzhOMTA4UHpLRDk2RmRiT3pPLzFsQnF3TFpqZXZtbGlCTCs2LzNSWDJjWEhw?=
 =?utf-8?B?ZjhZa05SYjZQZEQ3cTFTeFJrWFNlZ3dFWWNIR0xtcjNsdXRrTDVOMDY0T0NO?=
 =?utf-8?B?dUY1anozT2FrWWRYdWdka3dOSG1PbTFiQ1lMalNjR0ozWE1lNHpHRk1Id1kz?=
 =?utf-8?B?enluSnc0U0RkT0tCbERNZlI5aXVNaytFOGV1aEY3bnIrWXpHSFBRbjVibVZy?=
 =?utf-8?B?MGJaNkNselNPVlcwNHRKNGcvei82SUpHM1o5ODdhNHh5SkRSSFhDZFd3cFFi?=
 =?utf-8?B?WTd4aFVya2N5bUh3b2lqa29LNC90bUZFMEo5cUY2QmVQS1NSM1c5MXp0dU5S?=
 =?utf-8?B?MXN1endoTFlWMjhQSm1ZYjZlNlNRcUh3eG1ZRzJOVEY3OG1zL3pxSjh6bEk3?=
 =?utf-8?B?dUVOQjFGRmxFN3daY3JQaHRoRlNaTTg3bmVFMndVTXJUL2hpWDljVnpLSGU2?=
 =?utf-8?B?UWNsMzgzREl2UlR5Y21TM1praUxRT0VkcXkxZU1IdTlqdFhpYTRtaG92Z3Ew?=
 =?utf-8?B?citLV1Zjd3UwUGNtdFpOQ2RLcGpEcTNJZFBuQjZzYnZYMTdma3pzYVdEa3Fa?=
 =?utf-8?B?djMvT0lBaVBZTlFNL3dML2U4OFMybFBPU29sRjRPalRnU09RRk50by9zT2lr?=
 =?utf-8?B?VXh2NTc0WlFkK3QvM01sMndQYUtBeVdzcldrZWpUY29VY2RaUEszMStXY1U3?=
 =?utf-8?B?NW1pNGtvNGNWVWRadnVTZnRRSk9wcDZkY255blQyMHFZMHFzcnFkdDl0MUR1?=
 =?utf-8?B?WUF6a1llbWc0RUJGWVQ2SGVOd1Z1L0N2R1ZYZTZuQWxhQW1JUWRJTDBReXRo?=
 =?utf-8?B?SUtvSGtEN2RLY0NOcmVaTWZUbjBCb3BzTjVYWXE3Q2JnZ21TZHdBanFVQlJw?=
 =?utf-8?B?anFPVWRTcmtJZFlZalJMc2NhZU5jcDdYSXU5TXRFM0tpMG9adFRHM0J2bHVu?=
 =?utf-8?B?RkF6ZnRWdmJXNkJNWnNyVnk2L0V6TEVlbVM0a3hIVGlCTksyc0dhR2lzQ0dX?=
 =?utf-8?B?UFhlYjVmQzJhSkJwUXcvNEIrMjRIenlvMlpEZ1FzT013dmxQR0RydEhaQnFO?=
 =?utf-8?B?OEdZL1h5YVVDVG9wTXBGNHJLdHF1NlgyR0ViWXFPSXRSYWp0WFBWdjluMWZC?=
 =?utf-8?B?Q2I2RW5PcDA5UFVmL2JQTWplZU9ranIwT044NU8yaFE2RnA0dXJ6YjBYTmpK?=
 =?utf-8?B?VFdwZE82Y1k2eXp6U0JHY01pVUF0bUFQc0hSSmFXNlFzaHh5NUZQMnpZVU13?=
 =?utf-8?B?Vk8wekcrKzVNeUJSeEU0RGdYQ0pxY25nU2E5MHM2NlI5dTFuNC83R3NjQ05P?=
 =?utf-8?B?UnYwbmpiUFk0cWhiYkFHUHBnQjRGZFhUVCtodnpITkwwR0xwRUtTWi9BV1Jj?=
 =?utf-8?B?Z2lMLzFJMm5qQ3JvRXpsM0JIbGVSL21vL2xtY1BuWm0zY2RxeDVoYzRtT2ZH?=
 =?utf-8?B?d0hRR3YycFRYbWF1ZXc3VE9rMkdQUGNUeE5YSHUveWJhV3c4KzBTNnZsb1kw?=
 =?utf-8?B?NS8zdzc1cnFZZm1qckxlT2RZOWNCR0tNSkVMaHJINUpCVDRQejArY0NGbUln?=
 =?utf-8?B?VUVzNVNiYW1FK1k1L0tIS3RUcXN0TEhhTGttUUdFem9obURXcGJFRUxYallQ?=
 =?utf-8?B?YS9vUXc5emJEczkrUDAyeExvUUJBN1ZsdE9TUTUrUlkrNXVHNE5WTnBjOEI2?=
 =?utf-8?B?RTROTjEvZW9MaVU1OVN3MUJKUy84a29memE4RnkwZXE1a3JpRkJVV1RKZkhP?=
 =?utf-8?Q?dgLgfrg1xA88ULJ9T37Hv0PDBFNljt+h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjZSWjhIeDBZSnluOGdXUllHc2E0WlpLd0xrSmd4RnFoelNnMmFjeW1MOTNW?=
 =?utf-8?B?QUc3bHU4Z2NRUW9nYmYzekp2bWVzMVc0TUQrbTFMYzdVUUxra25vb09EclpC?=
 =?utf-8?B?WmVjQVB0NTN5TXoxMXFCSkRHVENpRWQ5c1NDVlZyK2phSzRsN2ZXT2FXZDVG?=
 =?utf-8?B?SURIN1lLY1kvcXRsNndOUHNqTVNERGI2QkV0eC9hbURjbmRrclIrQTFORVY0?=
 =?utf-8?B?bTFyMmFwdVZmekVOdXkyQlhHYUl3czk5VE81TzA4VXFjd1ZqMDJqWVJxd1VQ?=
 =?utf-8?B?OVJWRHl5OVdmMXdXbDg0OWdrZkpjM3lSMmNjQTN1ZkhacUlvWG9SV3FnZWd2?=
 =?utf-8?B?WU9DY3VDdUR4WkZzQVl1cEdEMkhLWkx2RVdBQlRsWERKTEM4Q0txMllzV3U5?=
 =?utf-8?B?WnlOS29IODU2Mzc4THduT1oxMitBMjIxazBYSVVXQnhPVnRiWjczR1FSa3Bl?=
 =?utf-8?B?YWVjTzBZNVhlczhkeE1LV1VkZ2VNY0ZKUnAxQUJBMm8wZmI5b0lTWlhVSGx3?=
 =?utf-8?B?eUxxZ3lNaVJ0ajdiQXVkeTJnejlrY2FJMnpQd0xTRTZZSldiRHR3OU14ei9X?=
 =?utf-8?B?S1Rjc3FjdTVYOVdpblkxZFpiRm9MVzZQMG8zd3VhdS9CQkExNnd2UzZTNDhh?=
 =?utf-8?B?VFl3MUU2eE9zdVRFLzJlRlpLZlJEK3kyN1ViS29OelVBdEZLa3dDRit2K1N2?=
 =?utf-8?B?dWtBVVoweXd0N3FFZUpnZ00xSE5ndjlxTjYxYm5KRFNycjU0ZEZBcjAzQUVu?=
 =?utf-8?B?RmF1SXVFU1BRRHNJYXZybWZSaVBWR08wMzlmeXZGcGxwVDdhWXdsY1JmZ3JN?=
 =?utf-8?B?ajllNGdoYzhxR0twNjNDcFE3NkZrNXROdElCamh6ZjZsRmFzTUdCTUJrN3k1?=
 =?utf-8?B?aG9tRkhPNFRkTkFHRXFlL2dEeFhzSFNpdkdIR29TS2d4d1VlUjZ2UVBNMFpM?=
 =?utf-8?B?S2hJaHpDT1h2VzRVMGNUdjJwb1pFTmFWZm1GdW9lVlFqYTFzQ21tYnVsQnpj?=
 =?utf-8?B?cms5aTJ3ZkNqb1VSVDBab1RZekhKM0dnNG1pZUVBV2lZQnViS2tMcmpxblJE?=
 =?utf-8?B?N2xJeWM3U3pDMEZmRDVRQi8zSUxPYUxKZkdJcWQ1UlVXelhoOVFNZmgwKzhZ?=
 =?utf-8?B?dmlvaUNXcUJnZEhjSXlxbk5GQldLWEZncGlZOWRKM0FhWUc4TVNoaG1Zd0NV?=
 =?utf-8?B?SkpLTFBuaXh0NkVFTEhIUTUzKzZ2REVWMS8rTDAzdlA5MVBGenk3UHAwbW90?=
 =?utf-8?B?RGxrbWFhNytDcG4yQWozRSt5QWhXalhSWDlKc1dvQVMyaXNBcGE4Y0gyMmUv?=
 =?utf-8?B?Rll2ckZSNXRzelVPeHNiV2VMWCtwZEZRejNqYVd2blo0ZCt6bWhEQ053QUlq?=
 =?utf-8?B?SjJ5Tjkwa3lEZDVRYlBMK3Z2MlROQi9WNXlaU1BOTllua0JyN3JESUt0UGdX?=
 =?utf-8?B?anFINDM2TU9id3ZIamJUL2gvUmpCa1YvWVVLZTU2Q25xVFRaZTBHbDVNTWlN?=
 =?utf-8?B?d24yZ2FOMkdjUFVkRU5ablNSWnZtS3ZxNEpNMEduTjlQcXpCWm1TdVRnRHBl?=
 =?utf-8?B?MHh0b2E4TG84V2Y5Y1grbTU1NTFhSVg0K0NYeDd0dUo4b0tEYnpQNlIweTBu?=
 =?utf-8?B?cnZWL2ptSmRkR1dqejAwRWp1VlJ1UWQxSkN4UDdvdXJpaHhxRkgvVlFLbmlZ?=
 =?utf-8?B?Q0FEZit6OThTWFBLVEkycUZXWEZVNzRFZlUxaDJybTBES2dTYXpEU005ZTZs?=
 =?utf-8?B?dFIzMzlNS2YwMXlpRVJKK21iczNZbkYzM1VZL2pHcm1GMGFESEtRWjNCdGZN?=
 =?utf-8?B?N1J3RWN0YjNNb2FrNVVXaWxOWDFSdTBpYTl4dThJTGdVMndtNExNTVJTT3pW?=
 =?utf-8?B?anQrTWxZM1R3RWsxZWs0NWJrMWd3eEJwb2Jib0JjOVZ3SVhlQTZMc0F6K3o1?=
 =?utf-8?B?aDZzNk91dG53OXJXeDV0VkYrSEFCcTFMRzBtZ1pGSWlaNXB0M3h5MDdzLzVC?=
 =?utf-8?B?UlpwTTFjVDlCa0p3VEFNT2JVTWhvS3NDeTBXaEVWekZNVkdxNE15aHVLMTlD?=
 =?utf-8?B?WDNFOGNza2hTUUZtejBMdDZZenF0U3NHWFZLdSsvMnF2L3I3YXpUb0Vvb2Ri?=
 =?utf-8?B?b0grbFJnVUE0eFpPczVLTnZuSFZYTWN1WEhUMHkvaTdCMDE4T1d4cEFRdUor?=
 =?utf-8?B?bHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69be2597-6e75-498a-21e8-08dd6deb2241
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 11:24:41.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXHDvgSrj74urj6Mv8lFTiyBk9q9b1qVjeldbfTK5sGjJUlrLl9ZsdMkUz5wARWB8QnzKIDQLDnFT/uLz2Pi3AntBdNKtEZI7vaRrXz9/4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6753

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMjggTWFyY2ggMjAyNSAxMToyMQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDA4LzE4XSBjYW46IHJjYXJfY2FuZmQ6IFNpbXBsaWZ5IFJDQU5GRF9HQUZMQ0ZH
X1NFVFJOQyBtYWNybw0KPiANCj4gT24gMjgvMDMvMjAyNSBhdCAxOTo1NCwgQmlqdSBEYXMgd3Jv
dGU6DQo+ID4gSGkgVmluY2VudCwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+PiBGcm9tOiBWaW5jZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZy
Pg0KPiA+PiBTZW50OiAyOCBNYXJjaCAyMDI1IDEwOjM5DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjcgMDgvMThdIGNhbjogcmNhcl9jYW5mZDogU2ltcGxpZnkNCj4gPj4gUkNBTkZEX0dBRkxD
RkdfU0VUUk5DIG1hY3JvDQo+ID4+DQo+ID4+IE9uIDI2LzAzLzIwMjUgYXQgMjE6MTksIEJpanUg
RGFzIHdyb3RlOg0KPiA+Pj4gVGhlIHNoaWZ0IHZhbHVlcyBpbiBSQ0FORkRfR0FGTENGR19TRVRS
TkMgYXJlIGRpY3RhdGVkIGJ5IHRoZSBmaWVsZCB3aWR0aDoNCj4gPj4+ICAgLSBSLUNhciBHZW40
IHBhY2tzIDIgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmllbGQgd2lkdGgNCj4g
Pj4+ICAgICBvZiAxNiBiaXRzLA0KPiA+Pj4gICAtIFItQ2FyIEdlbjMgcGFja3MgdXAgdG8gNCB2
YWx1ZXMgaW4gYSAzMi1iaXQgd29yZCwgdXNpbmcgYSBmaWVsZA0KPiA+Pj4gICAgIHdpZHRoIG9m
IDggYml0cy4NCj4gPj4+DQo+ID4+PiBBZGQgcm5jX2ZpZWxkX3dpZHRoIHZhcmlhYmxlIHRvIHN0
cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gdG8gaGFuZGxlDQo+ID4+PiB0aGlzIGRpZmZlcmVuY2Ug
YW5kIHNpbXBsaWZ5IHRoZSBzaGlmdCB2YWx1ZSBpbg0KPiA+Pj4gUkNBTkZEX0dBRkxDRkdfU0VU
Uk5DIG1hY3JvIGJ5IHVzaW5nIGEgZm9ybXVsYSAoMzIgLSAobiAlIHJuY19zdHJpZGUgKyAxKSAq
IHJuY19maWVsZF93aWR0aCkuDQo+ID4+Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IHY2
LT43Og0KPiA+Pj4gICogQ29sbGVjdGVkIHRhZy4NCj4gPj4+IHY1LT42Og0KPiA+Pj4gICogUmVw
bGFjZWQgUkNBTkZEX1JOQ19QRVJfUkVHIG1hY3JvIHdpdGggcm5jX3N0cmlkZSB2YXJpYWJsZS4N
Cj4gPj4+ICAqIFVwZGF0ZWQgY29tbWl0IGRlc2NyaXB0aW9uDQo+ID4+PiAgKiBEcm9wcGVkIHRo
ZSBSYiB0YWcuDQo+ID4+PiB2NToNCj4gPj4+ICAqIE5ldyBwYXRjaC4NCj4gPj4+IC0tLQ0KPiA+
Pj4gIGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYyB8IDYgKysrKystDQo+ID4+PiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPj4+
IGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+PiBpbmRleCAwMDAxYzgw
NDNjMjUuLjYyY2RlMWVmYTBjMCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9y
Y2FyL3JjYXJfY2FuZmQuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9j
YW5mZC5jDQo+ID4+PiBAQCAtODksNyArODksNyBAQA0KPiA+Pj4gIC8qIFJTQ0ZEbkNGREdBRkxD
RkcwIC8gUlNDRkRuR0FGTENGRzAgKi8gICNkZWZpbmUNCj4gPj4+IFJDQU5GRF9HQUZMQ0ZHX1NF
VFJOQyhncHJpdiwgbiwgeCkgXA0KPiA+Pj4gIAkoKCh4KSAmICgoZ3ByaXYpLT5pbmZvLT5udW1f
c3VwcG9ydGVkX3J1bGVzIC0gMSkpIDw8IFwNCj4gPj4+IC0JIChyZWdfZ2VuNChncHJpdiwgMTYs
IDI0KSAtICgobikgJiAxKSAqIHJlZ19nZW40KGdwcml2LCAxNiwgOCkpKQ0KPiA+Pj4gKwkgKDMy
IC0gKCgobikgJSAoZ3ByaXYpLT5pbmZvLT5ybmNfc3RyaWRlICsgMSkgKg0KPiA+Pj4gKyhncHJp
diktPmluZm8tPnJuY19maWVsZF93aWR0aCkpKQ0KPiA+Pg0KPiA+PiBJIGNhbiBub3QgZm9sbG93
IGhvdyB0aGlzIGlzIHRoZSBzYW1lLiBMZXQncyB0YWtlIHRoZSBnZW40IGFzIGFuIGV4YW1wbGUu
IEJlZm9yZToNCj4gPj4NCj4gPj4gICAocmVnX2dlbjQoZ3ByaXYsIDE2LCAyNCkgLSAoKG4pICYg
MSkgKiByZWdfZ2VuNChncHJpdiwgMTYsIDgpKSkgPQ0KPiA+PiAgIDE2IC0gKChuICYgMSkgKiAx
NikNCj4gPj4NCj4gPj4gU28sIEnCoGhhdmU6DQo+ID4+DQo+ID4+IAkgbglzaGlmdCB2YWx1ZQ0K
PiA+PiAJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+IAkgMAkxNiAtICgo
MCAmIDEpICogMTYpID0gMA0KPiA+PiAJIDEJMTYgLSAoKDEgJiAxKSAqIDE2KSA9IDE2DQo+ID4+
IAkgMgkxNiAtICgoMiAmIDEpICogMTYpID0gMA0KPiA+PiAJIDMJMTYgLSAoKDMgJiAxKSAqIDE2
KSA9IDE2DQo+ID4+IAkgNAkxNiAtICgoNCAmIDEpICogMTYpID0gMA0KPiA+Pg0KPiA+PiBBZnRl
cjoNCj4gPj4NCj4gPj4gICAoMzIgLSAoKG4gJSBybmNfc3RyaWRlICsgMSkpICogcm5jX2ZpZWxk
X3dpZHRoKSA9DQo+ID4NCj4gPiAzMiAtIChuICUgcm5jX3N0cmlkZSkgKyAxID0NCj4gPj4gICAz
MiAtICgobiAlICgyICsgMSkpICogMTYpID0NCj4gPg0KPiA+DQo+ID4+ICAgMzIgLSAoKG4gJSAz
KSAqIDE2KQ0KPiA+ICAzMiAtICgobiAlIDIpICsgMSkpICogMTYpID0NCj4gPg0KPiA+Pg0KPiA+
PiAJIG4Jc2hpZnQgdmFsdWUNCj4gPj4gCS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+PiAJIDAJMzIgLSAoKDAgJSAzKSAqIDE2KSA9IDMyDQo+ID4+IAkgMQkzMiAtICgoMSAl
IDMpICogMTYpID0gMTYNCj4gPj4gCSAyCTMyIC0gKCgyICUgMykgKiAxNikgPSAwDQo+ID4+IAkg
MwkzMiAtICgoMyAlIDMpICogMTYpID0gMzINCj4gPj4gCSA0CTMyIC0gKCg0ICUgMykgKiAxNikg
PSAxNg0KPiA+Pg0KPiA+PiBJcyB0aGVyZSBzb21ldGhpbmcgd3JvbmcgaW4gbXkgY2FsY3VsYXRp
b24/IFdoYXQgYW0gScKgbWlzc2luZz8NCj4gPg0KPiA+IDAJMzIgLSAoKDAgJSAyKSArIDEpICog
MTYpID0gMTYNCj4gPiAxCTMyIC0gKCgxICUgMikgKyAxKSAqIDE2KSA9IDANCj4gDQo+IE9LLiBU
aGFua3MuIEkgZGlkbid0IHBhcnNlIHRoZSBwYXJlbnRoZXNpcyBjb3JyZWN0bHkuIEl0J3MgYmVl
biBhIGxvbmcgd2Vlaywgc29ycnkgZm9yIHRoZSBub2lzZS4NCj4gDQo+ID4+IE1vcmUgZ2VuZXJh
bGx5LCBpdCBpcyByZWFsbHkgaGFyZCB0byByZXZpZXcgYW5kIHVuZGVyc3RhbmQgd2hhdCB0aGlz
IG1hY3JvIGRvZXMuDQo+ID4NCj4gPiBNYWNybyBpcyBkb2luZyBhIHNpbXBsZSBjYWxjdWxhdGlv
bi4NCj4gPg0KPiA+ICgzMiAtIChuICUgcm5jX3N0cmlkZSArIDEpICogcm5jX2ZpZWxkX3dpZHRo
KQ0KPiANCj4gVGhpcyBpcyBiZWZvcmUgYWRkaW5nIHRoZSB0b25zIG9mIHBhcmVudGhlc2lzLiBJ
IGRpZCBteSByZXZpZXcgb2YgYmVzdCBlZmZvcnQgYW5kIGdvdCBpdCB3cm9uZyBub3QNCj4gYmVj
YXVzZSB0aGUgY2FsY3VsYXRpb24gaXMgY29tcGxpY2F0aW9uIGJ1dCBiZWNhdXNlIG9mIHRoZSBu
b2lzZSBpbnRyb2R1Y2VkIGJ5IHRob3NlIHBhcmVudGhlc2lzIChwbHVzDQo+IGFkbWl0dGVkbHkg
c29tZSBmYXRpZ3VlIGZyb20gdGhlIGxvbmcgd2Vla+KApikNCg0KSSBhZ3JlZSwgdG9vIG11Y2gg
cGFyZW50aGVzaXMgaW4gbWFjcm8gaXMgYSBub2lzZS4NCg0KPiANCj4gPj4gQ2FuIGFkZCBvbmUg
bW9yZSBwYXRjaDoNCj4gPj4NCj4gPj4gICBjYW46IHJjYXJfY2FuZmQ6IHR1cm4gUkNBTkZEX0dB
RkxDRkdfU0VUUk5DIGludG8gYSBmdW5jdGlvbg0KPiA+Pg0KPiA+PiBhbmQgdGhlbiBhcHBseSB5
b3VyIGNoYW5nZT8NCj4gPj4NCj4gPj4gSSBkbyBub3Qgc2VlIHRoZSByZWFzb24gd2h5IHRoaXMg
bmVlZHMgdG8gYmUgYSBtYWNyby4gSWYgeW91IG1ha2UNCj4gPj4gdGhpcyBhIGZ1bmN0aW9uLCBh
dCBsZWFzdCwgaXQgd2lsbCBiZSBlYXNpZXIgdG8gZm9sbG93IHdoYXQgaXMgZ29pbmcNCj4gPj4g
b24gYW5kIHRoZSBjb21waWxlciBvcHRpbWl6ZXIgd2lsbCBpbmxpbmUgaXQgYW55d2F5IHNvIHlv
dSBzaG91bGQgbm90IGdldCBhbnkgcGVuYWx0eS4NCj4gPg0KPiA+IEkgYW0gbGVhdmluZyBNYXJj
LCBHZWVydCB0byBwcm92aWRlIHRoZWlyIGZlZWRiYWNrIG9uIHRoaXMuDQo+IA0KPiBUaGUgbWFp
bnRhaW5lcnMgb2YgdGhlIENBTiBkcml2ZXJzIGFuZCBNYXJjIGFuZCBteXNlbGYuIE9mIGNvdXJz
ZSwgSSBkbyBhcHByZWNpYXRlIEdlZXJ0IGZlZWRiYWNrDQo+IGhlcmUuIEJ1dCBmb3IgZG9pbmcg
dGhpcyBtYWludGVuYW5jZSBhcyBhIHZvbHVudGVlciwgaW4gZXhjaGFuZ2UsIEkgd2FudCB5b3Ug
dG8gbWFrZSBteSByZXZpZXcgd29yaw0KPiAoYW5kIHRoZSBsb25nIHRlcm0gbWFpbnRlbmFuY2Up
IGVhc2llci4NCj4gDQo+IGZ1bmN0aW9uLWxpa2UgbWFjcm8gYXJlIG5vdCB3ZWxjb21lIHVubGVz
cyBzdHJpY3RseSBuZWVkZWQgYW5kIEkgYW0gbm90IGtlZW4gb24gZHJvcHBpbmcgdGhpcyBhc2su
DQoNCk9LLCB3aWxsIGNvbnZlcnQgdGhpcyBpbnRvIGEgZnVuY3Rpb24uDQoNCkNoZWVycywNCkJp
anUNCg==

