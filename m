Return-Path: <linux-can+bounces-3099-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96CA630BE
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 18:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D589174FA0
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D141F7089;
	Sat, 15 Mar 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kDj4ldJ4"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010029.outbound.protection.outlook.com [52.101.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1E18B0F;
	Sat, 15 Mar 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059761; cv=fail; b=Wx4s7DvFUS4h0P70bvYAkcOMeqKj+iOHdjg7lzrgG2MrkzpVB0QuhUuJqcb7zU8z34zO6CGcUNHdKkx4UB+ioDCm4DCM1SstKScJcrsElnaDDta1PUUXcYtPKXShYPSmHMHPwCYT/g6Twg8dm3EfEowZgvUq//Ure6fU0rS7cog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059761; c=relaxed/simple;
	bh=NYqtkfkWnByBIhAkyE7rXo85mMxIs1QvUu7bXib2JfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bRAaAWrfewE5MczfBdMsh2L9X82BSdsMO7y04eripF0MJ3kmjfE+qOpBKWKjbUYeI6bngktacHtZXC9ngLR9uSLK30Kd6jSxprXTaGfWgmUqqJy/L3CSslMOZmmMS2y5qd6jJLNclGPdc3r5UdT5JKdigdPswOv3JXwiHUWAB3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kDj4ldJ4; arc=fail smtp.client-ip=52.101.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBKpceqOalj4gxyAWqiz1mDEaB3c0WGS85su/w/nKv2yqpmM1AHm/ISk+73VZJrx2NEmne8fc9/EqRiUouFPIuOpL4TZmhTMFlVtnSKdN53El+KnmPkXjrX6TC0qHX5D5IJ7mhSYp2J7UF42z3FWzRMP3JwsMwQ4elMXN4G2ZkFzxRWW0OtsHqAnDm2wLz8J9Z0RklQjnF+HEhPIpkpJf3SD98IKiLLtF2bm8SxAfzv1UrSnUKZ54bhv4u97WT79ZOMeE/dA+MPrKziTTfqHLu20pt8rGq0AYjb1crUvqZRJHiyNYv9tpBMzH6dwrq90//LC1AsGJRO1XewzMpS15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYqtkfkWnByBIhAkyE7rXo85mMxIs1QvUu7bXib2JfM=;
 b=VwvEtw49sb/Kyd+IU6ZpgJ6Ckf+OINeXMdV88mrGYiTnOQWSxbExSLx5FSSpiLDjH4TKpm+SbUmpuA2nH7JvaS72dGmNdYc8nnhsdBIgFdPQ9awNHp+uqDEXSDsjMcQKGv2KkPyuvOTfFM+kUpTi8QKcHFSOCnC6xRBqmNj2J0yawqTIxoNFQz7/AZ5Akb4PUIVIYMymM2GM0mGRHROvNeHqJ8agXiMtR+1xulo0xGQn4/9QGZoHNmTeTxQnaJoFX0fktgX52OrnBvdQ4zJtbXz+0jOje/N0tXU4TxVZHaT7FTm/nuXF7W3B0TBd5KYsP1rBGxG2wnI65kOOLj9Aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYqtkfkWnByBIhAkyE7rXo85mMxIs1QvUu7bXib2JfM=;
 b=kDj4ldJ4Bg3XWpRllf0g6CwIBHIJQQ4OQrARUwuRLi4ZcRjRoyvs3GtH7E/IbEGXgvjaTLHdqneTf+2d+Cxe0LRdnFaoFu3pgNYLJ45yvsxMYGTE3Sr26nJ6bnEJgXORLhN0gwxIjXFYuxw6VfBBuvY8ujL6y+bBSdD8+FdFSmA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8193.jpnprd01.prod.outlook.com (2603:1096:604:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 17:29:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 17:29:15 +0000
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
Subject: RE: [PATCH v4 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v4 07/11] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbjpVeWOCgoO/bB0m+87kyqkPDNLNywtmAgAG+xVA=
Date: Sat, 15 Mar 2025 17:29:14 +0000
Message-ID:
 <TY3PR01MB113469E1A11F43D9F404210F386DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-8-biju.das.jz@bp.renesas.com>
 <CAMuHMdXwNH-3AUe=CvONFxGfw3a1pATU4vTRqxX3xvk7K1yGjg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXwNH-3AUe=CvONFxGfw3a1pATU4vTRqxX3xvk7K1yGjg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8193:EE_
x-ms-office365-filtering-correlation-id: e74680bd-a251-4981-65a8-08dd63e6e870
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmF1UWJndnRjcnFXS3hTQ0xXMWs1alROeDhDZ1B2TUowdHZKZTIyMXY1bzV4?=
 =?utf-8?B?U04vQWs3UVpQSHRuUXliZzZxc3VxSFVZeGRpVGF1cVA3RC9zRVhIZ2N1K0ZG?=
 =?utf-8?B?bWEyWVBPSXJhZWJieVRvMFlXWVczY05xd3NoVTJHN2NBUjF2T3VqOEdENzlr?=
 =?utf-8?B?Yjh5RGFvV0lYbEdmT2Y5VHFrbmN2OWNxZ0IwMkRMSlF4c0VyZEIvYkVCUnpt?=
 =?utf-8?B?akFtakd5QUVpQk1YL1pVTWlxU2NsVlRlcWxGa2hQTmJSWDhRa21rNjJxZzlZ?=
 =?utf-8?B?SWtEVDZvM2FBZnlyYlg0bi9UK2F4WmJzRkZydFJHd2g1d25iZThIZTFJZ1BE?=
 =?utf-8?B?L0dvWWV3RFFHWStNbEtrelhOeFFQbXZKT0FqdE9ZZjJsb05RcGFtSDJJVytL?=
 =?utf-8?B?OVZoUmJjRVgycUpEdnpVS0pxSVI5eHBGUVRPRnMrZXdZdlVIWWtWZWM2V2pZ?=
 =?utf-8?B?RmZ3dEFHS0sxbHFFMTNpTjVMSWw0b1hxN0Q2OVEwckFydkhOVllhSktlYUQ4?=
 =?utf-8?B?Tnovc2xmUEZ2WnpDam5WaXdsMHhKYnlVRmtzZDVFWkxQUXNYVTFXOWxRQWVS?=
 =?utf-8?B?SGV5bTJ3N3h1VWlDSFdrOTY4UjZ4UDNmUkloK0xBNFdOK2NLZHhnaTI5TlAz?=
 =?utf-8?B?Qnd3VXdWTFg3cGYzUU1NUUwvVkFCdHZ1Wk10dkI1ZzZCSnpldEtaVlNoMHQ4?=
 =?utf-8?B?dHorQzFlUUpLWm5pLzV3bjVpQUNDUmpaYjdKWmJVa3FHVlRQVjhFVW03K0Rv?=
 =?utf-8?B?dlVDUndHTG1ScEY2b0czWWQ4SXhWVGtNNzJ5UU13U3V6VGdveGpDU1paclBl?=
 =?utf-8?B?VHRKZFI0QTgwSm9jeWpxK09VdnNrOU9zL2VPMk5WUWFDSHZXNFpjL1hhVkFT?=
 =?utf-8?B?cldsV2Qxc1QvNTM1Q3NKeHcxck0waHlVRWxzai9DRGRka3o5dmR0d1RtaGtX?=
 =?utf-8?B?RHk5a0NDbGRaODNiZCt3R05qaDhHVGFRNWVURlE0UkYvSFhxTG5YZUdlcWZq?=
 =?utf-8?B?Tm4vTTcySG5RNHVmdkdhczdyeGRZZW8vS2x0N1FoNk54TjlhckpTY1hDVC9s?=
 =?utf-8?B?b2hlMWJIeWpwTTg0MHdZeXFudkkyVmVMZWJEN2ViekNMZ3JPbXp6b0U0TkZT?=
 =?utf-8?B?TWt5K1czZlpEd1BIZjlualNob3hCdmc1M3VVSFlJWEx2N3U0a1VOR2prenNB?=
 =?utf-8?B?VEFML1NzbytJcnFZQnNsMGZVWllteFBwNzJQT25LblVDZ0xkWFljL25GNGRN?=
 =?utf-8?B?UzhIbFBmaDZrNEdlUlF3aXhpZ2d5OVFiWEZBY0tOOGFvaittazdudFZrVmtR?=
 =?utf-8?B?QndLNWdUUWZXRmxQQWJZS0d4SmZjOHl3WC9vem81WnJtSDVpQVplWDh2WVpG?=
 =?utf-8?B?eUg3dG50ODdmZDlKR0JuNWhkclJUZnNURk14RXo0aE9wUVF6eHM3T0dhNmtW?=
 =?utf-8?B?VHVqMm5EZElRTGx4WjNXbHBUTWpzS1NZc2JDTmNKY01RZFc3NkRrbHQ1ZnhG?=
 =?utf-8?B?YTkvSEVTbHFmN1JYWE1rVEpxcGVYR2o2aGRyQ0ZuUTV3YzZmYUU1N0R5UFJ1?=
 =?utf-8?B?WS84bHFjMjNrcFBOZUdjQ2tzN3pEd1dzZko2Ny85bFcvazlhM0lkWnhkRUU0?=
 =?utf-8?B?Y0xwMEpGM1ErdnNOMGMvbm5xTEJ5eTJiU0tzc0xFTzA5V3dzVEk1bDQyL1Bw?=
 =?utf-8?B?SHFsb01FdGs2b1FSeDZuYVJHZ2F2d0k4V2doNVREaHdUekY3eDVxcy92Rjlq?=
 =?utf-8?B?NGVUUVkvNTRWTkxLTGo2UERZUDgzYUhQNk4vRkFDQUtkQWtkQXNjMmxMRGxN?=
 =?utf-8?B?dGlCc3BXZGdkQkkyWVJMK1VYUnJmZjJGZXpFU3ZMc3VVTkxWcVc4dDllblJI?=
 =?utf-8?B?VnlMb0Faa3J2elNZbzltKzJFdU5acW5lQlVHVTdOWU5Vem5kV0xOY3c5T0Ro?=
 =?utf-8?Q?PgivLIxt0JtJeGL+NFeSVA0E7LpWn9RC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjZDbDdreU1NcjNOSldZUkZPVnh5WTFVanRTSjV0Uy9xSzcwY2tUdEI0MUpk?=
 =?utf-8?B?YTNHOTMrNXlEVjV4QjZZdHV3T3Z2eHNidmxtcnVDQUxhclZaSWh2SmFWY0I4?=
 =?utf-8?B?MVZpOGg3bTJROHZlTXhSK25JN0ExOXdjbjY5NXZ1NHNHdEtlaEVWZFhQRjRs?=
 =?utf-8?B?L2JTQ0kwelFuQU95T1h3RkVyYzhxdDBlazhZY1MrK0xLbnJ3V25OUXI3VzRL?=
 =?utf-8?B?TWxjbkFpcDFBa3FOdkoveVJPQmYvNGFwd25QYXVBVmhXaVQrOXBxWE1RQWR1?=
 =?utf-8?B?Um9OOWtmdExUaGZtb216OHdVa3dObEhucDVsTGh4QWE1c21tMnRMZnlkOGZp?=
 =?utf-8?B?QlpsY25rQTY2di9Hek5ZaWprbWZEWHVucVFNUVRNbHFWMzRyTTlWSDhwLzdk?=
 =?utf-8?B?VEU3ZEpGalNVYk92SUFHL0V6NnlNYzZFYnJQakJFaWpMM0JweDVPTzEyT2VX?=
 =?utf-8?B?V0JWdmluQklEMTNVcHI4NWVBV2F5M2x6d2JzZXI1SW02TldJUUdMRUwrTVY3?=
 =?utf-8?B?SWdCeVJHUjJnVEk3eVQ5VktwUGtYejd1NlZaT1M2NmI3MmdTdGg0OFc3R0Fs?=
 =?utf-8?B?SHp5N3NmTGdSblJvYlZBUXpUQTM2STZldkR3MjErK2lBcVRCN0s5LzBDcGgv?=
 =?utf-8?B?cU5TaHVtZHRVdm50UjBYT1B3Z0IyeTBpWWdrRkYxWmhORjRUdzJIcFdCeWg3?=
 =?utf-8?B?MGR3N0ZPUmhub3dxdjA0VVlOUS82UDJOMEMyV0hiQ0JHSWVYNXlxcFdHbCsw?=
 =?utf-8?B?LzM0MzQ5d2Z1MXRDT2szTEUyZG9TRDRxQXphaytkS2V5djhWNkNaajk2KzZL?=
 =?utf-8?B?SEwwNzlUVy9mN05rb094bkYvaVBIS2FwSGpuRUFwMzdNWTQvUGFSVmJnZEt1?=
 =?utf-8?B?Vy8wKzVzTDVOUE12YURObkVTNXhEZTVzdE03aEJ0ZjhOQ0U1N0JLZzVFQXZG?=
 =?utf-8?B?Qi9kUEdYdWNlNkVLTk92eTZzazRwMjJCWFZJMVdJdy9DaE9xYTFPVGcxeXpw?=
 =?utf-8?B?ZHNPdXZYMHFOc0RsNXpOcHBuQ2NvcTIvMmw5NURXUHdyZHhuUHdRMm9vbU5q?=
 =?utf-8?B?ZmIyaGlSUFNXZ0pSbnU3a0hsWDFtMHVVNXhwdkZqbEJjRE1PSmJVajBYUk9w?=
 =?utf-8?B?TFlDZkFoQUpRV0IxYlJIa3BkcXdzQ1pEaDBiTElRZkE0REJiZTlydVk0bkdX?=
 =?utf-8?B?YzRsZVg2N2RKN0RGUjBTZGp2QTRVTjYxeHJrV0J2MVovSGRuMFRvZEpKQ2tW?=
 =?utf-8?B?ekIrVVZmMkNlZk12RXlkN1RNMVIxWTIyYnNEaGppRGh2b3l5dmlLMmhlSnJ4?=
 =?utf-8?B?aHJuVC94dkw5N0c0MGNJQ2gzNk5vY0JaQlB1bjhBd2d6cFNGbTNEVVBJR09y?=
 =?utf-8?B?Sks5UVlzelFFK1gydGhjNmpVU2JVZ1dnNDVZUlIzZjhmTU1PMVhDczRKWVpG?=
 =?utf-8?B?ekt4d1ZVWHNpZk8vaFJsY2xIdmo3MTRaMG1icWhPK2R1OVRqUk1wbmpRd3Rn?=
 =?utf-8?B?cFFlTlk2L3kzb1RSYnRTM1l2aXlhejVHSEVrcnd3SGFYTi9tRVJnczM4WmhR?=
 =?utf-8?B?K09mYW1GV2FRKzRTcTdyWFREYzM2Ukt0czhGQU1ib29xZWFscjhia1FPSWkx?=
 =?utf-8?B?ODBOQlNKRVdOdVhMV201aStKUmJqTDk2bDhQZjJmY0lTSEVROEc3WW1RamY3?=
 =?utf-8?B?OFFyWmtHVUpTNFl0QUllaHFMYjB3MEFHM013UmZQUGxlTUJWdDNJaFhTdEhZ?=
 =?utf-8?B?U3FxL2w2V3kxMnQrTlNGcWFnd0traU92KzZnVHdGd2x6VzVIZ3EyMjdsalp2?=
 =?utf-8?B?Z05VUXBOZmlRMTN3MlV5WnZVWlppR0VTWm5FdkJCV2I0TnYxUlVkL3NmN3ZK?=
 =?utf-8?B?aEZYV0VoSENtbzZpQnlYVnNWOEhZYzJubEFjZlNaQUh6VUlYM2U2UjlLVkdR?=
 =?utf-8?B?SlQ4Yk1WeDllVkVLclQyaGRJT01BRkRDMDJkUGZWZzZXQmY5RlJWR3VxTUdj?=
 =?utf-8?B?K0hRVjdiYm5LM0JKWWpDeHdRU3RCSTVzR0QzdXI3cVN4VldSNUV4OFo2NG95?=
 =?utf-8?B?QS83WU55ekF6ZnFTVzZMaXV4WGN4UVM3SVgvcnFSVjlHZ2kvNHJITXhHK2N1?=
 =?utf-8?B?Mi9Lc2piUDhGZGN2WnpQSHZvNDJGU3VHbTBzcWluRmt6SDNZUWxoT3FsVW40?=
 =?utf-8?B?OGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e74680bd-a251-4981-65a8-08dd63e6e870
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 17:29:14.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JX5WRYyn6btyUhQgouwIFff2Jk7yzozogxvx3vJW6L2ERGaHecXU6SzEzax+jOydjgkxEO1SO8y27D0gcSFyDajefG8wg50wWuIfTOkn/2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8193

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTQ6NDcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwNy8xMV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgbWFzayB0YWJsZSB0byBzdHJ1Y3QgcmNh
cl9jYW5mZF9od19pbmZvDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBh
dGNoIQ0KPiANCj4gT24gVGh1LCA2IE1hciAyMDI1IGF0IDEzOjQzLCBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMgYW5kIEdlbjQgaGFz
IHNvbWUgZGlmZmVyZW5jZXMgaW4gdGhlIG1hc2sgYml0cy4gQWRkIGENCj4gDQo+IGhhdmUNCg0K
T0suDQoNCj4gDQo+ID4gbWFzayB0YWJsZSB0byBoYW5kbGUgdGhlc2UgZGlmZmVyZW5jZXMuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+DQo+IA0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT4NCj4gDQo+IFN1Z2dlc3Rpb25zIGZvciBpbXByb3ZlbWVudHMgYmVsb3cuDQo+
IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC04MiwyNSArODIsMjQg
QEANCj4gPiAgI2RlZmluZSBSQ0FORkRfR0VSRkxfREVGICAgICAgICAgICAgICAgQklUKDApDQo+
ID4NCj4gPiAgI2RlZmluZSBSQ0FORkRfR0VSRkxfRVJSKGdwcml2LCB4KSBcDQo+ID4gLSAgICAg
ICAoKHgpICYgKHJlZ19nZW40KGdwcml2LCBSQ0FORkRfR0VSRkxfRUVGMF83LCBcDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgIFJDQU5GRF9HRVJGTF9FRUYoMCkgfCBSQ0FORkRfR0VSRkxf
RUVGKDEpKSB8IFwNCj4gPiAtICAgICAgICAgICAgICAgUkNBTkZEX0dFUkZMX01FUyB8IFwNCj4g
PiArICAgICAgICgoeCkgJiAoKGdwcml2KS0+aW5mby0+bWFza190YWJsZVtSQ0FORkRfRUVGX01B
U0tdIHwNCj4gPiArIFJDQU5GRF9HRVJGTF9NRVMgfCBcDQo+ID4gICAgICAgICAgICAgICAgICgo
Z3ByaXYpLT5mZG1vZGUgPyBSQ0FORkRfR0VSRkxfQ01QT0YgOiAwKSkpDQo+IA0KPiBSWi9HM0Ug
ZG9jdW1lbnRzIG9ubHkgRUZGIGJpdHMgMC01Lg0KPiBJIHRoaW5rIHRoaXMgY2FuIGp1c3QgYmUg
cmVwbGFjZWQgYnkgZ3ByaXYtPmNoYW5uZWxzX21hc2sgPDwgMTYsIGVzcGVjaWFsbHkgYXMgdGhl
cmUgaXMgb25seSBvbmUgdXNlcg0KPiBvZiBSQ0FORkRfR0VSRkxfRVJSKCkuDQoNCkFncmVlZCBh
bmQgd2lsbCBkcm9wIFJDQU5GRF9HRVJGTF9FRUYwXzcgYXMgaXQgaXMgdW51c2VkLg0KDQo+IA0K
PiA+DQo+ID4gIC8qIEFGTCBSeCBydWxlcyByZWdpc3RlcnMgKi8NCj4gPg0KPiA+ICAvKiBSU0NG
RG5DRkRHQUZMQ0ZHMCAvIFJTQ0ZEbkdBRkxDRkcwICovICAjZGVmaW5lDQo+ID4gUkNBTkZEX0dB
RkxDRkdfU0VUUk5DKGdwcml2LCBuLCB4KSBcDQo+ID4gLSAgICAgICAoKCh4KSAmIHJlZ19nZW40
KGdwcml2LCAweDFmZiwgMHhmZikpIDw8IFwNCj4gPiArICAgICAgICgoKHgpICYgKGdwcml2KS0+
aW5mby0+bWFza190YWJsZVtSQ0FORkRfUk5DX01BU0tdKSA8PCBcDQo+ID4gICAgICAgICAgKHJl
Z19nZW40KGdwcml2LCAxNiwgMjQpIC0gKChuKSAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LA0K
PiA+IDgpKSkNCj4gDQo+IEFsbCBvdGhlciBtYXNrIHZhbHVlcyBhcmUganVzdCB0aGUgbWF4aW11
bSB2YWx1ZSBvZiBhIHBhcmFtZXRlci4NCj4gRS5nLiB0aGUgUk5DIG1hc2sgaXMgdGhlIG51bWJl
ciBvZiBzdXBwb3J0ZWQgcnVsZXMgLSAxLg0KPiBTbyBwZXJoYXBzIHN0b3JlIHRoZXNlIGFzIHBh
cmFtZXRlcnMgaW5zdGVhZD8NCg0KT0ssIHdpbGwgaW50cm9kdWNlIG51bV9zdXBwb3J0ZWRfcnVs
ZXMgdmFyaWFibGUgaW4gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mby4NCg0KQ2hlZXJzLA0KQmlq
dQ0KDQoNCg==

