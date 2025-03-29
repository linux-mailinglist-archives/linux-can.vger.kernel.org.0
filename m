Return-Path: <linux-can+bounces-3292-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BCEA75647
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B275716E8D4
	for <lists+linux-can@lfdr.de>; Sat, 29 Mar 2025 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AE1BD50C;
	Sat, 29 Mar 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ADj6F3Ya"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D701B4244;
	Sat, 29 Mar 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743252732; cv=fail; b=OnwrdGXLt6Hl19jb43fUNF5VsMXv0yG7LCEcOWpprd1DcYmiE56SJqEpNF2DOU3sV0cRg00wqqDG2+xvcPdJj5/gbtU4gDPdn/HBo84Ix+XiwPBKZOKTGv53VaJdtjLaoQYQCGFtEdLLqEzROO8gyV+c1rUxWhatQL7JzvlF6aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743252732; c=relaxed/simple;
	bh=61JZpnh68HEqnWnyrezk9qXr2t5kzQKFzbNSEALyRrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBZJOnJyUrqPZedbikcYf4wFIPDL+rMENCvnRpoMf127Rf+l/jjmyjlLkwtRYx6gcxpIBj7lmPaiDlCjZsufvMp93ZLKHGBEZ+i6N1U5/yf+LYLDEo10BGE8Ye7+nmH7hqhqFNKD4wACsnEw9u33UqKfPuN9cQeO6LBDlpVv+iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ADj6F3Ya; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8a1/GzeH/aC7BcREQ0yhPtwcGRSKDGUBTEFVidyQAOeEwZ+LEyV40gQFOnSiABlPNGoHFUkjCt3I2RkUOlMbPt4pplHeePNJoq4oOjuKg+yNgdrhJPaKKP73cEI0MrfzJthhQ8RB82+nHUgDDvZRp39m3OApjicoG4ORHPe2P6LT+7OyeccSGsZSovF8GE32pMoORW1ofS/Pbg5vC8a0WLEkWuq7VU2RKC5alWf2KNDPz1Cqr8hcaoNrtGpVde192Joqmmj4dTNEBH6vyNPfrpZb3TvjE+MZAVXw0wga4aAnNrSmALm9e2yGU0xYlrPFfEusXf2Y/tp+Hrc+n71SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61JZpnh68HEqnWnyrezk9qXr2t5kzQKFzbNSEALyRrY=;
 b=LZ5lWLsPCYPwYpms6z/7jmGRF153/bg/I4D7Fj59Bw91usuObpUQBDCFp+q8mQQTkdS5wwNbuIR/gPxpUh5lkmnGOgXvO8BPLdiPvpWpr8Qxt+/kG2hFC/LctWtvROPmwjNEU6BrYgaXYnblEZr/cRfki8AyFWSnrKST2FICYJKUFlHhtc8wlj9B1MaoiweNGqqXxsJxPR2l9OMaypaSDpsaYgn9IfWfN8z+B9LdSR1/GNEfx02ZEfiQGTOKmET4CuxUvHju6rswkSYhAo/R0pvaP8XFiBrn6f2293JUmJwNg2qxgb3lCskUSRsY5de3PpgY590Bianqu6CTzc6cZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61JZpnh68HEqnWnyrezk9qXr2t5kzQKFzbNSEALyRrY=;
 b=ADj6F3YaNoaGAju07LtX/1vDRyf1DglX0n/+69OFDBfti2r94wG3GsivUynt6SXpZtQWCrvTgueF2QOuloGJpS/Sb6sDVAwePtkvvhIN3F1dAG0ZI4xpPP4W25xSu64jgtkEsNDWwMgydLpGziK1mNnveDJkjwL8APbfAfYD3Ck=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11281.jpnprd01.prod.outlook.com (2603:1096:400:3d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.51; Sat, 29 Mar
 2025 12:52:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.028; Sat, 29 Mar 2025
 12:52:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 10/18] can: rcar_canfd: Add max_cftml variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 10/18] can: rcar_canfd: Add max_cftml variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkmFJPOPuz+kL0CUJUephewOeLOIhbUAgAGQMJA=
Date: Sat, 29 Mar 2025 12:52:05 +0000
Message-ID:
 <TY3PR01MB113462A042870503D4714624386A32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-11-biju.das.jz@bp.renesas.com>
 <8a9cf211-bc79-42bc-bfad-555b39124c95@wanadoo.fr>
In-Reply-To: <8a9cf211-bc79-42bc-bfad-555b39124c95@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11281:EE_
x-ms-office365-filtering-correlation-id: 6706262c-9246-4275-4e8e-08dd6ec0821b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG50ekhlMHBsalR0SzJ2aFAzQ1c5akdYWnpzN3BXRlNzMnhuL3J6UGtzWGV5?=
 =?utf-8?B?M1Rzenp3SzRST0N4bDVJT0NZT1F2ZS9OaHlBY1NmNXM2N0ZyYTlyQjN2OTFX?=
 =?utf-8?B?OUJNYURiWU5nZGxyUzZ5RFcvNGptTFZJcGR3Q3ZwTlMrU1BvVU9iNWZWZU9x?=
 =?utf-8?B?N1gvaVdKQWg4QjZXa3ZvK1dtb0IyM1pOVS96YnhTSlJZTS81cVhQRXBrNkRX?=
 =?utf-8?B?S08zbTN1ZnhwdThxY1YxYzk4ZnY3Y29KRXd2d0hCVjVobXZHOUF1bUxEQ1pr?=
 =?utf-8?B?SVhNV1AvY3BCckxHVjVMbmJ4OXZxeGo5ditqWDdGaHF3NU9OWExKMGx0azhp?=
 =?utf-8?B?QjE0U2dFbjZuUzJYVEloNDA4MHN6ODVDL2lxSHhGT092ZnZmemV0R0ppaEFw?=
 =?utf-8?B?STlkaEJuR0FGa09zMkk1TXBCWkloUEJ2RkFwTmYzZGgwYkFOMTk5eGs1eG5E?=
 =?utf-8?B?NHA3VStreFZRU2wxYWNTV1J3S2kraFpJbFZuYm13WGxUeldVV1MxaDdOTmE3?=
 =?utf-8?B?RWZ4VVFGd2owdWZBVVI1VC9xQ2FVL1ZkY2UrT0wweUtqd29FRCtTQW1lQTdI?=
 =?utf-8?B?ZHJrOG4yaGY4bUhPeU5VTlZrWEFjZmQ4QnluNFNGbVhlRjJlSzA4cGt1ZmxJ?=
 =?utf-8?B?S0lkdU4wZGt2ZjdGaG9VdWc3WmlxUFhiSk9jWThFTVNiRmg4Q0lTakU0T09V?=
 =?utf-8?B?M3VzYTNZL2R0Sk9QOXI3QXRNMlhra1I0K3ZHYnlXSVpDYmVEczdtY2lRUjAw?=
 =?utf-8?B?Rjc1VFgvUmY1bmw2TzU0eTYwcW1vYUtRZkRtVzYxMTRxcVNoR01IeG83RmI0?=
 =?utf-8?B?QTQ1SkZ6aXY1YTU2bVY1eUJYSzJQSEhwbmQvd0MwbkRiZnh1ZWh1UWhWQytH?=
 =?utf-8?B?djdabm13bTllaEY0a1hCL3g0V1VUZ1ZFRWJkeEdObWZ3ODcxc0gyR2R1eWQx?=
 =?utf-8?B?WExCQ0VuSndSaTJGRHd4dmtYdVJHbHhkdGozV3lwS3ZSSTZORjlpam9PRTJ6?=
 =?utf-8?B?cW5jWU9mdGpEa3FOd0I5SGR3WURqNE9rc2hIRUF0MTVpQlFxbFZUQ0phWWFy?=
 =?utf-8?B?UitCRzYyY09kN3czVjJTZ25VdjlJc25nZXRUSU1CK3ZVeVo5MFdwR0FxWTNO?=
 =?utf-8?B?azFyUTBOdDdJbitFenRJOGQvTEtkSmVFdXFGU3VPRWNja3VVSWhBQW9nWXNs?=
 =?utf-8?B?YStUZnYxTXQwZUtKM1FwNUJmaXFkOWlFOWFyOFFjRW1Kend2NTNtTU1ZcWQ0?=
 =?utf-8?B?VlhVMlh2RjFmUnBBZWd6c044YkVrMUs4MTY1WlZ1aWNuRXJCZTlyTi9aOGtq?=
 =?utf-8?B?TDZUUlVZSWdNUmxvTDBReEMrYWMxOENxU1l4UTBtbjRVZDJLV0tNS2JYbnZ0?=
 =?utf-8?B?Z2Z6U29STVpMOE80VlZ5dVJrWHBIQ1QwTEQrMGNzOU1teGRzZG5ENE43QXM2?=
 =?utf-8?B?NHdsd2xzTUtSSzhiZnBjejZRMVNGUEZicHV2MWFSOE9SNnpqTEtiVjk3eFBo?=
 =?utf-8?B?SHF3VmRFcy9xeE5XY0FjMFY4R2lIN1lSQ3dsRDAwVkN2Z2I3M1IvZnJMOXRi?=
 =?utf-8?B?eGVDZWV6azhaT0ZQcVNueTNua0dkU1VUVE53aytTaDJ5eHVmeTVSdEJlV2xr?=
 =?utf-8?B?VU5yK25raFNBaWsyZ2ZnMkdLcUtuUEppZVlSV2ZTUlZ6K1VuajJlQWRGVWVM?=
 =?utf-8?B?OUdGVU42T25RMHlsWUVFS3QxY0RJSkhhTWxjQVdQc3loTW0zVkJvdDN3bmRm?=
 =?utf-8?B?eHZwOUkwQnptcUcyOElENEpEczdPQ2xuMnFTV1VxdmxoanRxNzEvNGticWR1?=
 =?utf-8?B?UDJEWmxndENxcDczSkpsTlZsVW5vVWJ4Vm5XMG5QcGdWTEZHVytTaUh5UUxL?=
 =?utf-8?B?SC9qMXNqRFF6bWRia2dUTXRnTkczVlFvTmRtWW1kRElXYytjUXJZWDdWbER0?=
 =?utf-8?Q?ry5UTZ0s4co5Tb4/nZnNqClobzmheZcy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlloT2U4dkVyeGpsZHA3Umdyc21GOW8zWXltYUpIaEVHcDZQOHJ1YnFYT0Vy?=
 =?utf-8?B?RzZNSjZYUURGc1FveFNsdXMyNkZhUmNaVGNxdzBvWGlXbzU0Q2UxZDhPRXE4?=
 =?utf-8?B?MFNnZ01GcUFPUTNNOVVWSHhnRmVVOExCTC9vZG11bGpQblVValUwd1lkelJy?=
 =?utf-8?B?V2FpUU5sd2dBZDM5UHpMWCtHUDlMd0p6WVBpenpxcm5kRjFsZFFNSWdDTkIv?=
 =?utf-8?B?RkZySHROQzZLRDJOekdlSXBvZG1Ca2Fjb3paYXZNbnIxbjlaUkd2ZldoYUhQ?=
 =?utf-8?B?MXhxUjVVVGYxT3FUSXM1ejQvUkppTmE2bFFXbE43aTJQQWNkOUdiSmVYVFg4?=
 =?utf-8?B?V3pIMGhUTWx6WEhBQUFEVlFyeGY5dDBYb1ZHR2pmL1pJQ24vVHV5OHhuU2dG?=
 =?utf-8?B?SEJzZHJtdzdSc1BsUytDTURPTTlBWXFnV201MkJHbHEzUUJLbFVVOTlZODBQ?=
 =?utf-8?B?UkRTNVcvNlFha1Q2QUZOVmlvQ2hJcmNvdi83M0FKenh1bjRmM05ZYXhESWNB?=
 =?utf-8?B?WXJ6RzdteHBqaS9QTDNzaUR4WHhnbmRnbkR5RkdwU2N5Z2NyeDdHYzZhbUJj?=
 =?utf-8?B?OUdpSXNEZWYxdWlFc1lnRVlYcU4wUHZIME1nQ2NIWkI2MFpScGJxMEdvZDN5?=
 =?utf-8?B?MEUyNUwzM2FqUlFUeWZyTENoTW1RcnUxVG5Ya0xnV3JBVWxRT3JHdWlNYXhz?=
 =?utf-8?B?NlNnczg3aE4vT1JDeXdlWWpSTTBXRE1WNjFNbXExbS84R2xmTSt5RmZPZVdP?=
 =?utf-8?B?L00yeEtOMDNnaEpURzIvQ3IxRERkbHQxbVBzL09MZWp5THVqU0lQaUE5WWkr?=
 =?utf-8?B?WUNDeHdMQnZaOUd0M044cHFOT01ERVJZcWdTenlHRU1weXk0bVdtWTZFTmpY?=
 =?utf-8?B?Y0JuSWVBQTlkOVVpOFdRN0dhZEVUVExHM1pBYTNveW1PRFVhTDhKU2JaOGk5?=
 =?utf-8?B?RVVISUFEMTZvbmpFaGFOaWE4SXdtSTYyV2FsRzRPNU5kb1RjWEpWL25Xd3VW?=
 =?utf-8?B?VEw3Rk0xblNZcEx4Y3BJMjAzVExJT1pSUlNLOUtyQ2hjUWRMbXhOdEgzYVdL?=
 =?utf-8?B?SXJiMGxBWSsraEQ2eTlMNmpUcStHZnhmVnhES0ZDbS9mR1hHSlBNVUpVZ3hj?=
 =?utf-8?B?R3RWdVg5eTdqVmxtQklNT016bmFaVG9GZ0tIdVpISEQ1d1hJY3R0OUdjUWpx?=
 =?utf-8?B?MzBaLzBDTkVzY0d0ZGlRVVNXanVxOXk1OHpHNzIxVVhJM00wMk9hcGxTblFI?=
 =?utf-8?B?bEd2TGtlQk5RL1FqSTZnd0s4OTJ6L1hpTHVMRHFOcUNET084VzFXd1JyRkNh?=
 =?utf-8?B?VkVHRnJ4UEdEajFuZ1RLaE9XMTY4SThSNFhhckN4UXk0NnpFVFcyZEI4MGJn?=
 =?utf-8?B?NVhma3NuMzZwWFEvTVkrVTVNQ2t6MHovdXlHZ0xMci8vS1cvUGI3b0dhK0s4?=
 =?utf-8?B?aFo5bXBYbEplTy96RFRZa0psSzhoMnE1eldGS1N2YkpvZXlTOXFRcHRQT0lm?=
 =?utf-8?B?aE1waGVRMUJoNkF0RnNCcmtjeEd1WVhDcUhhUEdMV3NDTDJKUU1veW1td0JN?=
 =?utf-8?B?MWhnMnlBRGZZVHRVMlZVK2tpMkNkVzNoSHdZZVdTY2taY3daZkhoZFAxc0xr?=
 =?utf-8?B?dW8rUWtJVmZJbTdmNVYrYkwySEpxVUViNEVaSGxGUXNZempRMm1aeUpBOWt2?=
 =?utf-8?B?dHpaWTdGZEdEVm1BSUlrdEEyZ3RLSisrNGZhekZ4NHVDY0todjR3c2t3RUpP?=
 =?utf-8?B?cmdvZ2lEUmRhaDJJOHkvSkZOZHBQYkVDL1hlblNPbHlhNjdqeHJTUGF1YUV2?=
 =?utf-8?B?WUd5cjE4ZWhPdGI2VkRTT1I1bkpmRTlhSWtXeGgyaHBQZDU0dW54eFlWdllL?=
 =?utf-8?B?QXpsb1ZldFBxc0VMUEZSdEh4VlVLTDlhQnBOeXc0REovczNTazhjZmp6M0JL?=
 =?utf-8?B?VnpCZTh3UjZrTWRUd0hpa3FkTFl4bmI5R2YzYVF3NW8zQzhJMHhXVno4TkVS?=
 =?utf-8?B?c3MvOGFsSjdzSncvYnAzbE96VFh6aDJtTmduTnlwYnIzMU5oVXN5UnRyYS9M?=
 =?utf-8?B?V0lZQTU5WDBnSDZUN3QwdVVWYnRJWlRtbVRmZkRBK08zZVIzVHFKR0w1cjda?=
 =?utf-8?B?ME5BSUp5YU50cWtKdlIvVU42d0pQR1BGekhvUmN5d0Nnam9VWWtlS1BmRURU?=
 =?utf-8?B?M2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6706262c-9246-4275-4e8e-08dd6ec0821b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 12:52:05.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1VCAaFYy2UXnXUk+hCIS+ZZrsSCdBTmhPYKgx/hxzcHQwWH/Bp2UVBIArsJBIjgJnJEoa/HkpHrYL8ZOqydvmGYGTxcRjGYaUpoH65T3pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11281

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMjggTWFyY2ggMjAyNSAxMjo1OQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDEwLzE4XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBtYXhfY2Z0bWwgdmFyaWFibGUg
dG8gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiANCj4gT24gMjYvMDMvMjAyNSDDoCAyMTox
OSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gUi1DYXIgR2VuMyBoYXMgQ0ZUTUwgbWF4IHBvc2l0aW9u
YWwgdmFsdWUgaXMgMTUgd2hlcmVhcyBvbiBSLUNhciBHZW40DQo+ID4gaXQgaXMgMzEuIEFkZCBh
IG1heF9jZnRtbCB2YXJpYWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHRvDQo+ID4g
aGFuZGxlIHRoaXMgZGlmZmVyZW5jZS4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBW
aW5jZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiANCj4gPiAtLS0N
Cj4gPiB2Ni0+djc6DQo+ID4gICogQ29sbGVjdGVkIHRhZy4NCj4gPiB2NjoNCj4gPiAgKiBOZXcg
cGF0Y2guDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYyB8
IDYgKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGluZGV4
IDdjZWYwNjczZmJjOC4uYzM3ZmI4NWZlNDc4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3Jj
YXJfY2FuZmQuYw0KPiA+IEBAIC0yMjcsNyArMjI3LDcgQEANCj4gPg0KPiA+ICAvKiBSU0NGRG5D
RkRDRkNDayAqLw0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkNDX0NGVE1MKGdwcml2LCB4KQlcDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gTm90d2l0aHN0YW5kaW5n
IG9mIGFib3ZlIHJldmlldyB0YWcgYW5kIHNhbWUgYXMgYmVmb3JlLCBwbGVhc2UgZGVteXN0aWZ5
IHdoYXQgdGhpcyB4IGlzLg0KDQpPaywgd2lsbCByZXBsYWNlIHgtPmNmdG1sIHRvIG1ha2UgaXQg
Y2xlYXIuDQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiAtCSgoKHgpICYgcmVnX2dlbjQoZ3By
aXYsIDB4MWYsIDB4ZikpIDw8IHJlZ19nZW40KGdwcml2LCAxNiwgMjApKQ0KPiA+ICsJKCgoeCkg
JiAoZ3ByaXYpLT5pbmZvLT5tYXhfY2Z0bWwpIDw8IHJlZ19nZW40KGdwcml2LCAxNiwgMjApKQ0K
PiA+ICAjZGVmaW5lIFJDQU5GRF9DRkNDX0NGTShncHJpdiwgeCkJKCgoeCkgJiAweDMpIDw8IHJl
Z19nZW40KGdwcml2LCAgOCwgMTYpKQ0KPiA+ICAjZGVmaW5lIFJDQU5GRF9DRkNDX0NGSU0JCUJJ
VCgxMikNCj4gPiAgI2RlZmluZSBSQ0FORkRfQ0ZDQ19DRkRDKGdwcml2LCB4KQkoKCh4KSAmIDB4
NykgPDwgcmVnX2dlbjQoZ3ByaXYsIDIxLCAgOCkpDQo+ID4gQEAgLTUwOCw2ICs1MDgsNyBAQCBz
dHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHsNCj4gPiAgCXU4IHJuY19zdHJpZGU7DQo+ID4gIAl1
OCBybmNfZmllbGRfd2lkdGg7DQo+ID4gIAl1OCBtYXhfYWZscG47DQo+ID4gKwl1OCBtYXhfY2Z0
bWw7DQo+ID4gIAl1OCBtYXhfY2hhbm5lbHM7DQo+ID4gIAl1OCBwb3N0ZGl2Ow0KPiA+ICAJLyog
aGFyZHdhcmUgZmVhdHVyZXMgKi8NCj4gPiBAQCAtNTg4LDYgKzU4OSw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHJjYXJfZ2VuM19od19pbmZvID0gew0KPiA+ICAJ
LnJuY19zdHJpZGUgPSA0LA0KPiA+ICAJLnJuY19maWVsZF93aWR0aCA9IDgsDQo+ID4gIAkubWF4
X2FmbHBuID0gMzEsDQo+ID4gKwkubWF4X2NmdG1sID0gMTUsDQo+ID4gIAkubWF4X2NoYW5uZWxz
ID0gMiwNCj4gPiAgCS5wb3N0ZGl2ID0gMiwNCj4gPiAgCS5zaGFyZWRfZ2xvYmFsX2lycXMgPSAx
LA0KPiA+IEBAIC01OTgsNiArNjAwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZk
X2h3X2luZm8gcmNhcl9nZW40X2h3X2luZm8gPSB7DQo+ID4gIAkucm5jX3N0cmlkZSA9IDIsDQo+
ID4gIAkucm5jX2ZpZWxkX3dpZHRoID0gMTYsDQo+ID4gIAkubWF4X2FmbHBuID0gMTI3LA0KPiA+
ICsJLm1heF9jZnRtbCA9IDMxLA0KPiA+ICAJLm1heF9jaGFubmVscyA9IDgsDQo+ID4gIAkucG9z
dGRpdiA9IDIsDQo+ID4gIAkuc2hhcmVkX2dsb2JhbF9pcnFzID0gMSwNCj4gPiBAQCAtNjA4LDYg
KzYxMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHJ6ZzJsX2h3
X2luZm8gPSB7DQo+ID4gIAkucm5jX3N0cmlkZSA9IDQsDQo+ID4gIAkucm5jX2ZpZWxkX3dpZHRo
ID0gOCwNCj4gPiAgCS5tYXhfYWZscG4gPSAzMSwNCj4gPiArCS5tYXhfY2Z0bWwgPSAxNSwNCj4g
PiAgCS5tYXhfY2hhbm5lbHMgPSAyLA0KPiA+ICAJLnBvc3RkaXYgPSAxLA0KPiA+ICAJLm11bHRp
X2NoYW5uZWxfaXJxcyA9IDEsDQo+IA0KPiBZb3VycyBzaW5jZXJlbHksDQo+IFZpbmNlbnQgTWFp
bGhvbA0KDQo=

