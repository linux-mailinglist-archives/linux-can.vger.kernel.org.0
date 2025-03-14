Return-Path: <linux-can+bounces-3085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6589A6133A
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0F19C13C6
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A01FFC5F;
	Fri, 14 Mar 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PDm7H9yQ"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011035.outbound.protection.outlook.com [52.101.125.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EC1FCF7D;
	Fri, 14 Mar 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960756; cv=fail; b=euaX3tSsLXDevsRZ0f0EqkgZHIzzJPYh8r5rxoYokBFNiTi/YiI8ZrAZeyQ20rSYcDlHVwqKcEZkKAMs8fBakFf30LPseSaM/MyBszqONxm2cywKxHmbi52hOrTfRK///soXEie/TcTWaVr5JfDuEighFsGup2q/Ttut3XsUcVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960756; c=relaxed/simple;
	bh=yV5y0DEW4B2s7CTphDPC8AjT562buB6dPx1mvO0N/7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1Ru5gvyh6zNDXwJC4p8sUilOGqtOvNsNB4yhmrIqOM0og7rWePUFVAzYeoRJDNXUhgCgso/d/1H9ogD3LGGUEvnJtmR1gazI8RU0vgZ9xOAGjY6+FBvlUMKFhN6u5NmsZamqsBZEOf/sL8VwRVaGle2dD8UZHslAxSwiWaU+3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PDm7H9yQ; arc=fail smtp.client-ip=52.101.125.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ0Ue6ivl5bXjJuG9lTzUeMt0ebr4N2Pmu412ouM2tVsegG2gFUEjoUj5EgF6/TCM5fJ2FRWfes8HZxh5tmEayLw91ZrXtMIFYrQ79I7KkUsGL/Nr6nWADrJZ56QLYwMbZ87WelHSUVaPHsMLyHvtfb8xCxK4vanWcIW7iL457vYQ9rqu9LVdglq6MFIoQ/ttDvit1U6ot/fnD9eTju55hLB9M3gXcDpn1yvdMp9iROSwb/43jBUU4EpLDOKliR+IZs6CKKFrcbRiNWCPm9IzyLDtp5XwJJbJGPr0OX3vBOm5bGQEK/ChEencvLHQgcdKeq6QV2KGaPBKi0KGqvjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV5y0DEW4B2s7CTphDPC8AjT562buB6dPx1mvO0N/7Q=;
 b=yoBvG7Ap9dyh/dwH9eO5nTJrPIOTFKLIPN2b9k9zKzEmlaGhIyttTJkBc/JePYNTMHasxFJxKAYUGkh7HlGNwN+wc8hMy44IF0WEsqNtOs9GMLduT5KaSw6yXFnkIBXT8y+99qpIpbRcC+4xBPnWryF3a8G3773rVVSRJhfkbqj8aLGhkLrogVU5vCK9wEqc3d0Rthdxn9Vt7ba1qZkx+VYN/sUKhhDjIyFjbEU/sOklafgtq4qF67PBIWg5XeK0YO0dEr8rfFTOoUnoQja773L9UQRtVjaosjGdtEmhiZOEWBi1jRcyDnscBOOfW4vKwk0iT6WyalNbVBLZU7xQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV5y0DEW4B2s7CTphDPC8AjT562buB6dPx1mvO0N/7Q=;
 b=PDm7H9yQw2UFwu4sVnbxiOxg5SQCuR/cbeBoH10l7J0flK2/zdZaNWQk5nZ6IsZnMV6sdHADYpJnFO4GOJqtJdhIDYg3PgcVKz0LLA5tOtEN4PHQZ9N8hDP/8SbpcEx4d+wSSF8W1AeRajxt5k92HbG3CFAA5xlY81546jxfA30=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13054.jpnprd01.prod.outlook.com (2603:1096:405:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 13:59:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:59:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Simon Horman
	<horms@kernel.org>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v4 02/11] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Topic: [PATCH v4 02/11] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Index: AQHbjpVUuP9gjodQ9Uy99B15MhUwB7NysCGAgAAEBNA=
Date: Fri, 14 Mar 2025 13:59:08 +0000
Message-ID:
 <TY3PR01MB11346FA2425D6FDB9911C58C186D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdWGzSAVBh=TW2Ym-oEg0Q8z1HfMDsRbw6kOf-oUtwYJ3A@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWGzSAVBh=TW2Ym-oEg0Q8z1HfMDsRbw6kOf-oUtwYJ3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13054:EE_
x-ms-office365-filtering-correlation-id: e51b2960-47a1-480e-5882-08dd63006437
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkZIaHlZSytweENNVGNSQU5UOURRcEF6S0EyeUNFOWZxb01SYnU5NUV4RVFm?=
 =?utf-8?B?ZmkwbCtna2ZDL0kvREJ1R3JHQVVkWXkzTTV6MkxiYy9RNi9xYXZ2QVZsam9h?=
 =?utf-8?B?MjBMNXZGNkJScVN5eE56YmZLa1JzaVVGNFI2RFU5cmZFcHREUkxDS1VTNE9q?=
 =?utf-8?B?bWZ3SjVvRnQxVTlRaVN6ME9STGM4MERwRU1DQ3lMMEIxUFlKUzRpUXdqWkxS?=
 =?utf-8?B?UnZEcTQ5cWhHSG04Z1ZLK1YzK1JEVnhmY1pPWDZnclNlOTVLYjA4RnNJWEhR?=
 =?utf-8?B?YU5oMUFnVGVlODcveGd3dXVvSmhTbTV6YklrK2ZEbGFCd0dCcXA5Mzcrdy9K?=
 =?utf-8?B?VXZ5VGZEZ0dvTnQxVzgvdzY3QjdpOEFkaUhVNHN0V0JVNlpQNUN3V1JpUWFT?=
 =?utf-8?B?b0pTaXEyZjJBaTBqcncxVlFMbGJBOWJweWttS3p1ZEhoKzFUWDF4NTJsWXpS?=
 =?utf-8?B?bmx5L3FiQjRTbFNQMnp5ZjBSdmh3MkU0cGNsUlFGWVVPaStidmlxVk9Qb20v?=
 =?utf-8?B?dUJzajNCQStEYTVHbDl0N1R6cVZEWi9QZDJqeWNEcGt1OTJvNVZjVHJsYkFQ?=
 =?utf-8?B?cEc3VTNXazlqWis0Q3dxeS9IRHdkNU01bjA1NTZjZ3c4ZnloUWtFVWlqL082?=
 =?utf-8?B?OXNwdUx5STBGeWtHK0lMM0JHUnYwektSQ2ZJanZueFJYSFh2QTllZ0ZJZk96?=
 =?utf-8?B?cm8vRnF0aFBKNjAwc1BWTGRFWGRDMVFzWVVuVUQ5QjU1MDRwZlBuWmNGSi9Y?=
 =?utf-8?B?ay9aQ2ZYcHlxUy90ME5oQ00vSmlkayt2NkQ4ZnZxRjJVTGoyZ2Z4VjZIQkxX?=
 =?utf-8?B?SVRqMXRVNUZKbE1nRjJ0N1JTNHVyUUJuaTNrUnFRVGN1dVR1ZWMwaUdPTlZF?=
 =?utf-8?B?dzRxQ3ZXd1YzWVlJVDk3eTdmRkFFREErMDBGMVkxQVVtek5mb3FtaEhud0da?=
 =?utf-8?B?NEpiUlBHTWlTdjhjcVh4di9vbjlrMTZ1ZUQzWjRmUGF3NjZXUTk3Mm5hRGha?=
 =?utf-8?B?b3RuLzlRaXh4dEYwWDBoeW9zamRRaG5iWXoxOWlBU2R3dmxZT0ZvdWdYU21T?=
 =?utf-8?B?SGJpZ01nM21HZGo2eTB6VDB6SjQzNlRRTFRRTUFxNDEvVmlveERLYmRqYmFX?=
 =?utf-8?B?L0Zjb1E0dDlTaXNKMmV6Y2lZOWNOM3hzNVZ1bEo2d0dMbE5EU1BFc05ON3Vn?=
 =?utf-8?B?Tk8vMG54a2RPbHVjcnV6SVZvN0t5aStKZVQyVzBvUlBNYU8yM2xnSnRwYUlY?=
 =?utf-8?B?bDAzMVJWbXA1V1JxakZZL0dpNTcyVzVNcmRmRWt2S3N5anJQcW5xTUppMU9k?=
 =?utf-8?B?N3h4WSsraG1jYTFpZXNJNHZkc2dEaEgwaFUwVVpBZWlmd1VVYk43MFR3YlB4?=
 =?utf-8?B?UnBKRm8rSVFnR2k2ZWgxazRubXVFS0sveFlKckNkTTZrcEV1U0E4Z0x5N3pr?=
 =?utf-8?B?dG1iMEp6d0NWbHFhTjdsTVdnODBrMGR0OXIvL1I3ZGlJQmhDQmM1aU5YSDg2?=
 =?utf-8?B?b3ByV1g0RFQ5NHlacGpYR3FDeXFob0t2L0RyaGJaakE3TkFoSHBrMlJrTTJ4?=
 =?utf-8?B?aXlDTjV6TlN1ZnRSMmF3R0hqU2pXbXphVFpJQ1BISzFPY3ZlSHRaTVUrcDF1?=
 =?utf-8?B?TDUrc25aL0N2aThEUTgxTUI4aWNGMlJuejZPc3BlemxsN1FxWWpWRlFHOFpT?=
 =?utf-8?B?Q2QyUmZiVEVuYXk1dkliZTVpQWkyQ0ZXeVJxdlNSNGl0bWxSVlBHYmlVQmRw?=
 =?utf-8?B?azE4alJ6RThnMXp5cTVXOXVZV1FBNm5UVkwvb2lEcE1ZTnhCSFFNM0twQkdl?=
 =?utf-8?B?TEd4MUhhU2FzQjBSMkpWMnRXWC9PODIyblpWSEFwVHJoelZhM05tNE5RYURZ?=
 =?utf-8?B?dCtHVFlxVWdodVNWZ01NcnVRRk5NZG1IbnJuR1hXNzlpS1dWeVRVVkhOWG9N?=
 =?utf-8?Q?mAI36UMtzXGWWFCullaVAFZyhPb4FzVK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVlLOGxUSjJrb29hUnM1cG5yNlkrTXBRY3piSWR5WW5PVVVsQ0xqbEI2VHdH?=
 =?utf-8?B?MEdtUEVpbWpRaGorenFCWFlFSWZBQmhzZEN3VTJXV1VIc202U0l0UnJYMU4r?=
 =?utf-8?B?dXFnVkx0cDJScDV1NkVQSEREdGxGRW00TUVHVFJ2NFRub2RSM0lHaThSTUVC?=
 =?utf-8?B?QVp0UmU0cTJ2dnJLc3VTY0I2dzBvNHZMN2k1SFd5T1JjRTBJaE01a0dmVWQ0?=
 =?utf-8?B?R1NPL1AwamhnNzA4TTVNU2pGS3lqQmV2YmJhVkVoYm9ibDNwMFdFb0loektL?=
 =?utf-8?B?eEVORUJkSUdJaThsalE2dXhrVW5hSVY1RS81NTRqVVdLbEIyMnJXWCs0MFJO?=
 =?utf-8?B?U25oVWlPSVl3Slg3ZkxteXhLNTNzSWRTQ01zblpheGhyYURpYjJNZ01reDEx?=
 =?utf-8?B?SUpoV1p3UG81Sml6cHYxaVZvWGdJZHNpOXN3OFUzTG54Z0lLVm1vaFBFckpx?=
 =?utf-8?B?Rzd5TGhmWmFBNlNvdjBPVE9zL21lZU50dFFxMFo2cEhIQ2FTUWJ5MzQ2U2pi?=
 =?utf-8?B?WVNmQTJuNHpaeDZpd1JuWndmMnBGdmpmV0tRU0F2STN2TEpvaVZyWjZBTGRV?=
 =?utf-8?B?ZW8xalhpdktMenFmK2tOakRFYlpINVI5YnpaNGlsU0VPSldLR3o3RWlla0pP?=
 =?utf-8?B?NGFWZnM0QmRzc0NnczdOMUEyZngrL1lTUG5tTUlkM2Z5ZEVwWkdQeGxCOEt3?=
 =?utf-8?B?T2N5Sk1MbFlxZHh6R1pRelYzM0k2QnlIZEZqRXEyTkU2d1pFVDNLbW9ldDdE?=
 =?utf-8?B?MkpNNmZDZjhvSmNYZHdLSVJ1QWM2dG5nNGdwZXBERkt4WjFad3Q2cDVDRDZN?=
 =?utf-8?B?NDg1RzlUQS9IZ2tqQzJ3dnFrRVgyazhuOGNlc3I5UE1jUG1EMk8yUzJ4cFNx?=
 =?utf-8?B?N2dHZXBjWmlVRDA1dWxIQXE5NjhVbkRDRUJ0RDlOSmcvSllLQnlJR1BxdXVM?=
 =?utf-8?B?OE11aWw1YXNXYlF0Y3lBRU1wN3RyS29qNTVtTXF5dktiK3BqUU8yVnY3UUg0?=
 =?utf-8?B?NlZYd1hYWGwvUmtlQTJaSEVDemxOQzdqK0JWZkJNMk5MRGd4TzVSVWdNVmE4?=
 =?utf-8?B?Q00yOTVsbDVUc2JUU1ExQUdiZS9QUUR6SlcwcXBMeEFKZElic0ZmNUFDZ2ZR?=
 =?utf-8?B?cSsyVkZjbHZ4TXhtUkViTjdtNXBvMDNwd0NteUFxT3lzNmJlL21wU0YybG5C?=
 =?utf-8?B?OU9aeCsxSUxPUWN1Vkc3ZlNQU1BGR25TVGFBbWFQcVpuU1E0OWd2c3l5K1Z6?=
 =?utf-8?B?dksyQWNHNkk0RWZVVXFGOStIZXpxdFV2bnRLd2Nsc2tncFNob2VxMDNJSDVn?=
 =?utf-8?B?b1N4S2xNMTJaNUhWc0t1R3pRNVptRlRVMVp4NUtUa21YY25pbG5zZ2xrWTdB?=
 =?utf-8?B?N0g3aU5CckpHRDNJbXFlZHB2bmVpbkd0K3NQK1ppWHNVekFWTEw5TzVUaTBl?=
 =?utf-8?B?MVUwRWdkVEM5MStDQUhoQ2NJbnJpY3RSci9OTVZqOVQzOWdpWUU1a05WbFNQ?=
 =?utf-8?B?dGlUVTYwdGkrRXRINzB6TGRvYXNIYmdRMlFjbUpUUjg5d0hLWGF6RDJnUkFl?=
 =?utf-8?B?ck9MVzVFclVNV2t2WmhBYnpPUVVlakhDejFkZ2JWZ3hNZHczSnVHUzlpOWhp?=
 =?utf-8?B?TzVpTkZyZXVqajFXUStiV3cwd1VvOFV3RWJaNEtuRFNLY0xEYjFteW1hSkg4?=
 =?utf-8?B?eVVRNnI1dWlPYmpJZlpzR08yYWJxck51YXBhaXlXZVRLWS82b25TZzlJL3dl?=
 =?utf-8?B?RXQwSTcraUdKL1FkSnJ6dis3ZTAvSFRBeGsxNzFLWDVENWs2YWZjald0cW01?=
 =?utf-8?B?RWdpck0rYmRCZTFwQUt1ejhvbkF5SnUrTzhVaGhtUGVldXl0bVQva1UyQ0Zs?=
 =?utf-8?B?bCt5aHVwdk1aTXd0a3BCMkZsZG84eHVqK1Q5MXowUkNZNTdNSjR1eUxHN3lT?=
 =?utf-8?B?M3dreFl0Si9qRzZvREtpSzNuaVNEZ1JJSjdDTHZBSmpicnZGR0F2YlNvNUQr?=
 =?utf-8?B?azFVWmpXRVlyZ0ZEWFd3RXBYa2o3RzRKTWFCbnpFQWpqLzZpeEtYNWlEZU5R?=
 =?utf-8?B?dzR3RVNyaCtVYkhEZjlwSEdIZnJINExweUpqeHhNZEd4eWNHQ0NVVVUxZTR4?=
 =?utf-8?B?cWg2RG5GWnhFb0p2elc1WWF0eUZpVTJBUSs5YkNXR0V1Ukx0ZjJhRlhUak9r?=
 =?utf-8?B?ZXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e51b2960-47a1-480e-5882-08dd63006437
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 13:59:08.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcmFCjfqATxyvQHgdvrTRIInnS3aOjfe6B/b2ADQC8gCcaxXYgiPzJob9XPE4TvlwkOVcpYt5Z1madluNi7QX0j4zUlJfu4FGXjXD3/BvgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13054

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTM6NDANCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwMi8xMV0gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBEb2N1bWVu
dCBSWi9HM0Ugc3VwcG9ydA0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFRodSwgNiBNYXIgMjAy
NSBhdCAxMzo0MywgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToN
Cj4gPiBEb2N1bWVudCBzdXBwb3J0IGZvciB0aGUgQ0FOLUZEIEludGVyZmFjZSBvbiB0aGUgUlov
RzNFIChSOUEwOUcwNDcpDQo+ID4gU29DLCB3aGljaCBzdXBwb3J0cyB1cCB0byBzaXggY2hhbm5l
bHMuDQo+ID4NCj4gPiBUaGUgQ0FOLUZEIG1vZHVsZSBvbiBSWi9HM0UgaXMgdmVyeSBzaW1pbGFy
IHRvIHRoZSBvbmUgb24gYm90aCBSLUNhcg0KPiA+IFY0SCBhbmQgUlovRzJMLCBidXQgZGlmZmVy
cyBpbiBzb21lIGhhcmR3YXJlIHBhcmFtZXRlcnM6DQo+ID4gICogTm8gZXh0ZXJuYWwgY2xvY2ss
IGJ1dCBpbnN0ZWFkIGhhcyByYW0gY2xvY2suDQo+ID4gICogU3VwcG9ydCB1cCB0byA2IGNoYW5u
ZWxzLg0KPiA+ICAqIDIwIGludGVycnVwdHMuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogUm9iIEhl
cnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0
Y2ghDQo+IA0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT4NCj4gDQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55
YW0NCj4gPiArKysgbA0KPiANCj4gPiBAQCAtMTczLDcgKzIwNCw5IEBAIGFsbE9mOg0KPiA+ICAg
ICAgICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICAgICAg
ICBjb250YWluczoNCj4gPiAtICAgICAgICAgICAgY29uc3Q6IHJlbmVzYXMscnpnMmwtY2FuZmQN
Cj4gPiArICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscjlh
MDlnMDQ3LWNhbmZkDQo+ID4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHJ6ZzJsLWNhbmZkDQo+
IA0KPiBOb3QgaGF2aW5nIHRoaXMgY29tbW9uIHJ1bGUsIGFuZCBrZWVwaW5nIGludGVycnVwdHMg
YW5kIHJlc2V0cyB0b2dldGhlciB3b3VsZCBhbGxvdyB5b3UgdG8ga2VlcCBhDQo+IGNsZWFyIHNl
cGFyYXRpb24gYmV0d2VlbiBSWi9HMkwgYW5kIFJaL0czRSwgYXQgdGhlIGV4cGVuc2Ugb2Ygb25s
eSBhIHNpbmdsZSBsaW5lLg0KDQpJIGFncmVlLCB0aGlzIHdpbGwgbWFrZSBjbGVhciBzZXBhcmF0
aW9uLg0KIA0KUm9iLENvbm9yLCBLcnp5c3p0b2YsIE1hcmM6DQogIA0KVGhlIHN1Z2dlc3RlZCBj
aGFuZ2VzIGFyZSB0cml2aWFsIGFuZCBpcyBqdXN0IHNvcnRpbmcgdGhlIHByb3BlcnRpZXMgZm9y
IGNsZWFyDQpzZXBhcmF0aW9uLiBJIHdpbGwgYmUgc2VuZGluZyBWNSBmb3IgdGhpcy4NCg0KQ2hl
ZXJzLA0KQmlqdQ0K

