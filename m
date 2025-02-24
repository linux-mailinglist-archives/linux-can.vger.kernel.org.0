Return-Path: <linux-can+bounces-2942-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D7A41B4D
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F13174F6E
	for <lists+linux-can@lfdr.de>; Mon, 24 Feb 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C82255E4E;
	Mon, 24 Feb 2025 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TtQL8Qc6"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011047.outbound.protection.outlook.com [52.101.125.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3515250BEF;
	Mon, 24 Feb 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393405; cv=fail; b=I9izGZ7pG/N4K+WJA/EXIynR9FIKgqjIfB1WrwYRhmoUlsaPugRNm/fSYpnH2xGRpzuSuEM1DU20on5Zr9gVaentGg7NiHMYM+tGI+Ga968mbJDcjdM5RpE0cDLIJnx2OvIUOc6Fhels/0P/nPS6n+B7RNLZWgaJAskxxjtYBlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393405; c=relaxed/simple;
	bh=n4Tavw9zFy9bcL/gJ47iOLnjNaBjNiVwrutlQ3HjjFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cYx6lAAd0FsG7quwuTkB/GcDsm6HudIxKFzvTxtD72zEEDxyypXgZdhUMxtgQSVRBtIsT9MBxbqDns1A2sGWFGQ3aVGe8Tmzq/5mcy/1IhGQNDtXaDXsIudJ/UkIPd4iRg9xhsuJS3o9j+Ixnu2Wvc4JrEDPVw+dRNrjoS7cOI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TtQL8Qc6; arc=fail smtp.client-ip=52.101.125.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQL6LmvxtiKUPtv02ko6loeRAygxUERO3p2wdp4Gir7KiZwt3MpN+pG82l2/dWt2Dk+TZ9JhFZkSVFfZlQc1PRld2SW/Fiuk2CJo9kxNLycLlvgmucjHczCloaI22dbSSTlaTTs089OLGV5d0YgL2cS6489zYpOIOpRt0Ac7k5kauxMf01PdCyZQ3CEp5cmRmBZKvAQ0/73DVeO4Z8g08GZQABm5ERFWBbTJTO0tJ7yFNIc9HY1riBB0HkbkNAvcxdWZsTUrFYSjvH+poGNYHWBuwtQfzux+pDLIo7P+54i4108P/AXFlJD95djOzrtJcztlNMwduKZzNwgNC1nA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4Tavw9zFy9bcL/gJ47iOLnjNaBjNiVwrutlQ3HjjFE=;
 b=xo9OHwWm3kpaQG/LCrRJq9pSJoQcdnSwow5WnrgPNNin5l+1ZWSnMHsdn0BapfcG9qc7XreK4gEuHrLyxmzOvekIVvyZWxN5d2cD2GnXwfRDQTVAw6/69HKzLFaJdHG/e6IS/QtIm6mST4X15Cg609KmLzcSn0wFGQ7e7y3IKM2nKb1pfvswDVrLFsAcW7EvvpB3RqPQgZgNqR4Ka1VfY9/gfKc6fLuPeMWGlUya9JmVvGN/4L8BPzhKAvsG03ncd6TJdZQkm+prAJa5EvkqTGuQuy73f9a5bD1mGPlRVE1BKKA1TJ4d85GRU1ZWr90SdC8OPmayct4aoBlh9Bc6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4Tavw9zFy9bcL/gJ47iOLnjNaBjNiVwrutlQ3HjjFE=;
 b=TtQL8Qc6aaVddL0ENfVXpAv2se88L3nfYwkAQHjSuowhBxZvEMR4vWu58x+7ISTfrNl8xHKZ+oqLAHqVxVWpxKlY0j7oO26BNYlL2bwLCI5G0/h+u+Jl1Oodjz2VGXFVE1ODyWV6bc9UU6ZuRAAlpiSWDgzAdDi1LqlyOEBts5g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12495.jpnprd01.prod.outlook.com (2603:1096:405:196::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Mon, 24 Feb
 2025 10:36:38 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:36:38 +0000
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
Subject: RE: [PATCH v2 4/7] can: rcar_canfd: Add gen4_type variable to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v2 4/7] can: rcar_canfd: Add gen4_type variable to struct
 rcar_canfd_hw_info
Thread-Index: AQHbg5gKFGtXGSEFgEKYWvTOi84El7NWQeMAgAAFIwA=
Date: Mon, 24 Feb 2025 10:36:38 +0000
Message-ID:
 <TY3PR01MB113464CF8A3EBAFDB1B4464B486C02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-5-biju.das.jz@bp.renesas.com>
 <CAMuHMdWVsf+1J_e5iu_29SjVyF+wWnj4MH5sktb_FNeQpo5F0Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWVsf+1J_e5iu_29SjVyF+wWnj4MH5sktb_FNeQpo5F0Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12495:EE_
x-ms-office365-filtering-correlation-id: a98bf194-44c1-4f02-f71c-08dd54bf1e91
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUJ1WjBCamtORjgrVUVYY3FPOWhRMEdyVnhYYWhSNktUclF5R2FXZklsQlY4?=
 =?utf-8?B?b2owR29QVjErcDloTEFYR3NYTDl6b0VDbUpRY2hFLzJaRHlXZmloQ0h0ei9h?=
 =?utf-8?B?d3c0RnJ5NWs3Qm95ZmVkRnArMzUvTEhCM080VU1TekpndGc4VkZjbU9ISWhF?=
 =?utf-8?B?WUFSSkJ2UlJpVkpQNHV2ODhjbnFRa1VLcmNtVXl2SnJGcnQxN3dCbGNpdWVj?=
 =?utf-8?B?WjFrZ25tS1hCeXhvNDNrN2loZERpK0s2bXJxSG93SkUxRkZ5OWFRTi9ieXdI?=
 =?utf-8?B?NGJZbmdVZHBwbDVCbnFyKytMK1d4QUNLQW5VTUlxN2JkN1JESjFDb3JFdTlL?=
 =?utf-8?B?U0ZYTjhiVnRESGJEL0E4bXQ3aHRxQ0xQeVI3Y1pGKzNCNUMxaFczeCtMMENE?=
 =?utf-8?B?ajFrZXlkbDNmdHNFMXVEUEJOVktrVDdIZ2d0V2ltRFBKaVpQcVNxVGVGbEdx?=
 =?utf-8?B?aXBralVEWm95Sk5udXRScUU2V0JqL29MVFoyYzEzVnd3U21zYVQwWWQvUmhw?=
 =?utf-8?B?NW5NTWVXaGpCWEFXTFArQTh4QkE4UWIzSi80S3RaRU1HZXJDS1lFY0RkR2hF?=
 =?utf-8?B?Y3JFSUpDRThHemNQMXBaMTJRbStwRXY4bWN5YlZjVVJ2SzJ6WWRZUlpZazB2?=
 =?utf-8?B?T1IyWmJIRVZDQ2twcUVUOHRHUmNrT0RzVC94NFRaL1RNRnZ1TzhRbHJ3Zy9y?=
 =?utf-8?B?STlIRGZYd3AzZ3ZjU1QyVXkyTVk2ai9UaHIvZ2NrUFdQazVoOTNEVEFJazVF?=
 =?utf-8?B?WjNOV1JxYktmeEJKZG1HUnFqd0VhcXI0N0ZrKzJ1bWpLZjAzQXVYci9Xdndy?=
 =?utf-8?B?cm4wS1hrN2FzRVhtWlB0WWkzcUF6WFFaL3BYN0E3NGd6Y09pdGRBVmFmcnVE?=
 =?utf-8?B?a1YrNGxiOWVoT0liczQvNHFhZnF3d2wzZVNjNm5GeXhwcVFLMktvNXkxTy9D?=
 =?utf-8?B?ZStIOEw5aFNmNXJaWG5hWTlsWWl6bjJhMzJFMk5NdTRwNVdmdEplVVF2dERM?=
 =?utf-8?B?KytHNVAybGVkNWkrWllNdWErSTVRSlR4Q1ZJTGgrZ250TjZQd0V5Y3dMZkxy?=
 =?utf-8?B?RFg4dkxxN2VQMzYzQlBpNFhlUU9KWjJLRWZXbklZRFc5enVOQTBFeWdadVJt?=
 =?utf-8?B?M3JzT1JZeEdrMW9sbkYxOFp3VE1CMWxUT2kxc3RVSUROTkN5MVdjeVFORXpY?=
 =?utf-8?B?NTMzdzFJbVk1NWhXODdabGZoOUR3MVhaYWc2N0NzczlkbVJ5MmdTeEhIRjlE?=
 =?utf-8?B?WTlIbTJvcnN3UytSV0owNGV0T0VseldhTHhMZkpmNGM5WFd5ZVNMNmtwTlJr?=
 =?utf-8?B?YVh3c3VuTjdtN0lRMTErTEJLM0NlWnlMbStYbmZaeWY3eHBYdDluRE9PVkhW?=
 =?utf-8?B?Y3NmZnVmeGpmUDNBeS8zNFdzMW1EdHFOcEk0OWRvY2NCNDQ4L0lVR3ROL3Zh?=
 =?utf-8?B?MlZGd1A5N3ExSDlDQS9DM0dramhSMGl5aVZGTHoyd3g0cmY5bkxTTU1DUzE1?=
 =?utf-8?B?TVFUUHBJQ2R3RGZrRVA4OEVXVWhDNDI2SGE3aW8zdUF2OHZ2OXlqaUtxMFJa?=
 =?utf-8?B?RHRiNi9icUZiVThyUE5nbVVpMkowQ2toMXVUVWc4UEtJNVFuZGM0MVcxRlFU?=
 =?utf-8?B?OGZtUjBXMkFzcXlPUG0zc2xVcXZoamdRNk1qS2lNem1WdDNmRGNSSkVnMTZo?=
 =?utf-8?B?WHpkY2s1QkxlMUQ3ZFk1YkR6d0xYQzBYNVE5NzRyWnFaR1N4V01MRmQ0blpk?=
 =?utf-8?B?bUgvTHB5a1pXU2hOeUNVWTBZNk13NHhUd2lrRHZUZXJqT3h2b2RqdGNlT0sz?=
 =?utf-8?B?eXZZUzRmNi9TelZDSVMyN3RXRytFM2I2WkxFUGJrdFp4RzVWSEtaOGw5SlZI?=
 =?utf-8?B?cFRPWTJucGZ6WkdXaW1UWTdvZXFtZzZERTcremlRQURsK3I3amdlRzMwRk9M?=
 =?utf-8?Q?o+fsG2o2UV5RxSiazO4jiroS8GBRoPZb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXZURGxwMXd3L1pvZjJUVy9oRmJveXJweDlwbnlpZlBCME1DU3N0dzVJaXJ0?=
 =?utf-8?B?bWl5T0xvMytPUCtlWGt2Mm5hcGJVekhGYkxQRmZjVnVpcTEzOGJZc1E5SXlm?=
 =?utf-8?B?eWxoTFlnWnhYSzVUaWpmeWNiVlRIZmdPQkNlWktYV01sQzhpM3ZGRWJrVVpj?=
 =?utf-8?B?OWt2TlhXS21qQ3FycHZsMnlsQ1pJM1R6aTFvUkl6UGpEU29acmwwcGtUcnVk?=
 =?utf-8?B?VVFYWmlQT09RQi9lRk51TEtvQ0NuVE0vQ3JERFBNTzVrUllOdXVtUjRJckZF?=
 =?utf-8?B?WUhpWTFHZDNTN0tWNm9LMVdBNDJ5Z2c4ekwrVzM2ZjloY3pURFBCNUNuVzZh?=
 =?utf-8?B?Z29RbGpWckNDNmk5OU5QT1dnQ3dUVDFPWGhNbEtoajhLQVlnUkZiMEJEcXAw?=
 =?utf-8?B?am1MMS9vbWRDUnlKT0orVkIzY3BacURBRWFDMzE1ejk5NTBsck9uTElnczFv?=
 =?utf-8?B?Qy91Qk9kNkg1RVlQWmdHMjRrMDJDeUx0NGtOdytZRzBPY04zNHJOWGt0NlpQ?=
 =?utf-8?B?QVRmOGZaL2E1M1RybTlKUUZ2cVJFOG5QbEpmQTgvVUh5S25WNXdaLzB1WU4y?=
 =?utf-8?B?TDFraDNMSXI0dWREdUVQbE9iSG5NMWNSS2ozRGJVSUxXTUl3Wk1wY0dsb3Ew?=
 =?utf-8?B?cDVNeWpsWWxMWVo5V1dQekVOSncxRzhNQjJjMXhacFl3THhvc0I3L2pDWW43?=
 =?utf-8?B?TnRvTnNaM2JKT1BwQmFVM3V1NmJuMmRabEVDWFprODBBOGZIUDNTbWNmSTdi?=
 =?utf-8?B?cVJiUDg2Z3FUWVZ5VHE3TTRnbjBGMHJUUTZKZkNZZStRRFpzL0lCQ1NGWWk4?=
 =?utf-8?B?czlOUHA1NHBLbTNMdmxPTjNCZ04relBqREtZVWFiWEFCajdGQU9jYjhRYWZU?=
 =?utf-8?B?YnB2bUxLYi9wNHZFSldnbEtDTFVwVDl4ZHcxekF0Y0xGdUUwSVhub1NrdzFN?=
 =?utf-8?B?citLNVZQb3RQS1RlOVpEVFh0d2NoUTlOQVBPcEJKYXcvWm51QVpLU2pxM2VM?=
 =?utf-8?B?MUJEc2VCWFZxR2FMd21ueG1FM0RVLzJaZkRuN21hdFJYUVRwMHlrVFZ3Vkx3?=
 =?utf-8?B?ZkF0dWZ4QUVDOS9MVThCTzNHbDZwSXdRMEZoSTV1SW54aFJDOTdwUlU4NC8w?=
 =?utf-8?B?dGF2Q1REdmQwaVNnSTB1UG1XTkZaRllwRnRLa0ZxS2ZrWERxVmFhUTJqYlNu?=
 =?utf-8?B?RFdEUkNYVlpJT21LeDdITFJFbytSZUg1UHJ2cm54blVxVTNkT1dJaVM0RlFI?=
 =?utf-8?B?RGxMZGhmYWMya0lZeHhkSTV1elRxUUxZdWhNdGtqeDdoVGg3M0g5dXlBeEcw?=
 =?utf-8?B?QVNBWW5hSVplVmVDd242QnN6ZmlxZVJnRlRVaGRuQ29xemFMbGQwRGJqeCtk?=
 =?utf-8?B?VXdOQkpFV1M1Yk8vZVVzZUNkN2NzNDFkdGRscVRpZ3dVeDRkM0F0bmNUL3A0?=
 =?utf-8?B?QWFqOFJjZFF6UVV3RTkrMkVrVmU3T05QYUZBczVxVmRTZFZsYUc1bWFDc0Jx?=
 =?utf-8?B?RlI5M1hVNklXZTJTbi9RK2FweGkxci9qaXoxMlg4dUNHZ2ExQXl3dzhmZWQ2?=
 =?utf-8?B?SUlwZEtwc2NCZ3dEU0xWU2pQV3FYNlJUWUh4bm03ZWVBN3ArKzA3YmJia1lV?=
 =?utf-8?B?MFFJV2FHaUJrVFV2emM4cEtvNUl3aWgvZWxicHc1SHRIb1pMTmpld05qSFdU?=
 =?utf-8?B?U3RmMXVWd0F5TGh1dzRCSVdLSFJJeTl5L3MwampkYTN5QXJZTTZFU2dDQnVK?=
 =?utf-8?B?TU4zbDJ2enhtcDQ0N2JyY2N2TWhYRGU5MXFtWkdxYUt0amhCc2pxK2hXT3lu?=
 =?utf-8?B?Zm9xUm1hcUF1NWlpZDZ0QjhZRmtob0ZRL2NsdWYrNkNRWXJCdWxuOE96YnBi?=
 =?utf-8?B?THFpMkQ2bThpSlR0bEtGM1pRV2UrNjBrS25PS3JyK1hlUlBic0lyY2NqM0ty?=
 =?utf-8?B?Qm5pREp4UEpIMHFtMWs4Q1dUaUprZmsvV2FpTUFpNTVESWhyTmpjdmluVVJ3?=
 =?utf-8?B?Vy82WVh5OWtvd0U5SkJSbmxSMWdpenE4Mm1QdlhIT2d2alc2L3lPcXVnQlpH?=
 =?utf-8?B?WXZ6ZnE4bDhHZ2tmWWw5SkpaMDN0djFxbW1uNFhvU1c5bC9xT0NqN2xCcnJL?=
 =?utf-8?B?MDR3dXhJYUh3Q0k5RDVjbkRoOTUzZ3RaK3VNc1NrUHpwVWFCSzRkR2VNbTY1?=
 =?utf-8?B?T2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a98bf194-44c1-4f02-f71c-08dd54bf1e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 10:36:38.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrBhEzl3k7ohXNMG2TO08shoW9r3+NI1RiG00cgYXpquC9xvh3PjaIVeDDV0ZAXNPw5+H9Cw/BFxiY+zo1kS9jLiVUDIYTLptR04XzvkAJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12495

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjUgMTA6MTINCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA0LzddIGNhbjogcmNhcl9jYW5mZDogQWRkIGdlbjRfdHlwZSB2YXJpYWJsZSB0byBz
dHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCAy
MCBGZWIgMjAyNSBhdCAxNDowNCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PiB3cm90ZToNCj4gPiBCb3RoIFItQ2FyIEdlbjQgYW5kIFJaL0czRSBTb0NzIGhhdmUgc2ltaWxh
ciByZWdpc3RlciBsYXlvdXQuDQo+ID4gSW50cm9kdWNlIGdlbjRfdHlwZSB2YXJpYWJsZSB0byBz
dHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIGZvciB0aGUNCj4gPiBwcmVwYXJhdGlvbiBvZiBhZGRp
bmcgUlovRzNFIGRyaXZlciBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBh
dGNoIQ0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBAQCAtNTE2LDYg
KzUxNiw3IEBAIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gew0KPiA+ICAgICAgICAgLyogaGFy
ZHdhcmUgZmVhdHVyZXMgKi8NCj4gPiAgICAgICAgIHVuc2lnbmVkIHNoYXJlZF9nbG9iYWxfaXJx
czoxOyAgLyogSGFzIHNoYXJlZCBnbG9iYWwgaXJxcyAqLw0KPiA+ICAgICAgICAgdW5zaWduZWQg
bXVsdGlfY2hhbm5lbF9pcnFzOjE7ICAvKiBIYXMgbXVsdGlwbGUgY2hhbm5lbCBpcnFzDQo+ID4g
Ki8NCj4gPiArICAgICAgIHVuc2lnbmVkIGdlbjRfdHlwZToxOyAgICAgICAgICAgLyogSGFzIGdl
bjQgdHlwZSByZWcgbGF5b3V0ICovDQo+IA0KPiBQZXJoYXBzIHRoaXMgY2FuIGJlIHJlcGxhY2Vk
IGJ5IGEgKG9yIG1vcmUpIG1vcmUgZGVzY3JpcHRpdmUgZmVhdHVyZSBmbGFncywgbGlrZSB5b3Ug
ZGlkIGJlZm9yZSB3aGVuDQo+IGludHJvZHVjaW5nIHJjYXJfY2FuZmRfaHdfaW5mbz8NCg0KT0ss
IExvb2tpbmcgYXQgY29tbWl0IGxvZyBhbmQgaGFyZHdhcmUgbWFudWFsIHdpbGwgZG8gdGhpcyBj
aGFuZ2UgdG8gYWRkIG1vcmUgZGVzY3JpcHRpdmUgZmVhdHVyZSBmbGFncy4NCg0KDQo+IA0KPiA+
ICB9Ow0KPiA+DQo+ID4gIC8qIENoYW5uZWwgcHJpdiBkYXRhICovDQo+ID4gQEAgLTU5Niw2ICs1
OTcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyByY2FyX2dlbjRf
aHdfaW5mbyA9IHsNCj4gPiAgICAgICAgIC5tYXhfY2hhbm5lbHMgPSA4LA0KPiA+ICAgICAgICAg
LnBvc3RkaXYgPSAyLA0KPiA+ICAgICAgICAgLnNoYXJlZF9nbG9iYWxfaXJxcyA9IDEsDQo+ID4g
KyAgICAgICAuZ2VuNF90eXBlID0gMSwNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyByemcybF9od19pbmZvID0geyBAQCAtNjA3LDcNCj4g
PiArNjA5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gcnpnMmxf
aHdfaW5mbyA9IHsNCj4gPiAgLyogSGVscGVyIGZ1bmN0aW9ucyAqLw0KPiA+ICBzdGF0aWMgaW5s
aW5lIGJvb2wgaXNfZ2VuNChzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2KSAgew0KPiA+
IC0gICAgICAgcmV0dXJuIGdwcml2LT5pbmZvID09ICZyY2FyX2dlbjRfaHdfaW5mbzsNCj4gPiAr
ICAgICAgIHJldHVybiBncHJpdi0+aW5mby0+Z2VuNF90eXBlOw0KPiA+ICB9DQo+IA0KPiBBbmQg
aG9wZWZ1bGx5IHdlIGNhbiBnZXQgcmlkIG9mIGlzX2dlbjQoKSBpbiB0aGUgcHJvY2VzcywgdG9v
Li4uDQoNCkFncmVlZC4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiA+DQo+ID4gIHN0YXRpYyBp
bmxpbmUgdTMyIHJlZ19nZW40KHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYsDQo+IA0K
PiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0
DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBj
b252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tl
ci4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8NCj4gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

