Return-Path: <linux-can+bounces-7907-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RG+YAJuJQmqN9QkAu9opvQ
	(envelope-from <linux-can+bounces-7907-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 29 Jun 2026 17:04:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97C6DC6E5
	for <lists+linux-can@lfdr.de>; Mon, 29 Jun 2026 17:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=XhwGz3xD;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7907-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7907-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5377B3063608
	for <lists+linux-can@lfdr.de>; Mon, 29 Jun 2026 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7E42315F;
	Mon, 29 Jun 2026 14:56:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB63BBFCC;
	Mon, 29 Jun 2026 14:56:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745017; cv=fail; b=OJ9TgIh1ymh0mGUZJtkhpQArWOEqI4nvtx4NCPu1+3hCa3Vzh+xO8zFldE8xvic2RNxFf5hs/rYIer+5iNwIYr/cyoDIkcWpVVR4Ipei9dEQIFw3MowhFSH3qBGaDwB/fkIlvI+v8Uuaui2wLEwd90B9FL+96ytHjc+3vEIyX3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745017; c=relaxed/simple;
	bh=c8YpYpKDemrijthntApjbJISzNEUwQuiOD2MVEsX7Es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPvaofE7pKFE3sBcB8+VrQg+QYRwFsP+69x+bmEuw3+/ibzI1AHyMle9MacKd/31mwmlSCaMlN92gCGCvtkiProc69zXnvbKFyc0+5KYCZFsZSmZwT+h6P1BiQRiok0gW6QX3NwsIQngMZ/d/uqFyG7Vpyj1ThToF+8yHBT8Gm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XhwGz3xD; arc=fail smtp.client-ip=52.101.229.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGN3dPL2mWEm6yOkrHaRaR1ah4uqTwXHpiD7L6rM4qN32ALE3mDo4xzl11Ff91TKnnmzT1OFKtmW9ekOHAEqF0js9WyxUfyDyC7Yi4i4zDGWQZvKb8l80y0T0LW/Bz46osSsWmK+rRwXWwQdYd46a0OI1EiJGA9utQtWDkJ5+AIDm9ME364fklqIzLUvVVK/pPbD/N3t2k8S1LBo1Z0Ya7fseythgcxt/LkY8w8I9xEbbB8YzaKskI+w1imQRhTd4xc524iy6pp+QLdbRJ9Taj3VlQ5Cjdgo9RvpZlLklNExF5KmcP8r0ELH5O6oXk/UM6XwJFImM5FAYnuDidODfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8YpYpKDemrijthntApjbJISzNEUwQuiOD2MVEsX7Es=;
 b=dp9sSNkKAtzvX1ZuKZDIin9xeaFDUnq4buyAYZ/86t0OsUSsF5BCSUDu3gZs0D2+xns/40Mj1v6l4HIuqiF3+1lbOYowZcqLc+maSPRzk+2kBtQBgZ2aEc3rlN/zuM5Bv/RPiqF4LLf5QqTLqqmAex2hVtYfM9Jeftls1nVk+VHTFmDcoQKabUNV7bIApr2Zoq8CK54kpA7vp6lQKlMQO/xNr8pqEktBvZqLPnTrXWHsWKS30Z7yWvI1MGfP8ub6bcojDInCZ/bddVyMhieDf9qBGdQlMJQ58KmaoIwBgvQaDaxfy7Uhje5hySEibf2DWgCJT/pBMRjOd+CXc4xj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8YpYpKDemrijthntApjbJISzNEUwQuiOD2MVEsX7Es=;
 b=XhwGz3xD3bJjOSMuBPOviXjzEnNgK603Php5Yl5QEOpI4HIA4/wEgrHSojHClygsZfkE1LnVfCuUG/vT4RKvfv4xyofVJfJtwiPxkBp7YgSjkSWdbfz7EyAbevx/2TRDR7sBjKkSSZzBnQdGn8QeUAzOUecBROkuwoY7mZJsFIM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB11877.jpnprd01.prod.outlook.com (2603:1096:400:3fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:56:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:56:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, magnus.damm <magnus.damm@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Tu Nguyen <tu.nguyen.xg@renesas.com>, Duy Nguyen
	<duy.nguyen.rh@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Topic: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Index: AQHdBKnahRscR7xhqUa4HQBpTADRvbZVoiwAgAADQhA=
Date: Mon, 29 Jun 2026 14:56:51 +0000
Message-ID:
 <TY3PR01MB113464C6B94A6A3533A365BE686E82@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXF_2HiWosZfsm=wVUN7C0ow5eFtOczQAoTzsNKDw_+Dg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXF_2HiWosZfsm=wVUN7C0ow5eFtOczQAoTzsNKDw_+Dg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB11877:EE_
x-ms-office365-filtering-correlation-id: 6e0b1e68-a429-49dc-bc21-08ded5eea754
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|22082099003|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 IWBtqagPKWf+WQFglYNG5nFALxixyCIE3mChtlSJjOzc2uxFZuOG6U6fioIPJTCoIkHVAAj/KHj8WyqHeV7fVsai0id+VAYpRR/aFw17yyf7ngM48kj8jt/90/XC5KRS+AN+kA0xe+782bqZuja5lGg8AP0GRO15DSgWaK+avmqJXS3ChpzCRmEpL5iCNKaEOR+gFvHF5do2ZYLakRmUJB07+TI6wyPGQ7SU71G+6qzLs1MiaCjpbI9RAvuClLh6z+UVii7R8XiQC6xUFUCCtHeaOb7h/6+AwbjCzX8bVm1FtBLjI3FPrO7/caPtbAvFsCgsUvStRKwlHXi/87+68SP2GuEKwsIa9pcNsQ1tanhadnYuriQ7tLiwTckd1YFfUIXnQGsaQz9GD8VggwnTzm0YmHfPIxIaKSw3N1GyiUEA5NiJHK884d49lhzMiTwmJ0/NtYXNBX8bxYBlXcdm1I0A1VxpeJ2RZOQAa318Nnapw/TTfvXyo3astC48/vGzAqZUJjbaB3mBClxITPG9rt0Uo4GxJPbf/hZhmOeg/tazOCs6Kc4vgVJ9HySLdTWajB852Bu5t/5v970/c0qfKcYJ0pQg2GpLmTIA/MqtfTBYYp36CmUtJAPmo5OlsS+rXE90CV1XBsWDS7XN7XqNSCkcuWO2E/IlS7cSx3ZbTiwG2RUw7Ars5R4L+Rep5mNg+D6ZOKS8twtV6kmZb/9gD9sQnj55KPwTxAL+hfF0NoU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um9VOTRBUWExemtyUWk1RzRKdWZVTDJ5RzlZM1EyU0tHckorMG5FSzJHT0lD?=
 =?utf-8?B?QlA2MVYrakpDaUlPY1FOd0VudmprcDNBaytJN3BMa01McVJ3L3k4YVdseGgx?=
 =?utf-8?B?bzQ3Mm9GK3UxRXVmRDJqRHhJL0J1S1ZCQkxKVkw1K1pFTTU2MitaS1dUaWpi?=
 =?utf-8?B?emhvNzgxQW9IZ1JtY0xVNW5wZEoybE5kNmsxTFovcDNrNmZYaEN2ZzRWK2VZ?=
 =?utf-8?B?V2NucUZkUWZwYTdSUm1FTktxd21FSmY4QlhtV2N2MmlBU2FQaHZhMTFJL3oy?=
 =?utf-8?B?VGhLNVFQSmhXT3VONEo3L3NiNTJBMWovZ0kyNzRVek5nNXdLbWhlMnZTSGV0?=
 =?utf-8?B?MkNYckg3STdzMllpeXFEQkxYd09mV1U1cFdyZEhoWXB0RXVlWTJ5TXdGWXhU?=
 =?utf-8?B?S1RXZ0lrVlltTWJJbU1qU3R5alJ6QzM2U3FIR1dNZDZFQU1jKzdTSFIwUDVM?=
 =?utf-8?B?d0FaUnBZU2NGTFYvTlZ0ZjlOUVVLRElTc2RKenpJWXcrUVZPVnkvNlVFeFVv?=
 =?utf-8?B?THdUajJKWmVma1Q4V20vYU4ybFBvY0lINDB5L25SK25pams3WlhTWm1teW1v?=
 =?utf-8?B?ZjlabngwZTR0SXp5bU9sVzhoU0RtYkR6UTNRd1FheWxUZ3dLMkUwVnVZV05a?=
 =?utf-8?B?M2NRUEF2akM2ZzdodHZqaHJRb0VDSk9sekNWNktOaEVENTFHdnpkOHFiN1gr?=
 =?utf-8?B?L3MyVUJFaUJKWXU3bW5jRXovZkphQU1Dc2pXOThwa1NSV2pLbUtYTFAwR244?=
 =?utf-8?B?UzIxbXplVUo5ZHJNOFliT3VRMThPOVZnRHIzYklmczFIVVZoWHg4aTRkQjM4?=
 =?utf-8?B?N0YxbStEKzFrL0hnZVlveUl6UTFrS0w3SkE0OC9xeXFaV3IvbTUzVldMOGkx?=
 =?utf-8?B?aXpNNGRPK3BOdEtUcElyZ2xtWDFhZzRLVlM5NWdrbnNudGtZbXMyK3RReFF4?=
 =?utf-8?B?RVJtTkpXTGRFR05MRkd3NGI0ZlRLTkdMU1BMM3M5VDlaQ1M3dkhJRmdvMUJk?=
 =?utf-8?B?cWNqTUh1cFNLTjlEbzBvTllLSkdUV1lVQ29kaWVJRTN0eDNQc3pVWmtUVFFK?=
 =?utf-8?B?YmZ0SmJVRWI0am1iZlIxdFE2M2ZBNDlsVU5Cbi83Ukd2MEk0TGlERlVOWDV2?=
 =?utf-8?B?OE5kcEhtTHpFeThqSHUrM0ZNYUc1dnhNaU13Y3NNK1RieFVjYlVxSy9RQzl5?=
 =?utf-8?B?TCtVdkFhZDFod0QxY0hEaVZZODE2ZXhwVWVmRW8yWDdtYWxIazdZUmZuTmJi?=
 =?utf-8?B?a0RYeUEyT1hoWnJNVHhoUnhzd3MrNEk0OTRZWGMrcTIxTkNMNHVnKzhURjl4?=
 =?utf-8?B?am5OM2ErdFdJYUR4ejhZbDRwYTRXOGdWT1dPYlJ0SU14M3BSY0Z1cG5hblZP?=
 =?utf-8?B?THROVTVhOWlCYldZWVBHWmh6c3hueGs3N1c5N0RFaDlnUXJtTm9rdTBkbWVP?=
 =?utf-8?B?RDNmQmcxVyt6UGx6Y2ZxVE5rNUxFWGl4V0FyMkp0cSs4eHVKRGY2d0NVUDQ2?=
 =?utf-8?B?UWlGTnFJWUdGY0IxSlV1dGRJK05RTzNhdXQxaFMzVDBSZ0luTFllSlNvTWEv?=
 =?utf-8?B?MytmTzJlcmpxTHRtc2tXMjNFcmJ1dXJmR2NDWUNDOHlJUStnRkxpd0F2U2hK?=
 =?utf-8?B?dEIvdlJwU0RvVTgvZlJKb0tQQzlmbVZ4WElOTTZVbXBGNTFYR0liT2c0dkNB?=
 =?utf-8?B?L1BUL2lyOXlrenMyRVNxaklsalFyeVlzVWt6SGR6S1hOK0wvTVp1MmNhMWlp?=
 =?utf-8?B?QjZ6QUpGM3h1cEhpMnFFUkJMY3k1cGoxUjNRN1dIS0ZvdklGSVpuL0haeCt0?=
 =?utf-8?B?YkIyLzZMWHNPam5mY0E2NTRqSHBwOVB2MVBJOW80ZTh0ODR6RFhpK2YyNkds?=
 =?utf-8?B?cFdOWDNJL09vMDlDLzYrYWQ3VzBBYmRYaTRmdmhYWkxUNCtIRmJxZHQ2ay95?=
 =?utf-8?B?QnJWakZmNDNJNWg4T2xTYnFoTS96WHlCM1JTQk9MekxVVUxOV2ZQaDZlYjNJ?=
 =?utf-8?B?NnFkYzNtaFhsQ05ZZ3BVTDhxb0wybWVHeVMxeE0rNzhLckIxUmxwYUxvS0sz?=
 =?utf-8?B?V0hKaGNHZFpvVzNOSk9ocWhwMFZENXJieWFkUlg5UGk5K012eXA0QTdCK1lm?=
 =?utf-8?B?bzZLSXRTMVFKVWpWM1A5Q1N3TlFEUGZaWDIxWWIwNU5FbHpFUVlCdHFEcVFy?=
 =?utf-8?B?cCtQM1hDdkF0Q1ljRWs3bVZhV3dqeC9IYjNtamcrUitYMFhNYUVucmdCbzFU?=
 =?utf-8?B?czJyWGZpcHQwUjJTYlY5NEhOamFZeUdDTDdoSHRHbCsrMTJLVklDeHJ3QlZm?=
 =?utf-8?B?czVVMEpRSDdnZzBORmJPM2oyaHNRWXAxd1RZWExZcmJoV2IrazVwQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0b1e68-a429-49dc-bc21-08ded5eea754
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 14:56:51.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPANn/TLZxAGrrbAbg92+WiKWDTnBpw+7t69OiDu7RKem7voK+yoDZHvLNK8vBYwVR+H7WeRSXuh+atNpcuD27MeMZl5xgVXmNqWLbgJ/qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11877
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7907-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:geert@linux-m68k.org,m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bijudasau@gmail.com,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[linux-m68k.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,renesas.com,bp.renesas.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,glider.be:email,linux-m68k.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bp.renesas.com:dkim,bp.renesas.com:from_mime,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A97C6DC6E5

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMjkgSnVuZSAyMDI2
IDE1OjQ0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogcmNhcl9jYW5mZDogQ2hhbmdlIHRo
ZSBpbml0aWFsaXppbmcgZmxvdyBmb3IgY2xvY2tzIGFuZCByZXNldHMNCj4gDQo+IE9uIFRodSwg
MjUgSnVuIDIwMjYgYXQgMTU6NTIsIEJpanUgPGJpanUuZGFzLmF1QGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gRnJvbTogVHUgTmd1eWVuIDx0dS5uZ3V5ZW4ueGdAcmVuZXNhcy5jb20+DQo+ID4NCj4g
PiBUZXN0aW5nIENBTkZEIG9uIFJaL0czRSBzaG93cyB0aGF0IG1hbnkgcmVnaXN0ZXJzIGRvIG5v
dCByZXNldCB0bw0KPiA+IHRoZWlyIGluaXRpYWwgdmFsdWVzIHdpdGggdGhlIGN1cnJlbnQgZmxv
dyBvZiBkZWFzc2VydGluZyByZXNldHMgZmlyc3QNCj4gPiBhbmQgdGhlbiBlbmFibGluZyBjbG9j
a3MuDQo+ID4NCj4gPiBCYXNlZCBvbiB0aGUgSFcgbWFudWFsLCBjbG9ja3Mgc2hvdWxkIGJlIHN1
cHBsaWVkIGZpcnN0IGFuZCB0aGUgcmVzZXRzDQo+ID4gZGVhc3NlcnRlZCBhZnRlcndhcmQuDQo+
ID4NCj4gPiAgc2VjdGlvbiA3LjQuMyBQcm9jZWR1cmUgZm9yIEFjdGl2YXRpbmcgTW9kdWxlczog
UlovRzJMICBzZWN0aW9uDQo+ID4gNC40LjkuMyBQcm9jZWR1cmUgZm9yIFN0YXJ0aW5nIHVwIFVu
aXRzOiBSWi9HM0UNCj4gPg0KPiA+IFNvLCB1cGRhdGUgdGhlIG9yZGVyIG9mIHRoZSBpbml0aWFs
aXppbmcgZmxvdyBmb3IgcmVzZXRzIGFuZCBjbG9ja3MgdG8NCj4gPiBtYXRjaCB0aGUgaGFyZHdh
cmUgbWFudWFsLCByZXNldHRpbmcgYWxsIENBTkZEIHJlZ2lzdGVycyB0byB0aGVpcg0KPiA+IGlu
aXRpYWwgdmFsdWVzLiBBbHNvIHVwZGF0ZSByY2FyX2NhbmZkX2dsb2JhbF9kZWluaXQoKSB0byBh
c3NlcnQNCj4gPiByZXNldHMgYmVmb3JlIGRpc2FibGluZyBjbG9ja3MsIHNvIHRoZSB0ZWFyZG93
biBwYXRoIG1pcnJvcnMgdGhlIG5ldw0KPiA+IGluaXQgb3JkZXJpbmcuDQo+ID4NCj4gPiBGaXhl
czogNzZlOTM1M2E4MGU5ICgiY2FuOiByY2FyX2NhbmZkOiBBZGQgc3VwcG9ydCBmb3IgUlovRzJM
IGZhbWlseSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVHUgTmd1eWVuIDx0dS5uZ3V5ZW4ueGdAcmVu
ZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQr
cmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBBcyBDQU4tRkQgb24gUi1DYXIgZG9lcyBub3QgaGF2
ZSByc3RbcGNdX24sIHRoaXMgcGF0Y2ggaGFzIG5vIGltcGFjdCBvbiBSLUNhciwgYW5kIEkgZG9u
J3QgaGF2ZSB0bw0KPiBwcm92aWRlIG15IFRlc3RlZC1ieSA6LSkNCg0KWWVzLCBJIGFncmVlLiAN
Cg0KQ2hlZXJzLA0KQmlqdQ0K

