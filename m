Return-Path: <linux-can+bounces-2841-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D97A39B61
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76596189497A
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6B23958B;
	Tue, 18 Feb 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="YrV7Oy+0"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93406154C12;
	Tue, 18 Feb 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879270; cv=fail; b=QvTPP/gAz2SZTar8g+qIkUPUFq6Lcv0h3EEYRKHuRFp7ICK2z5NSBRxs/2IVMCe+PZ7G8jGj5RdG8YtTRpq89TvpbKWYNZyqxY2vqt6LaLLXhIHSx5l/uQw756cgigld9nscWG8wD4lsRhAR0o03eI5DbDQlN853a0P7aiKThb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879270; c=relaxed/simple;
	bh=KLYybrvL4lqYQKgVq4MK6OZi6nmq/kkK476grlzzCkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t58z9Z9aoZSAIUTo3QSTzd8l9ZKDVxieri7N9yHfJQxf2p8jbwAZNz15xSAzAMwXOb+3oRZuiBmAzaGd4KqePe5ToFVXi5E0s9WYdR+URcHOMPtRWaQKlHubmWcGpJSeAGZ1uQM/jwvXBMdOTnR+hhkXFcODbEx6y2JujigRyCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=YrV7Oy+0; arc=fail smtp.client-ip=52.101.125.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShcuskmVwifhJ0savKHNg1CApzYpFc/PE7QZSqUG2OHVhX1dufpOKlZ4XtnuH8IfrkIFTbcl/yKtC6jdiJPr9pF+X604KxdJ2B7fyv4Cxzfe/UKc+xfrcPIZJnW6h4LaFTt/KsYkkG+TLUgTyliocqJ/ndeUVUNjUhyisb4QnAbCndvYA4IaSUf0VeRgGIcmT4ndUlIoZL1/PR0Bwnvs/UTKHC8saH7u8xF7P/5ZrGyhuXGtPI2wISKpj6WCCMGSbQjjgFFq12WvXQy7uLhCLpb7GenFW7hY1a3i1G72hKXQMwYoXvtG0/lXOvipTqosr20DcYwKarU/ZVD0HmHeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLYybrvL4lqYQKgVq4MK6OZi6nmq/kkK476grlzzCkk=;
 b=ULhpxZcfmhha4T8rXvbRVkwFFjynZvZUTzlR8eD8BU991FyvzX7BbQ7z/VSo5hqxeSA8RgP0ySllZaG50wO8LczxE/G3T7Vt2yzyI9uOx9qfaTSBUDMUUkuKbvZEOT/HQVuYcKNhMlbXj3fShdrr0Q28Aqzk1pwi1ED5BlaGzWJrcgs6+oFDC8r8AdvCVKIB48nGss3+3WTBB380Uh/8aEjHJTy3sIT6OJTzK17OLXzDH4CTupNPPnbDr5TUwLEeDOND5jz7o8nHkUEuIuV/KOkj0CeLJujenytScmCbsF6uzNKq0jzC32Mb1lx2GV84GuEIz5T42Zj2eoBbGgIT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLYybrvL4lqYQKgVq4MK6OZi6nmq/kkK476grlzzCkk=;
 b=YrV7Oy+07CcIAHUjp/UIQZqREuYB0g/sOXG/trQzBbs08KdgB/wQopU8e9F8MrCVG3n48CE3R2NsCaTVCnbxqB2mGzcxx4s8fd1GKcKA1TAmct5uLKVoIRAILEi5tHtTTm98+OAL8tiFderv98z0dfEyxI613VtDbf+/tBcUu9g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6141.jpnprd01.prod.outlook.com (2603:1096:400:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 11:47:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 11:47:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH 00/11] Add support for RZ/G3E CANFD
Thread-Topic: [PATCH 00/11] Add support for RZ/G3E CANFD
Thread-Index: AQHbgfLm+Dqw6+dv70i+39VSRIOW9rNM6dSAgAAH2vA=
Date: Tue, 18 Feb 2025 11:47:46 +0000
Message-ID:
 <TY3PR01MB11346E47688ADA3309409055286FA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
 <20250218-smooth-macaque-of-inquire-45fb87-mkl@pengutronix.de>
In-Reply-To: <20250218-smooth-macaque-of-inquire-45fb87-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6141:EE_
x-ms-office365-filtering-correlation-id: b85e676c-76c2-4f96-f448-08dd50120fd0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVZ2QjJmNmczc1NhYlFtRFRQaGRmcjNFcEdSS2dRaC9DRWE5aFg1QWZqNkR4?=
 =?utf-8?B?clFmWHNuNXNtM2pmT2JLaXBGWTdQWjBKQUpMYlZHL3dDVVk3YTlVTGhVSEdW?=
 =?utf-8?B?SHQwblFUb2tXR3VJWDhqTTBUNEd1YlF0RnZhUkI2QnZuRFQ1dk9aUDh2WEZS?=
 =?utf-8?B?RVJXNE9yOHB1cWFVaElvczEyMlNaZmtQZGtsUEZITnU2a0FUZEV0OFdTallU?=
 =?utf-8?B?TEU4QnptZTNBQmVGSFppV1J2bHhMVjNkOEFJWlVlRTZXS1VrSy9la1gySHh0?=
 =?utf-8?B?OEZHWTdDZUZzeXN5dDFaWVlxVzNJelQ3dDlOVHNhLy93aVdaQXlyU3ppVTMz?=
 =?utf-8?B?N1ZjbmNqYzR1NnhEVmx2MzZjRXNPc0s2dUlZYzMzaXFTUGJEZjA3Q3FEN05u?=
 =?utf-8?B?LzJoOW9ldjk0RDMxTHJuVEtmeE1BQ3JBeDdhY2RmT005cUxoeG16V3JOYytw?=
 =?utf-8?B?djVXYis1Y0I1eVBqNUF3QVdMZkRtbWlFaUNGWTBCS3RvbkQ3aWRDUjVSMFd3?=
 =?utf-8?B?VDZCd2ZZRjhUVUxOdWoxVTNjc3FYWWxNV1pCZHEvaTh4Sm05b1BtODFVcldL?=
 =?utf-8?B?WVlFSVluL1o0TkRBRFJwOHZmOGo5dCtkc3BNSkdKcld3RlNmV1NTZUoxWEhX?=
 =?utf-8?B?WDQ5WUF0N01pNGR0UFM3dWcwT0ZjMit2R1o1YXhBOVloMkRBWnQvOE5CTVU2?=
 =?utf-8?B?U2FYRXp6QlNuNk8vSkMyQWNZV0h5NWU0cytwMGZsZ0xrZ3EyYXRwaDJFcDZY?=
 =?utf-8?B?aFJZVTdyOHRHSEFXYmREYk1kMjhaZUl6cmx2LzZlR2U2ZmkzY0pkZ0pESHFl?=
 =?utf-8?B?MStyOUZZYlY1U3hXUTg1Qmg0Mng0anBNb3dUNlB2UjlKMkFRaGlxNTVrK3FY?=
 =?utf-8?B?VHl5Ukd2eUtvU3dRR1ZwMWFqZ2M5Nzg5MGxkNTZ1SHZtZDNXTWxKb2VydXVp?=
 =?utf-8?B?Vno1dUxiUFRTK0hsbHFQN29RcGFVa0l1M1Q0bzNEZW5vR0xBbUVvZUZXT3Zh?=
 =?utf-8?B?eFk3TFJNb0ZYYlVERzRuYkdsNnRJRjFvSFQ1ZlVZOHpFcEU2K0lEL2o0dzdV?=
 =?utf-8?B?WlRkc0Z3S0NQcGllRElhYUpRMDhYcmFkVnVtRHM4VUJ3Zk90dHNWOXZUMFhC?=
 =?utf-8?B?bU5nTVk2aG5VVFVsb1BKR3NGWk9HN0JpRnM3SVJpa21qTzhVajRad3lDczVZ?=
 =?utf-8?B?VVU4Wi9mUmxTY3BlckdqbWRhTTNBWkFzTklxTUNsU2E4RndqclBQZC9SaThh?=
 =?utf-8?B?UEh4cng2V2s4WEVJbEtYUmtvT1VCbUVuZktmNFVsU2FrRlZwOXhpdXdOV2ls?=
 =?utf-8?B?NDIwTERFMkhQOEVCTWx5SUdyUWRxMUZwalFaSjZnOE1BdzlUWUl6NDBHeUxo?=
 =?utf-8?B?eks3TUlkSzdDM1QveU93UG1VQUVjUzE4cHFHN1d3WS92U0RlU2xrNW9FL01D?=
 =?utf-8?B?MWxqMVJ6QnQrSVpXQUlmUHp3UXQ5SXJvTXp3MjRzSDVqVEIvT0tob25BVXhx?=
 =?utf-8?B?R1FncHhjTjhvZGtjcnZJNy9xSjB0aktMQWZMTkI1ZHBwbmYrTGE5T2pqakh1?=
 =?utf-8?B?TStUcUNYaUhaQjlnQisrOVBuVmg0YVVhVDJMckdHYTBkZGZZb1Vhc0RyQlow?=
 =?utf-8?B?V1ZZaWlSN1hpVmFMZEpIbVRTSVVXdmRSN01Db2twYmR0WmlKMmg1NUYxaDZt?=
 =?utf-8?B?NFU1OXk0d2VyWm8zajRyYkhBSHA5cHVWdFVzWlppYkxRMnZNWllrNlFKaXZX?=
 =?utf-8?B?Vm9vTkdCbmRkakZ5WXI2MUlxMG43QStqaW9XZnVhcGVsdTJCRjdSaDJSeVBx?=
 =?utf-8?B?T3VITHJINjBHenVEUzFDeC9CTlFwZnBuelVKOXE0eVFVZkNHaXVBTENIeG5W?=
 =?utf-8?B?NDJES25oVzRZMmNUdFprK08xY1lJdUtnS0RFQ2VKdklzTDBaS0t5UUJlb09T?=
 =?utf-8?Q?mragcsjO8LhS2C8CqtwzQ6/eIKVupUyK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bElWNWs2OHY2SEt4enVWUlNlSnRKM0crV283dXBaM3Iwejdib1ZRZ0VoWWkx?=
 =?utf-8?B?VlhQRGorNjRDRWQ1empYUURsNzBULzM0MHorTHBzSG9VVjA1NU9ScjY1clpo?=
 =?utf-8?B?UlNhNXViVmtJU0wyVTFRUXZka0pLTWlKVlRselJNa1doWHVmQzNOMkp3VlFw?=
 =?utf-8?B?ODBoYm1GT29FbWh4eXVscHNzL1hUSnlyUEdJVmFva2kwUmxiOS92SFlJTjVO?=
 =?utf-8?B?M3ZyM2hQNnRMbTltOWFtckp0YkhSd2ZBT0gxWi9tUm93MEpDMTAybzhsU3Fw?=
 =?utf-8?B?ZEVZTlRuVWpPOWlDRHdsRmQ0L0FZQ0dSU2F3ZFdGRXhZZzMxTytpdlQ0aEdD?=
 =?utf-8?B?NjZkbTFSUHg2WVJPM3dzcnVvSmZETXB0eExvRDJlaE9Ceis4Q0habTNSbEtU?=
 =?utf-8?B?NnpxZ1FseXFFcGc1MCtzbjNCT0F6NU5UNW0xRndqeE9UVGFrRzBsdFZ6R2pv?=
 =?utf-8?B?UnpuU0VvT2ZSclR3aHZINVh4RFF6NXN2RmlnbmU4MEFubWJmc09BQUV2ZHJu?=
 =?utf-8?B?YmJPc1d3QXY3RGhQT29lV1lUZXc1Z0pxMEplQUVzWHRIVFVkeHJqaTRlTU80?=
 =?utf-8?B?aHlNdWw0Lzcrc2cralNuSHRmY3VnN2ZqbG1ONkJUQXRrK0hiUTFLcnhOdzJR?=
 =?utf-8?B?eldoR0FvTERVcGpUTmJVRklJKzVaTkFDaTBJMWJpMjZvRDdyanZJbUNlL2l6?=
 =?utf-8?B?aUhTTVU5NlNHemIweDg4VFFpcDFoOVZhekg5TDJMcTVEaW5IaEJNTDBwUVhD?=
 =?utf-8?B?N1pzZTBZd2c4bGFuandDVTdIaHQ3ZUhUS2o5U0lnM3FwTk54b1J3cTBMektl?=
 =?utf-8?B?eTZ0YnkxZ09JcThiVGV0VWw4SGZSY0x0Z2tjbkVBZTgzQndDWTlJcXl1bklE?=
 =?utf-8?B?VXVOeVRrMjllOVJVa1BYQ0F5RERZV1dNWVhUbnZTRW9BQU5NMDNEU1dnSTd5?=
 =?utf-8?B?OWM0Zkk2SFFpMHBiN1FoRUZ2UTQxSUFHOENudWhzMS9UTGJKMzhDTVNaWis4?=
 =?utf-8?B?UmFmbWRqZUhRL002VmxjdGxTWWt6OXIrWkVaZFByS0R2VjlDOGF3UUtuSlBr?=
 =?utf-8?B?T1FqVnMzNzJ6MDlNT1pkYWgyN1VKY2t0NmhncFVFaG5sdlhVOFQ4NitHMDRL?=
 =?utf-8?B?M21CR2JEQm1saUkwcmRkeWNFdFpDbENjL2YyajU4Rm9pM1NKeG8xMEkrbjN4?=
 =?utf-8?B?aDIvQWZkOWRwb3JxUHh4cjFrTW1OSU1wQ01wczFabWI4SlgrdjFlWnFKTEkx?=
 =?utf-8?B?Qko3dGtrT1ZPSXpkbnAvanZTdVY4YXJHbjN2cEkrS1RjK3hhVndRL010SEkv?=
 =?utf-8?B?U2xwYmYzTDFaYWdKQ3kzZkNqeEM3NEtPYzBZU0c3cXlSVjhiRVYxYzZPS0Nk?=
 =?utf-8?B?d1BzYi9xeUt0MUhyd3RTTzNWaDlBbzB6NnZsc0czRlVPTDRyK3M3dnNWeUtt?=
 =?utf-8?B?R09jalp5NzR5UHpxT1c3WmVBdm8rSUx5TTEwbCtvODZUbHI4MEN4bzR6Qk8r?=
 =?utf-8?B?QWdEcmcwNngyajBZc3k1ZVplcU1EQkxHQnBxU3Q3Y1Rna2VGT2NiS044dGQw?=
 =?utf-8?B?ZUFMUlA0SHBYWDNjMjhMeTZmQ3F6TC96RXA4aTByVWZKalJvSDFVeW1UaXhL?=
 =?utf-8?B?RnRsbXBxUlVyQUxCckJqN2FZeStSVHV3bEJCdjFhcVVySkRXMFdSZHRYUWlN?=
 =?utf-8?B?VUNHQXJkdHAyNG1mMk9GdUEwQnBkV1habTlmcTIrbDlhNU5aQWVjYXAyamhs?=
 =?utf-8?B?QlJXOW9HNUJBN1UyU2pDUDdoc1JGZnZnOUU5UmxGNnN1Rm5mVGtPYkthVFha?=
 =?utf-8?B?UmpCanFuaVFSa1JMSk0yU3dUWk15RnVhZXVGdU1aaFFTUGVqODB6OUVoMWNC?=
 =?utf-8?B?UDhRUURxYVgvNGVBMUVHbFBpS0ZxY1NzSnZWTHQ1clBITmxwU0xLT2Q4M0Rm?=
 =?utf-8?B?amREVnZPbk1wMk5pVklPUHJqRlNBUjFIMU5EZUU0ZWJVSzlhRzhUellOU2dP?=
 =?utf-8?B?ajlQSWJVMC8zdHh2R3RSOEREVG5JSkZRaVMzZTRSZXZwUnVBQmJ0dE1QeGIv?=
 =?utf-8?B?OVpNUzRidUp0c1F0OGNNZmVXdW9YNkhob3NaY3M1V0NBdkpOU2J3alpVUzUw?=
 =?utf-8?B?NTVHR0FteGwzZ2dQeUlacDBJcEp5cmhia3hpNi90dFg4My83dnpjajU3dlJ0?=
 =?utf-8?B?N2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e676c-76c2-4f96-f448-08dd50120fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:47:46.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYWzw0uTrblFvqiRBoAqZDfang+/xYj1a2MfP9PXuF1amXYrKv2cBE7zTPiLx4jiTRzuz+gQUbN/ewdaJCq/ubtiRJFnPY3Av8Vx+41BMVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6141

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMTggRmVicnVhcnkgMjAyNSAxMToxOQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDAwLzExXSBBZGQgc3VwcG9ydCBmb3IgUlovRzNFIENBTkZEDQo+IA0KPiBPbiAxOC4wMi4yMDI1
IDEwOjQ5OjUwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBUaGUgQ0FOLUZEIG1vZHVsZSBvbiBSWi9H
M0UgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBvbmUgb24gYm90aCBSLUNhcg0KPiA+IFY0SCBhbmQg
UlovRzJMLCBidXQgZGlmZmVycyBpbiBzb21lIGhhcmR3YXJlIHBhcmFtZXRlcnM6DQo+ID4gICog
Tm8gZXh0ZXJuYWwgY2xvY2ssIGJ1dCBpbnN0ZWFkIGhhcyByYW0gY2xvY2suDQo+ID4gICogU3Vw
cG9ydCB1cCB0byA2IGNoYW5uZWxzLg0KPiA+ICAqIDIwIGludGVycnVwdHMuDQo+ID4NCj4gPiBC
aWp1IERhcyAoMTEpOg0KPiA+ICAgY2xrOiByZW5lc2FzOiByOWEwOWcwNDc6IEFkZCBDQU5GRCBj
bG9jay9yZXNldA0KPiA+ICAgZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBG
aXggdHlwbyBpbiBwYXR0ZXJuIHByb3BlcnRpZXMNCj4gPiAgICAgZm9yIFItQ2FyIFY0TQ0KPiA+
ICAgZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBTaW1wbGlmeSB0aGUgY29u
ZGl0aW9uYWwgc2NoZW1hDQo+ID4gICBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2Fu
ZmQ6IERvY3VtZW50IFJaL0czRSBzdXBwb3J0DQo+ID4gICBjYW46IHJjYXJfY2FuZmQ6IEZpeCBw
YWdlIGVudHJpZXMgaW4gdGhlIEFGTCBsaXN0DQo+ID4gICBjYW46IHJjYXJfY2FuZmQ6IEFkZCBn
ZW40X3R5cGUgdmFyaWFibGUgdG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiA+ICAgY2Fu
OiByY2FyX2NhbmZkOiBBZGQgb25seV9pbnRlcm5hbF9jbGtzIHZhcmlhYmxlIHRvIHN0cnVjdA0K
PiA+ICAgICByY2FyX2NhbmZkX2h3X2luZm8NCj4gPiAgIGNhbjogcmNhcl9jYW5mZDogRW5oYW5j
ZSBtdWx0aV9jaGFubmVsX2lycXMgaGFuZGxpbmcNCj4gPiAgIGNhbjogcmNhcl9jYW5mZDogQWRk
IFJaL0czRSBzdXBwb3J0DQo+ID4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOWcwNDc6IEFk
ZCBDQU5GRCBub2RlDQo+ID4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOWcwNDdlNTctc21h
cmM6IEVuYWJsZSBDQU5GRA0KPiANCj4gUGxlYXNlIHNlbmQgdGhlIGR0cyBjaGFuZ2VzIGFzIGEg
c2VwYXJhdGUgc2VyaWVzLCB0b28uIFRoZXkgd2lsbCBwcm9iYWJseSBnbyBtYWlubGluZSB2aWEg
dGhlIHJlbmVzYXMNCj4gU29DIHRyZWUuDQoNCkFncmVlZC4gQ2xrLCBkdHMgYXMgc2VwYXJhdGUg
c2VyaWVzLg0KDQpDaGVlcnMsDQpCaWp1DQo=

