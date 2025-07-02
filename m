Return-Path: <linux-can+bounces-3930-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1549AAF107E
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E6F1899624
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0124EF8C;
	Wed,  2 Jul 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lYY/Ap8J"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4824DD1F;
	Wed,  2 Jul 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449598; cv=fail; b=Leqv2iAjivRfAJbz9VataK4LQRW8SMKQsYpNVzJ5xkFlQs3/W1Isg6YA1UhTC8XxdE+bWUV12/cIuimayqcGA4qvlKCIm3zhKVQhJv23XBWSydp+I/RSTYN5tKRhOAUkCKSwNR03b/pUhRvm203Jk+eGmfxDyIYcnlrQpHANq7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449598; c=relaxed/simple;
	bh=WiMTKcDeOhQy6EomnFeaZpLlFz75v5dMGRYKjTtfmi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrnZioxFyUjxc6p+KjVinSbRcGTJRq70nbRa1mPxBgPL6hDMrE2+vbisnpspasuJ+rUD4bQbC9x2SzwFADXOs53CZNdKu8BWSMqf8iwYcnt/TQyt1Q2u1u4bImKxFFtHGuLBTjazXa76g4CPQ8Hvb6dVCoJShrBH55Jtxg2Zd6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lYY/Ap8J; arc=fail smtp.client-ip=52.101.125.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRQIlxc8C62VcFYzuG9/TS3qG5uP3dju9Jv2syON/xT8Al30ERKIju1Onj2SGlXmrQmtRb1/3vwV5+P2cvzgi9Uy5iCcsgziABw2M9XzW0y0k39siixlZ1OaRmF1vezs7CfK5YRwAZ/JBZAdRUWPqV6zqlKCn6WlG0qK/7ueQo+RVhQot1AIPf+CocxUCxw7heC+xbgkGmVSoMw2o8Xt9T2pwOTqElnuUkAGUdqjWfmfGv2rHXEWJg/Oyr/KgIYtjKpJHKRi6BKFP/TOx5guAXTpseVMCddqycQkSPCWVbzN6KTowvJ/4Hbf8XCdwTLr0GnvTZksRGG2CU2uWMADJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiMTKcDeOhQy6EomnFeaZpLlFz75v5dMGRYKjTtfmi8=;
 b=pn/PVo9ddoYXMtSA2QX+FOjxgWZ1VE2Q8Aja5Nd1fyktbsoBaoB7NDxL3rgMbkXTks7VTWOc9yKAWEpGhPRU578vmsW1rvngKD5mO4+aEk9lljBwRzoGAdBkr0F43nvSNBJlWhIPAJ31kYioxhmAypsETl4FqdiZeIAOqdnotDXUgd99ix0J7ecLCSHg2LfEMmvPdq5LDN6BXAFNYNFGkVnV44IyPQU48ZjfF1cdHKdoFjZkzN2veNTMnkDEwD5w7HjUPdfIzf7Z9k88LA0GgdG9lcU/A+E/1pnSBk3qOGJWLwQ8pVCf0w/PrrNzh45W3KM7eCcVYa1xRE9SwEtHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiMTKcDeOhQy6EomnFeaZpLlFz75v5dMGRYKjTtfmi8=;
 b=lYY/Ap8JXCibUEx7slY8X/R8Q1WtRSyWq46FZu6KlGLRxmfZO6YdJ+/rYLbjsyqrwc6E6MXidu6OPpOj6yFdTZiG/LuzLkVfKli3IL5nR3fT4uoyuUNT77NyjbUNmEe/Ao+d+k8RJExqHGUr7pRZe4jrNUc6ccAgNt0lAlifHDc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7773.jpnprd01.prod.outlook.com (2603:1096:400:17a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 09:46:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:46:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH] can: rcar_canfd: Drop unused macros
Thread-Topic: [PATCH] can: rcar_canfd: Drop unused macros
Thread-Index: AQHb6QcZAMGsFD8KbkOy5jLau1TaSLQedkYAgAAiHDA=
Date: Wed, 2 Jul 2025 09:46:29 +0000
Message-ID:
 <TY3PR01MB113463762D1EC916BDE1B7BA28640A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXK9ZBpgPSE32Zya-nVBXQw25=2-g5pnixjFOoyOkrrvg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7773:EE_
x-ms-office365-filtering-correlation-id: 85feee09-fbdb-46bd-9fa9-08ddb94d5203
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WURrS1NLRDJsL3VtanZBRDNuOWtVNG9tK25EWXZmMmJKeHNoZ21IVzhQNkUw?=
 =?utf-8?B?cXVmdWJCTWI4eG9RU2NhclBHTHFEcUpDYzRBWmR3V0MzUzM3d2NmS1R1bnVC?=
 =?utf-8?B?U2dQa09iU2ZQNi9vZmFhcVNQdGIvOUFJNit6VWxOYnU3ZXJ4cmNxNlgza01z?=
 =?utf-8?B?MnZmSE14dXNCK1dydVA0ZWcyWnRUaXlXWUFmOTJpTENZbHBNUVNxMnh1c3Aw?=
 =?utf-8?B?YlNRaDZXbE0yTnR4ZWhYZFduaklzYWdRY3ZjL2d4a2poT1NJdFljMVRoMjZR?=
 =?utf-8?B?MnFnSzZwM3JtcFFYNCtDS3RaZHN3QWpWOGNwQWl5ekRUbW1zYnJtVjFEbmNY?=
 =?utf-8?B?M1JNeElMRW1GRnlMZU5Hb2lScGxBL2RBbXRXd3V3TzRtYkZyV3c4MEN4RzdJ?=
 =?utf-8?B?UktGVzNwaFdWK3JtanVZUVV0TDBiODdlUE1zWjBnZTI5N3hWdkRVN2xGTGhP?=
 =?utf-8?B?NXZwR0FiV3BOdjlqY3k2RjhDV2djL0xOSUthUFJGQ08wb094L1VVTVh3dEdo?=
 =?utf-8?B?a0hHT3o0NCtuanlKb0tTSVZLaFNDbEk3aHY0ZFk2cUxyOUs2MXdzc05sSkVp?=
 =?utf-8?B?dHlpNEIzNG1HWmowbERhTS9NN0IyNzdPa1FnK0NTOWZGUkd2R3JGQi96ZXRZ?=
 =?utf-8?B?WktZWkpJMTN0TldWRFNyc0pGS09QNGd5Vk5UbllYdDBodHV0SWRJNmFyV3B0?=
 =?utf-8?B?eVY2UjJRb3pRYkhRL2g1WGxyUU9zSTlwcm1CdTduNG5lTVhJaXV1M3BsaEph?=
 =?utf-8?B?QmxGN3FIa3pPck1hcHBwK0U1aFRFYmtvNXZSZlJIM3NGR3NRZ2FtOEkzUU5l?=
 =?utf-8?B?OVllWFE5N3praXRscHlVOWhBQ2J5UlBQbXdhQjIzVFNmZ3ZHNDFNaTAvT3ZF?=
 =?utf-8?B?bk9rcXUyUXo4OVZzZElFVWtMam1LOUs2Z3E3Rnd4cjgzRjBId2dpaW4wZlcx?=
 =?utf-8?B?WmUrb3I3Zk9tbHpIQks5azI5bUZ1ZzJVME43MXJ6ZXNuWVRKcUNtYkM1M2sv?=
 =?utf-8?B?ZVA0TkMzYXJzazh2cC9LdEVYM3pOWnlVSUlHeEZON1VJRVRQeDkwZk8wRk5E?=
 =?utf-8?B?bDI5aE1aS2VMcFllRHdxTmo5eXlIMXRlZzc0UVd1QUM5ZGh3VUdld056NWJX?=
 =?utf-8?B?bmZNVVhBZUdvSEJUNTNmSjliRUZUdHQ1OVJCNlVKSU5rME9kZ29RcDNpRXd4?=
 =?utf-8?B?MldyaUkwcnJuRGl0MmJ0alBmd3BLZ25SS3BVNy80VGZiRmZZeG5FdjJEZWVK?=
 =?utf-8?B?dlE0VzFlTXpqTThVNW5KbTlUMitpOG1LL0gwVzFJSmhzMHBJSCtHcFRIVWtK?=
 =?utf-8?B?QmY1Zk10NnUwT09xUExwSlhCVkRTa0RQY0Vla2pGajI1Wm5hTUdTQ3FZY3pi?=
 =?utf-8?B?ZXgwYjl6bWdTQUtHeGwyaHF1a2ZrNGtkVC9BdnNzbDB4amk3d1VoRmZDTTFM?=
 =?utf-8?B?cll4d0cwY0h1eVpTWUI0QUF5Vzg4N0k2VlNhUlJIOUw2Y0praFJwU1pLajFy?=
 =?utf-8?B?OWQrc1V5UmpiZGM4Y25YeXgzSjNHL205Rk9NcEVkaTFqYlFNU0E0emtMVWlu?=
 =?utf-8?B?elB1VUZPQk1QQldOWFdNU3RJN3UxRGlOZm1YNXF6clRFRGxodkNFR1cvK1Av?=
 =?utf-8?B?NEVXZG9teDZlYVNDTXIzQTBjUWo4c1FqZ2lYcWEra2wwdGhPT2JNRkhNdWV6?=
 =?utf-8?B?ZXVRNUp1WWg2MWpiN2owUkhYV0E0NForSnpYNmhWemxZbEhyejQ5RDBwdDBL?=
 =?utf-8?B?UUVnMW1MMDdXZ3lma0RZdlJaWWhmZ2tmOEpDVCsrZWtVbnQ5dHgvVThscGh4?=
 =?utf-8?B?V2hqQk9rdWl6L1RBLzkwZ0F2UDlZQ3k1NlJjdHZySHVyRlVDUDdVd3MxQWlJ?=
 =?utf-8?B?TnVhaWxkWmRWQXVBZE54OVQ5SkFBcWxGNHp6VGxoa2xwOENuQTRSNWVXQXR2?=
 =?utf-8?B?bGNxc1J3U2NaL3N2VG5OV0laU2Fmc0RPMXdpU3NQSCszaWVVVXFMVThtYSt6?=
 =?utf-8?Q?xOCRXPHLHYbttj69C6xO2fnPcEKaBI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGdNUHMxWDNCUlZJMTdjTmRWN29jUjRsaUc4ZHQ3U0JoY1ROZGRrYVBySlRy?=
 =?utf-8?B?elBnVWM0TzRiWjBla1VpUHR5ZmZkbHorZzY0OGNjRzlQMWtaRnIzazB2TzBz?=
 =?utf-8?B?YVdSc1RCanh5eW5CSjJ5Z1grbWI2ZWtCQ1d2Z2ltUDFRZDJLaUg0RmpGOSt6?=
 =?utf-8?B?c3BRNmJHM1VCaXhyeFdKd3lUeGJ6ZWMxT2RDNW9VNS83cjFqZVFlb0N2OURj?=
 =?utf-8?B?L0ducDFCNjNPcmM0YUZEbXVDTUd4a2dOV2ZUWElSb3ZEdE9XTkg1Ukw4cG0v?=
 =?utf-8?B?RnFoSFhteDYxM3g2c0J6anpkcHlQUDNITUtzdG4zWEthTE9MSEFOUmNIZ0xp?=
 =?utf-8?B?TzVid2hweHFsUDZTTTk2ZGhhbGZncjdkTDN2VFNjL0R6bEtyeVdSUDV6dms1?=
 =?utf-8?B?QlRGNjRwOVZYSm5WRTdqSE9DLzBFSHNGMkh1YThibTNUYU4zdXc2WERISmlN?=
 =?utf-8?B?T2pLSlB2MEtQTXhPUTdKNGppdDBRV0dYK3cxalJMQWdydEwrSk01blB5SExE?=
 =?utf-8?B?SDBmT1hzNWphNUxiM2FPcXE3WVJYalNkZ1NWaGJzMHhzWDNHd1F6TlpKS2Ft?=
 =?utf-8?B?RjFFNHVZUnZCQzgxdlBaNnpmbFZGMG5iWHdMNmdrdWlHTnAxQU93TERlZjVK?=
 =?utf-8?B?blhFTEJjTjh5RWRncURJRFNDY0dtdlQ5bWNqd09MUFRPUUN1STNSR1phUVll?=
 =?utf-8?B?V202UUxYYTJUZmhkK09TWnJXVG4yUWdIeEIrak1La0ZpOVpjeENoMytvMTMx?=
 =?utf-8?B?Y1IzSG9JcXRsOW9sV1I2RzJ6cDZGQnVuWWhON2JIOXF1ZlM3UDhOYnNuSDRT?=
 =?utf-8?B?cUZZR0UyajJPY1VQaHRxNTlra2MxK245ekRpWjcwQU1RME1hNHFpSG8zeWxn?=
 =?utf-8?B?TkdCWkgva1FXUUgrQ2pEZ2J4TFRjU0tXbTFRbU9Vd2Exdm1MWGM5WWdyQndX?=
 =?utf-8?B?Z2JvUEtwVVVyTWl4QkN1UE5CV2NCdlpvWEhUanFLc3U0dXB3U3VubEdiSWwz?=
 =?utf-8?B?OG41eDFsNEJHYm5rZlVTZzlHZjVheGY5ZnJoMWIrQWFCVmduOEpkd2Y5dUgx?=
 =?utf-8?B?d2ZzK2xZampmcGRJSnp2Tm43emVyb3RpTXBYN2wyWW9VcW8rTzROVWJhTXh5?=
 =?utf-8?B?b1JOa1ZhV09ZaDhBZ2daY1N0MWgrZS9ySE11dk1vb2ZKSkFKQWJ2UHBTRkVk?=
 =?utf-8?B?d2Nwa3I4V3FDSENUK09mcGp5NVpHd3lHUC90OEx5MU1vdzlQbkZqNzA4eVhQ?=
 =?utf-8?B?dkRJSG5PVHdZYTlVUXpjb1gxSEdPdVBYUTRYUStHUHU0QjBGekZ4cmJJcDhp?=
 =?utf-8?B?TWljcHNrT2xLOUl4N3dZM2N4TkcrTVZzd0MzQ0JYSGJaNlIzNW0wbUlQeE5U?=
 =?utf-8?B?eHN5MDlzQ29NOS84R2RKZjl3bmZxSWtxM2NUckhYZDZUbVJsY2lQTkhrY3d6?=
 =?utf-8?B?bWMreDN4UURURm50RnV2QmhQenptR3duT0Q5YWdpVXpORXdRbWR4ZTYvTjh6?=
 =?utf-8?B?UzhieUFvb1MrTGJmcURSdlpVdy83ZE5ka0dmb1pIV1IrNVN4S1A5Nk84T2VZ?=
 =?utf-8?B?QUtuTytNakZwb2tvcS9YWFVCRWR6NXlLQmpBbnFlbkpWdG1Ub3d4UlpLSkNC?=
 =?utf-8?B?U2xyUXRNVHVhZjR5K3RnU0E2MmwwTW0yVlNlWGJTby9FbzJ4RlY0TDJPL29Z?=
 =?utf-8?B?ZkZsT1U5OWQveEE2bHduWTJ5R2RJNmYzak5HUjRJK0FCRUFwK0M3RGMybFFi?=
 =?utf-8?B?TVpaWnpvcFduQ2cwZFkrVjF0dFhORXlWVGRzdWQrN04zZkk5SzRiZmZjNHlP?=
 =?utf-8?B?Zmw2ZlFQdXg5TysyMFFRb1hYNHVseGQzaWhQSzBmYVh5bXk1aC9ZZmJOcFQ2?=
 =?utf-8?B?MXlhMDJDTWlDVU55UFVQc0l0ZXB5YnVWUHU3YlZaSVVhOUk4bmk3OVorSWkr?=
 =?utf-8?B?Mkx5TDBpNG5CYXBzZloveEU0alExTCtuVTIvQVFwWUY5V1VLWnNjbGdhenoy?=
 =?utf-8?B?Z25qdGFNSWRic1RKcEEvUWhrZXlXTU5JSVhsMEdlRktRZjVsTUV5RGdjbVo5?=
 =?utf-8?B?Qmlnc3gyc0h1UUI5N3V0YUJlNlJRTm9yTDJBMFpqelk0WnhHaFJmbVNEYTZO?=
 =?utf-8?B?d3dsVWd1SDErSlc1Qlc0NG5IUmRwazdYdXBYNzlIaDhYTzA3RHoreVJ6dXdp?=
 =?utf-8?B?Y3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85feee09-fbdb-46bd-9fa9-08ddb94d5203
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:46:29.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tK0bkD/D++qm3VbA17+EoSQDVJ5umxkswHTev7AwDw/02cArZ1k3nzKjJtgLqlux2kWpA69IRoPTCdF+NbTP2hl6coSayYa9fuYQU68H+b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7773

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDAyIEp1bHkgMjAyNSAwODozOA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBjYW46IHJjYXJfY2FuZmQ6IERyb3AgdW51c2VkIG1hY3Jvcw0KPiANCj4gSGkgQmlqdSwNCj4g
DQo+IE9uIFN1biwgMjkgSnVuIDIwMjUgYXQgMTc6MDQsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRHJvcCB1bnVzZWQgbWFjcm9zIGZyb20gdGhlIHJj
YXJfY2FuZmQuYy4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBWaW5jZW50IE1haWxob2wgPG1haWxo
b2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiA+IENsb3NlczoNCj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvN2ZmOTNmZjktZjU3OC00YmUyLWJkYzYtNWIwOWVhYjY0ZmU2QHdhbmFkDQo+
ID4gb28uZnIvDQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9j
YW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBAQCAtNTEsMjUgKzUxLDE3IEBADQo+ID4gICNkZWZp
bmUgUkNBTkZEX0dDRkdfRUVGRSAgICAgICAgICAgICAgIEJJVCg2KQ0KPiA+ICAjZGVmaW5lIFJD
QU5GRF9HQ0ZHX0NNUE9DICAgICAgICAgICAgICBCSVQoNSkgIC8qIENBTiBGRCBvbmx5ICovDQo+
ID4gICNkZWZpbmUgUkNBTkZEX0dDRkdfRENTICAgICAgICAgICAgICAgICAgICAgICAgQklUKDQp
DQo+ID4gLSNkZWZpbmUgUkNBTkZEX0dDRkdfRENFICAgICAgICAgICAgICAgICAgICAgICAgQklU
KDEpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0dDRkdfVFBSSSAgICAgICAgICAgICAgIEJJVCgwKQ0K
PiANCj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIHJlbW92ZSBhbGwgc2ltcGxlIGJpdCBkZWZpbml0
aW9ucz8NCj4gVGhleSBzZXJ2ZSBhcyBkb2N1bWVudGF0aW9uLg0KDQpZZXMsIHlvdSBhcmUgY29y
cmVjdC4gSW5pdGlhbGx5IEkga2VwdCB0aGVzZSBiaXQgZGVmaW5pdGlvbnMgYW5kIHJlbW92ZWQN
Ck9ubHkgcmVnaXN0ZXIgb2Zmc2V0cy4gVGhlbiBJIHJhbiBtYWtlIFc9MiBkcml2ZXJzL25ldC9j
YW4vcmNhci9yY2FyX2NhbmZkLm8NCnRvIG1ha2Ugc3VyZSB0aGVyZSBhcmUgbm8gbW9yZSB3YXJu
aW5ncy4NCg0KSSBjYW4ga2VlcCB0aGUgYml0IGRlZmluaXRpb25zIGlmIGl0IGlzIE9LIHRvIGV2
ZXJ5b25lLg0KDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBAIC0xMjEsMTUgKzEwOCw5IEBADQo+
ID4gICNkZWZpbmUgUkNBTkZEX05DRkdfTkJSUCh4KSAgICAgICAgICAgICgoKHgpICYgMHgzZmYp
IDw8IDApDQo+ID4NCj4gPiAgLyogUlNDRkRuQ0ZEQ21DVFIgLyBSU0NGRG5DbUNUUiAqLw0KPiA+
IC0jZGVmaW5lIFJDQU5GRF9DQ1RSX0NUTUUgICAgICAgICAgICAgICBCSVQoMjQpDQo+IA0KPiBD
VE1FIHdpbGwgYmUgbmVlZGVkIGZvciBhZGRpbmcgbGlzdGVuLW9ubHkgYW5kIGxvb3BiYWNrIHN1
cHBvcnQuDQo+IE9mIGNvdXJzZSBpdCBjYW4gYmUgYWRkZWQgYmFjayBsYXRlci4uLg0KDQpPSy4N
Cg0KPiANCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0NUUl9FUlJEICAgICAgICAgICAgICAgQklUKDIz
KQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DQ1RSX0JPTV9NQVNLICAgICAgICAgICAoMHgzIDw8IDIx
KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9DQ1RSX0JPTV9JU08gICAgICAgICAgICAoMHgwIDw8IDIx
KQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DQ1RSX0JPTV9CRU5UUlkgICAgICAgICAoMHgxIDw8IDIx
KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9DQ1RSX0JPTV9CRU5EICAgICAgICAgICAoMHgyIDw8IDIx
KQ0KPiANCj4gSWYgdGhlIGRyaXZlciB1c2VzIG9uZSBvZiB0aGUgcG9zc2libGUgZmllbGQgdmFs
dWVzLCB3aHkgbm90IGtlZXAgdGhlIG90aGVyIHZhbHVlcyBmb3IgZG9jdW1lbnRhdGlvbg0KPiBw
dXJwb3Nlcz8NCg0KKyAxDQoNCg0KPiANCj4gPiAtI2RlZmluZSBSQ0FORkRfQ0NUUl9URENWRklF
ICAgICAgICAgICAgQklUKDE5KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9DQ1RSX1NPQ09JRSAgICAg
ICAgICAgICBCSVQoMTgpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0NDVFJfRU9DT0lFICAgICAgICAg
ICAgIEJJVCgxNykNCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0NUUl9UQUlFICAgICAgICAgICAgICAg
QklUKDE2KQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DQ1RSX0FMSUUgICAgICAgICAgICAgICBCSVQo
MTUpDQo+ID4gICNkZWZpbmUgUkNBTkZEX0NDVFJfQkxJRSAgICAgICAgICAgICAgIEJJVCgxNCkN
Cj4gDQo+ID4gQEAgLTE5NiwxMyArMTY5LDYgQEANCj4gPiAgI2RlZmluZSBSQ0FORkRfRkRDRkdf
VERDT0MgICAgICAgICAgICAgQklUKDgpDQo+ID4NCj4gPiAgLyogUlNDRkRuQ0ZEQ21GRFNUUyAq
Lw0KPiA+IC0jZGVmaW5lIFJDQU5GRF9GRFNUU19TT0MgICAgICAgICAgICAgICBHRU5NQVNLKDMx
LCAyNCkNCj4gPiAtI2RlZmluZSBSQ0FORkRfRkRTVFNfRU9DICAgICAgICAgICAgICAgR0VOTUFT
SygyMywgMTYpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0dFTjRfRkRTVFNfVERDVkYgICAgICAgICAg
ICAgICAgQklUKDE1KQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9HRU40X0ZEU1RTX1BOU1RTICAgICAg
ICAgICAgICAgIEdFTk1BU0soMTMsIDEyKQ0KPiA+IC0jZGVmaW5lIFJDQU5GRF9GRFNUU19TT0NP
ICAgICAgICAgICAgICBCSVQoOSkNCj4gPiAtI2RlZmluZSBSQ0FORkRfRkRTVFNfRU9DTyAgICAg
ICAgICAgICAgQklUKDgpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0ZEU1RTX1REQ1ZGICAgICAgICAg
ICAgIEJJVCg3KQ0KPiANCj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIHJlbW92ZSBhbGwgc2ltcGxl
IGJpdCBhbmQgcHJvcGVyIG1hc2sgZGVmaW5pdGlvbnM/DQo+IFRoZXkgc2VydmUgYXMgZG9jdW1l
bnRhdGlvbi4NCg0KSSBhbSBPSyBmb3IgcmVzdG9yaW5nIGl0IGJhY2suDQoNCj4gDQo+ID4gICNk
ZWZpbmUgUkNBTkZEX0ZEU1RTX1REQ1IgICAgICAgICAgICAgIEdFTk1BU0soNywgMCkNCj4gPg0K
PiA+ICAvKiBSU0NGRG5DRkRSRkNDeCAqLw0KPiA+IEBAIC0yMTUsNyArMTgxLDYgQEANCj4gPiAg
LyogUlNDRkRuQ0ZEUkZTVFN4ICovDQo+ID4gICNkZWZpbmUgUkNBTkZEX1JGU1RTX1JGSUYgICAg
ICAgICAgICAgIEJJVCgzKQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9SRlNUU19SRk1MVCAgICAgICAg
ICAgICBCSVQoMikNCj4gPiAtI2RlZmluZSBSQ0FORkRfUkZTVFNfUkZGTEwgICAgICAgICAgICAg
QklUKDEpDQo+ID4gICNkZWZpbmUgUkNBTkZEX1JGU1RTX1JGRU1QICAgICAgICAgICAgIEJJVCgw
KQ0KPiA+DQo+ID4gIC8qIFJTQ0ZEbkNGRFJGSUR4ICovDQo+ID4gQEAgLTIyNCw4ICsxODksNiBA
QA0KPiA+DQo+ID4gIC8qIFJTQ0ZEbkNGRFJGUFRSeCAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9S
RlBUUl9SRkRMQyh4KSAgICAgICAgICAoKCh4KSA+PiAyOCkgJiAweGYpDQo+ID4gLSNkZWZpbmUg
UkNBTkZEX1JGUFRSX1JGUFRSKHgpICAgICAgICAgICgoKHgpID4+IDE2KSAmIDB4ZmZmKQ0KPiA+
IC0jZGVmaW5lIFJDQU5GRF9SRlBUUl9SRlRTKHgpICAgICAgICAgICAoKCh4KSA+PiAwKSAmIDB4
ZmZmZikNCj4gDQo+IE9LLCBhcyBtYWNyb3MgbGlrZSB0aGlzIHdpbGwgcHJvYmFibHkgYmUgcmV3
b3JrZWQgYW55d2F5IHdoZW4gdGhlc2UgZXZlciBiZWNvbWUgdXNlZCB3aXRoDQo+IEZJRUxEX3tH
RVQsUFJFUH0oKSwgLmUuZw0KDQpPSy4NCg0KPiANCj4gICAgICNkZWZpbmUgUkNBTkZEX1JGUFRS
X1JGRExDICAgIEdFTk1BU0soMzEsIDI4KQ0KPiANCj4gPiBAQCAtMjk4LDE2ICsyNTYsMTAgQEAN
Cj4gPiAgI2RlZmluZSBSQ0FORkRfR1NUUyAgICAgICAgICAgICAgICAgICAgKDB4MDA4YykNCj4g
PiAgLyogUlNDRkRuQ0ZER0VSRkwgLyBSU0NGRG5HRVJGTCAqLw0KPiA+ICAjZGVmaW5lIFJDQU5G
RF9HRVJGTCAgICAgICAgICAgICAgICAgICAoMHgwMDkwKQ0KPiA+IC0vKiBSU0NGRG5DRkRHVFND
IC8gUlNDRkRuR1RTQyAqLw0KPiA+IC0jZGVmaW5lIFJDQU5GRF9HVFNDICAgICAgICAgICAgICAg
ICAgICAoMHgwMDk0KQ0KPiANCj4gTm90ZSB0aGF0IHJlbW92ZWQgcmVnaXN0ZXIgb2Zmc2V0cyB3
aWxsIGJlY29tZSBhbm9ueW1vdXMgZ2FwcyB3aGVuIHRoZSByZWdpc3RlciBvZmZzZXRzIGFyZSBy
ZXBsYWNlZA0KPiBieSBDIHN0cnVjdHMsIGNmci4gY29tbWl0IGFiMmFhNTQ1M2JiODNkMDUNCj4g
KCJjYW46IHJjYXJfY2FuZmQ6IERlc2NyaWJlIGNoYW5uZWwtc3BlY2lmaWMgRkQgcmVnaXN0ZXJz
IHVzaW5nIEMgc3RydWN0IikuDQoNCk9LLiBCdXQgcmVtb3ZpbmcgdW51c2VkIHJlZyBvZmZzZXQg
aXMgbm90IGFuIGlzc3VlIGF0IHRoZSBtb21lbnQsIEkgZ3Vlc3M/Pw0KDQoNCkNoZWVycywNCkJp
anUNCg==

