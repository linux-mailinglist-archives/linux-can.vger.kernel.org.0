Return-Path: <linux-can+bounces-2840-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE9A39B5A
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8832B7A4AA0
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1723F273;
	Tue, 18 Feb 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IbkpkOQX"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB2239563;
	Tue, 18 Feb 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879181; cv=fail; b=R1L+b4088Pm3it93VpA3rQWz2XCOrV3HCoaGiFSnMNbH9IZ0Am6awwdxlO5Qx4XBZX4p8408Ghqpq9Oi/yEkAhVTrfTMFUHtbE/29CG0JIsFJ0RKse0oldkCoCfl5P6fmZ6ytXIvi1Dje8Nlgh1wyAd5UPNlhEXmt9FznUQQLFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879181; c=relaxed/simple;
	bh=TU897Gi/1F5pFCPwimNTGIiMI1hOM8PCxigGGeGKjEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lt27dPfjkJUvVvQj/s2Y5SNRcqQXgD2BVJZT0FL1VQjlC/vYLZQ1UrrNxfzlyMh0oRJtDC1ETFY2BUvR7u0UDPSKcxX9+QOAarmsj+qjV5/UIYng7DpHXY1U4Zr472Lp11YzBatCwpwtwAgBaNVWL2ofNTcE3VNVHd+FWGanHSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IbkpkOQX; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2P6mdzZU0YR4BXq/vq/fgDvIx7W5c5es0Uls/z4XRXDfT4eTKrCd594Xf5FC9R/pXK7CUSVbgpPsJihP5mXJ5AWimQ12dlijPLS6yB1lnY/MX+Ytn27n4TsWEFlHz2ywbsHu5ihTJKtfBZ0Gh0nMXMXowKhmswbZa64O6gqkUVcbndOeA5lTgBBjozCIfi2aQK1/LI1egpiplBtxF4+m9FbIElWxPFeTfb++I5f2mSYJ5aysbWMPFtJjooEQw073nb++WgmQ1aGHEmXFpIaxuZXP5RNLPvfQWgaGq49kt4QhOyQA1WSUwTOvQw2CkQEFx5mAEpC1r6IqLLU0GIdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU897Gi/1F5pFCPwimNTGIiMI1hOM8PCxigGGeGKjEY=;
 b=krI4W7MeiRqzIiqRKsbt3xHz7IhvwRrn/w4jpUNAfEf+JD+lh6iP4vN4oKC89xtmowV7vrc07j4PKwMs+mA5+6syLPoXbpL+5lKl+g3PUqVt1hWtWLrPfGJ2z4z7wGzSS6OKfU+3oVx+oJ/9JsUDgqbA+AI0MdjdnbvWfofmMOYQ+kSeM+s/Pw3axrzDDQF0Zgbtiq/pwK5XfUngIpiawXK27lR8XX6tmZksbKjPM2aykpJwEHBysxvYADiQmcwgc/Wa5HD5Un4FADkvWyRF+UskudQmvyx0SqktntYgfsgKgidmBkmayc8zL3orMzS1JF0zZd9kUMp06c5mH6kWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU897Gi/1F5pFCPwimNTGIiMI1hOM8PCxigGGeGKjEY=;
 b=IbkpkOQXwrcdkQtxxHBgUQPsWLWf+RiTb6sW11nkWsWoWbYYo4cUkMPpAYiuvu1psD+i1yUG5dA1v5WKyhDK77UtAxX/pv0w1OY1puIoQ5VgntqAAGBBTHn8Cif50of97kNgq06qvdcxz53/xssHklUVkm5EcSwtrjao8jzBkOE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB15173.jpnprd01.prod.outlook.com (2603:1096:405:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 11:46:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 11:46:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH 00/11] Add support for RZ/G3E CANFD
Thread-Topic: [PATCH 00/11] Add support for RZ/G3E CANFD
Thread-Index: AQHbgfLm+Dqw6+dv70i+39VSRIOW9rNM6JeAgAAHTUA=
Date: Tue, 18 Feb 2025 11:46:14 +0000
Message-ID:
 <TY3PR01MB1134644C8EC2C3857EFE63EF386FA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
 <20250218-outgoing-binturong-of-tact-aa4d49-mkl@pengutronix.de>
In-Reply-To: <20250218-outgoing-binturong-of-tact-aa4d49-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB15173:EE_
x-ms-office365-filtering-correlation-id: eb6bc18f-4af5-4592-b045-08dd5011d952
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVBVRnJVUWRmRmNOaEtieG9pQWZBZmF6dE9CUHQxcGtCUFZ5alNtZ3ZYdldK?=
 =?utf-8?B?L2FaSEF1RHg4UU1pbzFNL2ZyL2pPNk45aXp3QkJBT3ZYQ1grb0VFRDR4bkRD?=
 =?utf-8?B?UjVidUJVVmxlUEt6c3VMZGtETVdkOEFxdFIwUGNxRnk0NE82SnMvc0hZemtK?=
 =?utf-8?B?ejJxZG0vNG9iSmp6d3M0UGJ2RzNjQXJIY2VPdVpuMVFlUEg4NllmUlFITEFK?=
 =?utf-8?B?NENtcmZKVHVkWHZHenB3R212WmFCVnplRHQzTGdIOFdlYUdaS2VrSVAzemI3?=
 =?utf-8?B?ZXF6c0g4QW81dmVWTlRiaFkveE45OC9oNTZaS2dsbjhEY3k2YjdvRE1NUVpS?=
 =?utf-8?B?SFROaXEyUFAyeE1wSk9FVFVtNlUrUjVuM0tJVTRwR0xTa1FFa0RiVUhqelRL?=
 =?utf-8?B?QVcyMG1iZTZ4UTNlL2R3TDdKNzA2RzZNQmwyWE1relBoVjZhVzNDQVZ2TUNj?=
 =?utf-8?B?VDRzTGluaGFoeVoydTViR0lQMWhNSVZxV2ozKzFMOVFSZ0k2WXk5ZVhaQzUv?=
 =?utf-8?B?ZVhWSjNEMzZnWkxVZ0NmdHJZT3ZuRlYwMkVlMXkzWkFNVmp5K2QwdHd5dlJS?=
 =?utf-8?B?RTMzTzJIdWU2MDRTcGdKL1JZYktxOFc5UlI4Ky9PYXFsT2x5aVFJWE9xdWhW?=
 =?utf-8?B?eVFMNmJ1Uk8wajdTOXFMeDNUNEljMjBaWWJhTlhqOGdzSDQyQmFMK1NhSEx4?=
 =?utf-8?B?M2xxaVVpckdSRDdUTnc1amo1YnZ4Qk1OUEtndWt3enorY2VFRHl0Smo2UjZS?=
 =?utf-8?B?QmJBSXBOZDlwbWhycHZGL1ZmTmlkdktTZ3dFdGNnazBPM0NBeERwQWlsTjRC?=
 =?utf-8?B?YmJ5Y0xVc2dvVmRJYURRa1FROUt4NVlIdm1sYmViV1J5amc3K29BWERWUFF0?=
 =?utf-8?B?bUZmbzREdmlEVUJkL005OE9iekhNVHRWUXFvSFl6UFJRdWVoWVJXdXA4V2ZC?=
 =?utf-8?B?b1lmaTNPbmgwaHR4YXV5Ry9vcVBxMDY1WGZUZ0dpODAvUUlYRTAzc1J2OFN5?=
 =?utf-8?B?ak05RGYwMFdMZXhHR0pWdklOUWRKRUJmZlk2a3F1eGhpM0k0bW5BbTdmdHVz?=
 =?utf-8?B?UFZTWEJSV2w2Myt1UXBWQURVMG5aZVBsTHNhakNBUmFSZUZBTGpzUVVDNktW?=
 =?utf-8?B?a1dhUkp0K3I4WFp0a2dXUjRsd2tFcUZNc3Y5QWJ4WmwrakQ2c3o5ZngwdEV1?=
 =?utf-8?B?Ky9TWXZrZWorRUZLT2hZMlRvMFV4Zzg2VlNQakZWK09Eb3EwNW9hNEtDVkNa?=
 =?utf-8?B?RHBhQXBvSDREQlhwbS9lL2pDMld5YmJlME5MYk1pQUtIVk11b1hTeENDcG42?=
 =?utf-8?B?dHlYQ0dCUDRheXFrSHhkYytINnRqeXlPRTJJZXViSk44NmRBS0RYSW9ZUlNs?=
 =?utf-8?B?QVY1Y212RFhBMjIydmxmSGg4RWFKVUZ0Y1VodzYyUHZQYmdtQW01cUQyazFr?=
 =?utf-8?B?UXpDMU4yZEJtN200OFc3VE5ubDRZbHNFaWo0OTVyL3ZncUVqZmEvSGRuazlK?=
 =?utf-8?B?V1FEVWltaXBRZEFua3hTMGdRTzFlYmV0aHVtZVBTaWdMemtnQ05xdythaURu?=
 =?utf-8?B?WGFObkhqaDdiNndEa203VGRrMkdWd3hqNUtPVFFhbXp6YzBNOEcvWTlka3F5?=
 =?utf-8?B?YURRRkJYWVI1N1A3NUNZZ3RBYVFhNENxbWxIbEpxQUVmNGI3VTdGY2JETXh5?=
 =?utf-8?B?azN3V0RkQUR4SzJXUTF3SWpOWXRrd3YwZmk0MU4zdksvUGVQYS9BczV2VDI5?=
 =?utf-8?B?V2xNZmZoanRLOXV4QWwyNnJXWnRESy9yNHJFQmNaTWVYRnFGUkxVY2lUYjBN?=
 =?utf-8?B?WVhrOVpJYk9XYTgvK3RUNmZYcXliNzRoU0lNdWsydG1yUzZCSi9zMFpMTk15?=
 =?utf-8?B?R0ZnNGlHeXdzTUM3dFdHR1prdjJLQlR0cko4eWh6cFZlV3hIV0FOK2RMcDJk?=
 =?utf-8?Q?XwBBo79o9J7sZiqYxK8pat+wc0wf2anO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZHRk54Q3B2NlY4WXV5RXpmZVg5eXoySWxZNVNNR2xhckxmNmg0SDNPaEsx?=
 =?utf-8?B?STFpMkphSEMzM0gxU1A4ZEoxUmxvSy9uVndxVHd4dnZjQ21UMWp2QmFJRllH?=
 =?utf-8?B?enJ2K0dIbjBmVVljK25JK3p6QmpCdjRJUFN1S2lPZHYwbnRSejdZeDVMMGpZ?=
 =?utf-8?B?RHVOeStkNW5KdkJyckFhSk1PUzlCYTRHc0NBbml0ekl2bHdnQ25nb240Y2dZ?=
 =?utf-8?B?RmZNNG5UOUhMWTYyQ0pZN0ZVRnZJUzFmbkRPT0VtTlo5aVExVVhzUzc1L0pM?=
 =?utf-8?B?TGwxNnpsa1BCQzhkTWJ0alc3TVFuN1ZqYlI2SHNPSGRlc25OZUprY3pxdG9C?=
 =?utf-8?B?cm1kclZMRUJQME1ZWFA5WjFxUmpySzgrMXdIbU80aFd5QkxkVHFYR01SbnFh?=
 =?utf-8?B?VWdDUnAyeDFSRkxadEM2VzBZUjNIUTYweEVQZ2hqejZKYU1yZHU5QUk1eThm?=
 =?utf-8?B?VFQzNGw2RDl6aWtPVW04UVZSMUo2MHl4NmIxUE9KZjNMR3lESjhOZDBYTEFv?=
 =?utf-8?B?QTdFUzJDR084elY0NGhLekxjYWhiUWljTUw5OFVsa0MwMG5uMDVXYVF3WXpw?=
 =?utf-8?B?dE5yZ2VpcUxseTdKYkxJVVIwb3V6WEMwUDdCMVlhL3pOL1BUSk5ZSW5PZVJZ?=
 =?utf-8?B?TUdlNUdmdW9zckRNdTIrcHlCVWpUM3ZoZ0Y4TGNLQWlqbUZEWkU5S2pQQWly?=
 =?utf-8?B?ZWplN1J4K3hKN1VQUk1pWmVSOTIrY3ZpNlVzMHlWWEVQL05aUGpDLy9MeVBI?=
 =?utf-8?B?cUZidE1uTjA5cVpSeXgxMXNBVFVaRGE0NVpLOUswSnNTb3FQbWR0clVUc2JZ?=
 =?utf-8?B?djVJU0ZzZHQ5WCtzY2ppS2QrWG5NcDkya1AzcTg4RHJRQUtMUzdOTitSUXV5?=
 =?utf-8?B?M2I2RFl3RU56dzZRRGh4SmxGN3paNEJhSWFzRXJQRzBlQm5EdWVBOUw0bkls?=
 =?utf-8?B?aWNxeEJLdVNRc1BCRFV6TjFnNkV6TnE0QnBuU3hlSEIzY3RRN0tZd3oxYzRj?=
 =?utf-8?B?NnNGdnhJM2ROYnFUcEY3a2huS3cvM1NTVUluV1M2czJMR3hHZ21RakVBY1pE?=
 =?utf-8?B?Zmt3Y2h0dFJETStSbjBta1d5bk1hc00zOWF0dDgwZVNKcURhVlduSmcvY3pT?=
 =?utf-8?B?K2tDZUlRQ0ZrdWtOM2xOb1Q2ZVJxdHljOFZEaU9ESjAvbXZOQ0RES09PY1F1?=
 =?utf-8?B?U1RXOVV5OEhZWE9tUFowMnMvUkl2UmM3aU50RzNjY2dhUnF0TUtHbXBPajJH?=
 =?utf-8?B?RjRBSnJsaWgydGIyVGdrTlM0SEwweTJVZjZaYzdJMUgra2x5S28rNEt4eVhV?=
 =?utf-8?B?OXJPWXZadE5OK0EveHgwaUhMOUExRnRQS0Z6TzhiZDV5VDZ1WGpvejBsUEJj?=
 =?utf-8?B?K2lTUEd5bWQ4N243MWIrVDJzY3E2M2FMMFJWM1ZGUFlXMWxWQzFHOURFQjdM?=
 =?utf-8?B?UUR5Y3JiWnliQStZL2dWcDgvTnVEazVRdUdXMlpyVFJXUEdQOE5ySEQyekla?=
 =?utf-8?B?d2JIOE9zWlE3bTRsUFI1ay9URTAyL29jMTBkaHpSMmtnRzBrQ1VBc0grMkVa?=
 =?utf-8?B?MFBoZUZzUGpZTzNsMWppdWRkODduSHUvNW1pME1EamZHOENsd1E4SUJPMXZw?=
 =?utf-8?B?WDQrZzlKaEpyQzl1YVBkQXJPSGYxNUZCQTBnU25iVWZRWjRGVFhGUE9QUFp4?=
 =?utf-8?B?WDRzZ3JCdW1wNzdOdmtNU1VBV1ZPQTQzVG1TRkpkdVlHOEJRNGphcTdiUkd6?=
 =?utf-8?B?L1VYN05HekN2bEJhYVhTZXpkR0xyenF1YUxLUHpqa0QyR0RZNzJUQXVCTW96?=
 =?utf-8?B?bFlkRm02Q1dRUzU1RlR4Mzl5UEI3Vmd6R2pBVnNFaXNhQ0o2Vnp6YkZSV3NX?=
 =?utf-8?B?UU5hZW5pNXcxeGd2ZEVvVndwT08zdU5sVkRpTUtBYktMamlPRERyTEJCbEFm?=
 =?utf-8?B?dytaTkxycDdFRlpkVnpOMjhCTzd5N1FuL2tqNDFGVWNOTENjRUJEUkxZelZZ?=
 =?utf-8?B?b2dNaWVvaXc5RHpwTXByNkRBejFKREpYN21MZ25GWi82WmJxL0hCOGV4c1dp?=
 =?utf-8?B?eG1sMldqZzREUThzdFFXZzhtTTl4SFRBcDlNZFpqTTdCYzl6WVUwWW4ybGc0?=
 =?utf-8?B?SEF4V1dxazRoTUNSdGY5Z0pWdE1RNVRIVEFHT2ZBMTNma2lxenBoSzBtVzdK?=
 =?utf-8?B?OUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6bc18f-4af5-4592-b045-08dd5011d952
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:46:14.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mewY7qEGIuHB0Z81FecGKTgIV5Pz1vxOvI5arbMVB00+5rkQzAh+/H2Xx5NLoE/vBZHEF6ycFzxupTo5A1DnVJLKETeph49hpkTslJZcRVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15173

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMTggRmVicnVhcnkgMjAyNSAxMToxNA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDAwLzExXSBBZGQgc3VwcG9ydCBmb3IgUlovRzNFIENBTkZEDQo+IA0KPiBPbiAxOC4wMi4yMDI1
IDEwOjQ5OjUwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBUaGUgQ0FOLUZEIG1vZHVsZSBvbiBSWi9H
M0UgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBvbmUgb24gYm90aCBSLUNhcg0KPiA+IFY0SCBhbmQg
UlovRzJMLCBidXQgZGlmZmVycyBpbiBzb21lIGhhcmR3YXJlIHBhcmFtZXRlcnM6DQo+ID4gICog
Tm8gZXh0ZXJuYWwgY2xvY2ssIGJ1dCBpbnN0ZWFkIGhhcyByYW0gY2xvY2suDQo+ID4gICogU3Vw
cG9ydCB1cCB0byA2IGNoYW5uZWxzLg0KPiA+ICAqIDIwIGludGVycnVwdHMuDQo+IA0KPiBUaGFu
a3MgZm9yIHlvdSBjb250cmlidXRpb24uIENhbiB5b3Ugc3BsaXQgdGhpcyBzZXJpZXMgaW4gZml4
ZXMgYW5kIGVuaGFuY2VtZW50cyBhbmQgcG9zdCB0aGUgZml4ZXMgYXMNCj4gYSBzZXBhcmF0ZSBz
ZXJpZXMuIFBsZWFzZSBhZGQgc3RhYmxlQGsubyBvbiBDYyBpZiBuZWVkZWQuDQoNClN1cmUsIHdp
bGwgc3BsaXQgdGhpcyBzZXJpZXMgaW4gZml4ZXMgYW5kIGVuaGFuY2VtZW50cyBhcyB5b3Ugc3Vn
Z2VzdGVkLg0KDQpDaGVlcnMsDQpCaWp1IA0K

