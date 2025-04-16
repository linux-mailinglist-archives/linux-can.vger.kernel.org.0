Return-Path: <linux-can+bounces-3415-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02AA90854
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B8F17A492
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8D191;
	Wed, 16 Apr 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RZ46BvyM"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010031.outbound.protection.outlook.com [52.101.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E81DF985;
	Wed, 16 Apr 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819740; cv=fail; b=g9UL/h7mAED4mc2H2F7+MXTGjumFDanMISk40TLQV4iPcHgn7EMTks1fis979c9hGqigXYknFsko/oGWdvrmQUA7tKRyGTfln7DVCSuWZrf6558Tn9l8usSvEUgpDcFU4y6n/J5UgD5YCHEPzYbafdwPkHmVaqB2NqSBIRBoImQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819740; c=relaxed/simple;
	bh=cYZCx2BeFtXJwgWaGEJKMjoh0BuyzMcPk/QF0Pwkc5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQ5/chpG0grYkNfUJ8JRtZZ4g4K1UvrUhjDrwMeCceMUoXPsV5N0fhin++xEcM8cePWBGE3Y79BviNffhJDnKWILiLoXa4RSSQGvuYWJ7ytIUQbyNU+6WEnBOGuGvMcxrdDXENYbDZDjBGqpXrpXlnOX0Ctj/Xi0iW9ZOzG1HEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RZ46BvyM; arc=fail smtp.client-ip=52.101.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIWQIUmc2lOTYoTC9ntVUsFHbq/ECK83pTrcUJfv+u9ijy4Jq+X3OWZ6Dzsvb2aCNK2opNu9+0NqUhaI4G8BH35PQDcFdPOPJjfnmhTYGIbL3TPabd8ES0PyAGLxBSS/itusGFUnEOm98+7spSj3aESYommRfLWW+eXRvyo2jw+Ty8aylUK9BWGGyPvXcrQz3Uld8fGp2jgYKT5OnrwmjC4dB2qlOZ0tJCzpuaFBoe9JuhdUYTSqUtGuhP3KS+BAcGBFnLVbg5plu7BXTFV4QlWUNb3BtMjPHjQHyULCpcys+LJfJBV4NbTssobm0iSzKQi5gYJUAOGPYI/Z136I/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYZCx2BeFtXJwgWaGEJKMjoh0BuyzMcPk/QF0Pwkc5Q=;
 b=x4R5LfIvi0K9SnriEWSUv3AehPvxLnC9NJmnEi1mTWjfppeCZ/9i1lN0ll6XIDZRSHriompT48dzZc/vvzuUUoyUat4bKhAaIu0jyjjC8pC9EQbVEHp7OOk8WtAWDLiYoqe9YLuOW/izw8dRNzOICOH+bUMn7AJRQz499SAwKqTVvxRiW99ELzt+NjMokpzshsqG+soSZtSYxeQYqY689Vx6J64YgPoynGrICB5+VHW6tpTRjLe+nHXBtLhOc051tW6keGJ3dgu+JPiB5Yt7nGZQkKtwAQ5ggN3PNKi8LDoVJ804Mja6i5waMzv3hK5GzCeJhG+zrIZPWrCeliyE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYZCx2BeFtXJwgWaGEJKMjoh0BuyzMcPk/QF0Pwkc5Q=;
 b=RZ46BvyMYgls6z842bZizlBC95ivEcP/LnY+qAj1wvEbF5ipbxlukwn7HubjP3m3hoXQwCqkSK+S4ZLcg97n5PUeEH2p5KUO3DsWAQni52vNQZ/WL4fI1NttRxx+W5CI1KIMf609zLtehrRBZwZTdH05E5TUEYe/2ILN/7XrNzM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7801.jpnprd01.prod.outlook.com (2603:1096:604:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 16 Apr
 2025 16:08:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 16:08:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 07/19] can: rcar_canfd: Add rcar_canfd_setrnc()
Thread-Topic: [PATCH v8 07/19] can: rcar_canfd: Add rcar_canfd_setrnc()
Thread-Index: AQHbo7k4uFvRuVMyrkiZ8U7fn9vyz7OmY3oAgAAokKA=
Date: Wed, 16 Apr 2025 16:08:48 +0000
Message-ID:
 <TY3PR01MB1134653C8B2819F70124BE39A86BD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
 <20250402102226.28032-8-biju.das.jz@bp.renesas.com>
 <CAMuHMdUi1t-KeeTYTacuxGNpbZQT9Fv5xGrNQHw-n6ihyKn1Rg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUi1t-KeeTYTacuxGNpbZQT9Fv5xGrNQHw-n6ihyKn1Rg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7801:EE_
x-ms-office365-filtering-correlation-id: 72c15039-2004-4474-324d-08dd7d00f896
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXFaZ1VCdWNHdEJBM3FHdmNsd2pTaFUxczJOR1dTcFBNd1JBcWlmNndmaDJ5?=
 =?utf-8?B?Q1JyQWljZ0pkaVlKWDBOblhERDh2RmxEZ0ZtSFlsSkJFS2JoeHRGRWV6M1Rx?=
 =?utf-8?B?RWlVUk1OSDRFNytMWE51NzBua2I2dllRR2lQdDh0Q2RMTjlXdTV4QXMvamZC?=
 =?utf-8?B?RkZPOVVnajg5N3lMNFpMeXVqR1VNTHI3RmxvZkREand1MW9uVzE0OTdqdmJw?=
 =?utf-8?B?b3Q5dUtvQWw0dHhwTmtnVDh2R09DZG8rUVZGdDdSZ3ZIb1owaU9iVXlwVWNI?=
 =?utf-8?B?U3MwL09IdUQ1cWJjWGFNWUxvNmNGN2h1SEZza2tUZmMvSHFic3VxREVtdlRS?=
 =?utf-8?B?d0JVWnEzQWVuaG96MUtMNFIwbEN0bjdCSFpQRTlZTTZoSk5MYnpXYzd0eGox?=
 =?utf-8?B?NFJEWkQ4M2VYaXpYUC9SYjl4Y3E1bEZQZmg3ejNWUFpQRFpZeTdmS2gwL0pj?=
 =?utf-8?B?NUc4NW9WeGUrU0oySWloaTlJaVdlYU9zTjZRWlMwM1FSVzJOc2pFSU1wQzNk?=
 =?utf-8?B?QzdWTHRwd1M2RnV2ZWJLbzk2a1FaRU1uNFdnV0FZNmRZWVR0ZTB4ZU0wVEZ3?=
 =?utf-8?B?ZDl2NkYxMHI1WDNTQmlmYWFhTGYrUkFNcU4vSC84WEtrK0JqcUV3M25USlJZ?=
 =?utf-8?B?akVKdmMxYlBOcDIxUnZkYWx5cDhibTkrVFFZNVdUQVdLcEI3aWl1MUx0OVF4?=
 =?utf-8?B?S1dpVlR1T0lFWS92VDdoU0ROazlKZEh5WEJaSjc4RFVYNEptNVBNN0xpdWJ3?=
 =?utf-8?B?UTZDTExaakRnbGpMTm5LcUsxT0plUzVaa01XZVBNQzliOStWTHl3cSsxYy9P?=
 =?utf-8?B?Wnd5a25BWE5CQVh1WldmdGNmNmJpUC9tNXJHcHNKWFdEWHlOTzRBQWp4aGpm?=
 =?utf-8?B?S1lnbU8wRUZhS2xqNGZkZ1pBcm1zNGZJaVk2Q2FISFlLTE9qeXFDL2xsOFRG?=
 =?utf-8?B?MmJoQ0dSdXVROU1VYWZwd3VoeXBiczd4STBnMVJXbUFLVFAwVjFuaFRaODdZ?=
 =?utf-8?B?NkVKKzNQZXF2d1VETVpGOG9sN3hUczN2QmhkbFlieXU1bFJEa3FPM2o3R0VO?=
 =?utf-8?B?ZGlQN3FHSFF4Nkk4djBiRTZhbFFHeHphZnNVYnhyTlAwcmtibEdqYzg4bWRY?=
 =?utf-8?B?MCs1MEdDQ0wxQnlSUE0vQWdFWDBJbWV6Q2xtUmdpWWdISGQrMWFtbG9tVFdG?=
 =?utf-8?B?bjlPSW9udnFVd2xYa3doNm9Ua3BobHZmNzFBalpUQVc0VVVoZGxpUXRrWTlh?=
 =?utf-8?B?SkxVNEg0UW90REh6M0s2TXc2aEpGZFBQeEVSWS9RaDA2T1BLN1Y3MHJRcGpO?=
 =?utf-8?B?SHJJaHY2UTdxN1RQcHptaW5lUkJpT2t3TnJIWHJBR09vYlBFdUFQMHhpVVF3?=
 =?utf-8?B?M0VTdW81Q1F2RmEzWHU1Qkp1aGhhdnFUNXVCZHJTS2plUXR6RUVpS09OaEVI?=
 =?utf-8?B?UWVRQ3pZS0VUT2IzbUZab3RqVUdvSTF0ZTdRTnpTTitVcjBkQnN3em83OERM?=
 =?utf-8?B?NksyNXVPTy82eXhSdzdnUXkvVjFpRkpnR2hZZjJXUHVTbUE0WFc1MXVpd1hI?=
 =?utf-8?B?UE9Dd2F2ZVEzNlFleE8rd2ZYVDVteUFDM29CMmRWSHZpQ2NVWnQwRGF1V3VW?=
 =?utf-8?B?TEUwc3FYTGZ0MlpHdVN4TlM0RXcvcFcvRXZ2QWxiUVVOQ0M1REtGeTkzNHhq?=
 =?utf-8?B?Q1g0UWFhdXoxNnJwb3lSOU0vODNPODJnNTNrNVJuUURXN2dXeEpBa1Vxa2F4?=
 =?utf-8?B?SkwxUnFzWEFqRERBT2xrOVRjL0ZTTmYzMUtqTUp0OFBnekRqUjRHQlZndWdm?=
 =?utf-8?B?elpSZ0E3dXVzZGNiQWJBYWNudjJuTWNaT24wUkF0SEJEVURSNlM2eG1IRFhB?=
 =?utf-8?B?R2YraWN6aWNsczI4Z1V5d284OTdiajZTNDg4eUZaU28yWnVjeUEza2tHbUhL?=
 =?utf-8?B?TVhwMk1BZytoSTZ2SmdNcmUwMC9UUmRLc0w5em42N1pjVWp1TGJBTnljc0th?=
 =?utf-8?Q?qMkgFL29IVTZLgi80dAB3au2a83Q5Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3AwLzFMTlgwK0xtcXhCY0VJNFdjemlRaHlxU1BXcXgrUGo1VG5KU2gwZlRv?=
 =?utf-8?B?Uy9BRHRNRVBkQ1hwSWdrTGRjSVh1Qk1xcE1sTkQreUdSaG1GQU9xaVZBK3ky?=
 =?utf-8?B?OGRhT3hyNTdpMm1zOUtYb3dFaitNWEtnMTZEZkNKblNYVzZQc2ZMN0VyRE1I?=
 =?utf-8?B?U0I1UTBQWjNOaW1jOEpMa083WU5KZ2lQYS81WXcwclQ2ZHU0K0JCem1pUFUr?=
 =?utf-8?B?V2V5bHBSa1ExVWVIRU5QZWlqZFZoUWN3d0RTRTVEZjdIT1pZRXovM3ROcVNz?=
 =?utf-8?B?dTFhRm91VzE4Z2dzTEw5OHEvQVliSTdBOFg3N1JWY3JOdTNpbHExdU1kZW1x?=
 =?utf-8?B?WU1NMjhpSHovTUFLL1ZZcUNpd29aQmFiRE9mNDZmZmlxSDlLWGVPdTRoNjUz?=
 =?utf-8?B?N2VlVkw3NnNCNzhwZDhlZGEwYURGZmMzSGdJaGp2d1BjaTlNbHExQTY4SDdy?=
 =?utf-8?B?NFc5eDl4WDdsQlgwNHJETXFOekF3ckJkc3pEamQwQ2MxelYwMU9ndGVlUTJF?=
 =?utf-8?B?VEJtSzJPUFErdTM3R1Fmc09NRVJYTTFpVWF1MjQ1KzVJU2lXOUZGYmFHWENx?=
 =?utf-8?B?dHl3YUkxSU5OcngrN2JEcWhNa0UvaW11dStuMy90aEVlQUZVaVZ3NVovNUtF?=
 =?utf-8?B?NzBFbWw5VkZDUkl2V3BQOGRTQVk3YWpCRkFLL3RNdUZEMjRJRkpaUWhpTmpn?=
 =?utf-8?B?dXZiNG82TnFBdWwwS3g3M3RJZ2xTMFhPUW1mckg2QkVOb2FmUExNYS9kTWVp?=
 =?utf-8?B?ZklVazlldnpEL0FVZWNDbVpBdHR0T0tqQmc3K2xXUGJ4RUg2WFRBQUU2ZXMz?=
 =?utf-8?B?UE9iSkpnRElmMWVtb3VNc09BcW9Pb0dTam9uZVVnOHZSZnBKWUZHaDRLQ2Ju?=
 =?utf-8?B?eThreTNwZmlmNHYwVlUwN2RQN29zOWRYaEtiNm5LR3k2OEhhZFNVUjMzN3BY?=
 =?utf-8?B?T3BOZmthOTdUcW9VVEtiZFduZzBjMUo0WDlWUWtRb2luNmpFclF5OGdydGp6?=
 =?utf-8?B?djV1VU5iRzdSNFBNcjRlWGxFVXlLOTJYRnRpalVGb20wdVJwdjlxaHY3Mnpx?=
 =?utf-8?B?ZkVmdnBBK1d5OWQwbldCR2Rucnc2dVdSMEsydDlCUSsvTExGQmhGa3dPMXZR?=
 =?utf-8?B?REZKSktMY3Y3bHBnZGVmcFo0cHRTVDFLSE1TclB0anF1dTc3L0NVSkFhdTVQ?=
 =?utf-8?B?ZG1uc2hHcWF6MWhSQkY5bWMxaGVxZmgvcnAvYU9rTHJUSWoxSk1rc2oxTzM2?=
 =?utf-8?B?YldIVmJzRkE2ZHpqWFhLdnVuaVgyUzk1YnJrSlk4aTJ1S3FOR3ptYU4ySUNl?=
 =?utf-8?B?TWtCSTlNdi9BZC9sM1M3SFpqNHpOMFpsYjZKNGdNcWZOamRjaUFFeHl3SWlr?=
 =?utf-8?B?NHZ5YVJJa0l6ZWxkb3FaSVVOVWVrLzIyQldudlJ5TjlWYUJhdEpRZjhsN0Vw?=
 =?utf-8?B?WHJoK0JlajUxVHBFeEd1T2wxR0xlY0VSOUVDbFkxSEZPZmtQTG0vcG51ejd4?=
 =?utf-8?B?NVpmRXVmTVhESTByU3ZzbTgybTJHaWNMWkswck1DVHR5cmZRNjBuaE1QTmEz?=
 =?utf-8?B?Y2t5eHk5M1hFako5d2lkMDU5OWRvSEp4TytFKzhOekM2WWpNWTJ3NXUvNEFl?=
 =?utf-8?B?cEt1RDlQZnEwUzNjWkFIUHpXakE5ektpNFkrdU5qSjZReHhEenZJYnVmT2pv?=
 =?utf-8?B?MDBmcGI5SVVUcGQwVXp0RXVtNEdaTEJVUFNGaGxib3Q1WEc0ZDZ5aXNlUSs1?=
 =?utf-8?B?VkVqWlV3QlJmOHlXQ0xyaDB5Sk40QUVjRmhxZ0I5SFUvUk9zSG1aZkRCcnUx?=
 =?utf-8?B?NGVFNmM1T2JHR3VUd0x2UURPSVB0MnB2VE1JQ211dmJ6bU1IMDNDY2Y0TE0x?=
 =?utf-8?B?OEdnSTc4V2NxTGZodVR4K0JKdy85Uk1XUE5pbzRVcUpsTXJLZmdwK1VXOVh2?=
 =?utf-8?B?Q2M5QWdOdEtwNFIrM1QzWFB0MTFYdDZ0WVhMRkg2NU91ZGJvZGdLZ0NtMDBG?=
 =?utf-8?B?V0trME1mV05iM3d4YmNBa09EOFFLNTJ6Z1lMYXJ6ZHlNdzB2QWR0Q1MwZ29o?=
 =?utf-8?B?a0psWGdZdWNNR0o0QStNR0FLallBeWkzL28wK0FXVTlUNHRUUzdKWVlBQ1lC?=
 =?utf-8?B?NWI3SE9pbHhQNVFlbHZpSmtmajd0RWxiY1VyUU5IS0UvZE9IdW5ISllUVFFB?=
 =?utf-8?B?U3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c15039-2004-4474-324d-08dd7d00f896
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:08:48.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq1YxMbqZ7Qu9b0B2kXnNFNGNDOs6BuO31sTIyPkGyZmrXeT5j4YPHuMOOCYZS9D5GUb/ycTO3OwXYMcl0WiQyHPX6g2No/G8uZ4LcxJAHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7801

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE2IEFwcmlsIDIwMjUgMTQ6NDMNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2OCAwNy8xOV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgcmNhcl9jYW5mZF9zZXRybmMoKQ0KPiAN
Cj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgMiBBcHIgMjAyNSBhdCAxMjoyMywgQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBBZGQgcmNhcl9jYW5mZF9z
ZXRybmMoKSB0byByZXBsYWNlIHRoZSBtYWNybyBSQ0FORkRfR0FGTENGR19TRVRSTkMuDQo+ID4g
V2hpbGUgYXQgaXQsIHJlcGxhY2UgaW50LT51bnNpZ25lZCBpbnQgZm9yIGxvY2FsIHZhcmlhYmxl
cyBvZmZzZXQsDQo+ID4gcGFnZSBhbmQgbnVtX3J1bGVzIGluIHJjYXJfY2FuZmRfY29uZmlndXJl
X2FmbF9ydWxlcygpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4g
UmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+
DQo+IA0KPiBPbmUgbml0IGJlbG93Lg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNh
ci9yY2FyX2NhbmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZk
LmMNCj4gDQo+ID4gQEAgLTY3Niw2ICs2NzIsMTUgQEAgc3RhdGljIHZvaWQgcmNhcl9jYW5mZF90
eF9mYWlsdXJlX2NsZWFudXAoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ID4gICAgICAgICAg
ICAgICAgIGNhbl9mcmVlX2VjaG9fc2tiKG5kZXYsIGksIE5VTEwpOyAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyB2b2lkIHJjYXJfY2FuZmRfc2V0cm5jKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3By
aXYsIHVuc2lnbmVkIGludCBjaCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBpbnQgbnVtX3J1bGVzKSB7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgc2hpZnQg
PSByZWdfZ2VuNChncHJpdiwgMTYsIDI0KSAtIChjaCAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2
LCA4KTsNCj4gPiArICAgICAgIHUzMiBybmMgPSBudW1fcnVsZXMgIDw8IHNoaWZ0Ow0KPiANCj4g
VW5uZWVkZWQgZG91YmxlIHNwYWNlLg0KDQpUaGFua3MsIHdpbGwgZml4Lg0KDQpDaGVlcnMsDQpC
aWp1DQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5i
YXNlLCBSQ0FORkRfR0FGTENGRyhjaCksIHJuYyk7IH0NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lk
IHJjYXJfY2FuZmRfc2V0X21vZGUoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdikgIHsN
Cj4gPiAgICAgICAgIGlmIChpc19nZW40KGdwcml2KSkgew0KPiANCj4gR3J7b2V0amUsZWV0aW5n
fXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBn
ZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRo
IHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dCB3aGVuIEknbSB0
YWxraW5nIHRvDQo+IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0
aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGlu
dXMgVG9ydmFsZHMNCg==

