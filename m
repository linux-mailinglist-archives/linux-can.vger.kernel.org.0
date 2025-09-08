Return-Path: <linux-can+bounces-4512-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737DB48A74
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127CC3C5887
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC542FABFE;
	Mon,  8 Sep 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TG3Y7AuR"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011061.outbound.protection.outlook.com [52.101.125.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F32F99A4;
	Mon,  8 Sep 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328129; cv=fail; b=khSJvbsWq10w+INgtSZlvTJ9R9X/YiB7fAzcirrByYd/f4gUarSUGOo2WO6U8LF7UQEMkDNWHRypv5EU5EQ/DS9+0j4bUgCR5uz74jZ2pSaweegI4VroGEQxqvzkEzKgkgdsRUF0dEvhktoWGzYvvBZHuVzu5jEyqK2XylhVJSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328129; c=relaxed/simple;
	bh=3qQJgqrbC8cYW0SJh43gcpMjyJROhbmz7MAcVS4aoIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KUQbtS28e6RCq04PfFT17VHQ4PWSZH2yIxSuS5h8+JU/6ZcXynH2PbtOEF8zUempDRE/mSThye9SXrMuRUYcooV5LkPZZr4QmbYbc93gjfRsmPuyyPc0wPGQU9qkMUwC4TLeOmTvu0M5chAK4/58g6WC7nnYyJ2tuphAt3Bilzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TG3Y7AuR; arc=fail smtp.client-ip=52.101.125.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hby7GHUANrJB35Z0oWQ6BgYg5d2Vkv8mgPM7INggrzG4VWCmRKoRaRw/fXtkSmT9hxU85QI/Fdsrm8kSnUKW3XlS0QnltwTGnAbW02roNWZDiCPIgxkGwlZ2LglBErVqxdndX8r3o/ENHBceDq60ERYiW2LS2a4rZOIbLk0nBekn6IJf3gDc5RA0Pwxz9MWu2E3/qfkAfCFXRtLcUFlk8jezgolFPkfSSrfrtVwbBQlnqeOZ599XxMa75altscLghbMt9OtOgqVLwrbwzere0NqVlOIu1wr10pTOmYU0lIBb/ud7tdSCeDNz0C9OoKpST9EkhUSMVyJuX2FtkP1kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qQJgqrbC8cYW0SJh43gcpMjyJROhbmz7MAcVS4aoIw=;
 b=ppNd/kfJgSsaPpWX3JraAk+0Tk5TO1QcUZmhNBS/h+4OBEQYkr7BCBj+jeVV+yuge+ionTVVe3sDGbHBOUVCgkK36KnuZGVBicQA9orkM9llyrrF4w8ejjEyCeBaeCOfOa/S/1kBO32QHseX9cCF111oKCpKzbDEYYf1DS9nxqQJwVbc0JaipucqH1tNdpvI72hjtBohMv5dmgaZFwBgOVYvAX6V1EcF0k8ftCGhTN3AD4GRD4ebaix1q2dACuH1fOD067oBztJETjJPipNabFnUee9+IBBVbkvdAnlXxY2kE2XlMlD41lPVmiAlkxbMN1crguhNXTz1HSmWrzUzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qQJgqrbC8cYW0SJh43gcpMjyJROhbmz7MAcVS4aoIw=;
 b=TG3Y7AuRWBmTsNSKuUgUMMeWTTgZrFgnWAaYriP93JTpzP1UBuW2ujDSWR3UBSjNfIuxcB7e2rm2lgxp6Dq10MME2Ry13Ltj+KhDRloXnvhsasEldejhfFdDjIJLv8GgWCGB2nX+i3eTBoYtbDj9hrGibNVN8QQy5BxQToQsghQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7460.jpnprd01.prod.outlook.com (2603:1096:400:f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 8 Sep
 2025 10:42:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 10:42:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 3/4] can: rcar_canfd: Simplify nominal bit rate config
Thread-Topic: [PATCH v2 3/4] can: rcar_canfd: Simplify nominal bit rate config
Thread-Index: AQHcEqXtG9ZoHv3RCE6r1ODngj6GZLR+Ze2AgArOyQA=
Date: Mon, 8 Sep 2025 10:42:04 +0000
Message-ID:
 <TY3PR01MB11346916359AE1075F3548EC8860CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
 <20250821141429.298324-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdWdy2YVxmXT2vPj+3OEJpqj+miTVjhCVuEYpXC8iHXPXA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWdy2YVxmXT2vPj+3OEJpqj+miTVjhCVuEYpXC8iHXPXA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7460:EE_
x-ms-office365-filtering-correlation-id: 96e5c652-4dc0-4e87-9316-08ddeec459c2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDhIUVVHTGhZWm02bG41WFdGVTh1WS9TdzBHYWxBRmMxc2loSHJZZExXclhC?=
 =?utf-8?B?Mm9ZV2VrSWJnWStSaitQNWlocTdleDFsUHc3aXh5MWJ5T0hiWGRGMjZTQkFX?=
 =?utf-8?B?a1hraUQzUG9NT3crUG1oNzZibUx6THRZbktnNk9QQURlYjlHU3FGMzJWOGVa?=
 =?utf-8?B?V1g0K0M2eW1TVEorZUcwY29XbmxraUFQajU0cU9MUWsydDk1alFVTWtwYTRN?=
 =?utf-8?B?YnFzT0RmdGlLM0VDNFpacng5M0RmMUk2ODFZSzc3WTdSaGk0aHBuNlJwV1FM?=
 =?utf-8?B?QmUvOTRBeVM3YS9ueExCZ0ZCMXRZOS9Vd0dUaVc5MDdsK1gzYlUrdFZwdEV6?=
 =?utf-8?B?YVJEZUhiUXkwMENRTGFTTTA3RnlEdVJiRFBSY3JlbU1STk14d0FVT2NiYlNF?=
 =?utf-8?B?NXBRYnFIaDlLNHBTVHNFek1EdnJPdHYzWnl5bGI5Y1pwZ0pFMUM2RXhoTk1t?=
 =?utf-8?B?Zm5mdzZuMUkxekYyZ3AvT0lHeVNBazh2YVBBNjlmVEM0QzBQODVEaEU3YVZt?=
 =?utf-8?B?di9iU2JKZ2hjcmxHRmxISytXMW9CUSt4cTRrZlNLSUpWSzlZOXFhQ3A1VktM?=
 =?utf-8?B?TWh4MVU0QW9SRG9ETXVJS1dZT2t0U0V1RXVHNlltVmpVSjczcU85Ull3aUov?=
 =?utf-8?B?MzRLbzEzV2N0ak1Jc0Q2NldxTHc5dnJGbGJ5Zi9tUDI0T0JIU29JNE9Pa0pV?=
 =?utf-8?B?dWE2M2g3SnY4YXpiYkcyVUFOMUhrR21ZditCVkF1NWtKN0Z5aCtZaEhqTnFq?=
 =?utf-8?B?eUJIMzZyTG93VVFYYXd1aGw5TytyZmx6VkNIaGRVQm13KzcwR1FZWkJjZi9l?=
 =?utf-8?B?YmRBTjkzTGFrYm8rZmRRYjN0QmFPT0F6TUFkQ3VIdkc0QnNmbVlJLzRBbUE1?=
 =?utf-8?B?SElIN0YvSnZ5bmFVWFdGTzE1UmZ1YnBVZGlVVU9SZGxQSzh3cmdON2hnUHlM?=
 =?utf-8?B?dEVqaU1Wa3h5a0RYLytEUVhYTlhUT0ZTbGpSUXp0WUY1VUVjRS9RV3p6OGNx?=
 =?utf-8?B?S2o2ZWRaSlI1UHZPWDgrbmlyZjYrY2d3R0hmOEJ6THFaRE5MTU9Ca3ZWWGFy?=
 =?utf-8?B?UHpnSS9KL3dMbnZwQmFrSlpPdHFHT3dYdkd5UXVNekgrckdZdTliWWRwYzRl?=
 =?utf-8?B?N3RJWlBjK2FOdVlqNmVxU3NMTTJOdkRhUFhwZ3h4SE5uL0toU3N1YlhwK1V2?=
 =?utf-8?B?dU5iM1UyUjlRVG9hWU05V2pUcSthSFZFcncyQ0JyZ0xGK0ZVa3AzdHowQmtq?=
 =?utf-8?B?Y1E4WFY4VDFWTWYrVGJRVFVnMGwwbjJabXpBNndUNG93M2IxUUpnZzZYRFll?=
 =?utf-8?B?VmxNcDhoUHI3bFVNekloM3JVeXhDbEVGTmZma2V0ZVhjdk95eGw3Ri9zeU9n?=
 =?utf-8?B?czB6T2RQeEgyZGsyc3MvUFhqRVhPb0x5MTVQc2QvbzZzOEsvRmNydGFDRUZu?=
 =?utf-8?B?cG5sb1YwMlE2ODNEQi9MbE1zcVEvd0NST0VseCs5dmxqWWttdkFzc0J1MFBl?=
 =?utf-8?B?VDlTdWViQXVLUzBRclVDb3piTEJhQ2xjTjJvTUxmRUR6Z3RXSlBBVXBzQ2pl?=
 =?utf-8?B?ZllxM21LYjZ4bzd4a1BQdERSSTNUNWk0ek80RDNjVEhWM0c1dTdtcUY5clVh?=
 =?utf-8?B?MGY5cmdpME9BSCtjVitNTnJLYU1vdmxZdkNVTmJaNzQ0eldvVDVqb0prZzVE?=
 =?utf-8?B?RTRVMURJaUZidk5zVWQ1bXF6bGt0QlBsV2Ruc1QrbHVKenVJYmsySEVhZHJV?=
 =?utf-8?B?cjBHRU0vazd4Mzc3alRlSCt6YlhmNldmWkhGMkJWYXFKcDlOWExYSjFTMDF5?=
 =?utf-8?B?eUNsbVE2NVllVnJOajZvQnIrbEhNUWZLSXdNdEpGOE5CR2xURUE1OFhrNFdE?=
 =?utf-8?B?dHl6QW5LOEt2dFlPczZzWDI5ZXl1UFdZY1J1b3JreDBCTnU3ZGpRZlRDTXFt?=
 =?utf-8?B?cXpQMVdPRkxZU1pqaFFWT1lQVTJJSDFUb1ZLTUk5UUJNM1BJOCthby9KVW9D?=
 =?utf-8?B?Nmw0WVl2NGx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2FYTzhVbk9FTWNJNTROVHJhZktHVWxwT2ZZT2ZNejVBVUYzbkVHZHZteUll?=
 =?utf-8?B?Q3VGcmM4QlJqRURtc3ZMbG5QQVVGSnNCU3ZDTk8xQklwUEUzTUxlNTRkT3Zk?=
 =?utf-8?B?L29WaVF1Zm5tVzFzNFJWcW50OThGUDI3TVQ0WlZjTkpSZmJiU3J0TDRVUHky?=
 =?utf-8?B?bkd1amRRSGRmNXVtbWptVzZNUmxYRHVJVXJMQmRCcWtRN0w1UUsrQVo0MnBS?=
 =?utf-8?B?OUZmOVEyUnlIQm9kN3FUU21SQUdoZ0NTRm5GbXZJMm9PcDZTaTNmemVxMG0y?=
 =?utf-8?B?RkpaVU4zTzZYYnZhdk02WFVRblhUWnFLRG4rQjlCVjF1K05MamdPWCtWSnd0?=
 =?utf-8?B?YU9iSnFHK1VzU29aNHVxU096OVNqREpRaWllaStyN2hzbit4SlNUUXQrQ2NC?=
 =?utf-8?B?YlpOZFhjQUhqWjJOZmFBWGU5WEFZMzZFd1NnRjJzK3M4SHM3bkpUczNIWUpz?=
 =?utf-8?B?L1pua1UvaWRDNEpjamZIUEhYQ1BHclBnRklJdGNhUFhkZ3hUSldLKzBZTjVP?=
 =?utf-8?B?VklOeW8wdExmRDZ5L2s3ZWc3aWR0b0lqeW9Yc3kvWDQvWFFjVDJoa3NhNFZ3?=
 =?utf-8?B?cTF0NW1kK1FPcmVsdVBtSStSaWk1RnJBUzRub3VUNURHdm9OeWxPV0xQaWMr?=
 =?utf-8?B?OHp2ZGdrcEUydkVGeXZhUHNZMzh2YmxWUGFIeFVHNWFUY3RvMjJ1SU1GbnlE?=
 =?utf-8?B?STFQTENJdUV6dUFrTnRMcElRQ05Qc3JERHVndDhlWmU5TUM3T1Raa3B0eE9o?=
 =?utf-8?B?d1NvOGlqOCs2djBLUlVVQngwOFkxdENQT1E3Wmd3VFFBek1NbkM2VFNxUzhZ?=
 =?utf-8?B?UllCaUlNSUp6a3BEdUNQVHBqKy9lT0E0amdxNFBsaHc2OGFza25tOTlkYlZ6?=
 =?utf-8?B?K3NnMlZNRkErUTgydjBjZFhlSXB5b0h0ZmZFVU5FdmxrWFlmdnd0MVBSYlV1?=
 =?utf-8?B?ZWRhdzdzdWl3WkNRcnF3aE00UFhWTzdOek4rbmNJeHlxRC9ZaWZXMzNCMm0z?=
 =?utf-8?B?NWdEUjFVOHc0RmF4S2taeHJLeEVSYnJtc3BJeWNYQXNhUE9oR2FnZStBQ0Rv?=
 =?utf-8?B?RnNCeW13K2YyQmtnNGdkUHd3d09oOW12Qk51aFpuVHZJU05GRVg4SWRJTnRu?=
 =?utf-8?B?NU1mcC9JWklmaVdabDFSNTRWTXhQaEFqcDFxcmlyM2ZDOHhneXVCbUUvaW1N?=
 =?utf-8?B?VzlMdWl0akRHcEhtVG9FMXVQT2tsUWRPZHJETndGdTlTUjRuZlozQ1VDWGIv?=
 =?utf-8?B?VVRLTlpkOGZZQnVvVEVGNW9NYm5QQ0xacnp5NkFHMzhpejQvdzB5ZVE2cEVN?=
 =?utf-8?B?eHExRFJjVHFGbzhkT2hoUWFRUWlsVTQxc1VWNUpaRmNOZXFKM2YvNWp3T2Fs?=
 =?utf-8?B?cjZ1N013NElHYTRhdEVsS1gxSUtubzlNVHAyZFFMTHVNSVF2dWJHNUFVSjVm?=
 =?utf-8?B?aXo2YWovR0dLNWpZd0IwVnJGTkVCWGNLVG8zeUZxekJZZ0F6OWZpMVNjWFpG?=
 =?utf-8?B?YWhPZGJnenBZWGtiUDdQcEtDNytxeTNCOTNaMUdhOGFSdS96L0g0eXhyK25o?=
 =?utf-8?B?bmJwai9wbTVpWlRWMC93bWJudkRERW80dklkNW16U2RkUVIwSklTLzBWVTlt?=
 =?utf-8?B?Nk9PNFBMQXdVK3MzRTZxRzUyOWJIRzRHSXgveHpTeEEzdUtuQVVqK3MxcVdT?=
 =?utf-8?B?Zm5jaTBrU292Q2FBbjhNZjUvVDcxUzVtMDZrQmZYaDBhcTJyQUVUUXd3d1Fr?=
 =?utf-8?B?bjhTR1QwNFkyRUtyd29pNS9DUWlldDcrcFArUUpZMm9ZMjZLeCtOL2l3Ynpq?=
 =?utf-8?B?U0cvNlp0a3NsWmhaelpiR2hlT0NoWnM0Sk0yR05jNlB5NGk1bEp5Y0VZN3ZX?=
 =?utf-8?B?bjJEUlROS0gwcTl0Nms4Yi9tOWtyWjJwWE5oWlRJOWhOd3c2SFBkSUR5cUIz?=
 =?utf-8?B?Q056MnM3SlR5akZQWTUyT3pDS1lQMFNIUnVHaWp6c2QwRnFteENLUTMxdmo4?=
 =?utf-8?B?RzhETkplUlBzSWh6S0pFZXhaUmRVWnpHZVoyNnhoTHc5d3paKzdkV2hWcTR1?=
 =?utf-8?B?TjlwSVlJcnU0Smt4VVg2OHEwR3RUdHV6NEthOU85VHVwWWtUeWFRNUVaNWZG?=
 =?utf-8?B?bTBMSVVvWWdnczFpOTQzY0w5WUlXTElWbjg3Wk4xR1BLR09IODFFQWYydU9D?=
 =?utf-8?B?REE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e5c652-4dc0-4e87-9316-08ddeec459c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 10:42:04.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nogZESrDjMoFNsSniQObIJFi6GXjT+WykG36t6dclGUcJV/CKpos+e95XSHumjSd+bIIAYsXoGEce+XzY4RdrB8dHjHuOtTlfQa0ljCKSyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7460

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDAxIFNlcHRlbWJlciAyMDI1IDE0OjM4DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMy80XSBjYW46IHJjYXJfY2FuZmQ6IFNpbXBsaWZ5IG5vbWluYWwgYml0IHJhdGUg
Y29uZmlnDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCAyMSBBdWcgMjAyNSBhdCAxNjox
NCwgQmlqdSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBJbnRyb2R1Y2UgcmNhcl9j
YW5mZF9jb21wdXRlX25vbWluYWxfYml0X3JhdGVfY2ZnKCkgZm9yIHNpbXBsaWZ5aW5nDQo+ID4g
bm9taW5hbCBiaXQgcmF0ZSBjb25maWd1cmF0aW9uIGJ5IHJlcGxhY2luZyBmdW5jdGlvbi1saWtl
IG1hY3Jvcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBi
cC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2MS0+djI6DQo+ID4gICogU3BsaXQgZnJvbSBw
YXRjaCMzIGZvciBjb21wdXRpbmcgbm9taW5hbCBiaXQgcmF0ZSBjb25maWcgc2VwYXJhdGUuDQo+
ID4gICogVXBkYXRlZCByY2FyX2NhbmZkX2NvbXB1dGVfbm9taW5hbF9iaXRfcmF0ZV9jZmcoKSB0
byBoYW5kbGUNCj4gPiAgICBub21pbmFsIGJpdCByYXRlIGNvbmZpZ3VyYXRpb24gZm9yIGJvdGgg
Y2xhc3NpY2FsIENBTiBhbmQgQ0FORkQuDQo+ID4gICogUmVwbGFjZWQgUkNBTkZEX05DRkdfTkJS
UC0+UkNBTkZEX05DRkdfTkJSUF9NQVNLIGFuZCB1c2VkIEZJRUxEX1BSRVAgdG8NCj4gPiAgICBl
eHRyYWN0IHZhbHVlLg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gWW91ciBw
YXRjaCBpcyBjb3JyZWN0LCBzbw0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+IFN0aWxsIGEgZmV3IHN1Z2dlc3Rpb25zIGZv
ciBpbXByb3ZlbWVudCBiZWxvdy4uLg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNh
ci9yY2FyX2NhbmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZk
LmMNCj4gPiBAQCAtMTA5LDE2ICsxMDksNyBAQA0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkdfQlJQ
X01BU0sgICAgICAgICAgICBHRU5NQVNLKDksIDApDQo+ID4NCj4gPiAgLyogUlNDRkRuQ0ZEQ21O
Q0ZHIC0gQ0FOIEZEIG9ubHkgKi8NCj4gPiAtI2RlZmluZSBSQ0FORkRfTkNGR19OVFNFRzIoZ3By
aXYsIHgpIFwNCj4gPiAtICAgICAgICgoKHgpICYgKChncHJpdiktPmluZm8tPm5vbV9iaXR0aW1p
bmctPnRzZWcyX21heCAtIDEpKSA8PCAoZ3ByaXYpLT5pbmZvLT5zaC0+bnRzZWcyKQ0KPiA+IC0N
Cj4gPiAtI2RlZmluZSBSQ0FORkRfTkNGR19OVFNFRzEoZ3ByaXYsIHgpIFwNCj4gPiAtICAgICAg
ICgoKHgpICYgKChncHJpdiktPmluZm8tPm5vbV9iaXR0aW1pbmctPnRzZWcxX21heCAtIDEpKSA8
PCAoZ3ByaXYpLT5pbmZvLT5zaC0+bnRzZWcxKQ0KPiA+IC0NCj4gPiAtI2RlZmluZSBSQ0FORkRf
TkNGR19OU0pXKGdwcml2LCB4KSBcDQo+ID4gLSAgICAgICAoKCh4KSAmICgoZ3ByaXYpLT5pbmZv
LT5ub21fYml0dGltaW5nLT5zandfbWF4IC0gMSkpIDw8IChncHJpdiktPmluZm8tPnNoLT5uc2p3
KQ0KPiA+IC0NCj4gPiAtI2RlZmluZSBSQ0FORkRfTkNGR19OQlJQKHgpICAgICAgICAgICAgKCgo
eCkgJiAweDNmZikgPDwgMCkNCj4gPiArI2RlZmluZSBSQ0FORkRfTkNGR19OQlJQX01BU0sgICAg
ICAgICAgR0VOTUFTSyg5LCAwKQ0KPiANCj4gSSB3b3VsZCBkcm9wIHRoZSAiX01BU0siIHN1ZmZp
eC4NCg0KQWdyZWVkLg0KDQo+IA0KPiA+IEBAIC0xMzkzLDYgKzEzODQsMjggQEAgc3RhdGljIGly
cXJldHVybl90IHJjYXJfY2FuZmRfY2hhbm5lbF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KPiA+ICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICB9DQo+ID4NCj4gPiAr
c3RhdGljIGlubGluZSB1MzIgcmNhcl9jYW5mZF9jb21wdXRlX25vbWluYWxfYml0X3JhdGVfY2Zn
KHN0cnVjdCByY2FyX2NhbmZkX2NoYW5uZWwgKnByaXYsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUxNiB0c2VnMSwNCj4gPiAr
dTE2IGJycCwgdTE2IHNqdywgdTE2IHRzZWcyKQ0KPiANCj4gUGVyaGFwcyBmb2xsb3cgdGhlIG9y
ZGVyIGFzIHVzZWQgaW4gc3RydWN0IGNhbl9iaXR0aW1pbmd7X2NvbnN0fT8NCj4gSS5lLiB0c2Vn
MSwgdHNlZzIsIHNqdywgYnJwLg0KDQpXaWxsIHJlb3JkZXIgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
IA0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2ID0g
cHJpdi0+Z3ByaXY7DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZv
ICppbmZvID0gZ3ByaXYtPmluZm87DQo+ID4gKyAgICAgICB1MzIgbnRzZWcyLCBudHNlZzEsIG5z
ancsIG5icnA7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKChwcml2LT5jYW4uY3RybG1vZGUgJiBD
QU5fQ1RSTE1PREVfRkQpIHx8IGdwcml2LT5pbmZvLT5zaGFyZWRfY2FuX3JlZ3MpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgbnRzZWcyID0gKHRzZWcyICYgKGluZm8tPm5vbV9iaXR0aW1pbmctPnRz
ZWcyX21heCAtIDEpKSA8PCBpbmZvLT5zaC0+bnRzZWcyOw0KPiA+ICsgICAgICAgICAgICAgICBu
dHNlZzEgPSAodHNlZzEgJiAoaW5mby0+bm9tX2JpdHRpbWluZy0+dHNlZzFfbWF4IC0gMSkpIDw8
IGluZm8tPnNoLT5udHNlZzE7DQo+ID4gKyAgICAgICAgICAgICAgIG5zancgPSAoc2p3ICYgKGlu
Zm8tPm5vbV9iaXR0aW1pbmctPnNqd19tYXggLSAxKSkgPDwgaW5mby0+c2gtPm5zanc7DQo+ID4g
KyAgICAgICAgICAgICAgIG5icnAgPSBGSUVMRF9QUkVQKFJDQU5GRF9OQ0ZHX05CUlBfTUFTSywg
YnJwKTsNCj4gDQo+IFBlcmhhcHMgdXNlIHRoZSBvcmRlciBvZiB0aGUgZnVuY3Rpb24gcGFyYW1l
dGVycz8NCg0KQWdyZWVkLg0KDQo+IA0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAg
ICAgICAgICAgbnRzZWcyID0gRklFTERfUFJFUChSQ0FORkRfQ0ZHX1RTRUcyX01BU0ssIHRzZWcy
KTsNCj4gPiArICAgICAgICAgICAgICAgbnRzZWcxID0gRklFTERfUFJFUChSQ0FORkRfQ0ZHX1RT
RUcxX01BU0ssIHRzZWcxKTsNCj4gPiArICAgICAgICAgICAgICAgbnNqdyA9IEZJRUxEX1BSRVAo
UkNBTkZEX0NGR19TSldfTUFTSywgc2p3KTsNCj4gPiArICAgICAgICAgICAgICAgbmJycCA9IEZJ
RUxEX1BSRVAoUkNBTkZEX0NGR19CUlBfTUFTSywgYnJwKTsNCj4gDQo+IExpa2V3aXNlLg0KDQpP
Sy4NCg0KPiANCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gKG50c2Vn
MSB8IG5icnAgfCBuc2p3IHwgbnRzZWcyKTsNCj4gDQo+IExpa2V3aXNlLg0KDQpBZ3JlZWQuDQoN
CkNoZWVycywNCkJpanUNCg==

