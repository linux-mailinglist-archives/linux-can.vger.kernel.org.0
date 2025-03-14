Return-Path: <linux-can+bounces-3084-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C8A61318
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA3E88368C
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020CD200116;
	Fri, 14 Mar 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="d/8lKV6k"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033791E991A;
	Fri, 14 Mar 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960424; cv=fail; b=hQ/Hu2d/5gDOSVGSMNrKohzcwWg9mQXFy7iVm0hCQYQwU1p8AcKbZzrwiJpvQWrNDjK1GZL1GYLGcj0iPFMRGSdzWGA5I6hBIZ2gRQA8M3k2QpHPZOOkgMCn6uTJcG96nac3E4HGbs8QS5b8IqGgeTP8x5008al4nZlcJV97nb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960424; c=relaxed/simple;
	bh=PvdnDoAxXkfjLv+QdRcvgGr/F69nAbl60gF60P/JThI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xnbu8e+N7LrWFEBU4lb1MxlD29qnrW31UPxlbBsfhu77p9fO6NdWmPD4++o4WoJXnUdr7+aR+XUJpVUPCeevukET33X5D1milQDdgA3q2YqEa1SNygYzlxOZxj9MWWRDGH02GuoVkVuHwWZcUlwgPZXamu6mL+Miv7r2uR4tMZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=d/8lKV6k; arc=fail smtp.client-ip=52.101.125.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEprqvg39sIPody3I7lrys8HQBp7nbPIi2yUpuN0hgeqVFxIBjwQpE4DM7XhvRbU/yWBTEqHp4m4vOWYq1uYlAk6Y3dKUriTFluKVEM6lVXu3XuJoHXLzcFE//Pxc5iuLIHaknXI/IVmFNIeuVo/G/68aAYl4ghtvsRvAlkqOHNo1s/3VeLc6AAu2N5Bk203UV1j9lzllKlC+bIpuACqXHWrHsBy0ZCO5hD3UhrpiFTNs77t0oHZLg1hyT1h/30nRv0Te4WH/t3ekv5mjg4DjagFfbEsFCeEDTWDW9BvzauQvyYSnQbI0P4TpQjgds7CHQP7naWLstdcPQTzX8IQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvdnDoAxXkfjLv+QdRcvgGr/F69nAbl60gF60P/JThI=;
 b=R9IBLbQINaGSMumGshp/uHVZF1tib2XYZy6D+hi5B6iBUEPCE6ZD/ZdjaL4GaNDXRb5l3AMYK803fOi1OJoCqG8QYFSS7jqwSeEj27D/CFs+4x9MjbQN572kFWdhq4yCrihn0ZF4bCoW1X5y9D1BflNi/2B2QaYBdn6fEQPh598NZmLjh9kfYNVBPdA6OA67zVI8sosagw1WwVFPEHzOP0z6QxDO/0nMHsuJtFE0mKHdLPf6+qu/U93xvPUClZFhKi2qR6txL9MCf5KBunPbM7HpxWCF8mqtGuX59cv6QsucV7fTMnPDa6bmpsDGl1PfZ2RWEhZQxaIMO7QA3gAvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvdnDoAxXkfjLv+QdRcvgGr/F69nAbl60gF60P/JThI=;
 b=d/8lKV6k4jYUxvoXAOk+eCkdznWuknKFzjZ3XHd3MTaD0mopXeTZHZilAneYcpZfUqWy07S8/VpJjPUibK6kRXPTxp/peGoElbOa1pdWjPnO0CkP+Ra2gutfWINuf9Cmkea4tUoTFeWRiro4f2UfNYsYCN6oacI6JfoGF+cY9aU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8442.jpnprd01.prod.outlook.com (2603:1096:604:195::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 13:53:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:53:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>, Duy Nguyen
	<duy.nguyen.rh@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v4 01/11] dt-bindings: can: renesas,rcar-canfd: Simplify
 the conditional schema
Thread-Topic: [PATCH v4 01/11] dt-bindings: can: renesas,rcar-canfd: Simplify
 the conditional schema
Thread-Index: AQHbjpVR87l8bfJ610WRwH0dmJT/brNyragAgAAFQGA=
Date: Fri, 14 Mar 2025 13:53:37 +0000
Message-ID:
 <TY3PR01MB11346E44176DF2A6C7E0829AA86D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdU0X=4KNXhh98igqmnwHuv20jxQe73hd=Gy7cALrHBFPw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU0X=4KNXhh98igqmnwHuv20jxQe73hd=Gy7cALrHBFPw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8442:EE_
x-ms-office365-filtering-correlation-id: 3db89165-ca15-41b6-07c4-08dd62ff9e74
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YS9yVkVCMWN5TmRMUVNSY1gvOUpKWDFGcTR1Q01paEk2RERkK2tkblpCZU9z?=
 =?utf-8?B?bTRFZVNwRlR4NElIK2llTytUR0x0eXBRMUxKekVoRUlMUmNOS2p4ZVB0aGNj?=
 =?utf-8?B?QytrODcwRXFnYnF6OFNzRFloL2tqRGtFamZZdWp2Mlpua0NlSnlRQ1JpZXA1?=
 =?utf-8?B?eWZBblJiUkRlRjhIU1JFSHBDV25EUGJmK3RGbXJiSkN4NzdQbm5EWkVEY3lL?=
 =?utf-8?B?Wmw3d3Z1dUsrb0NvRklKd0FKUmFNbEpWNXE5eFdQaDZmU3VkM2NaRW1XM1Nz?=
 =?utf-8?B?ZXVnR1FnLzhYY0RnRXA2QnZIeUNhdW9ON25xWFhTUjZORVVxN216WnFwajE1?=
 =?utf-8?B?TEhzQW5Pb25EZUlYWTdzSEFXa09pbDhDMGY2Rzd4UVBON3BYd01oTGc1TFdK?=
 =?utf-8?B?bE5LY0cwNWdBVkpoT251YmZJYWFYWkFIdkR2M2tLTkhaUDBsL0Z3VFR2TlJo?=
 =?utf-8?B?NWZFUEM0ZERaQnVzY3ByRktnMFRKYWl5UzY2a1R4RzhnbWNCS3lDYVpHVnFx?=
 =?utf-8?B?d2ZOTUgxelk3MmYrMzJIYUJjVFlCUG1tQnJhd0hZUVBPVy93VnlLOUF2UkE1?=
 =?utf-8?B?QWJsaVVqVEZsWHlVcEY0YjREQzV4a3VqL0hucUUwN0YwUnJJdm8vaTYyd0xH?=
 =?utf-8?B?U0pwaVpvQUt2VG5Td0xZMURoWUFsVHBMbEVxSzE0NGNoWCtqNmtROWZSWnJQ?=
 =?utf-8?B?eDFId3gzcE9LMlVlbmp5cXgvNUpza0lQN3U3Uk9Fa1B2bkk5eFlJUk5vbWJW?=
 =?utf-8?B?SnhBSFQ4OXEwMktUNzVWUXRUZmloR2NtTFdsckVOTHY2RlVrY0ljUXBpV3lv?=
 =?utf-8?B?ekR4ZCsyQjZVSUUzRjNhYVBKK0RTOFdHc3NiT2RLQWphcUxRdjZReG1DdUxM?=
 =?utf-8?B?RVlsd2tlYyswYzZLYUxhbGFZZFdyeTBSeHM4N3hiQlFER0xQYldVY3lWdmxi?=
 =?utf-8?B?NDRaR3F4NHNYT2VBMUU2Y0VBMUgzZHRJSFF2dDNtc3NPZFNiSFI5Yk1tNlFt?=
 =?utf-8?B?OEpQdnFwQnRtNWJCSGprOEY1eDhyaG8yR0xlajdRTGJYWndSUDE4c1dpVmdY?=
 =?utf-8?B?d0w0d1dUbmpvdGwxWUw1Z3pQRENaZVlkWmEwWjVNQm5CWkZzUHdSZGx4a0RN?=
 =?utf-8?B?RnBSeFZZMCt5WXlVenVqN0pXOWMxL1BaN2x6cFoxV1UvcG85NXZRb04zQ3pY?=
 =?utf-8?B?b05ZM21PUy9Ec2xPVHdEVk16OHgyMVhzTnlOZEJHMzhvWkt0NVBFQzlCMVpt?=
 =?utf-8?B?SnlQQzBVYTV5dFlvMjZaSVNYS0NreUd1RzN1cTdMS1VUcHJhOThZTFlwNm0z?=
 =?utf-8?B?WDJ5L0RmTkI2S1ZMK09JWTFTQjJoYnhmYXhaUldmN3VlNWZYTmg5dFdSUkl5?=
 =?utf-8?B?bk1wSVlseFAxTXBBcjNzbGlkaU05cW5EcklvOTdMSE9LTXFnVjZVL05pSXBI?=
 =?utf-8?B?aUlZbTdQTzE1TlFUMDg5OHNRQ0tLaTVMZXg5d2ZPdlNya3pLRUlFNUM0Q0pK?=
 =?utf-8?B?eDJ4SGo2RW1OdWY4d1BOYmFSVUtQdFg1THB6Y3JDMkFCaFQxamhEcUtINVg4?=
 =?utf-8?B?dzdBOVV2Mzk1ck5RZmRHVndtZXNFMkxVeDdiMXQ0TC9FdlVPZU9vRzZFZDlG?=
 =?utf-8?B?TlRVNnZUYno4cVYxOEIwWElKOElya0RNdkx2c0traTFSM05LY29PS3htQlF2?=
 =?utf-8?B?N2YxMTI5czNSYkZZNzFJREpKN0ErOExXVWxjNnRibUlVOU1jZXpHcVkwaVVX?=
 =?utf-8?B?TTQ4aGNTbU9kdTJXVUVZeHdya2xzTENma1VPK3FqVUlobDZGUHUwb0xiSGxR?=
 =?utf-8?B?emdXVHRxZGVqckdEYmVQem1uWGl5MHRDYmhyeFRYaWhleUwwZzByL21ZZW0y?=
 =?utf-8?B?NFdWOTRqYzdnSno1ckxVaCt6eU5tU3dyTFplSVRjL25LUFc4SDNFbjlRZ29K?=
 =?utf-8?Q?9wAFRn16tdblUD+iYuPgpGdhH2rXcZ8Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFdIS25HYit1Z05HMEZWazF6bDI0QmRJSFJGR0VHaTF6cVRPZFZzTkMrQUht?=
 =?utf-8?B?Rkh1YVY1K1JrNTExMEJzTEkyRUlKY09Oc3crY28xV3E0bk9FVVVQM2ZSNENa?=
 =?utf-8?B?ZEYzdEZOMkpIaStlUTFQeDFVb01obElWVzZDWHBEeTVtaXVRa0VJSGM5dnVr?=
 =?utf-8?B?d2ZDZGNvYVVOS3ZDazFrUGQ5YzE0NkFLbllPL0ZEMkUwSHRPUU5OQzF1M0M4?=
 =?utf-8?B?U3B4TGt2b2M5OWdWQlZCb1N2cGNiRzFyYWV4SVNQcU9RYXFEaVFFck5NR2lp?=
 =?utf-8?B?cVJ1YlptVTFDNjVLQUg0TkRQWUdSZ3dHSTNtRkJtd1VYb2pUU2NmTldxVkx0?=
 =?utf-8?B?dUNydlBsc3F5eTB2dkpqenlsalJ6bGlYdzloMGY5eDhlZkdXdXNTMTEvV25U?=
 =?utf-8?B?QTdLRzV5V1lsK2Z4SlcycDUveXNqNDlxb3djQnF2cUl1a0ovSHAxUjZobHM2?=
 =?utf-8?B?S1BoZk0yeTlXVS9lMHN4bHVtNy9JYXE0a1RsREF0QlJST1dBVU1xYndlbGJK?=
 =?utf-8?B?UHg0LzdlVnErTzA5YzhRWTh1R1VhajV1RnhxYkVkSkN6OUxjT3RrQkdEWE5o?=
 =?utf-8?B?TG5ybUVpVitlZEN3QlRoejl2NWxOMGl0ZmZIVFRyUWo2QTNyYm0zbUVrM1ZV?=
 =?utf-8?B?dzVyOUE1T09JYXFvMXdaTExBYjJKeGxWZGhVMlRwZ3BHSXlNS1NlNWJVVURR?=
 =?utf-8?B?eWc0RHUzdW03QlJCZG1sRHJUeVVVS2ttd3FuYlVNai9BdWp0QUtFaUEwMUNi?=
 =?utf-8?B?NHRydlNHQXRJVUExNjB1N3ZOMjkrRXJCK05WUDNjdHJraE5oOHBHYjc5YTVm?=
 =?utf-8?B?RE9LNVArSVVoSXpjNVRvOUxhVDRSR3pweEZML1FMbXI3R2M0MkZaakNvUGM1?=
 =?utf-8?B?SG9PSDF4TngvRzE2dXF4T3RkdzI2V2ZSOFR0bk9UMVc2b0JEZG1KdkdUeWNN?=
 =?utf-8?B?RzRIcklPbllzMnlkYTJjOVhFcnFwa0Y4cWpaSURyYUlUcWlseC9HQ1ZiNmVv?=
 =?utf-8?B?aHcvMy8vdUQzMkpGN0tZQTdidTBMdnZOK2RWNzNhZ1dPRDV2YnEvVXBHSDRk?=
 =?utf-8?B?aklxVmJqSnJHR1pqOXlNMnN4Yi8za1N3VzhCSGJDQkRhNjE0MC83L0xIY2Vy?=
 =?utf-8?B?NENGcGJCMVdRY0VlNFRBSTVRQ25XZlVOWTcvTFlrMTZWMURLODN3SXVwK1l5?=
 =?utf-8?B?eTF1eUlSeUg5T25qYi8wRXQ4NFV5MzJPV2k2YWF2SmdKYnpvOWkrTFBFbDcy?=
 =?utf-8?B?T1c2c2p4UlZiaWpGd1AyQ2tBSEtVU3NGenAxSXJDU1hSS09GTFdDblFTY0tJ?=
 =?utf-8?B?L29Xa3RXNXVyQlFWL09yQmliOW1Sa0dyMUplemNuZlJEOFU0ZytDaDl2c204?=
 =?utf-8?B?MUFFY0QvNEF3NXdRQlhzVkNmcXIyRnpUTDViMkNZTVhzaktrNmkvY05aS2pl?=
 =?utf-8?B?ZjA5bnh2VW9LODVNb0VJSzk5c0t1cTZsOGVha1hSTDhDaHl5ZUdRTFoyRzFu?=
 =?utf-8?B?dTVUYy9DKzZkeGsydG1MbEQ5RHVZOWFWWjhNRTBYbCtzRFB4S1VCRk5EZ2xG?=
 =?utf-8?B?c2pOZWVvVzlHSFROQlRibkthM1NYQVg0a3ZKVm9scUtKcHhkV0k5bThCcWd1?=
 =?utf-8?B?TlRMQUdjMVVHbGJHNXhYZW0xUmNOK0RqWnU0RW1CTE9oQSs0b1NrMW51L1dU?=
 =?utf-8?B?SUVCZENmdlBZWFpsWUNyN2NNSXNpZXU4WHVldFVmcnJQTkVucjEvZi9JcnRI?=
 =?utf-8?B?aE9KV0g0QkszQjEvRUd2Qk50SGNVNzFHOWVJaFBMT0VlNkJwOEcrZUhLYmdx?=
 =?utf-8?B?NXovM0x1VUlPd3o1Q0hiWCs3UlU4Tm5mOXV5OTFWdmwwT0c2NmpENmpYRHp3?=
 =?utf-8?B?cktDMytTYXhBMExreWtUR055N3J0akl0anpTVDU3S3J4VkVYWGJiaGVNRjVa?=
 =?utf-8?B?MFN1N2M4U1lHbnQ1eWI1Qi8zRks2b1lkVjNsbTU0UmZKOVdWQ1VXYStCMmtZ?=
 =?utf-8?B?N1gzYjNONXpaSDVZS3A3a09yMFp4c2RkcG5oTzljN2x6TzFSUzVuZkZIODdU?=
 =?utf-8?B?UnZJckhoVndKRS8zTHV5a0w1VTVScnZPV2Mva0FkU2JlRkI0YWJ3aXZnWVQz?=
 =?utf-8?B?RDIwVnhYUnRwZnQvSExLZDJiME1BajdRT055Y25nUWQrcFZNT2lwZk9ZR0Q4?=
 =?utf-8?B?THc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db89165-ca15-41b6-07c4-08dd62ff9e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 13:53:37.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuCcz++8O04+bJWxx6pbYQrw+LV6/SJeWcGlKdPlWa3jkfiE1p83nvjjo6IZhrcNn3DlQhbYU9NWWoWH25gJ6zuJPJRB/eEDEPBH+ZzLce8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8442

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTM6MzINCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwMS8xMV0gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBTaW1wbGlm
eSB0aGUgY29uZGl0aW9uYWwgc2NoZW1hDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCA2
IE1hciAyMDI1IGF0IDEzOjQzLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+IFJaL0czRSBTb0MgaGFzIDIwIGludGVycnVwdHMsIDIgcmVzZXRzIGFuZCA2
IGNoYW5uZWxzIHRoYXQgbmVlZCBtb3JlDQo+ID4gYnJhbmNoaW5nIHdpdGggY29uZGl0aW9uYWwg
c2NoZW1hLiBTaW1wbGlmeSB0aGUgY29uZGl0aW9uYWwgc2NoZW1hDQo+ID4gd2l0aCBpZiBzdGF0
ZW1lbnRzIHJhdGhlciB0aGFuIHRoZSBjb21wbGV4IGlmLWVsc2Ugc3RhdGVtZW50cyB0bw0KPiA+
IHByZXBhcmUgZm9yIHN1cHBvcnRpbmcgUlovRzNFIFNvQy4NCj4gPg0KPiA+IEFja2VkLWJ5OiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiANCj4g
PiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3Jl
bmVzYXMscmNhci1jYW5mZC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbQ0KPiA+ICsrKyBsDQo+IA0K
PiA+IEBAIC0xMTcsNTIgKzE0NSw3MSBAQCBhbGxPZjoNCj4gPiAgICAgIHRoZW46DQo+ID4gICAg
ICAgIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgaW50ZXJydXB0czoNCj4gPiAtICAgICAgICAg
IGl0ZW1zOg0KPiA+IC0gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDQU4gZ2xvYmFsIGVycm9y
IGludGVycnVwdA0KPiA+IC0gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDQU4gcmVjZWl2ZSBG
SUZPIGludGVycnVwdA0KPiA+IC0gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDQU4wIGVycm9y
IGludGVycnVwdA0KPiA+IC0gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDQU4wIHRyYW5zbWl0
IGludGVycnVwdA0KPiA+IC0gICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDQU4wIHRyYW5zbWl0
L3JlY2VpdmUgRklGTyByZWNlaXZlIGNvbXBsZXRpb24gaW50ZXJydXB0DQo+ID4gLSAgICAgICAg
ICAgIC0gZGVzY3JpcHRpb246IENBTjEgZXJyb3IgaW50ZXJydXB0DQo+ID4gLSAgICAgICAgICAg
IC0gZGVzY3JpcHRpb246IENBTjEgdHJhbnNtaXQgaW50ZXJydXB0DQo+ID4gLSAgICAgICAgICAg
IC0gZGVzY3JpcHRpb246IENBTjEgdHJhbnNtaXQvcmVjZWl2ZSBGSUZPIHJlY2VpdmUgY29tcGxl
dGlvbiBpbnRlcnJ1cHQNCj4gPiArICAgICAgICAgIG1pbkl0ZW1zOiA4DQo+ID4gKyAgICAgICAg
ICBtYXhJdGVtczogOA0KPiA+DQo+ID4gICAgICAgICAgaW50ZXJydXB0LW5hbWVzOg0KPiA+IC0g
ICAgICAgICAgaXRlbXM6DQo+ID4gLSAgICAgICAgICAgIC0gY29uc3Q6IGdfZXJyDQo+ID4gLSAg
ICAgICAgICAgIC0gY29uc3Q6IGdfcmVjYw0KPiA+IC0gICAgICAgICAgICAtIGNvbnN0OiBjaDBf
ZXJyDQo+ID4gLSAgICAgICAgICAgIC0gY29uc3Q6IGNoMF9yZWMNCj4gPiAtICAgICAgICAgICAg
LSBjb25zdDogY2gwX3RyeA0KPiA+IC0gICAgICAgICAgICAtIGNvbnN0OiBjaDFfZXJyDQo+ID4g
LSAgICAgICAgICAgIC0gY29uc3Q6IGNoMV9yZWMNCj4gPiAtICAgICAgICAgICAgLSBjb25zdDog
Y2gxX3RyeA0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDgNCj4gPiArICAgICAgICAgIG1heEl0
ZW1zOiA4DQo+ID4NCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAg
ICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscmNhci1nZW4zLWNhbmZk
DQo+ID4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHJjYXItZ2VuNC1jYW5mZA0KPiA+ICsgICAg
dGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBpbnRlcnJ1cHRzOg0K
PiA+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+
ID4gKw0KPiA+ICsgICAgICAgIGludGVycnVwdC1uYW1lczoNCj4gPiArICAgICAgICAgIG1pbkl0
ZW1zOiAyDQo+ID4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPiA+ICsNCj4gPiArICAtIGlmOg0K
PiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAg
ICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgY29uc3Q6IHJlbmVzYXMscnpnMmwt
Y2FuZmQNCj4gPiArICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gICAgICAg
ICAgcmVzZXRzOg0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4gPiAgICAgICAgICAgIG1h
eEl0ZW1zOiAyDQo+ID4NCj4gPiAgICAgICAgICByZXNldC1uYW1lczoNCj4gPiAtICAgICAgICAg
IGl0ZW1zOg0KPiA+IC0gICAgICAgICAgICAtIGNvbnN0OiByc3RwX24NCj4gPiAtICAgICAgICAg
ICAgLSBjb25zdDogcnN0Y19uDQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiA+ICsgICAg
ICAgICAgbWF4SXRlbXM6IDINCj4gPg0KPiA+ICAgICAgICByZXF1aXJlZDoNCj4gPiAgICAgICAg
ICAtIHJlc2V0LW5hbWVzDQo+ID4gLSAgICBlbHNlOg0KPiA+IC0gICAgICBwcm9wZXJ0aWVzOg0K
PiA+IC0gICAgICAgIGludGVycnVwdHM6DQo+ID4gLSAgICAgICAgICBpdGVtczoNCj4gPiAtICAg
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogQ2hhbm5lbCBpbnRlcnJ1cHQNCj4gPiAtICAgICAgICAg
ICAgLSBkZXNjcmlwdGlvbjogR2xvYmFsIGludGVycnVwdA0KPiA+IC0NCj4gPiAtICAgICAgICBp
bnRlcnJ1cHQtbmFtZXM6DQo+ID4gLSAgICAgICAgICBpdGVtczoNCj4gPiAtICAgICAgICAgICAg
LSBjb25zdDogY2hfaW50DQo+ID4gLSAgICAgICAgICAgIC0gY29uc3Q6IGdfaW50DQo+ID4NCj4g
PiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgZW51bToNCj4g
PiArICAgICAgICAgICAgICAtIHJlbmVzYXMscmNhci1nZW4zLWNhbmZkDQo+ID4gKyAgICAgICAg
ICAgICAgLSByZW5lc2FzLHJjYXItZ2VuNC1jYW5mZA0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAg
ICAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICByZXNldHM6DQo+ID4gICAgICAgICAgICBtYXhJ
dGVtczogMQ0KPiANCj4gSSB1bmRlcnN0YW5kIHlvdSBpbnRyb2R1Y2VkIHNlcGFyYXRlIGlmLWJs
b2NrcyBmb3IgaW50ZXJydXB0cyBhbmQgcmVzZXRzIGJlY2F1c2UgUlovRzNFIGNhbiByZXVzZSBv
bmx5DQo+IGEgcGFydCBvZiB0aGUgUlovRzJMIHJ1bGVzLg0KPiBIb3dldmVyLCBhdCBsZWFzdCB0
aGUgcnVsZXMgZm9yIFItQ2FyIEdlbjMvNCBjb3VsZCBiZSBrZXB0IHRvZ2V0aGVyLCByZWR1Y2lu
ZyB0aGUgbnVtYmVyIG9mIGxpbmVzLg0KDQpZZXMsIHRoZSByZXNldHMgY2FuIGdvIGFsb25nIHdp
dGggaW50ZXJydXB0IGFuZCBpbnRlcnJ1cHQtbmFtZXMsIGZvciBSLUNhciBHZW4zLzQuDQoNCkNo
ZWVycywNCkJpanUNCg==

