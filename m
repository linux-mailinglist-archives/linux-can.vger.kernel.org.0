Return-Path: <linux-can+bounces-4634-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0397B51473
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 12:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED88541ECE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86730DEB0;
	Wed, 10 Sep 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WUtPwBIh"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2062.outbound.protection.outlook.com [40.107.113.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52D30648D;
	Wed, 10 Sep 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501404; cv=fail; b=sYZKNepZt6XFZHzibMYNrz5vfxvu+2lyJ07m6PqQPOZQVXvUmDYsXqINQTkveNevHzO5ZO/YmLDUhXIYU7UfVNjDvkblvRQHJYbxF7iC0xK431NZbbYxG+R2JJAMjr/Q8uYOr9m4E4j5ua9OedcWNocWx41hjy6TWPFiIIulHy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501404; c=relaxed/simple;
	bh=pcf5UPvuD7thVTaaE63qjvPeYrtwLPFhADBhds3ebm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4rHlYRq7aZmKy+C1b6kroQsGNwXQ8ENu8XW6ARbr2vjC2EmL9vStQ0YM/0xFSEOff3NX9gNTfohVLzBDiWWRCTCuZyxOjmTShJN5hpviPxyoKjqZtKzdq2KPyQAxlU2Dt3ab/VXzLPXSS6wRGT/zUM77c2LBk+5HCHfWm3b8Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WUtPwBIh; arc=fail smtp.client-ip=40.107.113.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGqo2irSYhmRIgrJ8qgrXsmsP+xQG79Oia5P/Imq5DdoEHp9fDPRkamNhhK7iNqfCEkQGGL9t1nJYb45r6aAHgXcdmAzjljO2DWMENjonzeOfvN+7cvY0BnCJRmqhyZ2kwqMzjxA5ofLPciW2Qy7ZmBZNEbpLFChdPUhyn94NA70PPjHRfQD0SYItEXn8TgutDnFU9P0WGJc68lil4AbHdjQaFW5nraQ43U0Mc927GRDpK6eHOBlSEssl9qXi7VUZLwgBPxP5u7qzBIjgQZeRkFq3QHS+CXqok1Ei0ottNsnC1i14OHja7xfFFEsrm6ppl2+KNlQBjFst12S8nCgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcf5UPvuD7thVTaaE63qjvPeYrtwLPFhADBhds3ebm4=;
 b=jiE3s6qoitv2Y1JRPdyEO9jzA7sPgg39Ksnfd0KLKkvdMG+MYfslQFKJ555VfoFEu3E4B22D8PB+OFew409vyYvs8Ggifp8Xn8NxmUN98TScSxS7nzoh7+CGPFGZT3uR2BINNtpVA9CAjV2usols31dclrDIGT7yDqgRBCXbzg+SQ7b5Af9i1Y9VR9CUVoPtRuiqwd3D9L726/V2ey3tl7Gbqvg+Qd13rfhU9CACU7zWumfV/IbWERJQnS+EMbLESUbDDtNbqbwd45il4ImOlYbsT5ScrEtJNArLB3a3iW28M90xXUgeZR2YcGhG4nqOaHhmXMnYlURB9G2JRJGcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcf5UPvuD7thVTaaE63qjvPeYrtwLPFhADBhds3ebm4=;
 b=WUtPwBIhZ6JpmKPWGiTIHMggpFdTxyh3elMFNEQ/8wzMfwK7cPh6ZTrQJw4c7etRsV08fiobnYWS9MQuBzQZ81QztbiAQWgpF+FRB05L7z1HeC4OqsXBLQd315KintQ/Ek9x3wgPDjwhK29qOu/5dEEhQlKHBMZiAf4vmZg2Qps=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB16144.jpnprd01.prod.outlook.com (2603:1096:405:2e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:49:58 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 10:49:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 1/4] can: rcar_canfd: Update bit rate constants for
 RZ/G3E and R-Car Gen4
Thread-Topic: [PATCH v3 1/4] can: rcar_canfd: Update bit rate constants for
 RZ/G3E and R-Car Gen4
Thread-Index: AQHcILl6EXJRQHIhd0iOgY3hgB7gpLSMIncAgAAc9XA=
Date: Wed, 10 Sep 2025 10:49:58 +0000
Message-ID:
 <TY3PR01MB11346BE5957318E1805CF9E7F860EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
 <20250908120940.147196-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdWmMzZ0gCNVAsBOGKDTO4kAF5TTcSo4V+m-_MGfsTo63Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWmMzZ0gCNVAsBOGKDTO4kAF5TTcSo4V+m-_MGfsTo63Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB16144:EE_
x-ms-office365-filtering-correlation-id: 173de4a5-7503-44c1-3221-08ddf057c949
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXZJRlJvbG0rVnliYlFGZXVyWUxiWko2cittWXVEZ1ZHZHRHMDU1eFRJYXFm?=
 =?utf-8?B?QVVkYWNkQ29lVVBrbVZjMXQyS2ZiSlFlay9Cc3UwSWxvdkNiQ1ZtVFZoQ2ZZ?=
 =?utf-8?B?SXljWDZpNHc5MXhpeWc5d2VENmpuOWEwZ3BWR09IWVUvVGpUU1RIanFKQXZX?=
 =?utf-8?B?Y202TUFaZGlLSk5kdW5iVENoVHM3VWJ5S0NYQTJUVjRmSzV1akl6RkpkZ21G?=
 =?utf-8?B?TU1oTHJTbTJJR2g1eW9Yd2JoTEx2aVZ1NVJobk1OcUFJQndTOE9tN01QaG96?=
 =?utf-8?B?cTVmcWxBazhUcEJQR0w3b2p0cHVHZlEyVTk1bUNEUUtnSC9jem02TmVDbS9M?=
 =?utf-8?B?Um1OQWVJcWpucmhlTS95bDdCMytHZFd6S3lqNXpHTkZ4bGQvSjZxaVU3MTRR?=
 =?utf-8?B?M1RLbWJyNzN4b1ZZR3Z6RldCYmVPTXRaamRFRFRiT3U1VGl2Ujl6UFRIWVc3?=
 =?utf-8?B?U3VmL1RvWFBaL01wRVRITzlzNUQwWEtDVGh6aGhReUx0TCtpcjB1R1hHMVVq?=
 =?utf-8?B?a0JLOHVodXRqYTdGZ2tPK1pVMFMxWXU0UjBJQjRLNHZQN2RIV0ZNZzFSaURk?=
 =?utf-8?B?eDYzQ09VMURvTWhmbHIrQ3REeEoxb1I1bFVuZnVNckE0eGNKM3FWRVRzNEk5?=
 =?utf-8?B?OWo0Mmo1YlgzRUViOHhEMkdZV2RIWGhIYyt0c2JSLzFBa3hjZElhaHZ0Nmdn?=
 =?utf-8?B?WTRsNlB2NkljdzhMTXNTNDJCM3JVem0za0tscno0cW83SkZPbGVCUlFoS0Zi?=
 =?utf-8?B?UjFaaEN1YW9QRGY4K3N4dFVzTHFwRDYyRXhNTDNzaVV5OVZpSnhPMGljQVJx?=
 =?utf-8?B?Y2Q3cUV3eVAwbUhlcGNGNjhpUVFaNDZBeWx1ZjE4M1pMSTNybTlhWmZnUnNh?=
 =?utf-8?B?UFZ2YW1OcGJGMEJTamIrMUMrSFR2cS81YkNiMWU4LzN6NXVuTU4zZVZ4dDVT?=
 =?utf-8?B?VkJkb3JzZlN3VWJETDNjbHRsMmU4ZHdzTlcya0pxQ2VISS9vc0ZQMmRHOUhu?=
 =?utf-8?B?U1Vma3Q0eHBtRE5Bcmk5REdKcndqTkEzc0pKMkdBbnFuRVNNOHVWMFNSU0k5?=
 =?utf-8?B?ODBia2lqam9POGt1ZTNkcFhSNkV0cnJyc1RYMEkxR1Q3Ky9TRzhrcThYY2hY?=
 =?utf-8?B?UEFtZzg3cGJ1WUJYbktEVDh0VDVSUmI3RDBjOHdGL2pqNEZOaWV1bENjTHlW?=
 =?utf-8?B?c2hpNlRiYXk5TjZtNmZPcmRIL0FwWjJmKzkyNUdDYnEwN3RDUHp4ODZjWFpH?=
 =?utf-8?B?ZkM3WXZaSkFNQlRjMHZ4bEZZSmtYWXJTUFpzekRNVWJqNmswcFJRWXg2dzg3?=
 =?utf-8?B?Y1dLNW9sQzB5WTUrUkcyZExncW84WXBlQ0JIK3ZpalhIUU94dG1NajFHc0Rq?=
 =?utf-8?B?T0R1R0wrTnZRRnpRWjZrSTRhczVRSTd6ZnAyVEttZVkzNTVyTzRsejBXWjRj?=
 =?utf-8?B?Z1I1ck1zaXY1L1lpWXlHcm9HOHdER1NyN1hsY1BTT0Fld1JBSWxLcTczVGw5?=
 =?utf-8?B?cFJhRkU0RVpZUjNZdUVQMzBjdDZ3cEFYTHJjTzluRGZNSmJMWllldEp2d1dM?=
 =?utf-8?B?bzdqeVNoWEZvb2trUjZjdlpCSFpKREpMUmJwVW9OeVFxSC9HVStLWVdiaitV?=
 =?utf-8?B?dC9jcWMyUUNMSFpnUU1GQjc1eWNENUpqMHUxZGdsbm82aHUzZ3lKMlZaU05o?=
 =?utf-8?B?emMxMlJnWjVmL0FYd0dWdEtjMThqVHRVUkJDUmJpR3luM0VqU1B4MlZmdEpM?=
 =?utf-8?B?NCtWN21rSlh6QmVjTXEzb1g0NnZwRFNMM2RLVldRa3d4a3dTL1hSNlNrR3pk?=
 =?utf-8?B?bk5BSFJ5bjlxaTNBSUZYbngzeXpBSVduK2kyd2lFaUxuYTBhbzZuenpZOWEy?=
 =?utf-8?B?K0N5am5lc3pmbmpTbFV4aWFMQTRoaE53eDcyNENrMHA3VVE5U0NVYlp0N0Z1?=
 =?utf-8?B?QlNEdHBGNmNsTW5CWVBaK3drZ25uV1FUVURsdE1yNk9QeElLSU5WbUV4bmJS?=
 =?utf-8?B?TDE1QUY0aFJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVZLR2RkYS9SSEFkY1ExVUYwZXRjWHdZY1lEdGpDd3FHQXhkem5ieElpM0lh?=
 =?utf-8?B?UnIrcURxR3EwMWlCZGFQTXhMUmtPU1FPNFNKVVJmMGZET0VuREVFazQ0K0tr?=
 =?utf-8?B?VUowcGIwZVFrQlBXZzRWdENYTDRSOEJ2L0hIdkpUMVpkOUhPYWovSDRGWUg4?=
 =?utf-8?B?c28wenFOYTcwOWVCNWo5dG5tSU90Y3V3U2FER1JzN0V2N1h0c3l3Q2Uva3g4?=
 =?utf-8?B?ZHpxWVE1ZHhEZ012WnRqdHlRT3AweFN3bUJmbUJybnF1dmQ0NndrdXljNk5X?=
 =?utf-8?B?ZFh1RU5sS2grRk1qREJnbXJmSFRTMXZCMGRPWWVYckYveFYyWk8wQjVoajYy?=
 =?utf-8?B?OWFaYytiUXpRR0V6d2JhL1ZlSTBzZ2ZJOU5pOTVBQWhXbmMrUmwybExHV0d1?=
 =?utf-8?B?NU1jeHZWZHI5ZVN5UXcvdDBOUnhRc2w5N3ZKZ3FuTnNhVDVneEJlTmt5bGcv?=
 =?utf-8?B?THRVNFJQOEhuRzNaY3c1RDdZc2FrZ1FwbkVieFVmVUxEUlBmbFY3b1oxVDNQ?=
 =?utf-8?B?QW5NY1BFMERKU1hYY2pwcUhoZHhhb0s3c2JqYmxyKzhhaytiOHNxY3R2WlJN?=
 =?utf-8?B?NlowaFhURWNpa09VQUZSaThUT01zN3E5Q3FiSGc1WkVVZmxnYWxWajVUQ09k?=
 =?utf-8?B?cW1oTXlocmlFdE5RWFNOWkNuMmpoN0hBSFlUQVZpcFgvN1lJa3dUekN5d0JQ?=
 =?utf-8?B?TmVkZWxhbWJwTkxBZGdFWjV0aFNFQzZYUUh0TUNoNVo1V2JNKzI4NjYxU045?=
 =?utf-8?B?cFVlVERjdk5HZ3JzdHFqNHNJWUVNdjI1cmlsd0hySWZBMmg0cjN5ODZJcmpZ?=
 =?utf-8?B?RW15d29JUWM0NkFDQmV5b015dEd3UlNaWU03VVI1RXhHbkZRQ210K1BaYWFj?=
 =?utf-8?B?eWNpd1gxNENPV0VGZ2xEUEVUakVtUUVXblBsSUJzaWNuNElKNFVTc2xMUGIr?=
 =?utf-8?B?QThST0Q1dGVPNVY4MWNIOGdKbGtYTVc5MW90OVlQU011UGkvK0JMallzSXlu?=
 =?utf-8?B?MEhaQUdFQU9pb1lqS1hpb0VxU3hsaU9RdU5vZElYUUlnb1FOWTFOQ2VBa0Fk?=
 =?utf-8?B?NnM2bzQyL3B3aGtGdW9pQzJBQlR3ZGdTL0hhVkUwcnBPM2FwUU1kRnlvZWsr?=
 =?utf-8?B?eWhhZUNYTjZIT0Q5U1hNamcxTXl3MnZSQTZhYU9LME9kSHZFTnZhcEwzUVVR?=
 =?utf-8?B?VW5pNURvRGcvaFNJbHZzT2JsKzNRRk91MFltVm9GRnVoaE1HN09GNmpFU2JL?=
 =?utf-8?B?MlZNMTAzY3FSd08rVXh1K0JvUmsvWmFnY3NYM1pYYm5QaTVHTmxTeTVJYU1s?=
 =?utf-8?B?RGVaYmdhVnoxcFBzeHU5QXYwenpGOUV3Q3cwSkp4QTBSZ29hMTdkYmRrTHhU?=
 =?utf-8?B?OFJLSmRKMC95cjVQSUZDUVhpK1p5SHE3aTl6dlFxTFppY2s5RVJyaUNGMUgv?=
 =?utf-8?B?ZU1qZjBLS05SQnppdU9VVzFkUk1OWkxzVHphZ3hlQXRmY1JyVE1SYVA3a0JM?=
 =?utf-8?B?VmJ6c1pXcXdkT2FKS0o0Ry9RcFJmRFFUeFpwQm1EMWpVSExMRUFZWmZmdjgx?=
 =?utf-8?B?bXh4ZVovR3VjaklvL2ZQZVNLZzRJaUdJR0lmKzNFZnZsY25UWjg4YTl4eC9H?=
 =?utf-8?B?c2R2d0pyWjZqaUFkL1Rqcmp3bHBPSWpwM0RwWi9pVkZ5Z2Y5bXVKRlU1VTRw?=
 =?utf-8?B?N01ZdDFHNWJRY3FzenVkaDMwUWlYZnZFMndCTlpHeFdSb08zUmx3aURpNWZR?=
 =?utf-8?B?SmpGTU52OVU5MW02clI2bE9uOGVuVmRhTDRKdUFxc3ZDK1R3VXQzTkhTdXl4?=
 =?utf-8?B?RDR1TXhVZ09mbTZMS0dpYTd3aDF1WGhyL2JjazdBWmI0RXR1RHdrS3hSN0cv?=
 =?utf-8?B?WVE5clkwZktmRGdBZ2R5aVRRVm1zZVdxR0M0S2UxclNIL2VQSTlkNkhFTVNa?=
 =?utf-8?B?NGV1TEpOdkg5ZWw2K1ducGtqc3F4ak4yQkJlMGtzS3NBYXFBQmlEQ3ZZeTMw?=
 =?utf-8?B?ZkRZOWtvM1BnM2xWVFFRQStEdEZweDNIclBveGx5WGxKVkpIdHBwcTgyRFU0?=
 =?utf-8?B?V1Z5NTllNm5qMHdpeGlrWFlMMlB5eWR6SVczcHJVQUU1QTRyRlVLRW9OSjhu?=
 =?utf-8?B?WWlmKzN5czZhMFlIdnpEM0FreFFGaDBoMndFRUxZa2VjS2tWQUxCVVNWenFj?=
 =?utf-8?B?dmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 173de4a5-7503-44c1-3221-08ddf057c949
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 10:49:58.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8714G7d0VoaeMlXngylBmUwG79BhTOyu3N3GS0MMm39nf6VqGHM43uLeR0/RoA0vhFDET83Ux59ch7fKMrqFnBLj1redPecPP2x8GdrKwWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16144

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDEwIFNlcHRlbWJlciAyMDI1IDEwOjA1DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMS80XSBjYW46IHJjYXJfY2FuZmQ6IFVwZGF0ZSBiaXQgcmF0ZSBjb25zdGFudHMg
Zm9yIFJaL0czRSBhbmQgUi1DYXIgR2VuNA0KPiANCj4gT24gTW9uLCA4IFNlcHQgMjAyNSBhdCAx
NDowOSwgQmlqdSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBUaGUgY2FsY3VsYXRp
b24gZm9ybXVsYSBmb3Igbm9taW5hbCBiaXQgcmF0ZSBvZiBjbGFzc2ljYWwgQ0FOIGlzIHNhbWUN
Cj4gPiBhcw0KPiANCj4gdGhlIHNhbWUNCg0KT0ssIHdpbGwgc2VuZCBuZXcgdmVyc2lvbiBmaXhp
bmcgdGhpcy4NCg0KQ2hlZXJzLA0KQmlqdQ0K

