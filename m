Return-Path: <linux-can+bounces-5619-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A98C7E25C
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B620F3AAB59
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A22C21D8;
	Sun, 23 Nov 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZHAQQJY6"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849219C566;
	Sun, 23 Nov 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763910961; cv=fail; b=WBZrrGC05dL0Liu0WgZVMGruEQq3EZ8YsogfQTkhC1vD+Qd53vcsVDLyNoHWMZ+oO1rMWMSYKCXovvnkXri/XgL2g3erkdmwANfzFEV1FGuo8k9Sx4ZQQxigGGJGE3ZuCwz822WjxqejP1/eL0vxRIvDmgROR9Jr6zg2V8xzp90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763910961; c=relaxed/simple;
	bh=EaQ3uR7Su9JIfdqkhvYM2vpkIfwvb5o4XWyVQnsE2V0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhHn+eedeIu4Fkrxn4sfUwguErSvopAp/Uh6qMMeRqGsbbLoie5bevVC/lEMZhD8SZGvY7FSQDeBn7qcluuhV4u8OJnur60YzQN1ZlGqPVMYHQV2f8nkUYbNOlSrP06wLDspJFWJCp2kBHRx1/lzZ0JoBQQV0bSIPqjS5UCRuTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZHAQQJY6; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhaECUKvT10I3hlZwF9zqVevlazOFlUYl0s/IBgPTAH9LxszYbCxRy31mY4Cr33kveqpsIn7CCkXLIzsaINVAX98Mg5ztUNr+CEc2yr07XRUF0lEA7BUKuQ0QExiGz/cWKHPbOiU5mI1fcReFZZdoclaEfVR6+T1HocoatC3BYCFi1laCplAlzW6OLNbyfXvlrZJclGwVcTP7I6myq4VY+rlSEhCiYcc8141A0F9SRQDq55OCLoEYg7SYBiRoNVjKrHvCDt6Rdrq8LCnTYvbnd4yyZ9GMykv0aWO0Q+N+v76Q7pMHPOK4R59LYz8nOttb4X9CfXtUtpnUjg4PsQGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaQ3uR7Su9JIfdqkhvYM2vpkIfwvb5o4XWyVQnsE2V0=;
 b=hGWH5D6S02yvpRSYQ7bxm3LGE3RnJfEQRr/9NtWB5vaXEJInRXwsmueoIAX30N9zaj9d5VHKu613VvjazOKc9rpfnn9QfW6CH/YzcksgDWVjiWYykmHFS8+F8Ux2M+GnT56tf1DnF9vNw71+Ilsl7hI2X5GEDWzAzVJMAf/5E+tOU5LM/GROvPmpYLey9gRu88jCACIgOmyzJ/wkb7NTDkuo/DwGWdfhnZ49Q+o0HqhGlZKNqw1kHaGppZhUPWRF2HA53J53Pvgp63bJFlVhzesnIQwolwqplkLkUUopQHotrrlHaWZ9uVzIRMQTMF9F5AtYpaX8E4Z7YVERHEB+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaQ3uR7Su9JIfdqkhvYM2vpkIfwvb5o4XWyVQnsE2V0=;
 b=ZHAQQJY604EjDXN1gJPl/nht5r6Q7sDQCNFQwUE3g9TrseXVyTbTyJIGYHJnMFqbhoJv5xyrda3IoQje8/B81x2zSWUHaBwzeIRCNwEuQlN1j1oC+Am0K5dci9DVLgPEcpntvAWYMVpEJ7a3U/20tqLSoK6E7LSUZIwrlNA8jVY=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TY7PR01MB13780.jpnprd01.prod.outlook.com (2603:1096:405:201::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.8; Sun, 23 Nov
 2025 15:15:50 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%2]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 15:15:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Topic: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Index: AQHcXGubPTkKPcpfPUaJAr71uDlXKbUAQHWAgAAKwkCAAANJAIAAAZ2AgAANeQA=
Date: Sun, 23 Nov 2025 15:15:45 +0000
Message-ID:
 <TYCPR01MB113320211AB2810248A021C8286D3A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
 <20251123112326.128448-2-biju.das.jz@bp.renesas.com>
 <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346729E8758CFEF18C9E99686D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <24a71741-df53-4726-81d1-38c9eb3ad12a@kernel.org>
In-Reply-To: <24a71741-df53-4726-81d1-38c9eb3ad12a@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TY7PR01MB13780:EE_
x-ms-office365-filtering-correlation-id: 18ae0624-1b8c-406b-576d-08de2aa32d08
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2lqVHFqclBVK2hkM0pZeVFGV1BBSVUwaVJ3UkhJOUlFWkx3TG5jZjlwTVFJ?=
 =?utf-8?B?UEFwWE9MOUY1NmhWOUVBMG5nVUhWMlllTTgzalFxSDZwRS92R1BBcEpjSjVw?=
 =?utf-8?B?OWplVXZVWWVoWHRLbmpqL2Z3dWxydUlBdFgvbElFTFdMMTlOMnI3UFB2YlNs?=
 =?utf-8?B?NXkrSHBhWGJ2OXJ3MHo3eTMrY0NkWGJ6UVFROTRuWGpiK2xyY05JazRUVzB4?=
 =?utf-8?B?eXYxcU1IUkFGZzNTQURsS2NBamNrUkNUUWN3eFE2ZzNTOWZ1dnVsTGc3UWhr?=
 =?utf-8?B?bmpKZlhKMU1HekRiaHUzdmkxOHVnaUh5TEpHREVmbi9vL1E1ckYwbHEwclJ6?=
 =?utf-8?B?eXlvNzg1WkVuREwrejhORVdFeGVZSkZmK2FZelh4bFRCWDZ0VXA0Z2gzM0pE?=
 =?utf-8?B?VFBlYVNXVWRYMkROWkgwb1k2NUVadnNKV2dZL0llNVc3SzJzTnF6dGpMdHEv?=
 =?utf-8?B?N0pBNHhNTjZrS01rL0xpVGNkNHQzNXQ3bDEyYWVXVmgzK3NjcjhUdDRFbVk5?=
 =?utf-8?B?cHpCd2d6dWtBMjdTcnNrYUtpam9QNkRqcWVRUjhlajhuZjJhNFhEY3JHeG1Y?=
 =?utf-8?B?UVZZNzg2OE11NElaOVhjbXpPNUlsZ3NVZWVYaWVMN0VjQlVKcWVieFF6V0lx?=
 =?utf-8?B?bEdpU2FyOVJZYWlLdFg2WlpodGUveXpPeDRvNWtGbGhua3EvUU9yUjhmR3d4?=
 =?utf-8?B?NG9pQ0p5NW8xb250ck1jSUVvcjViNjduQUUveUI0Mkp2Q0E3Z1lVbG9mQitY?=
 =?utf-8?B?UVFEUklIL1BjV2ZGdURTYitiMXFFaURLMUxSc3FOT0hVTDZqRTN3T3Z3MG9F?=
 =?utf-8?B?ZjN3RS9DME5Cald3T04zSlNVQUJKVHUvVTVzbjhHem1sRGYrdDFZQ2Y1WjdU?=
 =?utf-8?B?QmduNURFWmM3Nnh5Zys5QUpTM2VyNGlsbmJtN3ZJVGJHL2QvenhjdkM4a1Jp?=
 =?utf-8?B?azJnaFZrcFlQaStoWjBmZ0dUazBxU0ZDRklOb3JzMEhmR0NZbW5CcElUK1Ay?=
 =?utf-8?B?RTRoU09ma3JFVW5iK216SjVHT0V3SkIzSk1BY2lyTDBFK0RzTjdsOGE0NWhH?=
 =?utf-8?B?Y011dG9ab0tZelRqTzBoUm94ZnRkWkRmSE9PWHZnRDVka1ljcGFYdE5VOVNu?=
 =?utf-8?B?ZHNzcitXaVNjbkJNTTBZcmd3NCtzbHZVS0kxYy9OVWNlcFkyL2ZYWFRsdjM1?=
 =?utf-8?B?TXVDK3RQSXpvOFN5a0pNL0tsSk13UWtGSmdyV2h4dTlSWVpiWnpzMnVRYVJy?=
 =?utf-8?B?UVc0d1plTjBKZjFNV1BXakJSb2NUR0RVdDZOUUFDa21GMm5NV0lGZU55eVIr?=
 =?utf-8?B?djF1WlFNajBKV3IrNFRwMzhSQ0IwVzlFYTNKWFFiQ3R5aEtNNHROVGNyL3p3?=
 =?utf-8?B?TlFKQTRsRG1QYlZvWFZhZEdSL1BQRjFtanFxV3gyK1hCVFNnZjVyMGRzN3p5?=
 =?utf-8?B?bldhRERqTWlhRkhNYU1PYnlRcWptcDZLWFcxclQxRnhuVEY0T2w3cG5wcnB0?=
 =?utf-8?B?QlduOGdHVjdhSWxsTXpCWUlQazJReUlFN09yeDFwQUl2eS8vNnJvZjE1a0xZ?=
 =?utf-8?B?RG91cUUzcGhWQ2pNcFVORGFRejhqOTc4YWZpeGdOMDBJMjdYcUp2aHphOU03?=
 =?utf-8?B?ZXBWZ055a1BXQWxmOC8zRUhYUDRUY09YZVRldUNraHkxSUJZSWVKY1Vpem5w?=
 =?utf-8?B?OHVxamlZQkdWM0N2ejBWam1HUGgzSWErMWZQeE9xT0VVejk1bjlCQlhac0ln?=
 =?utf-8?B?dTRQS29LUTFPV2ZhSmJYcDY5NlFEVlpEbGt5a2RQSXU4UlIwZS9PUFJBZWJS?=
 =?utf-8?B?a2JBWVlpelV6aVhadFArVnFUYy9MQ04yNHFwMEJpQ29pUU1KRitBbW1PbEFu?=
 =?utf-8?B?b2tyS0o0eWlnR3dJalBhcHlPVUdieTZKQ2hOSFgzeUVzNDF6dXc2elBSbTdN?=
 =?utf-8?B?YTIrMWdNSms5UzRLeFlQVHFCbkUrQldHSUhHbTlia0dMSk16WSs2L04xekhB?=
 =?utf-8?B?dytDRVEzUVpFcUdRZXJ1c1ZQM0d4SnNNdnB1YlBIb3NaR2paQ1F2Vjk3QXBB?=
 =?utf-8?Q?bl64hA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RG5uYWRMV2UvRS9SNDUybUVRZmN5aG5JakVaWW42cGhwTEwrUkZIdEtHTlBp?=
 =?utf-8?B?bjk0Q0RNM04rVFdSVnY1NG9hVldVSW5zRkJ0enhGNjhWZHJPZTd3UWxDS3pW?=
 =?utf-8?B?bU0wenRYUjIyd1phTmZuVXIwWEZ5RXNua0ZTQjRtRHJRUjdNYmd3bjE0NGNI?=
 =?utf-8?B?SHFXeEtSSzBubmYxTWE0NFFaK3BZS2Q1OGZKem01YlpWdFhHS2VGdi8wZ2hQ?=
 =?utf-8?B?S29hand1bjdDQzM1Zit6TWE0dFpNWlVpeS9IT1Zld0RaSVdPbmh5TnREY1ph?=
 =?utf-8?B?cCs3VE5XOGp6V0FxMHdSVkRmSytxeXZEQkF4ZUF6MGdaYlhzVUd0c043V3pP?=
 =?utf-8?B?Yy9RNDZvR1hXZ3NsTEFRN1h4ak5Famdjb3pabFVJcm41R1dvS2FXQjVVRk41?=
 =?utf-8?B?ejNTNTlsYXdQT3NLSTFSTlk4NzBlbjhTbmVVQm5sYkR4bHZpZmo4bDBSTGJK?=
 =?utf-8?B?WTZ6a1JQdUczWDgwaVdseFk2cVlHSS9jMnh3OXEwSGEvaEhWblYwcVVvM1di?=
 =?utf-8?B?ZjFUZWNvS3lhMWM2czVkeWtDYk50dkFiekhGVDl3T1c3S0g0V3lMRXlNbDNa?=
 =?utf-8?B?cnY2ejRmdWU5cmRQYW5HNmJ4ZDZWd2ppeUtTZFJuZmx4eHJ3WHpKVTNGMllZ?=
 =?utf-8?B?ZE9BTVFVMFFWcEg4SjN5QTVUWm5JRXZ3eFJKTnlrQXpjdU9DTkFsTEhFczBO?=
 =?utf-8?B?dEpHd2JrRGlabnMwUnN2NlJrVkNpSlRSckhyMHNpbVQ5eUlQMXVodlFmNitk?=
 =?utf-8?B?L3JkMksxRGtTTTlNU2dnbm9nblFJUkUxazlqYXdnSFpjTW9hdVR6VS9zOFJr?=
 =?utf-8?B?NEdrOG5kSVJQVDhtN1IvellPSXROUEhTSVdxOUJzVlk5ODQxWW5LVysralh4?=
 =?utf-8?B?TEpocGxqNDVRcE4rVU5qc3labmRjVW5PaGxzaGNNL0RyNmJYWHhyS0kvZHVv?=
 =?utf-8?B?QzlDNXBpaE1JcFgvSUpxUHlndGk4RHlHOFNjNlhUWUllcEJ1WmRWcVdteXhr?=
 =?utf-8?B?dzc1a093Q1RHTXovdGpRTWhySjBKaUJxVGlkV0lRVE5HZ2s3L2dlTkE1U3Jv?=
 =?utf-8?B?RUJjbTc4L05jNm9tR3E3TGJzc29zdm0wTGxxbUkxUFptMkdvcTNLZjNFazVi?=
 =?utf-8?B?OTg5ZFF6ejA5L1VUeEJHajdQUnowdkhxM1pNaVBqVG5iVFZlK0t6QjdEclpO?=
 =?utf-8?B?S0FHRUN6VUF3MVZadHh6dEJOSmVXQ0NnUFB4SDQwRHpLK3B5cktSdDlyNWdJ?=
 =?utf-8?B?Nzhja2F3dDdUV2NoZmoxTmNFa015ZHVzcEt1d3F5SGVoU25MMG0ya1hJZjNW?=
 =?utf-8?B?NmY3UTlnWmlOanY5SlhFNWw0Q0FBTkNsMW1Rb1o1NVplOGR6Mi8ySkNRK1Vr?=
 =?utf-8?B?Ynp5M2NnLzdvRThzL2pnTHNjNGhNd1o1aG9RNGxSckwzejlzVEYvV0g5YVM2?=
 =?utf-8?B?M1lUaDROOUJCUXAwUUtmK2lXMnRjM1YzYWNXNWIzWW10M0IxRVQ2d2FobWFD?=
 =?utf-8?B?NGFFRUJLaE9xeVQxbGEzN2xGQU0ycTFPSU1qampsLyt6UklGUndQVlZUaWEw?=
 =?utf-8?B?RHhRRGRhV1ZJdWtmZzBGcTdDaFRSVkd2NjN4elBkUjVFcFVVSlRjMkhCSTUy?=
 =?utf-8?B?TzhzOEoxTFovZUtiNmNhQlF5K0RzYmhqNnBrbUFtaHcya200eWdnTnNPR1Uz?=
 =?utf-8?B?TXQ1aGxUOXVoYkVMd3Q2L3FJN044S1pZeC9Cb0ZXQy9CUjdMQnI5K1JlSlZo?=
 =?utf-8?B?cUZmRlpXczkybitNOGdxd3dvRGwxTkJYcUlJSWlkbDNWeWFqV1ZZb0Q1T244?=
 =?utf-8?B?UTdRTGc5NUJkVndIWFYwZ1pWcHRoMFgxSThoYWpQako2eG4vV2tMM1c2SjhJ?=
 =?utf-8?B?NnZvY3d6bVMvRDZSaGNWYXRzODFxd2tqWTQxeUVJeE9VMUdHazRvR0RBMWJi?=
 =?utf-8?B?cW9FSENZZ2Z2V055ZXErayszYTJLM3FHYTkxMkhhaUVkdzYzclgwNENSWnN5?=
 =?utf-8?B?SUIxN25ENzg2bE9Cc3M2ZysvZXBKOU9yZnhDdmF1TExCY2NlUHdSWW1wMUJ1?=
 =?utf-8?B?MW12VEVYSEoyblNwb1NYcnV1SHJqMVVHVjEyS1JGcGl3b3c5MzZ4dTg2N0lU?=
 =?utf-8?B?cjVEaEw4aExQVnRGZ21wS0dHeW1SZWFoSmFLL0Jva0I4bkxoRGdnbkRCZFQ4?=
 =?utf-8?B?Y1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae0624-1b8c-406b-576d-08de2aa32d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 15:15:45.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0F4UktZjCq8xtzCjJi0CvtUu/A1NCJ5Lpl9yhn0Onl0fHxbnhf2RUqTtMkx6vyaFxJXmy7QwakQbgmMCdqKPB2bkbMwg83DE3yBM8RXkY2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13780

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIz
IE5vdmVtYmVyIDIwMjUgMTQ6MjINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJp
bmRpbmdzOiBjYW46IHJlbmVzYXMscmNhci1jYW5mZDogRG9jdW1lbnQgcmVuZXNhcyxmZC1vbmx5
IHByb3BlcnR5DQo+IA0KPiBPbiAyMy8xMS8yMDI1IDE1OjE3LCBCaWp1IERhcyB3cm90ZToNCj4g
PiBIaSBLcnp5c3p0b2YgS296bG93c2tpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEJpanUgRGFzDQo+ID4+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjUg
MTQ6MDYNCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBjYW46
IHJlbmVzYXMscmNhci1jYW5mZDoNCj4gPj4gRG9jdW1lbnQgcmVuZXNhcyxmZC1vbmx5IHByb3Bl
cnR5DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+Pj4g
U2VudDogMjMgTm92ZW1iZXIgMjAyNSAxMzoyNg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAxLzJdIGR0LWJpbmRpbmdzOiBjYW46IHJlbmVzYXMscmNhci1jYW5mZDoNCj4gPj4+IERvY3Vt
ZW50IHJlbmVzYXMsZmQtb25seSBwcm9wZXJ0eQ0KPiA+Pj4NCj4gPj4+IE9uIDIzLzExLzIwMjUg
MTI6MjMsIEJpanUgd3JvdGU6DQo+ID4+Pj4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIENBTkZEIG9uIFJaL3tHMkwsRzNFfSBh
bmQgUi1DYXIgR2VuNCBzdXBwb3J0IDMgbW9kZXMgRkQtT25seQ0KPiA+Pj4+IG1vZGUsIENsYXNz
aWNhbCBDQU4gbW9kZSBhbmQgQ0FOLUZEIG1vZGUuIEluIEZELU9ubHkgbW9kZSwNCj4gPj4+PiBj
b21tdW5pY2F0aW9uIGluIENsYXNzaWNhbCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRpc2FibGVkLiBE
b2N1bWVudA0KPiA+Pj4+IHJlbmVzYXMsZmQtb25seSB0byBoYW5kbGUgdGhpcyBtb2RlLiBBcyB0
aGVzZSBTb0NzIHN1cHBvcnQgMyBtb2RlcywNCj4gPj4+PiB1cGRhdGUgdGhlIGRlc2NyaXB0aW9u
IG9mIHJlbmVzYXMsbm8tY2FuLWZkIHByb3BlcnR5IGFuZCBkaXNhbGxvdyBpdCBmb3IgUi1DYXIg
R2VuMy4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgdjEtPnYyOg0KPiA+Pj4+ICAg
KiBBZGRlZCBjb25kaXRpb25hbCBjaGVjayB0byBkaXNhbGxvdyBmZC1vbmx5IG1vZGUgZm9yIFIt
Q2FyIEdlbjMuDQo+ID4+Pj4gLS0tDQo+ID4+Pj4gIC4uLi9iaW5kaW5ncy9uZXQvY2FuL3JlbmVz
YXMscmNhci1jYW5mZC55YW1sICB8IDI0DQo+ID4+Pj4gKysrKysrKysrKysrKysrKy0tLQ0KPiA+
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQNCj4gPj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sDQo+ID4+Pj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQu
eWFtbA0KPiA+Pj4+IGluZGV4IGY0YWMyMWM2ODQyNy4uYTUyMjQ0ZjBiNWQxIDEwMDY0NA0KPiA+
Pj4+IC0tLQ0KPiA+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbWwNCj4gPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQuDQo+ID4+Pj4gKysr
IHkNCj4gPj4+PiArKysgYW0NCj4gPj4+PiArKysgbA0KPiA+Pj4+IEBAIC0xMjUsOSArMTI1LDE3
IEBAIHByb3BlcnRpZXM6DQo+ID4+Pj4gICAgcmVuZXNhcyxuby1jYW4tZmQ6DQo+ID4+Pj4gICAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4+Pj4gICAg
ICBkZXNjcmlwdGlvbjoNCj4gPj4+PiAtICAgICAgVGhlIGNvbnRyb2xsZXIgY2FuIG9wZXJhdGUg
aW4gZWl0aGVyIENBTiBGRCBvbmx5IG1vZGUgKGRlZmF1bHQpIG9yDQo+ID4+Pj4gLSAgICAgIENs
YXNzaWNhbCBDQU4gb25seSBtb2RlLiAgVGhlIG1vZGUgaXMgZ2xvYmFsIHRvIGFsbCBjaGFubmVs
cy4NCj4gPj4+PiAtICAgICAgU3BlY2lmeSB0aGlzIHByb3BlcnR5IHRvIHB1dCB0aGUgY29udHJv
bGxlciBpbiBDbGFzc2ljYWwgQ0FOIG9ubHkgbW9kZS4NCj4gPj4+PiArICAgICAgVGhlIGNvbnRy
b2xsZXIgY2FuIG9wZXJhdGUgaW4gZWl0aGVyIENBTi1GRCBtb2RlIChkZWZhdWx0KSBvciBGRC1P
bmx5DQo+ID4+Pj4gKyAgICAgIG1vZGUgKFJaL3tHMkwsRzNFfSBhbmQgUi1DYXIgR2VuNCkgb3Ig
Q2xhc3NpY2FsIENBTiBtb2RlLiBTcGVjaWZ5IHRoaXMNCj4gPj4+PiArICAgICAgcHJvcGVydHkg
dG8gcHV0IHRoZSBjb250cm9sbGVyIGluIENsYXNzaWNhbCBDQU4gbW9kZS4NCj4gPj4+PiArDQo+
ID4+Pj4gKyAgcmVuZXNhcyxmZC1vbmx5Og0KPiA+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+Pj4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+
Pj4gKyAgICAgIFRoZSBDQU5GRCBvbiBSWi97RzJMLEczRX0gYW5kIFItQ2FyIEdlbjQgU29DcyBz
dXBwb3J0IDMgbW9kZXMgRkQtT25seQ0KPiA+Pj4+ICsgICAgICBtb2RlLCBDbGFzc2ljYWwgQ0FO
IG1vZGUgYW5kIENBTi1GRCBtb2RlIChkZWZhdWx0KS4gSW4gRkQtT25seSBtb2RlLA0KPiA+Pj4+
ICsgICAgICBjb21tdW5pY2F0aW9uIGluIENsYXNzaWNhbCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRp
c2FibGVkLiBTcGVjaWZ5IHRoaXMNCj4gPj4+PiArICAgICAgcHJvcGVydHkgdG8gcHV0IHRoZSBj
b250cm9sbGVyIGluIEZELU9ubHkgbW9kZS4NCj4gPj4+Pg0KPiA+Pj4+ICAgIGFzc2lnbmVkLWNs
b2NrczoNCj4gPj4+PiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4+IEBAIC0yNjcsNiArMjc1LDE2
IEBAIGFsbE9mOg0KPiA+Pj4+ICAgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4gPj4+PiAgICAg
ICAgICAiXmNoYW5uZWxbNi03XSQiOiBmYWxzZQ0KPiA+Pj4+DQo+ID4+Pj4gKyAgLSBpZjoNCj4g
Pj4+PiArICAgICAgcHJvcGVydGllczoNCj4gPj4+PiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+
Pj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4+Pj4gKyAgICAgICAgICAgIGVudW06DQo+ID4+
Pj4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHJjYXItZ2VuMy1jYW5mZA0KPiA+Pj4+ICsgICAg
dGhlbjoNCj4gPj4+PiArICAgICAgcHJvcGVydGllczoNCj4gPj4+PiArICAgICAgICByZW5lc2Fz
LGZkLW9ubHk6IGZhbHNlDQo+ID4+Pj4gKw0KPiA+Pj4NCj4gPj4+IFlvdSBkaWQgbm90IHJlc3Bv
bmQgdG8gbXkgZmlyc3QgcGFyYWdyYXBoIGZyb20gcHJldmlvdXMgdmVyc2lvbi4gQXMNCj4gPj4+
IEkgc2FpZCwgeW91IG5vdyBuZWVkIG9uZU9mIHRvIHJlc3RyaWN0IHRoZXNlLCBzaW5jZSB5b3Ug
YXJlIG5vdCB1c2luZyBzaW1wbGUgZW51bS4NCj4gPj4NCj4gPj4gVGhpcyBpcyByZXN0cmljdGlu
ZyBmb3IgUi1DYXIgR2VuMy4gRFQgYmluZGluZyBjaGVjayByZXR1cm5zIGVycm9yIGlmICdyZW5l
c2FzLGZkLW9ubHkiDQo+ID4+IGlzIGRlZmluZWQgZm9yIFItQ2FyIEdlbjMuDQo+ID4+DQo+ID4+
IEFtIEkgbWlzc2luZyBhbnl0aGluZyBoZXJlPw0KPiANCj4gQWRkIG9uIEcyTCBuby1jYW4tZmQg
YW5kIGZkLW9ubHkuIFdoYXQgZG8geW91IHNlZT8gV2hhdCBpcyBleHBlY3RlZD8NCg0KQ2FuIHlv
dSBwbGVhc2UgcG9pbnQgbWUgdG8gYW4gZXhhbXBsZSB3aGVyZSB0d28gYm9vbGVhbiBwcm9wZXJ0
aWVzIGhhbmRsZWQNCmxpa2UgdGhpcz8gSSBkaWQgbm90IGZpbmQgb25lLg0KDQpJbiBteSBjYXNl
LCBvbmVPZiBjaGVjayBpcyBub3QgdmFsaWQgdW5kZXIgYWxsT2Y/Pw0KDQpGb3IgZWc6IFJTNDg1
LCBXZSBjYW5ub3Qgc2V0IGJvdGggYm9vbGVhbiBwcm9wZXJ0aWVzIGFjdGl2ZS1oaWdoIGFuZCBh
Y3RpdmUtbG93IHRvZ2V0aGVyLg0KDQpyczQ4NS1ydHMtYWN0aXZlLWhpZ2g6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICBkZXNj
cmlwdGlvbjogZHJpdmUgUlRTIGhpZ2ggd2hlbiBzZW5kaW5nICh0aGlzIGlzIHRoZSBkZWZhdWx0
KS4gICAgICAgICAgICAgIA0KICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvZmxhZw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCnJzNDg1LXJ0cy1h
Y3RpdmUtbG93OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgICAgIGRlc2NyaXB0aW9uOiBkcml2ZSBSVFMgbG93IHdoZW4gc2VuZGlu
ZyAoZGVmYXVsdCBpcyBoaWdoKS4gICAgICAgICAgICAgICAgICAgDQogICAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnIA0KDQpDaGVlcnMsDQpCaWp1DQoNCiAg
IA0KICAgICANCg==

