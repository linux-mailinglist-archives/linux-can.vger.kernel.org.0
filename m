Return-Path: <linux-can+bounces-3294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF8A7564E
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ED416ED7C
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB541C4A13;
	Sat, 29 Mar 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="H/Xr9ArL"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845D1C3308;
	Sat, 29 Mar 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743252939; cv=fail; b=kDf8w6swU/BWhxaHfRJlMAeiuh//8kXkWgABokmIp8mlNIraRH3mWc0k4KLmqCQb/WM8qFhz/YZjME/KwVom9xdmtg8nRqBBEcPcu0a+wF6i3yGiQ+Aj2T+bquj4Qhg2Y1OwPHijCM7i1z0OQ/q4QPYR43CIE4rDo6q5U4nxUTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743252939; c=relaxed/simple;
	bh=iEQVSg/WXnLYR1vdky7SD9sRpzgsLhdfnRrwzMVk8v4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxLpYN/bq0Zai03E0aSI0R3HU6rgBy2CE9cc72sFqlf4o4UBzSvt1KPYMuzvfBuRrLrW+leVL8QCyO8BquRw+3ppdMPeA9NpClmxB1k8bA2crL7ZY8xmORWTloJaeg4xV4UGbEvr1YS+dV8MPeXBFl8NVqSe1EZgKg9t/ybkcEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=H/Xr9ArL; arc=fail smtp.client-ip=52.101.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQTOYyY8pYzQeapmPk5RmPgITpYzhx8pXOTowAtu8cKmcLvXO7NMFC21QI7tJSkL44+E+lNU+P32XXIrwH1lMxucmb2aukEdd0bVUoqiiUDV8WiXCUI4R50uktUgb60fGN/BWUP+DYS8L7lRMposJ/+PIJeFOefsgNvZKsfpo2hMzHDbSSlNBRG6wX4k7pGehSmIU62drOhq+sgFeh5M9GCf/N9r+zxLzEXkgtPa4X4TsBFteRGmHxaHBQnOag2JciVFSXSR0nLKJ/wvIMpbu4Hdj9/Ogrh9CP7m/bfmeBlNlD3mU2ZyANI37cKQb0AjTN1Y1C4LrLfOvmslZ+XcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEQVSg/WXnLYR1vdky7SD9sRpzgsLhdfnRrwzMVk8v4=;
 b=l/SycPyVLfpCTqa0Uip6V+B42jMF5nWSa5qHadSFuNIpqGD/ZwQoYFz1TCtIH+tlJ0XemG+4CAfnO8NKPxRv0Jh9rH5Vr7sRVZ0VfEyU2pEweKOK+kOJPZ/VmunHTVkMvz8u7ZUlKXKJA20osBOsEoCuj4QJq5g2BUcLtruPNnYPOQaJqB0Kv+DplfKlXRx4+kTdQHm9+0bjyXO7odGqnjVYCT4A0RAF8lgxObMWjkBNBAhJUs+Cr/PY09LAvs0JtKeyGb1c31KPXt80D0xd5gB+HJ3/RRKlZ2CAaX5melSZ3sLBp1KUu2Q6goBZqiHixekDu7PWlNU/9v82ewc2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEQVSg/WXnLYR1vdky7SD9sRpzgsLhdfnRrwzMVk8v4=;
 b=H/Xr9ArL969uu9nYMY9aEitIpIRrNwQTlSbHjdSGxFmtxN/P6cNzmHQp0+rLEmHlpGR0rg7mxuACanfboauiSFSZ2xL61h80oW7JS0q8Xug9eTx/DuuUI9cKdOqBlkhCO4GevgdOY5cILCkH2PuIfAErh5Imo+VxlzgQl5nyw3s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11281.jpnprd01.prod.outlook.com (2603:1096:400:3d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.51; Sat, 29 Mar
 2025 12:55:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.028; Sat, 29 Mar 2025
 12:55:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 15/18] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v7 15/18] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbnkmPXHAkSybKyUyCSeZiR8BrULOIrsiAgAFoMuA=
Date: Sat, 29 Mar 2025 12:55:33 +0000
Message-ID:
 <TY3PR01MB113461E38EA8BB234A27277C486A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-16-biju.das.jz@bp.renesas.com>
 <6b663ace-002c-44f9-bbdb-38af8a4e4da3@wanadoo.fr>
In-Reply-To: <6b663ace-002c-44f9-bbdb-38af8a4e4da3@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11281:EE_
x-ms-office365-filtering-correlation-id: fb284f7e-02e1-473a-87ee-08dd6ec0fe1c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SG9MQnRFTDRWQW9iVGE4U0U2bXYxTVRIeXdaTTQ4MHpUTFFVL25VRHdQQWFQ?=
 =?utf-8?B?L3NubFVRK2RHcFdKblFSemsrSHg3TFc4UVRLVFlvNnYwbTBkaTAwVWI4TU90?=
 =?utf-8?B?MGlnOUEyd3FjRGlxWWlPdm5zNm5LSnpsc3Y4WUdXMk84dEJUYlJ6UmFuUXBo?=
 =?utf-8?B?RERVSnlYTWdpeVRJTnB5QWxFK3VZMTlLSFYvNWx2SjZHZkZnNFBTQ0cyckJO?=
 =?utf-8?B?bWhHQmNSVU5oQ2FNZ1BOMzFZVVNoTXRLSG93cjgzT00vZm9FVlhvRTBHbk5o?=
 =?utf-8?B?MTgvL3ZDU1ZZVUE4bFMxU2NGTUJwUnVOcEJWM1lOWEd4ZlkvaVlhamFYWXpu?=
 =?utf-8?B?cDFBSUk2R2xNaHY5QTRKS1A0ODAzVTV1M3FCYTBHTWJHSXNuZ09Xem40eXdo?=
 =?utf-8?B?RWwrMGNGeXh4VlZ0YmxVOFZQRCtIdjZZcjlJNGNlb1A3dyszakJ1cmZlMDNi?=
 =?utf-8?B?aHNxN3hSMWc5S29TWTVSSTJEamtldE9qRnIvT2VzdnJNa1FKVVNIYzgrdmh4?=
 =?utf-8?B?bzdzZUNaakdmK24vd2ZyMWh2cEtJNnFsQmFPejEwbGtCZHQzTWVRRGNrbWla?=
 =?utf-8?B?L0pYUHFtMnpoSzNaM1dtaHZFWm9aQTBINUpsckNaZ3hDVnFYN3kxVkJrbjFw?=
 =?utf-8?B?T3ZzTVdGVXN2MDJaN0Q2SlNzSGtodlRFdHUwYzJYb2J5ZGZDY3dBYS9UMkti?=
 =?utf-8?B?alVNV3NnUzkvV1djbXFCRGhnNEVoc09raFpKWWR6dzZ5OEdaak1wazU1V3ZD?=
 =?utf-8?B?aDZXU2lZS2FBVkRURFRJalNIMTFQczJDNTVLbUIxWi9VaC93RnAwTFhzckVz?=
 =?utf-8?B?WkRObDRKcTNhSHBQUWRrdjl1bE1LNjBDVTdJaXhUSmNaNG8zMW5HM1hRQk1D?=
 =?utf-8?B?cmZ6YzNVRVdJZ1kvdmk2UDM2OWFVSThhMW9tU3oyeUdldEozc1hqUlZJbUFG?=
 =?utf-8?B?Um5adEc4YUlPVyttK1pMaWUrd3VSTnhQKyt1dnA5dGRNVzF0RmxHS1U5V3h6?=
 =?utf-8?B?c2pRR0NhZXVONFQxTVJIL0NFcVdsOExLaHA3OGhuWCt4dENVLy9LcDBDS0VH?=
 =?utf-8?B?ZlN5S3hZT2llcUZ5bGpab1RJQjFTODlVS3V1alhQejlrSXdoTkQ4MnlXa0Q1?=
 =?utf-8?B?ZndPeDFUejZOc0w0eTFQYThXTW94TnlQMXcxOW4rSEZpc1E4eDgyUnlIUWRN?=
 =?utf-8?B?NnZqb3FsR0EydGxrVEN2TEZEZ3JxcVV5N2s0WkpiOGppVUZLcjlFakU3ZXNy?=
 =?utf-8?B?NEFNWEMyTFEyaU92TWlYNFJ4Zko3OW9qZHh6SU5YK3dDWHJQZGFuQ01TWHhY?=
 =?utf-8?B?TFNqQld5ekxFQ1c0Y1puam4rblc3VEJQRERMSVppdGpOSUhTaXlnZ1AybkVL?=
 =?utf-8?B?STFJb2JDL0pndlBOaGk5QitlZ3ViU1ZHWTlQZ2FTaWFBVmp6S3JObHZUS0pM?=
 =?utf-8?B?ZWJYaEtMTlQ4OFEvTGN5RnMrU1hCaWJ3dVc4UzNGcURyaktQTHoyK2paamFB?=
 =?utf-8?B?bnQwaXdiRVEyUElpaDI3Y0VXcmo4Q2k5WHpSYW1xd3VDdURycThFU2FHTlhn?=
 =?utf-8?B?YmEvV21scUVUajJiSFllZUZMVDNVek5pQ0F6bU80UGY1WDFMZXlBdDkzWmFm?=
 =?utf-8?B?Sm10YmRxcU1kK2c1aXpZWXR1NS9hbUROYzArRkN4MVpKRWdNZUZORTRaZzhl?=
 =?utf-8?B?SkxBOW5wcyt1T3pwc1A2TFlxT2tUbmxyU2QwQ3d4T1RJT3VDTVAwRjF5YzRR?=
 =?utf-8?B?dWJkd0dGZDQxT0dUQXA2Q1hLRXFwQ1pkYVV3NUJ3MXh1S1hIMnZVMUZBaWtS?=
 =?utf-8?B?eWcxRm5HeFFzeGl1TVBZTUZYck1sd2ZVMkcrYUpNZzZTTUV3SEluakZPUGFD?=
 =?utf-8?B?aTRHcjBNSkZFMUJyOTZWSmxIeUd5QktzeW1ZdjJ1REtKZm0yY0xJVklidkdZ?=
 =?utf-8?Q?Tut1FWLr1JlcpWiXnbk59gkIywBXWMs/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXUwZGlCVjAzWE5hS2gwb3Q0cHVjc2JSd0hUN2JYUGQrWHphWFVvSXl2OGM4?=
 =?utf-8?B?bGthNC9jYzdmYm1UUjl0d2k4ZUZ1cmN2bVQzN0NkM1ZYd0pqNEtlV2FZdG1E?=
 =?utf-8?B?VzkzaVhtb2VlNU9sQTBqZGhvQ2thcm4zbnN5Z0JCVFB5bldkNlRXYnFySytF?=
 =?utf-8?B?UDdkVHVBV1hrY05xUE9VT0RxWnp0U0VPK3gyU1NoQS91dXJISjVIUkhpOFdy?=
 =?utf-8?B?Mzd3bXQ5dllIdXJhVU5lQkpCdDZHUURPT3BGVDhUejZYSkxkeU5oMk9MZVFh?=
 =?utf-8?B?NEFjSXloZ0R0dWdMRCtTZEJYakg1NW8xSDdQeDFMbG9RcDUySW9qYkY5RFN1?=
 =?utf-8?B?Wk93SkpUOVRYUTFHSnJIbk1DUTZ0Zmozc25nall1S2dDMWVBMWFTNi9WLzI4?=
 =?utf-8?B?QTMrU3U0cktNdVhhdE1lQ0pLZmRMRENqeVN6TVhqZmpBS0cvZ2VESG1MNzBM?=
 =?utf-8?B?ai8xQlFDcVVaQmxXQkwvNDl6UUVibm5rbmtQRU1yTHVaekJFVE9ZM01SUkg5?=
 =?utf-8?B?VHVWa0szZGZ3ZEpvdXVkRmlVWWh2QXMyWnZ5TWg3L0NseGRPREJ5L285QjM1?=
 =?utf-8?B?aXA2Qmw5NmhEdUhMZ0ZncEhaaHNScWRmc0crQ1NvTTFhRVZ6L3M1dDlHakNP?=
 =?utf-8?B?QUY1QTloSWx3K08vWE8wcDhFalQraSs4VWkxSVIzQnF0WUNIL0tpVGRFa0p3?=
 =?utf-8?B?TElRa1UrSHFLL3hHc2NySE1ITFh4b3F5TEo5MUtWdWc3OS9KNjZRbUxXL2wx?=
 =?utf-8?B?emYwRkFLODN3Mzk1d1ZGY2RrY2ROL1JxRzNWaVdONXdoWjVncGxZMVFtb1dk?=
 =?utf-8?B?UU1oeE9JbkVta1JVQktZMXZGM095VW1adlIyNnFjNTNSK0NHSlVpdVhCQ3Ir?=
 =?utf-8?B?bjJrYWJlNGVxOUF1TVpkMWdFOXBxbWo5S3lJNnYyVzlpdHlFQTk4WG9KL1Ro?=
 =?utf-8?B?SWU2SjlYTW4zWjl2SDRyWFVURmFjNkFvbnJEZ1IzSGpnQThHNGg4MWNmcUtx?=
 =?utf-8?B?N2NNQkJZL0dWZDBKUXA1d1NSQ0Y1b2ZDZE9FWGFOTmh0Z0pIVFlrdjRvWU1H?=
 =?utf-8?B?U0VBOHRBRGw3Y0pSeHpINUgyOGJrUWVXQTREVUVJV2Y3WExNNzhQZG12OEox?=
 =?utf-8?B?TmF3MUJDRnZ0OGkvMUVGQ3pqem92cGtidGlWd2hDQ25jMnlta0NDRW9VbGNi?=
 =?utf-8?B?V2FoaDJwbEZ5ZUtESGI5MEFTN05yTkV3aFhMTzQ4MjYzTGdlSVd3b3dSaGtI?=
 =?utf-8?B?YkIyWTArZmd1YThZNXh2NnFPeDUxZXV3RTk3azhtS0pJT21XZXpBRWJ2Y0hR?=
 =?utf-8?B?OE1EaVZ6VWdPM21XRDMwZHhZQWVUbDNvcWQ5K3J3anZHdTNiR0N0ZDdlSzZU?=
 =?utf-8?B?UGkyQ3p1QWx4ak9lcExydUJuaEFZUFlJRXVmTEV2RUo5VmdwdlJEREtPYjlv?=
 =?utf-8?B?OHF6OENpekxtTGNuNU9kTGx6d3kxbTJpWFFqN2o3bDF6NFZKeHlqOE1waGt2?=
 =?utf-8?B?NDI2a0hnMjVUMWJnbkVFWlIvbHlGMDg3ZkRSbzFOTFVndTU2blllOHZZdmdJ?=
 =?utf-8?B?S0lYaEJ5SFovOG5UcUx0ZzNaZm56M3BveldJd1FoaGo3RkVDSlRxYzZCV0RG?=
 =?utf-8?B?NEIrUFpMZnNvb3FTbWVReC9BOFI0NTZMRDZ2cXBUaUV5SVFILzU1OEdWbW9H?=
 =?utf-8?B?ZXB0VDZqS1ZMb2lWcVV3TFk2bmkzT29WYStlZkFRZkE0VHJZV2ZMQldHbEM2?=
 =?utf-8?B?Q2c4c1BrV05PMmxtN0pvOGhZS2ZEaUNpK1RDMTVDbzZMVmZ6RWx6MVBmL2ho?=
 =?utf-8?B?Ykc1UE9vY3UxZm0zSlVhV0s3Mkc4VlVBekVoSlROY2wvYkpyMXRIdzBRWGVJ?=
 =?utf-8?B?bkkvcXJta1ErdzNrYXhhNG91bk5QbkNoMi9GOWhsQ3p2OEVqYmNOdVhGdmNI?=
 =?utf-8?B?Nmp0MVZBTFhqRGZLZTQzVEoxV0FYZ2JUaWpKVEIvZmN5SUh3bTZnbXdZclBl?=
 =?utf-8?B?UG9oN2lpK3N4WHU0OSswdnNaMnUwVkJjUmlTWk5MNzZCM21CVFA4WXJMcC9s?=
 =?utf-8?B?cXVSVzRHMUpUUHRtcEVNK0NCQVBhcVRmeHdNQnJTdnVNM2NnZzVsQ2NMdnht?=
 =?utf-8?B?RG9iK2hLRWtoVUlIekFjS3o3eTUyQnVQTVluY1ZjNWZPc05kOVA1NStRNEZq?=
 =?utf-8?B?bGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb284f7e-02e1-473a-87ee-08dd6ec0fe1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 12:55:33.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRgCURvp4NjXt57X/WsiiP3OFNQvbp/OYUnjaWa4TgAiuM+2l6iVUFdoaKCp74VMEwDPzv61XtJG4RUeQwK+z0RiTq3ywNdWWKnZZywnJ7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11281

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDE1OjI2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMTUvMThdIGNhbjogcmNhcl9j
YW5mZDogQWRkIHNoaWZ0IHRhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+
IE9uIDI2LzAzLzIwMjUgYXQgMjE6MTksIEJpanUgRGFzIHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMg
YW5kIEdlbjQgaGF2ZSBzb21lIGRpZmZlcmVuY2VzIGluIHRoZSBzaGlmdCBiaXRzLiBBZGQgYQ0K
PiA+IHNoaWZ0IHRhYmxlIHRvIGhhbmRsZSB0aGVzZSBkaWZmZXJlbmNlcy4gQWZ0ZXIgdGhpcyBk
cm9wIHRoZSB1bnVzZWQNCj4gPiBmdW5jdGlvbnMgcmVnX2dlbjQoKSBhbmQgaXNfZ2VuNCgpLg0K
PiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0Bn
bGlkZXIuYmU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHY2LT52NzoNCj4gPiAgKiBObyBjaGFuZ2UuDQo+ID4g
djUtPnY2Og0KPiA+ICAqIE5vIGNoYW5nZS4NCj4gPiB2NC0+djU6DQo+ID4gICogQ29sbGVjdGVk
IHRhZy4NCj4gPiAgKiBEcm9wcGVkIFJDQU5GRF9GSVJTVF9STkNfU0ggYW5kIFJDQU5GRF9TRUNP
TkRfUk5DX1NIIGJ5IHVzaW5nIGENCj4gPiAgICBmb3JtdWxhICgzMiAtIChuICUgcm5jX3Blcl9y
ZWcgKyAxKSAqIHJuY19maWVsZF93aWR0aC4NCj4gPiB2My0+djQ6DQo+ID4gICogQWRkZWQgcHJl
Zml4IFJDQU5GRF8qIHRvIGVudW0gcmNhcl9jYW5mZF9zaGlmdF9pZC4NCj4gPiB2MzoNCj4gPiAg
KiBOZXcgcGF0Y2guDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2Fu
ZmQuYyB8IDY5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gYi9kcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBpbmRleCBhOTZjZjQ5OWYwNGIuLjIw
ZTU5MTQyMWNjNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBA
QCAtMTExLDEzICsxMTEsMTYgQEANCj4gPg0KPiA+ICAvKiBSU0NGRG5DRkRDbU5DRkcgLSBDQU4g
RkQgb25seSAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9OQ0ZHX05UU0VHMihncHJpdiwgeCkgXA0K
PiA+IC0JKCgoeCkgJiAoKGdwcml2KS0+aW5mby0+bm9tX2JpdHRpbWluZy0+dHNlZzJfbWF4IC0g
MSkpIDw8IHJlZ19nZW40KGdwcml2LCAyNSwgMjQpKQ0KPiA+ICsJKCgoeCkgJiAoKGdwcml2KS0+
aW5mby0+bm9tX2JpdHRpbWluZy0+dHNlZzJfbWF4IC0gMSkpIDw8IFwNCj4gPiArCSAoZ3ByaXYp
LT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FORkRfTlRTRUcyX1NIXSkNCj4gPg0KPiA+ICAjZGVmaW5l
IFJDQU5GRF9OQ0ZHX05UU0VHMShncHJpdiwgeCkgXA0KPiA+IC0JKCgoeCkgJiAoKGdwcml2KS0+
aW5mby0+bm9tX2JpdHRpbWluZy0+dHNlZzFfbWF4IC0gMSkpIDw8IHJlZ19nZW40KGdwcml2LCAx
NywgMTYpKQ0KPiA+ICsJKCgoeCkgJiAoKGdwcml2KS0+aW5mby0+bm9tX2JpdHRpbWluZy0+dHNl
ZzFfbWF4IC0gMSkpIDw8IFwNCj4gPiArCSAoZ3ByaXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FO
RkRfTlRTRUcxX1NIXSkNCj4gPg0KPiA+ICAjZGVmaW5lIFJDQU5GRF9OQ0ZHX05TSlcoZ3ByaXYs
IHgpIFwNCj4gPiAtCSgoKHgpICYgKChncHJpdiktPmluZm8tPm5vbV9iaXR0aW1pbmctPnNqd19t
YXggLSAxKSkgPDwgcmVnX2dlbjQoZ3ByaXYsIDEwLCAxMSkpDQo+ID4gKwkoKCh4KSAmICgoZ3By
aXYpLT5pbmZvLT5ub21fYml0dGltaW5nLT5zandfbWF4IC0gMSkpIDw8IFwNCj4gPiArCSAoZ3By
aXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FORkRfTlNKV19TSF0pDQo+ID4NCj4gPiAgI2RlZmlu
ZSBSQ0FORkRfTkNGR19OQlJQKHgpCQkoKCh4KSAmIDB4M2ZmKSA8PCAwKQ0KPiA+DQo+ID4gQEAg
LTE4MiwxMCArMTg1LDEyIEBADQo+ID4gICNkZWZpbmUgUkNBTkZEX0RDRkdfRFNKVyhncHJpdiwg
eCkJKCgoeCkgJiAoKGdwcml2KS0+aW5mby0+ZGF0YV9iaXR0aW1pbmctPnNqd19tYXggLSAxKSkg
PDwgMjQpDQo+ID4NCj4gPiAgI2RlZmluZSBSQ0FORkRfRENGR19EVFNFRzIoZ3ByaXYsIHgpIFwN
Cj4gPiAtCSgoKHgpICYgKChncHJpdiktPmluZm8tPmRhdGFfYml0dGltaW5nLT50c2VnMl9tYXgg
LSAxKSkgPDwgcmVnX2dlbjQoZ3ByaXYsIDE2LCAyMCkpDQo+ID4gKwkoKCh4KSAmICgoZ3ByaXYp
LT5pbmZvLT5kYXRhX2JpdHRpbWluZy0+dHNlZzJfbWF4IC0gMSkpIDw8IFwNCj4gPiArCSAoZ3By
aXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FORkRfRFRTRUcyX1NIXSkNCj4gPg0KPiA+ICAjZGVm
aW5lIFJDQU5GRF9EQ0ZHX0RUU0VHMShncHJpdiwgeCkgXA0KPiA+IC0JKCgoeCkgJiAoKGdwcml2
KS0+aW5mby0+ZGF0YV9iaXR0aW1pbmctPnRzZWcxX21heCAtIDEpKSA8PCByZWdfZ2VuNChncHJp
diwgOCwgMTYpKQ0KPiA+ICsJKCgoeCkgJiAoKGdwcml2KS0+aW5mby0+ZGF0YV9iaXR0aW1pbmct
PnRzZWcxX21heCAtIDEpKSA8PCBcDQo+ID4gKwkgKGdwcml2KS0+aW5mby0+c2hpZnRfdGFibGVb
UkNBTkZEX0RUU0VHMV9TSF0pDQo+ID4NCj4gPiAgI2RlZmluZSBSQ0FORkRfRENGR19EQlJQKHgp
CQkoKCh4KSAmIDB4ZmYpIDw8IDApDQo+ID4NCj4gPiBAQCAtMjI3LDEwICsyMzIsMTAgQEANCj4g
Pg0KPiA+ICAvKiBSU0NGRG5DRkRDRkNDayAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkNDX0NG
VE1MKGdwcml2LCB4KQlcDQo+ID4gLQkoKCh4KSAmIChncHJpdiktPmluZm8tPm1heF9jZnRtbCkg
PDwgcmVnX2dlbjQoZ3ByaXYsIDE2LCAyMCkpDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0NGQ0NfQ0ZN
KGdwcml2LCB4KQkoKCh4KSAmIDB4MykgPDwgcmVnX2dlbjQoZ3ByaXYsICA4LCAxNikpDQo+ID4g
KwkoKCh4KSAmIChncHJpdiktPmluZm8tPm1heF9jZnRtbCkgPDwgKGdwcml2KS0+aW5mby0+c2hp
ZnRfdGFibGVbUkNBTkZEX0NGVE1MX1NIXSkNCj4gPiArI2RlZmluZSBSQ0FORkRfQ0ZDQ19DRk0o
Z3ByaXYsIHgpCSgoKHgpICYgMHgzKSA8PCAoZ3ByaXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FO
RkRfQ0ZNX1NIXSkNCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0ZDQ19DRklNCQlCSVQoMTIpDQo+ID4g
LSNkZWZpbmUgUkNBTkZEX0NGQ0NfQ0ZEQyhncHJpdiwgeCkJKCgoeCkgJiAweDcpIDw8IHJlZ19n
ZW40KGdwcml2LCAyMSwgIDgpKQ0KPiA+ICsjZGVmaW5lIFJDQU5GRF9DRkNDX0NGREMoZ3ByaXYs
IHgpCSgoKHgpICYgMHg3KSA8PCAoZ3ByaXYpLT5pbmZvLT5zaGlmdF90YWJsZVtSQ0FORkRfQ0ZE
Q19TSF0pDQo+ID4gICNkZWZpbmUgUkNBTkZEX0NGQ0NfQ0ZQTFMoeCkJCSgoKHgpICYgMHg3KSA8
PCA0KQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkNDX0NGVFhJRQkJQklUKDIpDQo+ID4gICNkZWZp
bmUgUkNBTkZEX0NGQ0NfQ0ZFCQkJQklUKDApDQo+ID4gQEAgLTUxMSwxMiArNTE2LDI0IEBAIGVu
dW0gcmNhcl9jYW5mZF9yZWdfb2Zmc2V0X2lkIHsNCj4gPiAgCVJDQU5GRF9DRk9GRlNFVCwJLyog
VHJhbnNtaXQvcmVjZWl2ZSBGSUZPIGJ1ZmZlciBhY2Nlc3MgSUQgcmVnaXN0ZXIgKi8NCj4gPiAg
fTsNCj4gPg0KPiA+ICtlbnVtIHJjYXJfY2FuZmRfc2hpZnRfaWQgew0KPiA+ICsJUkNBTkZEX05U
U0VHMl9TSCwJLyogTm9taW5hbCBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMiBDb250cm9sICovDQo+
ID4gKwlSQ0FORkRfTlRTRUcxX1NILAkvKiBOb21pbmFsIEJpdCBSYXRlIFRpbWUgU2VnbWVudCAx
IENvbnRyb2wgKi8NCj4gPiArCVJDQU5GRF9OU0pXX1NILAkJLyogTm9taW5hbCBCaXQgUmF0ZSBS
ZXN5bmNocm9uaXphdGlvbiBKdW1wIFdpZHRoIENvbnRyb2wgKi8NCj4gPiArCVJDQU5GRF9EVFNF
RzJfU0gsCS8qIERhdGEgQml0IFJhdGUgVGltZSBTZWdtZW50IDIgQ29udHJvbCAqLw0KPiA+ICsJ
UkNBTkZEX0RUU0VHMV9TSCwJLyogRGF0YSBCaXQgUmF0ZSBUaW1lIFNlZ21lbnQgMSBDb250cm9s
ICovDQo+ID4gKwlSQ0FORkRfQ0ZUTUxfU0gsCS8qIENvbW1vbiBGSUZPIFRYIE1lc3NhZ2UgQnVm
ZmVyIExpbmsgKi8NCj4gPiArCVJDQU5GRF9DRk1fU0gsCQkvKiBDb21tb24gRklGTyBNb2RlICov
DQo+ID4gKwlSQ0FORkRfQ0ZEQ19TSCwJCS8qIENvbW1vbiBGSUZPIERlcHRoIENvbmZpZ3VyYXRp
b24gKi8NCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbDsNCj4g
Pg0KPiA+ICBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHsNCj4gPiAgCWNvbnN0IHN0cnVjdCBj
YW5fYml0dGltaW5nX2NvbnN0ICpub21fYml0dGltaW5nOw0KPiA+ICAJY29uc3Qgc3RydWN0IGNh
bl9iaXR0aW1pbmdfY29uc3QgKmRhdGFfYml0dGltaW5nOw0KPiA+ICAJY29uc3QgdTE2ICpyZWdz
Ow0KPiA+ICsJY29uc3QgdTggKnNoaWZ0X3RhYmxlOw0KPiA+ICAJdTE2IG51bV9zdXBwb3J0ZWRf
cnVsZXM7DQo+ID4gIAl1OCBybmNfc3RyaWRlOw0KPiA+ICAJdTggcm5jX2ZpZWxkX3dpZHRoOw0K
PiA+IEBAIC02NDMsMTAgKzY2MCwzMyBAQCBzdGF0aWMgY29uc3QgdTE2IHJjYXJfZ2VuNF9yZWdz
W10gPSB7DQo+ID4gIAlbUkNBTkZEX0NGT0ZGU0VUXSA9IDB4NjQwMCwNCj4gPiAgfTsNCj4gPg0K
PiA+ICtzdGF0aWMgY29uc3QgdTggcmNhcl9nZW4zX3NoaWZ0X3RhYmxlW10gPSB7DQo+ID4gKwlb
UkNBTkZEX05UU0VHMl9TSF0gPSAyNCwNCj4gPiArCVtSQ0FORkRfTlRTRUcxX1NIXSA9IDE2LA0K
PiA+ICsJW1JDQU5GRF9OU0pXX1NIXSA9IDExLA0KPiA+ICsJW1JDQU5GRF9EVFNFRzJfU0hdID0g
MjAsDQo+ID4gKwlbUkNBTkZEX0RUU0VHMV9TSF0gPSAxNiwNCj4gPiArCVtSQ0FORkRfQ0ZUTUxf
U0hdID0gMjAsDQo+ID4gKwlbUkNBTkZEX0NGTV9TSF0gPSAxNiwNCj4gPiArCVtSQ0FORkRfQ0ZE
Q19TSF0gPSA4LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHU4IHJjYXJfZ2Vu
NF9zaGlmdF90YWJsZVtdID0gew0KPiA+ICsJW1JDQU5GRF9OVFNFRzJfU0hdID0gMjUsDQo+ID4g
KwlbUkNBTkZEX05UU0VHMV9TSF0gPSAxNywNCj4gPiArCVtSQ0FORkRfTlNKV19TSF0gPSAxMCwN
Cj4gPiArCVtSQ0FORkRfRFRTRUcyX1NIXSA9IDE2LA0KPiA+ICsJW1JDQU5GRF9EVFNFRzFfU0hd
ID0gOCwNCj4gPiArCVtSQ0FORkRfQ0ZUTUxfU0hdID0gMTYsDQo+ID4gKwlbUkNBTkZEX0NGTV9T
SF0gPSA4LA0KPiA+ICsJW1JDQU5GRF9DRkRDX1NIXSA9IDIxLA0KPiA+ICt9Ow0KPiANCj4gRXhh
Y3Qgc2FtZSBjb21tZW50IGFzIHByZXZpb3VzIHBhdGNoLiBBIHN0cnVjdHVyZSBsb29rcyBtb3Jl
IGFwcHJvcHJpYXRlIHRoYW4gYW4gYXJyYXkgaGVyZS4NCg0KQWdyZWVkLg0KDQpDaGVlcnMsDQpC
aWp1DQo=

