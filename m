Return-Path: <linux-can+bounces-2713-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE59A24D8E
	for <lists+linux-can@lfdr.de>; Sun,  2 Feb 2025 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3710163C75
	for <lists+linux-can@lfdr.de>; Sun,  2 Feb 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6111D6199;
	Sun,  2 Feb 2025 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Mic2uO35"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010008.outbound.protection.outlook.com [52.101.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143681D54D1;
	Sun,  2 Feb 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491665; cv=fail; b=Z7majNV/PsRucD1v/MqISIe2KxDRJBJ3I6q1DRzDYnvmGXuqSsnMybHJNAY5Ve3v6agSmgRxoq0SwTe89tEWF4E7NLVr51DvppiI4GFOlgAnZBq4FqEP7UyaMB/k4mr/MTaCRU8aV5dlfL2QmvTw5EaRkrb+pXk5gqsgRy0/8Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491665; c=relaxed/simple;
	bh=rdR7C13pZTFajPyf1XMRq/IYJoMFSzxAyvt/eoYK0Kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NV5a/1h2zATOk4OKewLjAnr1TahJaJVIC6NRlxR+ECprCjUClZo7fsiYG+lIHqIceJfP7zKGChkVmWK6bx0OBJxEIRag/ftch7+/2/C6cG6DnZvzLfOmy3VE0o3Su0EJ5kL53rtIIwJa+sHxWx3OS8WQzRwDYunJQwKc2pGJRFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Mic2uO35; arc=fail smtp.client-ip=52.101.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9mfdLK+iCMuH6M2J4jTVSsf2sZNoxcQzx5CI2VR/ZOZM7M+KLAMPfP6HnQvJSjgD98vPs8mO8lGHlUW1KcF3aE/BqitE2foGOlVZrfLYLnjFKo8tePlFt/F5vy2T/shrRqPnOS2eq/MVmvOI98i47deEcWIu9NwYfA9d5d35Vt32ESmJK1CVQI7VMfPEjyrifVySWp/IVgqVnL0AH1AZP9205rq9MNrmWNqG9Q5DdXQVBo661vnAdfPFmoW54glCxClazgj10mzpf3uFJpQZNsLM8r0LliSdhTIC+GPpfY1/enUtXs7HGpbbCTr+j3mI3X975GvdIAVmoj1BQ58Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdR7C13pZTFajPyf1XMRq/IYJoMFSzxAyvt/eoYK0Kc=;
 b=uJ8gchqSpdxdjPNXLPlc4+3p8ve2kdHZgyJuQlBhK2+m9/X9cDqbvr5tF/G9hO3YGkYvneNTbJ5iXlTNmX6ZXiw7AnEhs8VhC/jG1vk2Dr+AwGD19e6LhTyBLw/Fh0B5gVB81i9kyg8zh2XxD0aFdiDctk9t/vlsSZqjHK1yKykzH19fhSMTWxnzEp302lgMCke9fw7KiwaMP65LjJ8teJv1mPVa+2E6BdLAEIjObRqtSThdjWAUJ0nOivmPaCI0UYyefF1IgeOGdLYMxYeeXSOVcavutjFi1rx65IDrnFuOY+7LI9pX7Bu1E9xsDVFJIBSNUQRmlmm977xKzVBLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdR7C13pZTFajPyf1XMRq/IYJoMFSzxAyvt/eoYK0Kc=;
 b=Mic2uO35x05YY6mxfRJ7mM5QCdHfAo+vhYa/NDko70FjYxj80lecjFQJ8niiD+BjpvTEgkLZ6AAyXdjSpwrw8xMvu742A/P1guV0sz5xshyXD6HWYxhbkgSMAHtxiQpLSNqtgfiJGyW3jNSzMd8oc7Vup7WSCY8FNmT3GzZGFeI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9540.jpnprd01.prod.outlook.com (2603:1096:400:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 10:21:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 10:21:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Sergey Shtylyov
	<s.shtylyov@omp.ru>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH] can: rcar_canfd: Use of_get_available_child_by_name()
Thread-Topic: [PATCH] can: rcar_canfd: Use of_get_available_child_by_name()
Thread-Index: AQHbdI49r2Z1rHD+vkuCmng/9xof2bMyy9aAgADnZQCAABtH0A==
Date: Sun, 2 Feb 2025 10:21:00 +0000
Message-ID:
 <TY3PR01MB11346A59E7C522333EC66CF2286EA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201094642.16243-1-biju.das.jz@bp.renesas.com>
 <2cdfed6a-4461-4c57-96b8-a6c928f2f0ac@omp.ru>
 <78a3517d-7d9d-4f1c-b9bc-bc78d61fb810@wanadoo.fr>
In-Reply-To: <78a3517d-7d9d-4f1c-b9bc-bc78d61fb810@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9540:EE_
x-ms-office365-filtering-correlation-id: 4d61bb58-a047-4e40-ecc5-08dd43734a60
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ri9LOTJuN0ttVjRzczc3QnhJS1Vuc1FNVmc5M015VC93SVZoS3kvNVVLbjdp?=
 =?utf-8?B?RW5SY2Z6UktzV3hBSlJGU09xcXgxNWhseGw3ditmNmhyUnZGaWFWdy9MTEdV?=
 =?utf-8?B?ekx5SThPcWJYcjV1bFQ3L29zc3JFb1FNNzUwMmRYb2NjMDVQU1dpcFVrYjN3?=
 =?utf-8?B?Qzl0TVJaWVNiMzJqRHVDQWdHOHZVVVIwTUc0bXRBMEI5VjFuN2N5NS83K1Bq?=
 =?utf-8?B?bUwwbFVyemY2T1JXamloVlp3blUxNFdRU0dHZUg0Nnd3UEh6SmVUVVh6b2l6?=
 =?utf-8?B?UGVrWFVXOS9xd0xCTDdMdUJ2cThQOXRCMEJwblpTRmdEY3lSb2ZmMUJIT1pu?=
 =?utf-8?B?dFg2ZWF4TXBSRGVsRENPQWFxdURHZDNXakJNN0xVaHM0eXkrdmFoSTR6VjlU?=
 =?utf-8?B?VEZYUDJiT2ZPa1Rld2o5QVh0Z0wyemU1clplOUFNaG5TQTFKR0QwK0l6SzNP?=
 =?utf-8?B?TURJSlRraU81OUdORXBiaEEzNk9hbW5yS1RzT2lLVkFNU3gySE9rVUh3ME9w?=
 =?utf-8?B?N1ZhMDZlalExWW1oK0tuTlBmdGpiZlM2YTdXcjFaR3padGErTm5zRG1nQURY?=
 =?utf-8?B?UmNQVFo2WjFQV3NxTWkzWlhkZk5VNFRrN0ZFVzE0cXlzRW5OWFk0RWZ3bzJM?=
 =?utf-8?B?dzQyV2NRTUFRVzg5bkQxaFVoVEE4QnMxN0wweHpLcGNwT3o1V0hKbnpYRGVt?=
 =?utf-8?B?dDRENjBrZXRVa3B5UTltdThJYUVPamdZQ3BMalRyRTdMWENQM29rRUFvTGN0?=
 =?utf-8?B?NlR0WjNFVk03ZjN0MFVVSmptODlXSEp0akp4c1VBMVoveU1zZmttcjNZNEEv?=
 =?utf-8?B?cUZocit6VGpzVnlORC9qVTdaUnNVM2JZTU1ZTDcvVzlFODZndXc1M0tNOEFW?=
 =?utf-8?B?UDBqUXBCVStTU0JRMFMrS1lSNUNnc0djeFl5ODRqRlFKZFdhQ1RKM0haeHBN?=
 =?utf-8?B?dHJodmxKZitwSzRHdjRIUitwT3FpbWRqUkJYM3RMcDdsM0o0bEZpWVh0ZjRF?=
 =?utf-8?B?bk1KUmxRckdrVnFhL0JFSFY4Qlp5bWJrMWVNQjJ0MkEyYzE1TWh4WThHQ0RJ?=
 =?utf-8?B?M2NqTG0yTVBFU2dnTXBNRGlubkFQbkNmYld4RzNWM2h6QnMxQlFQd3pkNXR1?=
 =?utf-8?B?dTBPUDFDODRhOEFJb0VKT3NiRWY5ZWgwYldaM1pTNUx1SnUzem0xbkpyU1k3?=
 =?utf-8?B?bE1Cc1pQNVM2dDNEeGZpeit3UEwxR0N1RDZVS0c4eElxOXdBOGpXNEVhLytQ?=
 =?utf-8?B?UVg3ZkYyc29CNkFlV1NkeWtDTEVtTDNaU3RLbk5sNndWSzBlMXkrakcyWG04?=
 =?utf-8?B?RHFuWUh5N0JiOTVCWmtKcGxVU1kzaEVhby9YMno4KzRpMlZ6c1Y4aGFaYU5n?=
 =?utf-8?B?Umd6ZHltVVRtNE5jOWk3c3dwWk45YnBzUHNrL1UyZE9xWkpnVGhxUzMvYTFD?=
 =?utf-8?B?L3RMRzRlRUR4Q2NRQ21oU0ZtdXM2bFVkTzBvUDlXUFk0ZTlsQ3B6UUloSlNk?=
 =?utf-8?B?c3crVEhkeTQyRHBMdnEwL1lEa0JXYm4vVU1kWTB6VXZ3eVBoUWwzbnVqTkJs?=
 =?utf-8?B?Z3dKcUw4am9UYVAvT0tmV2hRWFd2SWJrckNQdWdLRkN4dFlUVExua0paMDhW?=
 =?utf-8?B?YXdVMkRES1Z4VFllRk1VZTFjSUNwLzM4eHpYaUhjc1hhQXdzakVrRFFFY2RZ?=
 =?utf-8?B?RjZnL3hwVzlMU0gvZnEvRGxoc2syckNKME5vVytNSktaUk5qcEhDOGJHSTB6?=
 =?utf-8?B?ZXo1QnYwT21qckQ3QmZwclZvOGloc0t6K2hwMEN0Q3BDSUxudkI0L1B6YnZW?=
 =?utf-8?B?bFcva3h6cjJCYkE2RkhNK0tWWWY3KzEyTXcvMTJnTktITHlQdmo4V25LYURx?=
 =?utf-8?B?cnZyWlNXam9wd2JxRDZ2VDU3T1dyZjhTaWwvNmR5RCt0WFN2TG8wNUU2NFNJ?=
 =?utf-8?Q?i4uEbFsd2jAdvC75Yio7VLY3LLxxz3TU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzI5b3lYQUZwQlRkR2N2dkdQMmNWQmJDalVpdloxc0VueVUwSmRmM3lLMzI1?=
 =?utf-8?B?cFRzYTdnNWg1OG9zdlBSZTQ3RlVkbFUza3hkL29nY0hEbThUUjYzREFuSHc2?=
 =?utf-8?B?STJ6Z01QZnltaTdpd3ZVUm9SRVU2a0FlUkpsb1VJejhUR1FWZ2lKVUhZTVpW?=
 =?utf-8?B?dzZ4a04rcWdxcUppeXg4eG1Jc2wxN3Q4ZmxmOWZ1b1o3TndFb05hUzNsOFpW?=
 =?utf-8?B?NE9tNEdEYndkOXRBeTVpVG4vSy9OSmIweWV2Mm9TZ0hUQXVrTU41S0J5ZXlG?=
 =?utf-8?B?aDU4UU81b1REd0FWWHVWR0JkdzlyZ3YyWkl4UUdFM0R3QzBNUVNZQ256WEtK?=
 =?utf-8?B?QXUyUjQxNVpueGM2WHBzUDE3Z1JMVlpPNVRnd1R6TlZjUU5NcjFCVWlkR2tF?=
 =?utf-8?B?Ylg5Tnhmb3A3M3Q3Zm1PZVNIVVJlVHhxeXF4WEduWFR2dWdYcmhqK3pPVVlS?=
 =?utf-8?B?T1Z4bmZ2QTNvWFFDUzNxTVMrQlFuMWprMU1HK05lbzUzRS9vUG5Na3Nucjdt?=
 =?utf-8?B?TUVLSzlNMFl5TSticnlvTXk4bzJrb0NMRjIzeDBxTW5NSzRpNEczbTMrd212?=
 =?utf-8?B?OGczbjI0Z0hsOE12K3kyU1NnYU90ODIyeC9Rd3QwOUZmMnNKNVZZMERNb1NP?=
 =?utf-8?B?RW9sV2JpbzlBRWRDUTFhbFg0aFNVK3ZmS3pXOGl1SlZWaWNCSGRIZzRWbjQ2?=
 =?utf-8?B?ZDZ3OE13bUUxVXFLd1NJKzJlSGsvY2pld3lSTlpPSTBMQm83T2tyKzdNY1Y5?=
 =?utf-8?B?bHhPcG1UdDF4WW1yUEVBRWlWNXNCZ3RwbldsVG1iL3BobW5oejYySWNOalB1?=
 =?utf-8?B?Q0Z0czlFanJ4T3h1NXNndDQvU09sN3AyWS8wRzhYbWw1bENldGJYdFQ1TEM4?=
 =?utf-8?B?cmdjbEhNTnBWMkZ0b3pub1R0M2NnTGxEYXFibDF6VTlqQXlPc1BIU1ptR1FO?=
 =?utf-8?B?bFRFZDhVL09FWWFpQlZSd3Y3ZkRha0NnZ3Fyeko0YzVZWm01RVhlVFpTQUZi?=
 =?utf-8?B?dWs4bmJWcnFiVEVYblZzb2QrTFdJOTM3V1l2MWFtdERLRFlvajZoSHhqcG0z?=
 =?utf-8?B?aElMWS9FdEhzL3JLSkxBQzZrd3M1VFVmWEdqZmVFNjA2ZWl6M0JlbDVvZTM2?=
 =?utf-8?B?UGRYazJRS0Y2RjI0L3NnYjg0ZWgyRGNOSDh0VlozU2xLOUNBYzFDZHZpaU1w?=
 =?utf-8?B?TGR1RElnMms4VDRxUGtsbnZ4REYyNi9HNnBLNEdnTTlPVWVRYlkyRGxqNUtx?=
 =?utf-8?B?TytESnB0UUs4RFlYR3lNTmFpRG9uUDlPdGFaQ050VjJtOE85dHlYTUZ2VDNx?=
 =?utf-8?B?VjJzbFZPeWlMWHF0cVdaODE4dFQrWFA5MEpBZXRESndacXQ3TjhVZ1N5ZTF5?=
 =?utf-8?B?UEJlTTBXUWVwdVlKdDBnVDJGbzZQaHByQ09IQTFYVnE1ZkJoSkNnOVlVWVNQ?=
 =?utf-8?B?SnB5K0w1TVRlKzFTWFVUM0M4czVoaGJNL2VxSU1uS0JuekJNVU5xUkxuK3NL?=
 =?utf-8?B?UmtxTExJV3lNNkVoWEkwblN0WW1KNjdkbTBjbEpNeElVMmZ5Mmw5c1JsOTFX?=
 =?utf-8?B?MnZ5UW9NeWd1WnhVZVdtVVk0Tm1mM3BQc1AyY2YveFE5MjQyMlM0ZThxalZO?=
 =?utf-8?B?akFTdnZOYldZc0NZaHZsWkZKTUZQTWZ4NEY0N0lSaU4vdzY5bll6dGxMR2Zv?=
 =?utf-8?B?Z0RNWFlDaHczWllPTGZFalFJNFU3dGhFQXJiMVN3VFFNYzdPNmlldVpUREVu?=
 =?utf-8?B?cUY3NlEvaE81dHZLUDdDVEc5OU9TK3FONG9sOUJJU210T1lSZTNXeFZkam8z?=
 =?utf-8?B?ZXJONHpNSzFteVduRTlTQnRJMC9TNVRFQzMwZC9PbitiRU12VGl3VjVrUFdG?=
 =?utf-8?B?SkIxTXlxVVZxR0g3cEY0RUZJRXhEb1FuNVVuM05uZU9kVzcwMmQ1bTN3M3BK?=
 =?utf-8?B?M3NBYzhwMVJRQnQyZkdmcW9UYW1IWDFlMnF3Qk9KNWU1TCtHbndUQ1BlNW5o?=
 =?utf-8?B?a2ZQSmRqRy9PNUxEWkh0REZuajV0WHFuK1hRdU9IM2pCRm5OR1V6b0VVT29T?=
 =?utf-8?B?RFcycmtjMEVmbmZTV2hjaittdEszejVGTng3V0RvbUV6ZlhlVElHQnJjV05W?=
 =?utf-8?B?aEplTmI5d2ZYZ25EYW41NzNpdmlZaEhXQTFDaHlhbUpLeDVzSHhSZ1FwYk5B?=
 =?utf-8?B?Q1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61bb58-a047-4e40-ecc5-08dd43734a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 10:21:00.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4RIzX3ZL9m7lG2UD5mP4g8704c5z55fLYNw7O3I5MUdmXH1PU3p7dG72JRa5GnSratZ7QMqZ117Um9xyr5P4+uecUND94jJYm9iF4wxR4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9540

DQpIaSBWaW5jZW50IGFuZCBTZXJnZXksDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFp
bGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IFNlbnQ6IDAyIEZlYnJ1YXJ5IDIwMjUgMDg6NDEN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FuOiByY2FyX2NhbmZkOiBVc2Ugb2ZfZ2V0X2F2YWls
YWJsZV9jaGlsZF9ieV9uYW1lKCkNCj4gDQo+IE9uIDAyLzAyLzIwMjUgYXQgMDM6NTIsIFNlcmdl
eSBTaHR5bHlvdiB3cm90ZToNCj4gPiBPbiAyLzEvMjUgMTI6NDYgUE0sIEJpanUgRGFzIHdyb3Rl
Og0KPiA+DQo+ID4+IFNpbXBsaWZ5IHJjYXJfY2FuZmRfcHJvYmUoKSB1c2luZyBvZl9nZXRfYXZh
aWxhYmxlX2NoaWxkX2J5X25hbWUoKS4NCj4gPj4NCj4gPj4gU2ltcGxpZnkgcmNhcl9jYW5mZF9w
cm9iZSgpIHVzaW5nIG9mX2dldF9hdmFpbGFibGVfY2hpbGRfYnlfbmFtZSgpLg0KPiA+DQo+ID4g
ICAgVHdpY2U/IDotKQ0KPiANCj4gKzENCg0KT29wcy4NCg0KPiANCj4gPj4gV2hpbGUgYXQgaXQs
IG1vdmUgb2Zfbm9kZV9wdXQoY2hpbGQpIGluc2lkZSB0aGUgaWYgYmxvY2sgdG8gYXZvaWQNCj4g
Pj4gYWRkaXRpb25hbCBjaGVjayBpZiBvZl9jaGlsZCBpcyBOVUxMLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gWy4u
Ll0NCj4gDQo+IFBsZWFzZSByZW1vdmUgdGhlIHJlcGV0aXRpb24uIEFzaWRlIGZyb20gdGhhdCwg
dGhlIHBhdGNoIGlzIGdvb2QuDQoNCk9LLCBXaWxsIGZpeCBhbmQgc2VuZCB0aGUgbmV4dCB2ZXJz
aW9uLCB3aGVuIGRlcGVuZGVuY3kgcGF0Y2ggaGl0cyBvbg0KbmV0LW5leHQuDQoNCkNoZWVycywN
CkJpanUNCg==

