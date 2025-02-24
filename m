Return-Path: <linux-can+bounces-2941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1360BA41AFF
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B7116D133
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC124E4DC;
	Mon, 24 Feb 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tza12rh8"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010064.outbound.protection.outlook.com [52.101.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792124CEE4;
	Mon, 24 Feb 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392916; cv=fail; b=J7A1FZGDa9MCdf6Rng1T9VwX3Or9F1BMBxyguVXZIVpotcCl/ETFMV1VwFCul9ZwS4Fng+fNEyRmwMTUcDPdAgofrCJYVf8yuDvsuxkIzs3zqjgKRYZV3pctrcQToxstUSWtPb2fiHuZZbCYGELSC4chwahb6DYnlAL9W4mPcm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392916; c=relaxed/simple;
	bh=6l9hDVjZBmlvddzkdKJeXEK1r+HCYBQDPKwxdJiF308=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvdKUddlmCi2VuiFP26p2N3WSljmnGe6OpFUEmw95zqFs+1Xwq/HRCj0RyQ8L7Z8ZgCICp18pFC/Hdr8Lk7+tsYM4K+WvB1wJUj7n5GpC4q+HgxVP1crbQVRvQGaJ+QVXUI4tuFjvtFeAHCJikM5bx5LTa44q4UXsEVWtQNRu6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tza12rh8; arc=fail smtp.client-ip=52.101.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKrm0fB6DByEL2fil76RCBGblSWxczFWuscGC/MOuO25tM7YreB+vIIRK3APy9ytRIUw6/GyuUCsD2D9yrTurhID39UneeRuUhLy5KYKpB/xtgOUydTaOpArgSU0jZFAftNAsIpUhmWwVdNBqra+T5xnPAKKl4FSaoK1TYV8sAGw6hoqgENu0YEOcAr4mlEq6TEp4vVjTknQBj8YDdaZNBvyWPDMLfurb0LawYe+W5en37/PO4pDccRhQL5Qf9faY03zURto7NDqMMr/ANaKjIMYhMg4JCdb8Fp2be+yQ9mIm7Y7fy4Wzw5PuBOlVjE6hG/WMo9Vgt0oP3LiHcOiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l9hDVjZBmlvddzkdKJeXEK1r+HCYBQDPKwxdJiF308=;
 b=KVbOa6IIHpkEOtnej0qEA2KFqBPmsB+QLXrFeg8qphmWhyFrP/WAvsCXHMw8bWxTez1YhAeGjHM8gE76v5qQGb2nycueyTVdbtepIJZYyVHRhi+dgoCW2R+oEElG49mWeozFD4UQKL1WVhTkezD+W149TIm/nxvYnSMbRkNh9out+mmlbC+o9nXi6J3g7ZbtrQOIr+onQEXO1OC+zNv9Wr3dB4p3MnXjAq9ph1QXDQ0AEBBLl3RgXEHN/hwOc1bS5BpqpnliXWvtFivA0geT1n9F548oLG6LJgCi5CenyA1u5GompLaWoHIoWqasuY0zJNy4esZYq/GVrU2kgsSV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l9hDVjZBmlvddzkdKJeXEK1r+HCYBQDPKwxdJiF308=;
 b=tza12rh88+Ba9QtKTeMb+oVkux3owkAq6oeve05rJxRor0imq3TAx5xTgpam5nNXCmkOHtUrSl9S33aziGiu71gxqVH8sETL7yVZmooNSL/2DnsjBJqE57Q84ski8WyrpAA+R+nTSTd9Atc0HgQOHJ0G4aFQUFBMZt5n40v1Bt0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11452.jpnprd01.prod.outlook.com (2603:1096:604:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:28:27 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:28:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, Ulrich Hecht
	<ulrich.hecht+renesas@gmail.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Topic: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
Thread-Index: AQHbg3wwxySbXtRqN0i0VotwnX4XtLNWQ86AgAACeWA=
Date: Mon, 24 Feb 2025 10:28:26 +0000
Message-ID:
 <TY3PR01MB1134685DA5E37B4FD717946A386C02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVYKPMshDretnZRCaz613p-ME_HxGGDiwk0iYkrL+GzBw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVYKPMshDretnZRCaz613p-ME_HxGGDiwk0iYkrL+GzBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11452:EE_
x-ms-office365-filtering-correlation-id: 205c040a-6fc5-439b-a29e-08dd54bdf99a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L05UMFFUOVo2aWg3TmFIUk5ZZEMwMm1rUVhEUmVJZEE2WC93ZHMwbUV6UlJm?=
 =?utf-8?B?R3FhNVI0RHhYMGRVemZROG5CUWZRZndQVlBwT3ptcWl5REhCeXZRRmM4dkxF?=
 =?utf-8?B?V0Z1V2FVR1FpSkVOejNQNXVqdW1FYWNDZEJNeW9LUlN6NUkzdHFCTFNjNHc5?=
 =?utf-8?B?Y3VpZEN6eThFeGwxS2gxa0FIdTZwZGp6NmlxUmNaTVozMDEybXJJMmFRNkdt?=
 =?utf-8?B?U0hmL3RQc2pzcVkvN0hwanpPNEZTVVNQTHE4KzlsaWxlbEo4NEtiZmVvZjV6?=
 =?utf-8?B?bVZCN2I4SjMvcFFORDdzaXlzSk5ZeXV2aDI5Z3dQanVFdnYxY0hvdVM1dTNB?=
 =?utf-8?B?cHFJOHM3TnZPSko3Z2txWml5S1I4dDdKek5IeDhldC9EaVZvcHZyMG5jN3VM?=
 =?utf-8?B?ajJWdnY2TDlCRXc0dVNRbXVPaUc3ZmtZaTlEYnIwMzQ2NHU1ODd5MUQ2VXZY?=
 =?utf-8?B?b2hNZ3ZibERObThRcmFqZytML0tFcmQwbXNnK3RCRGF6OVhicVMzV1JZTGE5?=
 =?utf-8?B?d21ha0tGVFBiZXk2Mmw3emV4c0tNb3lRdloyYlplSDExU2NobzJFYitPM3pK?=
 =?utf-8?B?V1o5dnRPTllFVG9wQ25uU0VlbUxJTEY4S3NYWmhQMHRWdm5YeVdGQlhIM3M4?=
 =?utf-8?B?VWpzNnZYSTRuZjlNbUZZcUZFL2xvN3ROMTRBMVVqem02dzhKOU41TE15ZWZY?=
 =?utf-8?B?cTU2dWZWS3VNQlVMdytrV09WR01VaFowWmxEZkFRbEdTYUtzNmFWTjU1aVNv?=
 =?utf-8?B?eE91WVpHYjBxZnRqaERZYmxjeWdOYWcyT1JtUmV4SkJJTXEwaTVXdks1V0ts?=
 =?utf-8?B?N2twWVIrTFpNTmZZazB0d0p0d1crbnZCd1Y2QktPdnJXYWoxS1JhdlBDc0RP?=
 =?utf-8?B?ZTg4UjJqMUJ4bDlsa3JSTXhCT01LVHE4bzlNK1hjSC9CQ0llT3d1ODl0d0o5?=
 =?utf-8?B?ZVdjc1FwK3RFRU0xaU1wTU5sbnh5cldBeEtNYk9CUXNkZVh0Nk85RkpjSkpx?=
 =?utf-8?B?eFlSWFpnK2c4aEx6aHFYY2svYXlYUGNzZDl5NHhMWWxzZm1EZjhUZGo5aGdI?=
 =?utf-8?B?aGx2TmtwaG9tdjhOOTJwUUM2MEQwSmZJQ1duQXZqMnA5NnZ1L2tiNXRVc3o0?=
 =?utf-8?B?U3ZMV0VUdGlFS2tUR2xMaE9qR1FPb0c4UG1LV1ZHY3YxeTNyTWdpY3B2ZVlE?=
 =?utf-8?B?Ty9jZjZ3cWZqNzZmWkphOTltcWd4SGJCQ2VYc0wzUm94QW5kVGxFWmhUUzly?=
 =?utf-8?B?M2N2RWNNaUcyKzc4alJ5Ujg4ZWRuaTR0TmhxZW04aXRaODNrd0VhamlVTjhx?=
 =?utf-8?B?Tk1pbWVpR0s2SENLcURnZ2NuTFhmT245OWNOOFZmL1V4aVFLYldGTXlQamZz?=
 =?utf-8?B?ZjBNQTVJTDZ6eHZLZ1VsVGExWllMUmd4cm8wNzRGZkRsLzhMU3hYeGFnL3dx?=
 =?utf-8?B?Qm9aUUlKV21UbXJ4T1huK2lHK0p0d3d6RzNQVmlDUEJXMWJwd1lLL2FGMVFR?=
 =?utf-8?B?MitDQVBWR0hkV1BJMHh0RnI3ZU5jeExGTHVDeFJPa1NneXBrMVhhM1JNN1dU?=
 =?utf-8?B?eEtibDV0dzRpTUd1akdoYVRHc3k5bWcxNnFJVE1zWlFya0xuNE1CczFHdkJy?=
 =?utf-8?B?QlNBWDhWN1VTTEIyaFdKSksyZTBRbzRPZlRaam1DY3VHNnhIUS9CZmJoK25L?=
 =?utf-8?B?TDFueHNSVjgrOWpCZ1pKNXZMck1iQUxIYk5QK2dNTWF0YnJqcTFRclFneFJp?=
 =?utf-8?B?azl2VGdwdDZDbE1qRGdKVnFFakFDeXVFc1ZCSnpya3lvR1hYTVVGTUUvZXV4?=
 =?utf-8?B?RlNFL3N3MWM1aGVaYTZnelVJaG1KWXlTdUpmN1ZONzA3WHdwWDAwRkNabnpP?=
 =?utf-8?B?QmRWVHFSU3ZYQTZtelliQUFjaEdyUkxEaWpWYmF3bEtnTkY0Z01nQlB2eEw1?=
 =?utf-8?Q?CB4GNKG9J8n6fDKm7liERC5VeGpLMGlS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEk2UytwaU1ZVktscHlrdEtPQ0xSalJ5YzVadzZwNU12ZHc4bFpiZTBhWHda?=
 =?utf-8?B?T2hLQThqVVZmUDJyYW5aL3B6Q2VDZXlQYm5IRTYyblNWdUtDU29YUy9OUG93?=
 =?utf-8?B?d3ZLWUFXcnRCaFpJcW9oSUhPRmdZQWlsdHN4VlllNVRsUksvM0FUY1FCcS9H?=
 =?utf-8?B?dUIrMk1oTHQ1TTNrOXpLMmdUb2pZenlxcEFNOTBGc2ZBQWxHa0Q2NmZoaFM2?=
 =?utf-8?B?VXNXZmRkdnpobmlsTEQzNGh3WUt0aW1QVmVnM09QZm42SnJvOWVlVEVYeSt5?=
 =?utf-8?B?a2hjeXlpclc3eVMzNHZTZVBxbnkxMStQUFdUTVBkVVJjUlcxQzl1NGRsWjFN?=
 =?utf-8?B?RCttRDUyN3B6YU5YS0FSZkIyR3ptRzM1azA4MFFIanhac1JyZVhXcUVGZFRj?=
 =?utf-8?B?VU44OFZ4ak5ESW05QjFiYjFtZGZIdnRIM1V1WWJPNWQvZ1ZvZlc3RGdTVk5o?=
 =?utf-8?B?UGpTQi85VUM0M2Y4VHpNN3dMNE9YYlhtWmY4TUhnUXlCc3Z5b2NMcFpGVnJ4?=
 =?utf-8?B?MVNnRXMzblFyYTlaeERBSlBLR3JaQlBuVmRSOGphWS9oTkVRTXpxT3d2Rmph?=
 =?utf-8?B?cmU4TU1BOXdxUHdUK1pXMUtBeUlCc0hlWW1qSFNVdm9QR3h4aXYxeWRqSFk1?=
 =?utf-8?B?RWt6YitKWTczMXVZRlIrT2xCSGQvbFI1VGRRbmNqQ1dxcnFmZWx2QnFFcVVr?=
 =?utf-8?B?cThKaFFmRzJ4QnNQOGFieFFPcTJhbGZCWExPSWN5RnhqRXJyU08zaGtFKysz?=
 =?utf-8?B?TFRNdGVWc053V0cyTlAzUHdQL0c3RnZmQWdIcjU2Szd0V2RwOUVkRGZBMGNy?=
 =?utf-8?B?T2R2WVVpZ0VnZTdkUlZ1ZGkrOUZuVzJudUxVak83Q2p4Q0xYY3VMUEg3RDhQ?=
 =?utf-8?B?eEg5TVhMRVNKT01lc0UvWFdBZ0l2a1gwZEZPNDVpNW1MaVN1anRZTzdVQ0dU?=
 =?utf-8?B?UmRFbGtndVNiVk1UZHpNaVJ4WFgwbDlXZE9Sa2JaRkY5QWxXd0V2ZmErMVM2?=
 =?utf-8?B?bnB5VlExK2JUOTFDUTJPbFNadjk3djRDSE1JTGdvb3E3NlVKZWFUejdRb2Nh?=
 =?utf-8?B?aTRVUEhHeG14RUNDOGk0cmloNW1aZ3VpSkZLUDYrelFxWVd5TEZ1eVFMUzhP?=
 =?utf-8?B?UmM2V2svdUJKNFFOR2RiWVFPUXJKd2xnZzRVUVEzMkc5UC82cEp6K2lHZm1h?=
 =?utf-8?B?VFNTdVE1aUgwY3EyUTIwMCtUYnUzVHBPTWhnQXdYS0NFZ0F5cDVRdHN3cXZm?=
 =?utf-8?B?djBCN2U0eWxNTk40SmRmRmIvMmhITWZOVkpJQkRGaW9zd2tCWWNCdXVJNENu?=
 =?utf-8?B?eVNWVXlmZG9UYldDa204MTdEY3ZtQllTMTY1a1NoUmt2NzdqY09pT0IvbUk0?=
 =?utf-8?B?ZXFhMmZnNzBiNUdHSkxjNkw1OFpzaVhFTzZvaTFCd2RNNVNhVDFBb0tNdTJI?=
 =?utf-8?B?SHlPRGdQUGo4a1B0bmJqMitBTm5lNGk3NHM0anh2NFk0N213dmJORDVZRFVZ?=
 =?utf-8?B?eTNVK1JXQjJJNk53Qi9tdlp6ZE1Sa3RVeVpXcVNXNnVEa0dpK0JhcHZqTFVX?=
 =?utf-8?B?NXVCdWI5d0ZteHZ1Q3VhVTZ4QjRLZEllTkxEc29QQk9WQmc1VkxtMCtwQ1h5?=
 =?utf-8?B?UmJTRlg4QnBZOGZmQlI0SGJPMFYycG9ybm9ray8zNTJmZ2dOeG1zUk5FYmxR?=
 =?utf-8?B?WDE0MmZGc0wxZ1Z0MytiL2J2K013OWs3aW1LUVVNTVM3bldhclRvbGhNMFlZ?=
 =?utf-8?B?WmJyeUVzOHRxcEhaY2V2LytsZnp2OXpmOTJ5UEF3cmYvNFk1b2drN3RGUzYr?=
 =?utf-8?B?RkFZbnNMK1VOdXFmTmtnYk1JL010Wjl0aVBtWFVNUGRGcG5JWS9Ec3ZueFlJ?=
 =?utf-8?B?dFh4Z255R2hvNnhPUjlVN3RwejJkWlFPa2tjRHgwR3Q0RWMxRnpNV1cwOTZj?=
 =?utf-8?B?WGVjeDE2TUkybW9OZFFVWEFwajhUdDBGcVpPMEcwcUFxbG91dFQ5NEI3WHRB?=
 =?utf-8?B?aGlOOE5tRDhueURMSW9HM2VDSVY3OGVvTS83OFVpQ2svYUFOZnV0bTJxUUFK?=
 =?utf-8?B?WnNzVE03WVE2RXk3OCt4dW5vSjJqYjdMeDk3R0VJSW1NcnZ5WUdIb2J0UUQ3?=
 =?utf-8?B?clo3MTh0RDlNb0dvalFwR2FXenh0TjZ0RjFZcUluK3RQZ1ZkUXVaMzhFbU84?=
 =?utf-8?B?WHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c040a-6fc5-439b-a29e-08dd54bdf99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 10:28:26.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8uZnC6PJKSQ7aWkcJsp0l4TluTEqm3eSLPV4LW8tac/8W8i675JYRd+K8oGWmtd+EHywG8y6ulL5OwgmL0MhjTWhdTxA3V3wF8521GDNU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11452

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6
IDI0IEZlYnJ1YXJ5IDIwMjUgMTA6MTgNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIGNh
bjogcmNhcl9jYW5mZDogRml4IHBhZ2UgZW50cmllcyBpbiB0aGUgQUZMIGxpc3QNCj4gDQo+IEhp
IEJpanUsDQo+IA0KPiBPbiBUaHUsIDIwIEZlYiAyMDI1IGF0IDEwOjQ1LCBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFRoZXJlIGFyZSBhIHRvdGFsIG9m
IDk2IEFGTCBwYWdlcyBhbmQgZWFjaCBwYWdlIGhhcyAxNiBlbnRyaWVzIHdpdGgNCj4gPiByZWdp
c3RlcnMgQ0ZER0FGTElEciwgQ0ZER0FGTE1yLCBDRkRHQUZMUDByLCBDRkRHQUZMUDFyIGhvbGRp
bmcgdGhlDQo+ID4gcnVsZSBlbnRyaWVzIChyID0gMC4uMTUpLg0KPiA+DQo+ID4gQ3VycmVudGx5
LCBSQ0FORkRfR0FGTCogbWFjcm9zIHVzZSBhIHN0YXJ0IHZhcmlhYmxlIHRvIGZpbmQgQUZMDQo+
ID4gZW50cmllcywgd2hpY2ggaXMgaW5jb3JyZWN0IGFzIHRoZSB0ZXN0aW5nIG9uIFJaL0czRSBz
aG93cyBjaDEgYW5kIGNoNA0KPiA+IGdldHMgYSBzdGFydCB2YWx1ZSBvZiAwIGFuZCB0aGUgcmVn
aXN0ZXIgY29udGVudHMgYXJlIG92ZXJ3cml0dGVuLg0KPiA+DQo+ID4gRml4IHRoaXMgaXNzdWUg
YnkgdXNpbmcgcnVsZV9lbnRyeSBjb3JyZXNwb25kaW5nIHRvIHRoZSBjaGFubmVsIHRvDQo+ID4g
ZmluZCB0aGUgcGFnZSBlbnRyaWVzIGluIHRoZSBBRkwgbGlzdC4NCj4gPg0KPiA+IEZpeGVzOiBk
ZDNiZDIzZWI0MzggKCJjYW46IHJjYXJfY2FuZmQ6IEFkZCBSZW5lc2FzIFItQ2FyIENBTiBGRA0K
PiA+IGRyaXZlciIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBJIGhvcGUgdG8gZ2l2ZSB0aGlzIGEgdHJ5IG9uIFdo
aXRlIEhhd2sgYW5kIEdyYXkgSGF3ayBTaW5nbGUsIHdoZXJlIEkgbmV2ZXIgZ290IGFueSBjaGFu
bmVscyBiZXlvbmQNCj4gdGhlIGZpcnN0IHR3byB0byB3b3JrLi4uDQoNClRoYW5rcyBmb3IgdHlp
bmcuIEkgZ3Vlc3MsIG9uIHRob3NlIGJvYXJkcyBzdGFydCB3aWxsIGdldCBhIHZhbHVlICIwIiBm
b3IgZmlyc3QgY2hhbm5lbCBhbmQNCiIxIiBmb3Igc2Vjb25kIGNoYW5uZWwgbGlrZSBSWi9HMkwu
DQoNCkNoZWVycywNCkJpanUNCg==

