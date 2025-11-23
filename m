Return-Path: <linux-can+bounces-5621-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BBBC7E2E7
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 16:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDD684E1BA2
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E992D4B6D;
	Sun, 23 Nov 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Ret3AdDv"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCF2C1586;
	Sun, 23 Nov 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913210; cv=fail; b=TGv9rWpviX/PsgXcO1n0QrzCswHOUglZ3r4ZKCvvg1MEMQpZWwCOV+cLr0MawZugVsLUgSMtoinCXoVg14jnHkoC6AY9OTApj2pOXpZmn96hi44ubCDyKl/Gkz00SpeTE9R8XRE7FCknoCLFPTMgfol6/sB/7YUreIbX21FX5TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913210; c=relaxed/simple;
	bh=3SfoUVVObRu7fUa6wWzDabFVJysC1kaWxibJlqdixTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpAqife7CnWX0QvXr6pObtyEHwYN4TWCIt9LINOxEUT3nz5SkkRcMv1EDAuMUTCY7Ronudujldrpc3JZOrD+9+JFJkQ2LQ1QV17VUSryIS7FE/xJ/MB5FgYCs1sd6AV1Ah9BsypTHyBbdmbh4y4LETgs2Q/3O6ObTGeA2YspJBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Ret3AdDv; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjM52z1EF8f9A6X7i18eMgI5OHaHPPlAP/js5B2d3JPfskO0bQQ1UJp22K0rnP0thB1/9PLimEvTcJ87UITQmGcaYB8Vw5pjEoJbpZvHGJvhT7kLgUSxQjewaFuc176FD2zLiwl7xXKoIbv3FxvmwPY0JC/sI2tlZ5XEwUOAY9S/N48E7SJECrep5r6/7i9IWi1YzbqzV1V6Gqbcab31eU5tFmyV8l9zMosMcpqySXQ8ceswkIM6gXC5bOTasgDyyQOJqM63A7Lg8aMdKScfXxIhpwLHAqWnUqyEY4cFAzlXgwSJPbknTpjDEmfhXC+AxOKp+Rjkszf53mmfFmRfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SfoUVVObRu7fUa6wWzDabFVJysC1kaWxibJlqdixTY=;
 b=Lj/Rik6ag6ZFjJVdXy3uatmyf0EDsMQnDSg1PjNi9JQPeNH3G+ImG1K9BqjIrof46DtXdPMcUmfLJaAPMfFGnt1h/lj7pb++Z1uPAzR7agAJddIH+MPMqsB8pV3Ap28SdZjE6DSDXa0Dhu1FiQ2mVLhL2lBes4s7FHlbc9eE98HxSn3b9piGddbiiocIx8LzxD8PoeUlbtZyzaQIXPuQUkwIqdCyFvjd/kuR4pFbnuYXwsF0/zZ9KHcQ3GF7PoqLhltQamtWZ67jcl7xf40PHGaIqDnQc/ARRnG00vK/b8E8X/bQdj9KqTH//sQWaJRDNvpPjrUiKEvlnpX7tu2ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SfoUVVObRu7fUa6wWzDabFVJysC1kaWxibJlqdixTY=;
 b=Ret3AdDvYGGtx/McoNrlFb7RHTmuv/3o9SSzA/CHIRiXvPBs4dXW8QO/sd6zc+O5VeNKoa4SZnfq2HVqUCdMpLdSrikseh3K3sp88kbY77s+VPq1Qb1Op437tNmbrQFo82whisrVzew6ocRaNdB85LzFNfaVut3K3gOY9q2q5+M=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OS7PR01MB17400.jpnprd01.prod.outlook.com (2603:1096:604:43e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.6; Sun, 23 Nov
 2025 15:53:22 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%2]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 15:53:22 +0000
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
Thread-Index:
 AQHcXGubPTkKPcpfPUaJAr71uDlXKbUAQHWAgAAKwkCAAANJAIAAAZ2AgAANeQCAAAO5AIAAB/Sw
Date: Sun, 23 Nov 2025 15:53:21 +0000
Message-ID:
 <TYCPR01MB113329C425A1AC666909624D186D3A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
 <20251123112326.128448-2-biju.das.jz@bp.renesas.com>
 <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346729E8758CFEF18C9E99686D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <24a71741-df53-4726-81d1-38c9eb3ad12a@kernel.org>
 <TYCPR01MB113320211AB2810248A021C8286D3A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <148f0db8-1c86-479f-9a21-5b9d882fec8b@kernel.org>
In-Reply-To: <148f0db8-1c86-479f-9a21-5b9d882fec8b@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OS7PR01MB17400:EE_
x-ms-office365-filtering-correlation-id: 5f0cac2f-35c6-483b-e0d0-08de2aa86de5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ankwZkxyeE5BSWRrQ01TWXBJNG02N0NFbWlDMjNyaXhrUkVUTjZXbmlLb2d6?=
 =?utf-8?B?Qlg2Vi9LNmFKT1o0ckVEbG5ScUFaWUVKam81TTBGaGh5VlZld2NKQXh2MkNQ?=
 =?utf-8?B?eWlKai9sT3JkV0Z3M3dVYWhRWmpZcHJGelYxM0h4OVBpVW9kaWlPQTNSdVlq?=
 =?utf-8?B?R1o1MjdFYmU1d0tqLyttRU8rRFowMU1pTUFYa2RvVml1NmdMdk1DTVNVOGc2?=
 =?utf-8?B?SDFxK3dLdEorUERUR3FlS0JGZFo3NXQyd3ZoZFJZeUJPSXpBMzF5V3huVE1w?=
 =?utf-8?B?eWs3MFRBc0hpWit5Z05hOVlwRTZLZmg5UXZkR3ZxWEQwd1g5aXRGYUZKUDUz?=
 =?utf-8?B?YTdkWmZSZlhlKzNydVBubHhQT1kxSFRTL1Q1QjAxb1NZRDdrOGErLzlnTDZ4?=
 =?utf-8?B?Q2o2TVRaWUM4Sk1maEdOUkx3b3ZNK3h5eVVqdXlSWEx4eTVsR0c1L0Yyckww?=
 =?utf-8?B?dzJhTVE5ZlJ0a1N6V3Uza0xDaWxuOVl4bmtFalptTDVoeERKTmhIOXJDZkpk?=
 =?utf-8?B?a3FjUmV1cHlWd0tOdjFXUjFXaGJNdW5wNmwrYitNN3BSV043RVF6b2hKTklC?=
 =?utf-8?B?UVJZcjRzVi9uWWpsQjFOWFNaOEswekdNdTNlMWxzdFVoL0lWbDlaeS9JV3BU?=
 =?utf-8?B?Y2txczlsSmNoSXhRbTc3bUtiYkhCR2ZmYjJhZGVLK2NUU3NMelZaaUJxNnZk?=
 =?utf-8?B?R0pFc2hySW1YdDJkZTUrN0x0UXErWDZFZXhXUDZ5SG13UmhTWU1MYm9jdDgv?=
 =?utf-8?B?d0ZXSVRPWHZzSjhVR2pBQ0g3bXFRQVdTeFVEWHNjaWFUdFJvNVdkSCtVMjBv?=
 =?utf-8?B?VTFybUtjMUdYZEVyT0NTZGp3UkhLMFExU1RPSDIySUtveDNFZWdDWjBtYWYw?=
 =?utf-8?B?WmJnYThrOGpoa3J3WTVJQnl3ckpWaUliZGxHT0ZMK2FiaGp0MHRHNDBQYng4?=
 =?utf-8?B?eUIrNitGbVhEUnp6TVhRSFZUbGNjd1NZcWluZmk5TlJwRnpYR2lCT2pidHJ2?=
 =?utf-8?B?blVKaWdkRmc2ajdldEFKcWJtbU5LTGlGRFNrM1N2UGNwazV4bFBHRkpibW5V?=
 =?utf-8?B?Z0FLVG40eGtvQ1M2bFNlSFRWV0t6eWdYYWgzaTFSWDRrZ1RKSmVodktYeDEx?=
 =?utf-8?B?QmZlTW5pYjJHc3pZaDJQRDN0MkdhZVIweHB5clQ1a1hkM0p3N2Z6aWFkSTZ0?=
 =?utf-8?B?RjkrclluMXV4T25EcHliY0JDUzhxemZoRHNpdEtlM0QwMTMwZTlZNHZJVzRE?=
 =?utf-8?B?Y0hPaVBjNUNKbUUxc3hvbFJWeUZDZHhvT3hpYVo1LzFRSllKVXJZQnpxRmt3?=
 =?utf-8?B?OUhobVlLQTJIQ0hCUW9xM1l3ZXZKTDA0dG9TNzROc1dZakREVVZmNW1nYVd2?=
 =?utf-8?B?WUxsSWJmeGtoam0rOWc3STFhVk5TdFNNY0lMK1VOSmpYaGNCdkJpNWNweHpw?=
 =?utf-8?B?NkRRREFObUdsVERUSlhUa0tOdks0ZDFvbmZqZVNhaVRCVURwT3FLTTdpaENO?=
 =?utf-8?B?Rm9ZUUZBMTRGT0t1NUpvdGl5Q3k0dEpwSFRIOXB6QnhTYmh1aG0zM2M3dmRx?=
 =?utf-8?B?dytxM3pkMnZyWDg2ckVZcTRzWUsrQWsyVEkxR1hnaFBYZm9CR0lXajRQWDZ4?=
 =?utf-8?B?MG1HUEpaOWVDbGRnaFhFcldtcjRqUkIxUEhldUVKM29uRHpKTm5Xc3JqRzl2?=
 =?utf-8?B?N3dlZUxVejRsUjIzWDdCOUZiNEtUVnhtbmZqeXRaVTIyYVJHbDJOYmw5Nlly?=
 =?utf-8?B?cG5meFA2V3I4Q0cvalljN2R1aUVQdFo0RCsrL25FclBlQlFEa3ZHellTV3d0?=
 =?utf-8?B?VzlsUGlyYWxBbmE4azBpMVMzaFZJKzBDRUhHVVExcW9QU0UzYkN3L2dHckRX?=
 =?utf-8?B?UkdSTmo5cTdUb1FFZGU1cncrL3g5SU1FR3I3RVZNbWcwb0lSOFlUSktwbmVX?=
 =?utf-8?B?dGdBc3VIcStCcGN2bFhtTGNaaVl2MTVpZ01sQ24vTUNDRG1pTHErSXRZMTFN?=
 =?utf-8?B?c0dSRURiekJvT0Z4L2lLa2dIbFNWc09GVnhNUDN3dXFLT3V1QVA4UnYrdGJ1?=
 =?utf-8?Q?OBNSkH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEFwenVuWnA0Y083YW9kbmVYNUNoWnQzUXpHNDlPKzV5Ym1LREJYMGFETjdn?=
 =?utf-8?B?c2RNbFhueUZaRlhQOWtTMHhmMzNYeWV0T2hVRWo0MlVwQUQ5dHVvdkZnY3pW?=
 =?utf-8?B?RWN3Tk1IemJMNVZ3dVh0dWNqNFRub1o0aHpoTXFocExtcS91VnJ4dkpnWndT?=
 =?utf-8?B?ZEFlUjBONzFJdnI3MHVNcHBzeDN1VzN3Q1ErN1RkOG9ucFlrbXloU05xUG5p?=
 =?utf-8?B?bGdUWHd1ZXcyTVNsQUFwR01xZHNneWxDK24rVitEcGtzcEdiNW5XUXBzSEJH?=
 =?utf-8?B?elpGVTJCVnphcnBwUldybUx1V1NFcnF4SHJZYmYxUENlb1czbWlYTlo2MnZm?=
 =?utf-8?B?bE9BajBEK0dKMjBlcXQ5RzBoakFVZkQzSlU5WmVQbjRlWkMxOG1LL0RmVUNU?=
 =?utf-8?B?TXpnNVZRZml1WEV2V3VPeEZwQkl1Z2VzTEtXY1NIaGJoYmt1bWJpMG1SWVRV?=
 =?utf-8?B?cktsak0zV1JSWVYzVzFtZjFQaGV0Z2RHVElKQTM0ZHhPaDJPeWkrWFlERnVj?=
 =?utf-8?B?bmlmMDgwNTArSDNWbjVGYmRWNHBQelgwbFNGeFVtK2lteVZWODFzWks0TEQ5?=
 =?utf-8?B?S3Y0UkR2L2FRZDR5NEEzcFNYNmlONFFDc0djRm5lQzQ5WUoyWm5wRk4xaTVI?=
 =?utf-8?B?Sk05SjdWM0lNTFpXNW5IYjdMcWdPYXArQWYxMHU4NlM0cjNOY3BoamdiVGJm?=
 =?utf-8?B?eDdzZDZNa21QR05NNzd1bk95VVJ1SWNmelU3eGZXck84MVVrVjIvQ253ZGJS?=
 =?utf-8?B?OTJVQTR1MzNCWjJWY2NpZ2g4SjB2a09PSWpPdUZSWmJqU1hNcks3RkQ3OGxV?=
 =?utf-8?B?eW5xOXJEZ3F2eG1ZU2lhUkRzdGsvbHhCLzlRWFpPM1lNbjhQSnNPd200Y0pS?=
 =?utf-8?B?T2Z3SC9idkUrMUtvM294MjR5NEU5ekNMWWdocTJjSGJEUFdqYWtVR2UxY25O?=
 =?utf-8?B?QWdZN0paaW8xNzdSMnRkbWdydm5mWERRT1p2N3VoRHBTTG44MHpsMEM1dUl5?=
 =?utf-8?B?cCs0R1ZhZ3hyejl4MGVycEVLRnNhTEpabDVUazc5WFczWEZIQVlLVXRnR0R1?=
 =?utf-8?B?M2tRNkhreVFaVkc0cWkwOVl3akRHSTJmRHlsazgzSVpvdkQxVzdHM1VVdS9S?=
 =?utf-8?B?Z1VEeEUybmFEdEdDMVFVdkYxak1jZEszRFdKZDhKODdXVmpxYVFGZzBWeDFy?=
 =?utf-8?B?SWlNbXkyMjlycFJXY1pKOFh1Wm5hNksxSkg4NEdEY3JrQ2o4blRlT2FtRUhE?=
 =?utf-8?B?SlRNOU1SZ3RXUlNlc00yOTVoQnJETjR4b1kxYXRONzBCV3BjZWZ3NWdYTk45?=
 =?utf-8?B?ZGZUbGlNYW14dFQyNFZvTHBvNFdPVEhYcU1xblZ1M0I2dlFTaDZ5WTNWMVRz?=
 =?utf-8?B?dy82d0FWSDFNck4zQXk4cGNwK3JRWmo0UG9KWXBXVUtxV1JoUW9lUUdBVUp2?=
 =?utf-8?B?bXZUQ0NBbmJ6czJ4SVNMbG5CeDVqTFJpMkJoZE5FVTRoNWd5VzBMczFiQms4?=
 =?utf-8?B?TGFOY3R6Q0w5WVFRRDVJMUN2UlJRTkRZSmpvc1IyZTVFeXpQTUgvbm8yQkZD?=
 =?utf-8?B?RG5WZjA3S1dyU0loT2ZJMHhnaTVPVzhJeUFnck1PUUkzbEYyUCt4b2gwc0py?=
 =?utf-8?B?ZFk2ZTh0NUZQOTR4TUczNmYvVyt3UWwwQ044b010QXlaVDcvTGxlam9ZNTZa?=
 =?utf-8?B?Wk1Kc2thZnFUbjdQcFhKOXdkc2pGVVRwOHp0MzJMZmhlejY2c2JCdk1aQmR0?=
 =?utf-8?B?Zm5qTy8zTkh4QXI5akpFbnBUNS93MEt0UisxeisrTzFYbXpEcFN5UUk4YUVS?=
 =?utf-8?B?MEs5Yy9VVTVCekFxc1VHcEtmQThKanNUNzBsb0kwY1A3Qngzb3FWNXNucXY0?=
 =?utf-8?B?OHVhL09VWGJCbnc0WXZ4MEJZQURGTno3bllrZzNMY2M4RGFCL3A5OXJmMFFJ?=
 =?utf-8?B?dDRLNlFjVWJPekJoa0g2REIweXUzRTVFZm1zeDJkWFZFT09zVmRzZlVFK21H?=
 =?utf-8?B?aEJ1U2ptZkV6dFFaQnNBZkoxQ1VMdlh0SVRZbmZPMzNQYm81SnlFaGMrWVpG?=
 =?utf-8?B?d2trNkRpaDcrdi9iMjBKMm5hc21INTVWS0p4b0tFREZDM3pYczR0cFZ2RWc0?=
 =?utf-8?B?TCtmSzFiaEc5MkVqdFh3czRkK0Z3K0FwVHh0VUxveWFzOGZncTNDNG9vWENw?=
 =?utf-8?B?VFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0cac2f-35c6-483b-e0d0-08de2aa86de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 15:53:21.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfgK8KFil9w0x1ZHnyLgV9Bv5z+5m2PysIFjYtq7zDLYxhyGsfLZh32nsZou+rkxbsesFdOQoPCcEP9QO1lB4ODq4yNsL62YlZ98zbSJbLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17400

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMyBOb3ZlbWJlciAyMDI1IDE1OjIzDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2Fu
ZmQ6IERvY3VtZW50IHJlbmVzYXMsZmQtb25seSBwcm9wZXJ0eQ0KPiANCj4gT24gMjMvMTEvMjAy
NSAxNjoxNSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjUg
MTQ6MjINCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBjYW46
IHJlbmVzYXMscmNhci1jYW5mZDoNCj4gPj4gRG9jdW1lbnQgcmVuZXNhcyxmZC1vbmx5IHByb3Bl
cnR5DQo+ID4+DQo+ID4+IE9uIDIzLzExLzIwMjUgMTU6MTcsIEJpanUgRGFzIHdyb3RlOg0KPiA+
Pj4gSGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBCaWp1IERhcw0KPiA+Pj4+IFNlbnQ6IDIzIE5vdmVt
YmVyIDIwMjUgMTQ6MDYNCj4gPj4+PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEvMl0gZHQtYmlu
ZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOg0KPiA+Pj4+IERvY3VtZW50IHJlbmVzYXMs
ZmQtb25seSBwcm9wZXJ0eQ0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprQGtlcm5lbC5vcmc+DQo+ID4+Pj4+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjUgMTM6MjYNCj4g
Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBjYW46IHJlbmVz
YXMscmNhci1jYW5mZDoNCj4gPj4+Pj4gRG9jdW1lbnQgcmVuZXNhcyxmZC1vbmx5IHByb3BlcnR5
DQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIDIzLzExLzIwMjUgMTI6MjMsIEJpanUgd3JvdGU6DQo+ID4+
Pj4+PiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gVGhlIENBTkZEIG9uIFJaL3tHMkwsRzNFfSBhbmQgUi1DYXIgR2VuNCBzdXBw
b3J0IDMgbW9kZXMgRkQtT25seQ0KPiA+Pj4+Pj4gbW9kZSwgQ2xhc3NpY2FsIENBTiBtb2RlIGFu
ZCBDQU4tRkQgbW9kZS4gSW4gRkQtT25seSBtb2RlLA0KPiA+Pj4+Pj4gY29tbXVuaWNhdGlvbiBp
biBDbGFzc2ljYWwgQ0FOIGZyYW1lIGZvcm1hdCBpcyBkaXNhYmxlZC4gRG9jdW1lbnQNCj4gPj4+
Pj4+IHJlbmVzYXMsZmQtb25seSB0byBoYW5kbGUgdGhpcyBtb2RlLiBBcyB0aGVzZSBTb0NzIHN1
cHBvcnQgMw0KPiA+Pj4+Pj4gbW9kZXMsIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24gb2YgcmVuZXNh
cyxuby1jYW4tZmQgcHJvcGVydHkgYW5kIGRpc2FsbG93IGl0IGZvciBSLUNhciBHZW4zLg0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4gIHYxLT52MjoNCj4gPj4+Pj4+ICAg
KiBBZGRlZCBjb25kaXRpb25hbCBjaGVjayB0byBkaXNhbGxvdyBmZC1vbmx5IG1vZGUgZm9yIFIt
Q2FyIEdlbjMuDQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+ICAuLi4vYmluZGluZ3MvbmV0L2Nhbi9y
ZW5lc2FzLHJjYXItY2FuZmQueWFtbCAgfCAyNA0KPiA+Pj4+Pj4gKysrKysrKysrKysrKysrKy0t
LQ0KPiA+Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYgLS1naXQNCj4gPj4+Pj4+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhDQo+
ID4+Pj4+PiBtbA0KPiA+Pj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWENCj4gPj4+Pj4+IG1sIGluZGV4IGY0YWMyMWM2
ODQyNy4uYTUyMjQ0ZjBiNWQxIDEwMDY0NA0KPiA+Pj4+Pj4gLS0tDQo+ID4+Pj4+PiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55
YQ0KPiA+Pj4+Pj4gbWwNCj4gPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC4NCj4gPj4+Pj4+ICsrKyB5DQo+ID4+
Pj4+PiArKysgYW0NCj4gPj4+Pj4+ICsrKyBsDQo+ID4+Pj4+PiBAQCAtMTI1LDkgKzEyNSwxNyBA
QCBwcm9wZXJ0aWVzOg0KPiA+Pj4+Pj4gICAgcmVuZXNhcyxuby1jYW4tZmQ6DQo+ID4+Pj4+PiAg
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPj4+Pj4+
ICAgICAgZGVzY3JpcHRpb246DQo+ID4+Pj4+PiAtICAgICAgVGhlIGNvbnRyb2xsZXIgY2FuIG9w
ZXJhdGUgaW4gZWl0aGVyIENBTiBGRCBvbmx5IG1vZGUgKGRlZmF1bHQpIG9yDQo+ID4+Pj4+PiAt
ICAgICAgQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUuICBUaGUgbW9kZSBpcyBnbG9iYWwgdG8gYWxs
IGNoYW5uZWxzLg0KPiA+Pj4+Pj4gLSAgICAgIFNwZWNpZnkgdGhpcyBwcm9wZXJ0eSB0byBwdXQg
dGhlIGNvbnRyb2xsZXIgaW4gQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUuDQo+ID4+Pj4+PiArICAg
ICAgVGhlIGNvbnRyb2xsZXIgY2FuIG9wZXJhdGUgaW4gZWl0aGVyIENBTi1GRCBtb2RlIChkZWZh
dWx0KSBvciBGRC1Pbmx5DQo+ID4+Pj4+PiArICAgICAgbW9kZSAoUlove0cyTCxHM0V9IGFuZCBS
LUNhciBHZW40KSBvciBDbGFzc2ljYWwgQ0FOIG1vZGUuIFNwZWNpZnkgdGhpcw0KPiA+Pj4+Pj4g
KyAgICAgIHByb3BlcnR5IHRvIHB1dCB0aGUgY29udHJvbGxlciBpbiBDbGFzc2ljYWwgQ0FOIG1v
ZGUuDQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArICByZW5lc2FzLGZkLW9ubHk6DQo+ID4+Pj4+PiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPj4+Pj4+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4+Pj4+PiArICAgICAgVGhlIENBTkZEIG9uIFJaL3tHMkws
RzNFfSBhbmQgUi1DYXIgR2VuNCBTb0NzIHN1cHBvcnQgMyBtb2RlcyBGRC1Pbmx5DQo+ID4+Pj4+
PiArICAgICAgbW9kZSwgQ2xhc3NpY2FsIENBTiBtb2RlIGFuZCBDQU4tRkQgbW9kZSAoZGVmYXVs
dCkuIEluIEZELU9ubHkgbW9kZSwNCj4gPj4+Pj4+ICsgICAgICBjb21tdW5pY2F0aW9uIGluIENs
YXNzaWNhbCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRpc2FibGVkLiBTcGVjaWZ5IHRoaXMNCj4gPj4+
Pj4+ICsgICAgICBwcm9wZXJ0eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gRkQtT25seSBtb2Rl
Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgIGFzc2lnbmVkLWNsb2NrczoNCj4gPj4+Pj4+ICAgICAg
ZGVzY3JpcHRpb246DQo+ID4+Pj4+PiBAQCAtMjY3LDYgKzI3NSwxNiBAQCBhbGxPZjoNCj4gPj4+
Pj4+ICAgICAgICBwYXR0ZXJuUHJvcGVydGllczoNCj4gPj4+Pj4+ICAgICAgICAgICJeY2hhbm5l
bFs2LTddJCI6IGZhbHNlDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gKyAgLSBpZjoNCj4gPj4+Pj4+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPiA+Pj4+Pj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPj4+Pj4+
ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4+Pj4+PiArICAgICAgICAgICAgZW51bToNCj4gPj4+
Pj4+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyY2FyLWdlbjMtY2FuZmQNCj4gPj4+Pj4+ICsg
ICAgdGhlbjoNCj4gPj4+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+Pj4+Pj4gKyAgICAgICAg
cmVuZXNhcyxmZC1vbmx5OiBmYWxzZQ0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pg0KPiA+Pj4+PiBZb3Ug
ZGlkIG5vdCByZXNwb25kIHRvIG15IGZpcnN0IHBhcmFncmFwaCBmcm9tIHByZXZpb3VzIHZlcnNp
b24uDQo+ID4+Pj4+IEFzIEkgc2FpZCwgeW91IG5vdyBuZWVkIG9uZU9mIHRvIHJlc3RyaWN0IHRo
ZXNlLCBzaW5jZSB5b3UgYXJlIG5vdCB1c2luZyBzaW1wbGUgZW51bS4NCj4gPj4+Pg0KPiA+Pj4+
IFRoaXMgaXMgcmVzdHJpY3RpbmcgZm9yIFItQ2FyIEdlbjMuIERUIGJpbmRpbmcgY2hlY2sgcmV0
dXJucyBlcnJvciBpZiAncmVuZXNhcyxmZC1vbmx5Ig0KPiA+Pj4+IGlzIGRlZmluZWQgZm9yIFIt
Q2FyIEdlbjMuDQo+ID4+Pj4NCj4gPj4+PiBBbSBJIG1pc3NpbmcgYW55dGhpbmcgaGVyZT8NCj4g
Pj4NCj4gPj4gQWRkIG9uIEcyTCBuby1jYW4tZmQgYW5kIGZkLW9ubHkuIFdoYXQgZG8geW91IHNl
ZT8gV2hhdCBpcyBleHBlY3RlZD8NCj4gPg0KPiA+IENhbiB5b3UgcGxlYXNlIHBvaW50IG1lIHRv
IGFuIGV4YW1wbGUgd2hlcmUgdHdvIGJvb2xlYW4gcHJvcGVydGllcw0KPiA+IGhhbmRsZWQgbGlr
ZSB0aGlzPyBJIGRpZCBub3QgZmluZCBvbmUuDQo+ID4NCj4gPiBJbiBteSBjYXNlLCBvbmVPZiBj
aGVjayBpcyBub3QgdmFsaWQgdW5kZXIgYWxsT2Y/Pw0KPiA+DQo+ID4gRm9yIGVnOiBSUzQ4NSwg
V2UgY2Fubm90IHNldCBib3RoIGJvb2xlYW4gcHJvcGVydGllcyBhY3RpdmUtaGlnaCBhbmQgYWN0
aXZlLWxvdyB0b2dldGhlci4NCj4gPg0KPiANCj4gDQo+IEkgbm9uZSBvZiB0aGVtIGFyZSByZXF1
aXJlZCB0aGVuIGluZGVlZCBub3Qgb25lT2YsIGJ1dCBzb21lIGlmOnRoZW46Lg0KPiANCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC0NCj4gcmM3L3NvdXJjZS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Fjb20saXBhLnlhbWwjTDE3NA0KPiANCj4g
QW5kIHRoYXQncyB3aHkgeW91IHNob3VsZCBoYXZlIHVzZWQgZW51bSBpbiB0aGUgZmlyc3QgcGxh
Y2UgZm9yIHRoZSBmaXJzdCBwcm9wZXJ0eS4NCg0KVGhhbmtzIGZvciB0aGUgcG9pbnRlci4gTG9v
a3MgdGhlIGJlbG93IGxvZ2ljIGZpdHMgdW5kZXIgYWxsIE9GRg0KDQorICAgICAgICANCisgIC0g
aWY6DQorICAgICAgcmVxdWlyZWQ6DQorICAgICAgICAtIHJlbmVzYXMsbm8tY2FuLWZkDQorICAg
IHRoZW46DQorICAgICAgcHJvcGVydGllczoNCisgICAgICAgIHJlbmVzYXMsZmQtb25seTogZmFs
c2UNCisgICAgICAgIA0KKyAgLSBpZjoNCisgICAgICByZXF1aXJlZDoNCisgICAgICAgIC0gcmVu
ZXNhcyxmZC1vbmx5DQorICAgIHRoZW46DQorICAgICAgcHJvcGVydGllczoNCisgICAgICAgIHJl
bmVzYXMsbm8tY2FuLWZkOiBmYWxzZQ0KDQpDaGVlcnMsDQpCaWp1DQo=

