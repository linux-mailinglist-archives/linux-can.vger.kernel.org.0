Return-Path: <linux-can+bounces-3101-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7EA630CF
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 18:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACEB1701AE
	for <lists+linux-can@lfdr.de>; Sat, 15 Mar 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BD199396;
	Sat, 15 Mar 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WGiXF661"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7B4A06;
	Sat, 15 Mar 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060012; cv=fail; b=HUJLJrVpLRQil3BmZF28P4gt6SHxNN+3FEArkMlcS+/JvZCuWqj8VTzn9AqIb106w2msv8U82bTvFahNNwerlZDj4hoL8fvSkCoYHWCkzYTPgu1/mMubrEf6XwMbSxtdmT9tKCBvY5zolY4zJM2ZuHmODxel3cXOoJsVmuH4JCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060012; c=relaxed/simple;
	bh=HCcmAut6tp8DBl8VLWR4bKwg7wSYEXdBixnnf+J4oUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfWYJQud9qHeGFBhR9AcDxjIoADPHESr6slNl4urYxa/inzkWTiA2e/9f0b1z5x7G/PpsusDqn1w+Ujp2VvuyRerdmtw0ZmhUuRZj/VCSEBpOhdIIEvt3hV2vd0tBCghboF8L9R7CUr1DjFZ21qg1ykmkYQZHpF3TKjiAfSaigM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WGiXF661; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybv1S8E3S9CNn2h7hWqNvghfgmbvNo4qMREscU1Rpkl0N4fFXRpLtWp3DpaGIjLse7KGqYgP3dVHsqieCOdrucCIlv3OBjlQvTDj4gOyCq6FElKkbIlg+LwJntKaQOJCzVs0PactrReR6qyxw5HW1BshF4pBPiJi86/K39tZxB9XEIS0xdzagtForD90f/c7uJoPVb8Uy3wciizo6KVePej3zPraZeJ+xsIPM9hMBz0Kqe2XH5oOZYoqqi5LoakZeOkjJk0TANpbh0OXrs+v9nYRX88PjiqrdRGdeK8xbP5q/7bxbIk9Bzkmw9rtdmt1/NzcCYFVrkRaKZrOLGr8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCcmAut6tp8DBl8VLWR4bKwg7wSYEXdBixnnf+J4oUc=;
 b=H0bywJRr8PTysnNfJjYuAzN/pl11kzeyZyHAHgLe176ZERzCt7YKjI2JmdIagKfKhup0QnGA0f2OWHCcXAWIcswrYWgL68CTAmRxRQh71wJPuceYmiFQkaGugsPpP4NZZuMwCiaTi1qKBkk+cLAM40yYOfNRvc9oCaH2/Z5DYInEj83Ehjydr7r/c5SSkXHVLroroEbqJ4zMC4TmlUNw05vOqFNzYyjq+l5k2COKTv/itZ3lSvFwB72fllYppGIieZHKzq6zUFhG0Y4YxAag8Ua8YtlVprTVaxrK9rYP41AWTP/vw7jiDqtf4mpGf+4OOzHvTq9pZSTJckcvFop3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCcmAut6tp8DBl8VLWR4bKwg7wSYEXdBixnnf+J4oUc=;
 b=WGiXF661mIjNd+u4rUt3ZFN1zb0ppUi/EkYdXAniCJjj/nHl6GgbYE2MYlO1ac31PhMHs1I1blrzNVMVR9/Idzrc9H+8hkmr3R5+8KuVLCHLFwpkLWCPw2elmC79Z4WW/VdcvqmRk7eXhnE26/hJFQfgr3aA/fel9s3O2RC+188=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS0PR01MB5892.jpnprd01.prod.outlook.com (2603:1096:604:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sat, 15 Mar
 2025 17:33:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 17:33:28 +0000
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
Subject: RE: [PATCH v4 09/11] can: rcar_canfd: Add only_internal_clks variable
 to struct rcar_canfd_hw_info
Thread-Topic: [PATCH v4 09/11] can: rcar_canfd: Add only_internal_clks
 variable to struct rcar_canfd_hw_info
Thread-Index: AQHbjpVjqWv+yfrYI0SIen3umJmsnrNywvUAgAHAK2A=
Date: Sat, 15 Mar 2025 17:33:28 +0000
Message-ID:
 <TY3PR01MB113462C8C4356BFAABADFF66586DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-10-biju.das.jz@bp.renesas.com>
 <CAMuHMdWQQGHdg_bH8+QTwXKOxQb6_M3Hkj5Re4QkGU8BNZ6vhg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWQQGHdg_bH8+QTwXKOxQb6_M3Hkj5Re4QkGU8BNZ6vhg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS0PR01MB5892:EE_
x-ms-office365-filtering-correlation-id: 4f7d9d55-8b7f-4efe-72cf-08dd63e77f69
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2UyMjBmZ1U4dktRYzZYWGxubVBBbmFjaFF0b3NlcW9HdFZMc3VlMWRoczQ5?=
 =?utf-8?B?d0craXNHVjlmRm9jNFA4V2JZS2ZWQnhaWG9ydHVHRFJrNTNucFYxd3NoN0xD?=
 =?utf-8?B?MTd6MVJCbmhTTWdOelJ0Ry9COTV4d0VRSDdKMmlNUmFqQ29DamlmVWpVTkwz?=
 =?utf-8?B?TmpwaDRReVFSQVYwaGM4Qnl2SDZua2FuR0VRVlN2OFVMczRiV3FGOXV4VEN0?=
 =?utf-8?B?VlN4RnZka2I0cnIrN1FubzJUQkJRazVSd0hhRTVFMTJBVHVBWXR1S00rMTJj?=
 =?utf-8?B?ME9GeEpiZU9qYmZ5c3ZPWTRjVTN0clEvTlMwbk5pdjk2NlZkQlFJMlNkTjZT?=
 =?utf-8?B?YUk0bS9RRVhHaisxdmRhY1pFdDN4RHNGRStGelM5Sml0S04wTVVRcXI4bXpX?=
 =?utf-8?B?dUVOTE4zNHRNbC9jbW9peUthenJVVDRVYUpSUXk3YXhzSDd5cmRxKzR0Zm43?=
 =?utf-8?B?YzE1RGhVc25tTlFNTU8yUjVvcjhQM2xFbVhtalBqWlVDcUNONitLRHBNSGVJ?=
 =?utf-8?B?cHZOWjFGcnR1dTlnM05lZ3hkQzVpcTBkTzFValdRZ3haVG4zV04rQ2g0NThO?=
 =?utf-8?B?Q3ExaC96LzRQQVZiblEweU5WSU5jbDVhSTRVQWt0QU1sVENTUTM5Qjhwa0k1?=
 =?utf-8?B?L3lNMjZjRExVdm5Ja1czamlBOE9WNXUxZzlxZ2VGL25lUitJd3Y4ZDB6Vmth?=
 =?utf-8?B?V2VuRS9kM29RYldlWEpGQVordlBidTlqbVRRaWIwZjVzRTNEdmdvNXpiVUFy?=
 =?utf-8?B?bjZ0dkpPNXJxYmxkRmNkSjd5ZXlnTHdXQVZpQi84M293Z0d1Y1dlVTA3bkNp?=
 =?utf-8?B?ekxqMm5rcmU2eFNiRkZXWm9Vb0lpOStFRXMyTWlabkhsNDRldDluM0lKZ3ZD?=
 =?utf-8?B?dXVpSENPQ09xZy9qOVUrcDhjMTNZQVVBTkM0N2orV1BBWlcvT2t6QllTMnFQ?=
 =?utf-8?B?c25xZzRjd0gza3BFZzc0aWlGS1N2clg4NGFQTnZ0TXlzQUxJNkVLR0tDWWlS?=
 =?utf-8?B?TDhubzNuK0txTjU5c3RsL0NDUE1qQkRWRUcydmZ1ZzZZNFQyTE5ZUk9IUmt3?=
 =?utf-8?B?TzF2Z3NCN1Q1NGNXUjJWNW1iTytraytLSmR0VVFud3RDZlA4ckw1NEFUTzdI?=
 =?utf-8?B?M3J4b2d3Q3VXb2hTOVRrMkFaa0NrODhxK1V5QkVYR3pzRmRwVktNUTRIRFFZ?=
 =?utf-8?B?c1lLNnFtOS9IUllBOVNKa3N3WXBuZ0owcG5yMytYc1RFQ1c5cG0zMy81MVd2?=
 =?utf-8?B?UTduRHZFLzFxY0NHVFEvK2Z4OGR0OGRVdlJMcmhHRDhXVyttbERidUlza2NT?=
 =?utf-8?B?Y0Z6ZWtmRCt4bHBpb3RXVkJtRzBXV21jbW5vWGhOeG5yOC9ZNGpMWXF6Vzd0?=
 =?utf-8?B?UTBlcnpJbi9uUEVWQnBnM0hzNGtPNHRqNFNzOVlmQS84dFIxOFBDd2FvdkE4?=
 =?utf-8?B?SFRYc0xEeDhVZ2lzL0lYWGg4Q2QrOWJmRHE0QkdrdlZwOUVKcjh3TjdVWW1w?=
 =?utf-8?B?REtMQ2JjV0NnN09Ob2RmeWl2WVJsN2dhazQycmZld05NM0UwdmRuY3VhVWhQ?=
 =?utf-8?B?WFg1UUlSdjhmMkoxNGRSM1ZMSmw0Uk9QZ3pOM3FvQ24rNkVYWHBRd2hCVmJk?=
 =?utf-8?B?V2hTdHhLMmt5Z2RVTFRsKzFrd0tub0VSNDh0Y2s1MlpXQ3FvYXFHeGhwT1RG?=
 =?utf-8?B?ZTZkalpTT2d5U2hvc3l6Z0hlU2lMaXZpSGJWWFBKNkRKd2hzL1NvWnhrd1Q5?=
 =?utf-8?B?aFFMQldGQ0lBNDlDd0RpaXNReFk3RmZwUjdhSVRVb0I4NEhOei9FWlBzRDZp?=
 =?utf-8?B?NkxFUHMvSlQxV1RxMGtNOTdZS0x0Q1ZJeTBjUGM5ajdJT2huQnc1ckkwRVhP?=
 =?utf-8?B?cHA5SEZydzZIVGgxTXJ3bHg4K1FGa29SU3lYTHBYRnl2NkR3OUtQOHp3SkZY?=
 =?utf-8?Q?LlW+P3+CK2MlcUwGCZ1Dp61TaEvCZmRQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NCtrbUpXdkZYWDJ0akNUTUFtR2daK3c2UTZZNXQ2SmExc1orMWtPRndVTm56?=
 =?utf-8?B?dGdUZm84aEJrTUlkMmpSUTJwdEdkSDVOamluZmM4THB4ZThZeHBWcUs1cE5E?=
 =?utf-8?B?K0RiODM5YTBET0lkelQ4U1E5UjJMR3hKekdXVWZFaDhWUWZBUkZSSHZydFRD?=
 =?utf-8?B?SjAvR0pjQlhHcjFrdVl5ZzYyc2EyemZ2RzJjZnNwRTlFd2FGbFNqaUU3ZVpJ?=
 =?utf-8?B?cWY2ZUs3dnF3VnBUdVYwcENpeXZnZlIvVGF6dEtJMWQwcVJzUWNYSkNVWkE5?=
 =?utf-8?B?ZWxJWEY2REo3cEJqcStqQWk3MGxHa0RrdzVzWXdMZWFTcm5naVJmbWJXWk5a?=
 =?utf-8?B?bEdEdWRiaHhqcXBLemkvcmpNRG5nZG1YbjQ5VHowTTJYTlphalZBdG5pUjFw?=
 =?utf-8?B?cGFCc0ZXc0c5SWhKNmNpOUJBRklGYXJWWVR2YW56ZzZwRlNycU8zUmpiMFlH?=
 =?utf-8?B?RHZLQzFGNEJaZzl5UWkyWGg2OXJRUEFaMXZnU1JISjJwU2FXUzEwSW1pRk9Z?=
 =?utf-8?B?bkd3RUd3V2dqbURwSWpiQThWRGNuNE9yY3JORll0UTZNRzU0eTNaYklCWHg2?=
 =?utf-8?B?WlBtbVFGOGo4MG15L3lGQnExd1RDdC9IVUp1SVNtZUh1RzMrK09FUW9ESDI5?=
 =?utf-8?B?RkllZ01nbHlTSU1xM1ZOZ3MzOUVsbER1Q0J1UDdacGxlbHhyOGxGRjc3Y2ZU?=
 =?utf-8?B?a3NPcys4enh1aW9iRzMxZW44WHUzZm1KcjkzVEJIT0lTWktLRy9hR0dwV3Ix?=
 =?utf-8?B?TVJnbXlaNzVzdnFZN2JPSUQ1Ylc4N3FMZVRLeTd3OEhvcU9qNHRLRnltZnFE?=
 =?utf-8?B?S1RpZENLZXg2dzl5WHFyZExhNS90YXZaL29pL01YdkpHd245U2t4YnNQcXJL?=
 =?utf-8?B?RzYzcWVqTTRMbytwZzQxU1RNZ2hOaTMweHVuUHR0dCtEa21qRFdQNHIzaUZ5?=
 =?utf-8?B?ZFgzS013V1FDL3I0aGw5ZTRNcXByY0Zpc1Uxc2tFY1ppV0NlU1U0aWtqQTJJ?=
 =?utf-8?B?eXRmcGNwRlpTV0k2YnBlNG0rZWsrVVoyUDlFcDk5SkVtRnRNTUN0U25acjdB?=
 =?utf-8?B?eWZyeHZJTDRCRm9KeGtJRDhxWDJDZUo2VmU4WkVGWGZJd0RrRC9TN3o5VnFE?=
 =?utf-8?B?WEpLaTJYZmZJSVBIZ0VrdGk4M0p0cHlGNjdWNlJlU1laajVsOFEwaktlU1JZ?=
 =?utf-8?B?K2crWks2Yk5ZZTJMSUJ5OEN0cUtnZFZVdSt0YzhuUHE0b3JTYThPOGhqRlBH?=
 =?utf-8?B?UlhIZk5mWW5mRjVBam9XV1VEMWdadUtiL0g0Nk16YjlPMGxnVXlISld4dkxC?=
 =?utf-8?B?THBkdUhGbXJYMjk0VU9JSUZhS1BnQUZHbG1WUTd3c2FLLy9Ebm4yNytpM2ds?=
 =?utf-8?B?M1l1SHU5NHc5TVhGUTczejlnVm43aGg3RkM3ejZQOVZNcEdpNW5veFU3TkZL?=
 =?utf-8?B?MG85c1MyeWhabDdDQmVTSTc2c1VxSlA5WTc5eUdmTThqWjlaME9JWVI5V0JE?=
 =?utf-8?B?dlVLWkcrekxGdm43OHZ1djZwVU9CNFF6NW9Gcmh4Sk5hVTlpYlhFc1B4N1hr?=
 =?utf-8?B?cnVudEpzWmxQRnEzdGY2UE1UNTMxSWhKV3N2a1k3eTJGQTMwWU9BRVBCcWI2?=
 =?utf-8?B?ZEdyQkpuUGIzWVN1cGoxdWpJaTVmMkNZQjBBZFZ6b1NHMmZYdEpPeDhtSHFN?=
 =?utf-8?B?ZS9kbCtOZ2RtQ0hQTFJzV2lPTTdSNFhHeGxsVU04elpZTUtnM2p1Q1J5ODJ6?=
 =?utf-8?B?anU4RXVCdUY2V2NEaFNHMGhFZlRwbCtKZW9SbkNVMzI0bWlvbGNQdzl2Y0tH?=
 =?utf-8?B?cXh4UVVpSGpUNkR3VUpHY25ETXpuRS9UbzN5UnVJL3ZQTEZqYzByQWhxUHkr?=
 =?utf-8?B?SmJtVFBFYzYvaEJzZ0Q4UWZNV3VZenhsdWtQZlZoeVgvVEo0dWVmbEFkOG56?=
 =?utf-8?B?L3hBcDBHdXU3QlFoR29IVkU4OGVnWE43bUpFT1dnMXo2U1RUZWhZeUZueS96?=
 =?utf-8?B?c2hxdjdRNWhRSCtmbmtPUUlWZ3VldGIxc1ExMDB6NjhydThJQy90NWtxSk9x?=
 =?utf-8?B?M0pHNlVqVVdnQjg0QkJRTnFZSDNXN1IxSFAybVRVOWxiODU3cGx4YmZQTGlz?=
 =?utf-8?B?WXo5Z2VzWHg0NzhFVm45dkZqTnlzNHVkM1RwRkV3ME16S0YrQTJxUUhLNm9x?=
 =?utf-8?B?WEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7d9d55-8b7f-4efe-72cf-08dd63e77f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2025 17:33:28.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1YIy/1uCTJpUj2lboCc9U+J/0ZWqw8T+ShAZJkroazCmU3C3TMzF1l9GRFWYa8tcuvAVwb7tvoulrT1L5mabLHfAQFJYbwURF9geaO6Bcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5892

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTQ6NDgNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwOS8xMV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgb25seV9pbnRlcm5hbF9jbGtzIHZhcmlh
YmxlIHRvIHN0cnVjdA0KPiByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IEhpIEJpanUsDQo+IA0K
PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBPbiBUaHUsIDYgTWFyIDIwMjUgYXQgMTM6
NDMsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gQWxs
IFNvQ3Mgc3VwcG9ydHMgZXh0ZW5hbCBjbG9jaywgYnV0IFJaL0czRSBoYXMgb25seSBpbnRlcm5h
bCBjbG9ja3MuDQo+ID4gQWRkDQo+IA0KPiBleGlzdGluZyBTb0NzIC4uLi4gYW4gZXh0ZXJuYWwN
Cg0KT0ssIFdpbGwgdXNlICJBbGwgZXhpc3RpbmcgU29DcyBzdXBwb3J0cyBhbiBleHRlcm5hbCBj
bG9jayINCg0KQ2hlZXJzLA0KQmlqdQ0K

