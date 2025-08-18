Return-Path: <linux-can+bounces-4256-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D4B29E7D
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3BD16E565
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBF30FF1C;
	Mon, 18 Aug 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Dahdsby3"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021112.outbound.protection.outlook.com [52.101.70.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071B28032D;
	Mon, 18 Aug 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510906; cv=fail; b=hMlkM4Ak6CClBeWX2IkVTURknJAW4OCJf+QQO8ezRTe8RUQlffi3Kmh/aDv/RP150B9Yc174sugoxCPq7oaDQD6DZA3PO0vGWZQKH1/6kxjcotL5Rg6IA7Vy3EvNmcOu9DiIq4bGjy5PelOVL59/xRzUtCwfDfMeTvUbH5j4pXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510906; c=relaxed/simple;
	bh=HWnwQKERY1TtF0k50YPI7+Sd1AdBVF8cE3KpQvi0HAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzWUQAicFOKfA8acGe2xt3pGdlmUJiDiZO14JGMu08d+Igunbok6E2eJwOAWxfgkLK/TDi1tUShNlOIafIbDpeomYHdbDCoUa6Chk45Z7cqRLQHM5YkCwNpkDcCXxtEiM2bwy2eg8zy4yFKgtLOnPqvsPKSE3FJeyyiTRUbBses=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Dahdsby3; arc=fail smtp.client-ip=52.101.70.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbbdiShmiqzUJfBuJC7FC83hzP66ViDI5vj0av/zio0YGDhryZB/ZU7MgzqUEeEwXTsVXjNS/6SXM7PF4S7eg9BW32U8QnOTwFvvoLmo3UYtLQZA6lPqNVuWMTfoJoKBtrH0JheHa+Y4karTbUSSlQlT21gWPIud5B676JgorgqQLkdfG/pJyfNRSK4qOgm31RFYSBacnf/X/VhAXAOcPPbEV6zemikGenAelqKk5U4PovrSLjoFjZEu0p2f0SqGP8N80+muaxULLC48J1pmGu5pEN7VUJkW5Q3yjNiDTvXwJnlIN4BjEyvuc/jypypYZLvO4ELAwoxnEnJJNy2qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWnwQKERY1TtF0k50YPI7+Sd1AdBVF8cE3KpQvi0HAA=;
 b=xScPyaFjrKIf1FICar5qduqAr7gbHnXHMgEgpe0Drb0yQTHtIZwUvhfYTzNBBKvqITxRf22VsWFP1fv/m8sJ+VKuJhK9jtsXvG8J9MuxD5Yr0A4ZtEliHgxTEKis8hqe2GjiVfuZD+BKU4VXKWZMIm4lrpi8b2zQyPCGf6ePAVmy/dOf6uDgVu3ZoKoUA+xiQ8dFApzko2rfDPxKk9D+SzLdNtnBjk6c4SxCiyGZLbr+tVnA4O8bHFFb4mW4dCopQVcj3KYwP6I69mAS7jWeWXkuFVu7JMYQ7AzF7jjzsaEhQx128J1pk+HMzVzfoVFq/BV1xFT1+n822g0JZzJLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWnwQKERY1TtF0k50YPI7+Sd1AdBVF8cE3KpQvi0HAA=;
 b=Dahdsby3TqpDukVTHXXnwDvSNI1MF91FdtGIouTFFvM430S/MGwg6gaVg9OmrBpYB9Hmv8Y79slouJfAPotQwbrLBfqJ4ypQAelEj3A9V4s0W4W/VFvtxgzFus0wQ3uRuOa852zn25gSvIN692SWZDmn6etj1kb1wp/1zHV++2E=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by PA1PR03MB11112.eurprd03.prod.outlook.com
 (2603:10a6:102:4f8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Mon, 18 Aug
 2025 09:55:00 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 09:55:00 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 4/6] can: esd_usb: Add watermark handling for TX jobs
Thread-Topic: [PATCH 4/6] can: esd_usb: Add watermark handling for TX jobs
Thread-Index: AQHcCwPGIxV9xPZf+ES03zRY15/CZrRgPkCAgAf4CYA=
Date: Mon, 18 Aug 2025 09:55:00 +0000
Message-ID: <aa9e49d52421ac821062f6cdbccc77e81838dc03.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-5-stefan.maetje@esd.eu>
	 <20250813-chubby-lizard-from-asgard-fb7867-mkl@pengutronix.de>
In-Reply-To: <20250813-chubby-lizard-from-asgard-fb7867-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|PA1PR03MB11112:EE_
x-ms-office365-filtering-correlation-id: 84df45da-2625-4d6c-cc1e-08ddde3d4bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wk51Y1BhN0tSb2tpWVRVL1BoRitEWTBGdzNTT1pUdEg3MEc1Z1ZWSWg1bWQz?=
 =?utf-8?B?YlB4a0NjcXRiN096QXk1VlJqQWJINjBLYm5UVXdxYnBzbXJQRVYwR1JNOUtZ?=
 =?utf-8?B?RFRaWmMzeEhGdW9oWDdWWWExKy9TOXorL1dUR0kzTC9INDVGZUthUDk0Ykxy?=
 =?utf-8?B?NW56Z1B3OXdodWZWajlmeDVVdGo3cWZyZmhHSHJFNXM3dWFEZVlkN2FJVHZZ?=
 =?utf-8?B?a1FUbkQxNkFGdDNsQjB0TmFFK3hiUDhCNVNZZi92UTdhSE5KbnRtUzVaOXg3?=
 =?utf-8?B?c3B4UFhYYjltM1IrS1VpWDJhWTBRdTNUbUFZVmw5OVVjSVdZb1A4aElOMUFO?=
 =?utf-8?B?akFhSjFqSXFGZnlra0YrVlFMZVFKcW5sai85Yi8ySkowM0xKcGJVeWlGZmNa?=
 =?utf-8?B?RW1yUDc3MnFUUDlJZmJPSFI1NktwcXRTQS9UVDdZY0Q3amxpYXdiSTRxZGZs?=
 =?utf-8?B?dzNCb1U0V0NBMVZnUXZCbGVpVmcrNTUvMHhxN0NUQUdHRXhxK1UybWVCOWpi?=
 =?utf-8?B?T0grQU5pZ3RRdmRlaDRYNmFoTFVIWDNWUDNGWEppMlM1R3kxVjg2YWl6dDNX?=
 =?utf-8?B?NWRDRDkyaVY2T0FjMXNaZThIUEZpcnVZaUV5Q3l2anJBUFRXM1ZNNHhlMmdI?=
 =?utf-8?B?TlNQTXBrbzZrZlUvc29mc01UbmJiZHI5RE5lMXh2MFpyQTFkRHh4eXRvRDlZ?=
 =?utf-8?B?bUtJMUl1cHVPYjU1U0VYQWo3OXM2Z2syYjZEenVaTWxSZENvNGM0ODBzcWNs?=
 =?utf-8?B?eDRlK25tZGJlNzArdFcxdWVCWDVwZGtYblR6Zjd1Z1Q2Z1hHNVNLOHJnRWJI?=
 =?utf-8?B?TFZHdW9NdVRGc21xc2psWDBRelRBUUlEU2RpdXZ6RTBVUS9TMXN0SGJOa3Z3?=
 =?utf-8?B?eUdRTkxjVFJZTXJKb1BKTDBSWWxJQS9NMDlpTUxkRDBISXdYQ1l0UHNwRFdt?=
 =?utf-8?B?M3pSK0JGcG0wWldMRDlVWjBKc3d6a2dJbkR0ditSSG1vRXlsdmVLZ2FTWmdC?=
 =?utf-8?B?Y3h3WVdvSWpEbG9zL0VQUTFFdnJhSGY4bzNYK0pCVVJ6V1BLcTZEY0p0a0Rv?=
 =?utf-8?B?dko3NGxhdTN1OGNHWnZ4eWFKaTczV09kL3luMmk0QVc3ZU8vRjg5VHZkQ2hE?=
 =?utf-8?B?TmNVUnpORFJSSU1vYml5MUFRVThGWFM4OUdEMEVHOTAzQWYrTW5BR25IMmJF?=
 =?utf-8?B?azFHUC9HbUZ5ZDNNZ3lQVyt5ajFxeHRERHFLUjQ0dEJveGlhSmh0QWpYckln?=
 =?utf-8?B?eGkrNEpsM2w2eG1GY1FZUk04R0N4MksyUExOM0QreEpoSW9LTk1zZUdLWHBZ?=
 =?utf-8?B?VmhMaytTV3NuaXJSMnJ5SEFHd0U2RUYweHZsUExLd3NFWlBQMUR0QzJVdjhX?=
 =?utf-8?B?WTZzaC9wdExNeXErVmdFMVNnOUNJbm1YQWtFTzR2ZzlNZjd3MUc0UDMrSXpF?=
 =?utf-8?B?aVVrc1hpKytpMjdIRDVsTGZmQnVVejlyRDEwS3g2bjhaV0NhNXR0WkhCclFN?=
 =?utf-8?B?RmZVV0tWandnYXlYcHl4OHJYTmkveDdsWkk2aExldkdEZi9mZFBLeFRWNXVP?=
 =?utf-8?B?RmhrSm14cnZ6UXFDUkdheFhiMmV4S2Q5bm1Uc2hzWWhtYTdtRkE3M1hWV1gx?=
 =?utf-8?B?VFpZMDRBS1lRRWgvT0NoOSsrWUxJbnNoWjEvNFlHc29rbWFMdlBtZ1A5MnhJ?=
 =?utf-8?B?NWxWRDNDSFArbVdnMTY0em9rTUhpOUpCalNsVVFQdDBsT0VHa1Ayb3hCWGhj?=
 =?utf-8?B?YmFIajhuWmRJQ3JrR3cvUWo4Q0ZaaVMxa0RnWVJPRlg5Q3ZhdlFyRFRhRTdx?=
 =?utf-8?B?ZmhFdFJVN0tDQlBZVkpaSUpiNk1mVWtsOFA1Y2lCQkt2bFpPWUhVMDV1KzFB?=
 =?utf-8?B?a0djaDBnMjhHRHhoaGFidk9QN0NJVno1QmJYcHNWSXJWaDJ4cjd1Tm1pY0dL?=
 =?utf-8?B?THFqcDFCSHpWZGRXNUlGOXcvd1JBZyt5eG5WNThJVGZVS2R0RTM1TW9OTUN5?=
 =?utf-8?B?Q0REYWRrYlp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnhhRWFRYnV5L0FvM3VPaTdHa09vTHp6R3VHalo3VkJrbmhBWEZuWUFDRGpK?=
 =?utf-8?B?aDQ3RXgrdzRjZ2gvS2pOcHNRRnlKZ21pb3pEdy9QS0hTUFJTWEpFOFVMMUxP?=
 =?utf-8?B?NzJ5NE1uR0oxcUphYUxMd1R1TDRnMFlTbWxZNm9NaTFZaGhBV3lsSW5CM3hY?=
 =?utf-8?B?L3ZTQzl4eUlldG5INnBKWjVFeWMrQ2lEM3o4VWs4a01FdU9LbVVJSlk2VXJn?=
 =?utf-8?B?TlFUWFk2eHFOUmdtTDlHVmI4UkVQZ2xuUzBZU0t4dSs0RE5WMm1BQVFKTWhG?=
 =?utf-8?B?MzFlS3ZFNXBodjA1YTJ6T2RxQlJ2UllJUGRmeUxEcmFaVUt1bk5RL3lLZmtC?=
 =?utf-8?B?VEtJNEZTQ3RMTHlDV01lQzNsWUdkRFh2K0wzQWxWTGdaTVBEMzB1MHd1UVNW?=
 =?utf-8?B?eEIzWTloZlZpMmNmQnQvbGI4dFRzQUNpNllJbVU3Tks3RWpva0VrY0VFaVBZ?=
 =?utf-8?B?SVI3UEZyUHY3aHBlRm9pQ2NuUWVUdEZKWmx5VE02bFhyYVpwUTg2WDQ2TTk0?=
 =?utf-8?B?UzROZjhaRjR6bXhQaTFSQnZlZWNER09aeXVQVXFMbmpzalkyNnViRXduTG5D?=
 =?utf-8?B?WXRud3lnVjMvcndkQ29yN3lDQjYzck1zMnlIeE8vazU2eEVGUG9xZ0MvSjFB?=
 =?utf-8?B?ODRNUmtMaVcxK1FlUjFPYWZ0dktrTWlpTmRQdDhsdjBEcU5EWmpWQm5EbDdl?=
 =?utf-8?B?a1Fxb2ZkRWJmZWxRcHc4djg3S2ZLb0FMMGw4NDA3NlFyekgxOUNzOVNxS2Fy?=
 =?utf-8?B?aythOTNjR0VhSGVhRnlkOXd2ZE1ZUFc3SzdFVG5wbnVCcGRCTGNIK01RbGtG?=
 =?utf-8?B?ZlZVQnVaVjU2bHR0WDBmblh3aHpQUTYvd3paSm5xTEtwSWttTHdINjA2Y0ZG?=
 =?utf-8?B?KzRScENyMmx3YUZDYmhsdFVISC9RNUlFcis5eXF2RGpGQm1zSWZNb1B0YWdV?=
 =?utf-8?B?c21lR3VTdWlMSFBrZm9EV2ZvU1hQUmV5V0dTRXZIU3A2dE85dkNRQ3RxNzFS?=
 =?utf-8?B?ZmcwRWpXUE5WKzN6STRnTHBmNzJUSGpYRlh4WUJRQ1YzSUs1dVhqUjdxNUMx?=
 =?utf-8?B?YmZpMVJhMVhpRFNwZWxSc3FrTVNaZVkwOTZtelFVVzRwcGZTVjZXUjlHamhG?=
 =?utf-8?B?WGRveHhncnpwNTN0d05LdFlSVXIvUlRCRUZHcDdhb3JRVE1iT2E3OXlTS0Uv?=
 =?utf-8?B?QkVuNENFRXMxdlJwamwzMFlGNmNUaC9xQzBVbDB0UUVzRys5NU1MbzI5aHpM?=
 =?utf-8?B?cFh5ckREWmE0Z0R6M0VVcmJJSm9mZXVZNEhnOHFGNzZlWENMS2RkZEMycEhI?=
 =?utf-8?B?WCtsVTBMYjY5K2pQM2liSlQva1A0ZlAwZVNid0FzTHRBeTZNSTBTcGZQRVhw?=
 =?utf-8?B?OUprdUxxNEpzdzdwVkdkNmJLWVdOZXpNQlBIN1A5d3VZM3p0K1gzMVYxeDJk?=
 =?utf-8?B?NHoyUUp0RitlbUhtNnZBN0VYUWxMd3V3b1JwWFpuZmpIS0xGMjQrUmRQK0Np?=
 =?utf-8?B?UXhRK010UGFtTUMvb253Wml1YkJKTWlIaDFsdEZ4WjNTcEtseDk1SzhKdTY2?=
 =?utf-8?B?c1BFNDIwelZ6QzNUNzJEWkFkb3ZyZHcrQ0VneW1CazFFdDdqZ0lYcS93WDlP?=
 =?utf-8?B?NTYxbmIySXlSQkVFVURWT2hTRUZqamp1WjE1WmN3eGNZMUtxV09CU0dpYVlm?=
 =?utf-8?B?Vk5PWEhNWFJlRVArcnJHZTJsck96aTd1Y1c2bVhjWDlBck1Wdkx2QlYxWVlN?=
 =?utf-8?B?YkZFRC9aS0tQdDgxVDB5RGJMSlVGRXlhL2xzSFRtNXQ3S3Q5UTdRazZjeVhM?=
 =?utf-8?B?S3Mxd0hpQ0IzdWxEZXl0eC9xa3VtNDUvUTZkQzRFczhJUlJPeWpkNm41MWJr?=
 =?utf-8?B?M3lqdHFmbStrNzhNck1adG1mM0ZKWC9qWXJXMi8yeEFSaUxXWlAvWHQwUk11?=
 =?utf-8?B?OEZ4T204SDZEdzdKSStRNCtzSmcwdks3N1o1Ymlicjg1MXhoV3pUTk01RDZI?=
 =?utf-8?B?OEJJU0tNNnRVUHlLcGJaWHhueGw5OVE2NkUwbGZIeUhkV1ZJajQrdHlJVGhF?=
 =?utf-8?B?M2hUN29haXFuZXpnRkc0WjhkSDRDbjFYSGRsZ0dqdXlKOGxlL3h2MnpKbThQ?=
 =?utf-8?B?WUtNWkk5WEFhVmxxbVZab05Yd3dRNmFvcTd5MmMwQmdYZFovMWFGVW5EMXZF?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EE13768E5D4124CBA10C48CAC2AB83C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10517.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df45da-2625-4d6c-cc1e-08ddde3d4bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 09:55:00.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Woxi5kerdSUTiomWhVii6U7WakkWsVZh802QdXCTo/dwlW0NOWT3kLFo9HmYbpwY6Rt2sEmCzJHhK1cXnBAc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR03MB11112

QW0gTWl0dHdvY2gsIGRlbSAxMy4wOC4yMDI1IHVtIDEwOjEzICswMjAwIHNjaHJpZWIgTWFyYyBL
bGVpbmUtQnVkZGU6DQo+IE9uIDExLjA4LjIwMjUgMjM6MDY6MDksIFN0ZWZhbiBNw6R0amUgd3Jv
dGU6DQo+ID4gVGhlIGRyaXZlciB0cmllZCB0byBrZWVwIGFzIG11Y2ggQ0FOIGZyYW1lcyBhcyBw
b3NzaWJsZSBzdWJtaXR0ZWQgdG8gdGhlDQo+ID4gVVNCIGRldmljZSAoRVNEX1VTQl9NQVhfVFhf
VVJCUykuIFRoaXMgaGFzIGxlZCB0byBvY2Nhc2lvbmFsICJObyBmcmVlDQo+ID4gY29udGV4dCIg
ZXJyb3IgbWVzc2FnZXMgaW4gaGlnaCBsb2FkIHNpdHVhdGlvbnMgbGlrZSB3aXRoDQo+ID4gImNh
bmdlbiAtZyAwIC1wIDEwIGNhblgiLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggbm93IGNhbGxzIG5l
dGlmX3N0b3BfcXVldWUoKSBhbHJlYWR5IGlmIHRoZSBudW1iZXIgb2YgYWN0aXZlDQo+ID4gam9i
cyByZWFjaGVzIEVTRF9VU0JfVFhfVVJCU19ISV9XTSB3aGljaCBpcyA8IEVTRF9VU0JfTUFYX1RY
X1VSQlMuDQo+ID4gVGhlIG5ldGlmX3N0YXJ0X3F1ZXVlKCkgaXMgY2FsbGVkIGluIGVzZF91c2Jf
dHhfZG9uZV9tc2coKSBvbmx5IGlmDQo+ID4gdGhlIG51bWJlciBvZiBhY3RpdmUgam9icyBpcyA8
PSBFU0RfVVNCX1RYX1VSQlNfTE9fV00uDQo+ID4gDQo+ID4gVGhpcyBjaGFuZ2UgZWxpbWluYXRl
cyB0aGUgb2NjYXNpb25hbCBlcnJvciBtZXNzYWdlcyBhbmQgc2lnbmlmaWNhbnRseQ0KPiA+IHJl
ZHVjZXMgdGhlIG51bWJlciBvZiBjYWxscyB0byBuZXRpZl9zdGFydF9xdWV1ZSgpIGFuZA0KPiA+
IG5ldGlmX3N0b3BfcXVldWUoKS4NCj4gPiANCj4gPiBUaGUgd2F0ZXJtYXJrIGxpbWl0cyBoYXZl
IGJlZW4gY2hvc2VuIHdpdGggdGhlIENBTi1VU0IvTWljcm8gaW4gbWluZCB0bw0KPiA+IG5vdCB0
byBjb21wcm9taXNlIGl0cyBUWCB0aHJvdWdocHV0LiBUaGlzIGRldmljZSBpcyBydW5uaW5nIG9u
IFVTQiAxLjENCj4gPiBvbmx5IHdpdGggaXRzIDFtcyBVU0IgcG9sbGluZyBjeWNsZSB3aGVyZSBh
IEVTRF9VU0JfVFhfVVJCU19MT19XTQ0KPiA+IHZhbHVlIGJlbG93IDkgZGVjcmVhc2VzIHRoZSBU
WCB0aHJvdWdocHV0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBNw6R0amUgPHN0
ZWZhbi5tYWV0amVAZXNkLmV1Pg0KPiANCj4gUGxlYXNlIGFkZCBhIEZpeGVzIHRhZy4NCg0KSSBk
aWQgbm90IGFkZCBhIGZpeGVzIHRhZyBiZWNhdXNlIEkgaGFkIHRoZSBpbXByZXNzaW9uIHRoYXQg
dGhlIGNvZGUgd2FzIHdvcmtpbmcNCmZpbmUgd2l0aCBvbGRlciBrZXJuZWxzIGFuZCB0aGUgb2Nj
YXNpb25hbCBtZXNzYWdlcyBiZWdhbiBzaG93aW5nIHVwIG9ubHkgd2l0aA0KbmV3ZXIga2VybmVs
cyBhZnRlciB+IDYuMTEuIFNvIEkgd2FzIG5vdCBhYmxlIHRvIHBpbnBvaW50IHRoZSBlcnJvciB0
byB0aGUgcGF0Y2ggDQp0aGF0IGV4cG9zZWQgdGhlIHByb2JsZW0uIA0KDQpCdXQgSSByZXRlc3Rl
ZCB0aGUgc3R1ZmYgbm93IHdpdGggb2xkZXIga2VybmVscy4gU29tZXdoZXJlIGJldHdlZW4gNS40
IGFuZCB0aGUgNS4xNQ0KdGhlIHByb2JsZW0gc3RhcnRzLiBCdXQgb24gb2xkZXIga2VybmVscyBp
dCBjYW4gb25seSBiZSBleHBvc2VkIHRyYW5zbWl0dGluZyB6ZXJvDQpieXRlIGZyYW1lcyB3aXRo
ICJjYW5nZW4gLUkgaSAtZyAwIC1wIDEwIC1MIDAgY2FuWCIgYW5kIGFkZGl0aW9uYWxseSBsb2Fk
IHRoZSBzeXN0ZW0NCndpdGggb3RoZXIgaGVhdnkgdGFza3MuDQoNClRoZSBjb2RlIHdhcyB1bmNo
YW5nZWQgc2luY2UgdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24uIEkgd2lsbCB0aGVuIGFkZCBh
IGZpeGVzIA0KdGFnIHRoYXQgZGVub3RlcyB0aGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbi4gVGhh
dCB3b3VsZCBiZToNCg0KRml4ZXM6IDk2ZDhlOTAzODJkYyAoImNhbjogQWRkIGRyaXZlciBmb3Ig
ZXNkIENBTi1VU0IvMiBkZXZpY2UiKQ0KDQo=

