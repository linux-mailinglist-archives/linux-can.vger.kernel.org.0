Return-Path: <linux-can+bounces-4674-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA207B5461A
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A014E1C27266
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3447274666;
	Fri, 12 Sep 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="G0ySgZhD"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2056.outbound.protection.outlook.com [40.107.113.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35C270568;
	Fri, 12 Sep 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667403; cv=fail; b=E8RlfzCGcrjlbPATnkCLzo3l978PvDQcLNbbaMsWHr18BDf1e6tH9ZaPV2WVyXNkSIie/stAOQiXll/tH6FBrOe1CrYpXjw/NgfAaDRf4vQ4L+yKtG3y2io0oPj/CMZd+Y7vQix0Af499jdE1BSliLOnacbETG/vuT1stn0Vz6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667403; c=relaxed/simple;
	bh=HJ6ftI+eCHHFNhRSJkknU5svFYBQdJZvZnCDFELj6MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVkUgIYKETlxFi4Her5uhzkWrgHTl5S82RoPoSRT1BwvcUTpGR2/xMKI3GjuHl4AY4NyCkPIRv3PJC7HT3L+MVeNDzX4tsePXYInXtAWyY59jKmLXfCM8YxA20hXUIxBBgViKoqi5VeuqUvnN7A5sts5RTRcsVwG4U3UDYZ8UBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=G0ySgZhD; arc=fail smtp.client-ip=40.107.113.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Vu0wRXmf74+etbQw6X4RvHUZFu81tpVYU5QQZtm35vHYZ+qJLD1arWHcgBLd2VIC8AN4l7PI13F5BBGs4bJKbFCu2mluBpJswNTTa7MZh5Gz92y984pLOTnDMEgvwPnRFyohC3Qr4phu18bfnM/mE0TFMRZ1EdSISf8pKXFH7PvyH4OumAv+/Ilh9eaM0HJ+0Wqmhh96pGEUmcupaiZ8sI2ej3CToZKjCioLgYR3Aq2rqRKwFPk/CXeqD1YZGD4unEbfeiNU4w//1z6+TJtsyhUw3BrCTBRzlo68nnmOLhR7DBzwn70iqRrFc8qc03foIYIHaQozBUWQKRNIKv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ6ftI+eCHHFNhRSJkknU5svFYBQdJZvZnCDFELj6MQ=;
 b=cqiCPuNW/gxtvuhlYJxOCDubX4mSNZH+dMyQGZE3nfHg+f86zf+3UgGYC+KVw9oZlVYFPH8igEjzDIZfa9A/KxduIdzlelcoySGl7z7S8ivqKV3HYE1GKphCudnqu30qzUdOkjytBaW+sndUmfhuKbDfVnSRETi3jTdaqHJzI6WDSrkdbF54XkbXJ1jR7O4lWac2hnElgaKan7fMdjnSdI9galuQPr+i5MXL8NQr+6JsTQKwPgE4P0kGC4v26Od2yVrEcBzm8lQRGI3AfOf8TlOX2XWhOwOlrY30P/jpZ/SkRPld+B0QIPC4CGlKEBA07Wc4JAi+5fA7tEwxrlzciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ6ftI+eCHHFNhRSJkknU5svFYBQdJZvZnCDFELj6MQ=;
 b=G0ySgZhDvK10bRlJEKIpEzAOrOWbVAW71cB12s2KBQBBh82w5if28/+UuwHzDNnFGHg6nyx9XRNk2cbxPZniXiQkvPT0KAEp7kXEFiXzmXdb4kOkMffWAvswGXBgLrafQsRSrj6cwGKri0+9luCHQzfGlWcQF+tVieMeumwHZQE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB14295.jpnprd01.prod.outlook.com (2603:1096:405:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:56:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:56:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7SPTPuwgAAKdoCAAASrYA==
Date: Fri, 12 Sep 2025 08:56:35 +0000
Message-ID:
 <TY3PR01MB11346F15CCED6DD68900FBF1C8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXSVtgGkv6_=ixdBOcTRFHtPxPGxKLGJtV59v4pHBBR0w@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXSVtgGkv6_=ixdBOcTRFHtPxPGxKLGJtV59v4pHBBR0w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB14295:EE_
x-ms-office365-filtering-correlation-id: db31049d-8034-48df-e499-08ddf1da470a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVBTakdiOW9QM0czbktQVDhJRUkrU1Jhem50azR5WTA0L3dFZEdEbWxnUzBL?=
 =?utf-8?B?elc1dFFlRlBXdHNQdmhkR0Jyd2lTTS9Damo0c2JiMEN2YXJiRmxQdHUrb0dH?=
 =?utf-8?B?cWRDZ0FGT0RIVWtobWQ2ZFdIN2dENWcxd3UycWZYa3Y1Qmx3d0lydnlLYTEv?=
 =?utf-8?B?dExDdWtLS0E1bXhnRDBnKzQ1SFVXeEdVemU3UGZVT2pOcWJtQXp6TjBIQmZF?=
 =?utf-8?B?ZWxSYWU0Qys1Mm9lYUdxeVI5Z2x3T2p2T29zanI1MEkzMXN0bktGUmNZeXBF?=
 =?utf-8?B?YzJoMDVFYyt5SGJaNHlPV0FlanVRWDVYelJBTU9JYm5Ia1RZVXRpTGE1YWNY?=
 =?utf-8?B?NllqdHV0SXc5STFjNDB5SEhXRTBTYklHS2hoUkhFZG5ORnJuOTE5Mk9nQmtM?=
 =?utf-8?B?SjIwTEVja1laVUY4Vk43bVZZVTRZRlFxTnVQZ1NaTGkzcWVKZFMxTGJBSHhn?=
 =?utf-8?B?b1dBZEZkc1R5NmNIYkhFT1RNZFBqcmZQVmhXelF2aFNDOVBUSVRWanZlN29i?=
 =?utf-8?B?dlRqT21RZTFOT3Z3Q3FLVmpDMnRLZnFtTThvWStvSEVjektyR3ZQdVZ4SWpw?=
 =?utf-8?B?RkozaURwRGJwQkwzWXdVNStSTURGamp5TnVkUGFyMHJRenhUeEQzQThid0Zp?=
 =?utf-8?B?d2oxeTV1YnlJbFZsRXMxak5lVFNxRDI1eFUxejQrL3VYVTdwUFBIM0dIOU1C?=
 =?utf-8?B?TDJiWmtQaFpaQjIrY1ZLaysyUmdjWjNDLzVQemRZM25tZGV5dS91a2gxaEtO?=
 =?utf-8?B?THZYVWZQWEFZSUQzZjlmbHNlT2FSaHdhUlJtOEwyUmcxSjlyaWtUY0kyNU5y?=
 =?utf-8?B?SDFvWGJvbFUwUG5OaWR4dEMyYW9tREZlOERKMWlIK21YV0R6ZEVtUEgyRWZl?=
 =?utf-8?B?bjZ1ZWhKUjRDMU45NzF5L2k0cnZNQ3dQMU1QemhNZzNJMGZIdjR2MENhRWhN?=
 =?utf-8?B?T1UrTnlMVzRObDAwUXc0bTNidHY4Vm1XckVVek1taitnZXVINzNsTnlqL2Fv?=
 =?utf-8?B?Rko4UWNvMGFHdGVPSDRuRVpRVVlLcmlUQzJpanhtVXJOcTBXaVhJNXJqelgr?=
 =?utf-8?B?MUdGWXY2elhqUnFkTVhuSEVoK1FUTDRUcWVOcy9UdmRQek1JVUI1YzRsZm42?=
 =?utf-8?B?WDlEMFNKQzJJVndCTGdhd01KR250TlNzZFlZN3BrZHExUVFXbWZIU0d6RXl3?=
 =?utf-8?B?WmVWL3RZbUZqb2pCSmEvcmhrWWNzMU9tWjRDWDNsZFdPakhrdmdQcUcwZVRV?=
 =?utf-8?B?NjFYcTdoRXlQWFVIeStSR0d4Mk1EMlVldXdpZHFNaVl0RDBBalVTSzlyMTRu?=
 =?utf-8?B?RmdpWHlYS0dobWpKNXdtUzVlQW4yRitvb2ZSTW1CczVoak5zSFJSL3lGcVhV?=
 =?utf-8?B?N1VWREI4aThXS2RSa1ZXaHVsRkdLdm1HaSs5RVE3SnpPN2UvSjhwUDFYNGpn?=
 =?utf-8?B?ZE9WM1hXd0RudGlPNFZ3K3ZtSzNqQ2lXUEZIdWRaSU15NmdIN2VJdHFadGJE?=
 =?utf-8?B?ZWo0aEx1b2VsSmdsR00xbkZoTmtYZjVXWnF0RXQ4L2s3RUQ3RHhTejFwZXdI?=
 =?utf-8?B?NFBTcTdSYlk0d1dsdHp3OGV2aUN1aVdOYUdNMDF3M01aY2puUlBjRTJLVlhJ?=
 =?utf-8?B?NEtjTGZjMU1URFBpTkh4dzNZcVNuZG1qTDVuV2cvbmtjR21BUDZGd1FaWnIz?=
 =?utf-8?B?SlBuZ1ZoZUJsZmpIZmRuTVlpSHMrRGNadHM0bW9BMUVYSG1KVENUZmU2YUZp?=
 =?utf-8?B?clRhRFI5UmM0dExoQ3RvV3J4WEF1eXB3ektud3pvYWVTTFh3TFNKZFliOGZt?=
 =?utf-8?B?N2gvQjBwenlPTE9TVjlYeVJWWm9KTDdhbU4wS3NOQTdjbkYrd1BrZzIzalFK?=
 =?utf-8?B?aXRBcHB1RDkrZzZUUVEwczJMZTNJc0N1dmJySkJBSnhuVnJDeEdpTkpENXFZ?=
 =?utf-8?B?R2lIcEVrYVJYTXIrWlA3QndObXJJditkVmlXTUVJU0J5WE9FSVkvamI0N09h?=
 =?utf-8?Q?3/fX4FMlcdW2/MAB+ziBkW1o6lyVH8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWRtczJDdklaZFQrM2dlcGxBTzErNnkyM2M4QVZSMnVzdTAxMGZSeEI2eTRB?=
 =?utf-8?B?dllHNm1Nc3dmT0l5QkNpMVRPQzhjbk9UalF6SWozQzk2UjFQb214RkpOaEQx?=
 =?utf-8?B?ZjY0N3RlVE5YRXYzZkYvVGhETzlXUFNoYXV6Kzh5ZzJiTk1KS1kvOEFqQ1Z3?=
 =?utf-8?B?Y1ppUzlGQmRGdVd6cTFVNzhueTN0Z0wyYklhMHliVVRoOE1JdldIVnBxQnJv?=
 =?utf-8?B?VS83WCtyM3Jkc1VkR3FiL3NOOElhanM4aEN3QUpmOEJjYXVNaktDbEJPVzkx?=
 =?utf-8?B?QmI4MGkvcHlkWTlHZkFEMHg1dFJsdkd5RmNVWW9FZ3YyS3o5WlZyVW1XYTl3?=
 =?utf-8?B?Qi9mM21tNWsvMERHc0l6TjdMZldnWHRQcEhKNWU3Ry9iVFMxQjN1TUtaeXg1?=
 =?utf-8?B?eEFJNlA0QlFFcGx4QVhrNUIzTU9zWEVyRWRZdERITFJ1OHFZWFhQcEl4UGd2?=
 =?utf-8?B?MmpyUnRyZFJKVnlaeGpiQVh2ZGwrMG9OWkM5azFkTzREa2htcm1TRXNGUnl1?=
 =?utf-8?B?d28vMUlHd1pxN0lMeWFpaTdNOGNDZmdyQ3FqR09DTVVIQkhXUnQxVExNS2Jj?=
 =?utf-8?B?R1ZCSXg0MEI3T2Vld1E2SjBKcXFIdzVQZXF6Q2FETW5YVDhzY250Kzc3NGho?=
 =?utf-8?B?ckJGVWQ0dkk1VUtNblkySHQ2b2U2UHlDNnkrc3VwTjk2dVZoTkMxNUpqYUFU?=
 =?utf-8?B?dWpBNXQxK1FvajQ2M0RidTdxRnM0TWRUM0ZtZkl1WkN0YmpLWkhmT0ZJQTIr?=
 =?utf-8?B?WXRyV1Vpa1pnZmQ1RmJNVjBRTTluS2hCbW9PSEhHVXFSVnRYa1k1cWVobXhx?=
 =?utf-8?B?VlJDaWpXb2JVb3VoWGUwTTR5K3VUaVhDQURTMlpsZGk0K0Q0YXFVcGMralFr?=
 =?utf-8?B?RUZ0Tjl4VktzZ1N4aUF2c0Yvdlh0WWtwbmNub3BpTWRjU2xHcnJINkRmRnNU?=
 =?utf-8?B?NkNrV1dUUHE4bFhiYVYzR2FRQUc0VVhkZ3M1MlJpTGJSQjNwTDd0VEpkSE56?=
 =?utf-8?B?dVhueUNTWWV0L1V6STlXcTZsWnVRSElxWkdZOEdacmdydllFV2Z4alpocVFH?=
 =?utf-8?B?SUxOaGhnczlmSG04S21OS09Lak5NQ1pyQ0tOUjdZSmRsWWxySlU2bU9uOVNX?=
 =?utf-8?B?eVNUWWlPRkdUSGtnU1RMTlVpZFVKTDVNM28vYmg1TzdnVnhzVXRwVDFNSm9u?=
 =?utf-8?B?eHNYUkhKWjhkdGJKenFPSFNIeU14WkJTZ1dVUjN4d09jTTFaak5wWHZTUnpP?=
 =?utf-8?B?NEt2dC96cHg4RE54UGVDK1E5MkdFOEVaaXllVEFCdVJYWlNVSjg4Rk5OVlN2?=
 =?utf-8?B?eXJFYkVPMkZRNE1uZG9GSTlwUzRDZ0RjSGVYZ0d4OEhubXBabEtCMTBEbjZP?=
 =?utf-8?B?VWFkVk4rZ2tlZUYzUXNEb09QTUFlcW9CMzdmSStDSC9zLzZmZDI2V3hWMEE5?=
 =?utf-8?B?ZzBaK2RhQy9IeEhYRVRjMEdEb2tWMWRTK3lFQjBNT2I2OCtSUGk4N2hjQjNq?=
 =?utf-8?B?SHgyN3luNk1kbHVQZXF6dENENkRWMG9DUHhtZDJ6YTlFeDBnRVh6dmdwWldi?=
 =?utf-8?B?UmF6aFBFVkE2a2VsYWFFaGxHT1AxN2hwVVF2R3NYQWlQNGIwSFhDSnpQUkMy?=
 =?utf-8?B?SmErV1dLdTMxcUxybUhHT3ZDNklJVVArTW5zZW45ZHkzaExBQVh5NnlpdXJ6?=
 =?utf-8?B?bzlVT1BGUWltUndHaFgvcHlaWW1vanZjRzErRnlpNmtnUGVEeHlqN1lVQTFn?=
 =?utf-8?B?UGVhbGZSSVlqNTR3VkowdC8zOWZWUStUeXMxNXJoQm5TVnJQU1FJQlo1a1BO?=
 =?utf-8?B?WERPYVpQUlBOUUlQV09JODJqK2QvdlhUZVFNQzJ2RnpxSDN1dkZRZUhITXFG?=
 =?utf-8?B?NFJZMXY0NktmTzhEOUU5OUx6QjF3WVhKcmVVOGh0R093c25rd1pYMTVTajJK?=
 =?utf-8?B?SjlUcTJXWUdueHVacUNYeVh0dC83U3V4Rk5GTlNrbGd0Qi81bjFrOEpxbjNl?=
 =?utf-8?B?ZmdxckJ4UFRSYUtvSjB0eGFhRFR6eHpRWEZ5WXAxc1VzRG43NU9kVElaL1k3?=
 =?utf-8?B?S3dZTTlvU0cwc3ZHS1RueTNsbU8zOW9HQUo5dlJjWUI2dzRXRDdhYlFFOUsr?=
 =?utf-8?B?eDRPNzYzSjVDdE02VjZOVC9OSE1ZNnVJUGRoS2FiRzBWWCtOejM0OWlVY1Fy?=
 =?utf-8?B?bWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db31049d-8034-48df-e499-08ddf1da470a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:56:35.3391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MRZUd6JDOQukl4vnqv0Fj8QNE7iN/NEFRpf7YMW464NBPnyPlKTPQMmmSXgal6Dqy/P3EGgnn10OKjNWB6yrZVMsRbHwXZKKZHdlv8oI5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14295

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTIgU2VwdGVtYmVy
IDIwMjUgMDk6MjcNCj4gU3ViamVjdDogUmU6IFtQQVRDSC9SRkMgNi82XSBjYW46IHJjYXJfY2Fu
ZmQ6IEFkZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24g
RnJpLCAxMiBTZXB0IDIwMjUgYXQgMDk6NTQsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4gd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+
IFNlbnQ6IDIyIEF1Z3VzdCAyMDI1IDEwOjUxDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0gvUkZDIDYv
Nl0gY2FuOiByY2FyX2NhbmZkOiBBZGQgc3VzcGVuZC9yZXN1bWUgc3VwcG9ydA0KPiA+ID4NCj4g
PiA+IE9uIFItQ2FyIEdlbjMgdXNpbmcgUFNDSSwgczJyYW0gcG93ZXJzIGRvd24gdGhlIFNvQy4g
IEFmdGVyIHJlc3VtZSwNCj4gPiA+IHRoZSBDQU4tRkQgaW50ZXJmYWNlIG5vIGxvbmdlciB3b3Jr
cy4gIFRyeWluZyB0byBicmluZyBpdCB1cCBhZ2FpbiBmYWlsczoNCj4gPiA+DQo+ID4gPiAgICAg
IyBpcCBsaW5rIHNldCBjYW4wIHVwDQo+ID4gPiAgICAgUlRORVRMSU5LIGFuc3dlcnM6IENvbm5l
Y3Rpb24gdGltZWQgb3V0DQo+ID4gPg0KPiA+ID4gICAgICMgZG1lc2cNCj4gPiA+ICAgICAuLi4N
Cj4gPiA+ICAgICBjaGFubmVsIDAgY29tbXVuaWNhdGlvbiBzdGF0ZSBmYWlsZWQNCj4gPiA+DQo+
ID4gPiBGaXggdGhpcyBieSBwb3B1bGF0aW5nIHRoZSAoY3VycmVudGx5IGVtcHR5KSBzdXNwZW5k
IGFuZCByZXN1bWUNCj4gPiA+IGNhbGxiYWNrcywgdG8gc3RvcC9zdGFydCB0aGUgaW5kaXZpZHVh
bCBDQU4tRkQgY2hhbm5lbHMsIGFuZCAoZGUpaW5pdGlhbGl6ZSB0aGUgQ0FOLUZEIGNvbnRyb2xs
ZXIuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPg0KPiA+IFRlc3RlZC1ieTogUmV2aWV3ZWQtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPg0KPiA+IFdpdGggYWRhcHRp
b24gdG8gUlovRzNFIGZvciByYW1fY2xrIFsxXQ0KPiANCj4gVGhhbmtzIQ0KPiANCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+IA0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgaW50
IHJjYXJfY2FuZmRfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4gPiA+ICsgICAgIHN0
cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
PiA+ICsgICAgIGludCBlcnI7DQo+ID4gPiArICAgICB1MzIgY2g7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICBlcnIgPSByY2FyX2NhbmZkX2dsb2JhbF9pbml0KGdwcml2KTsNCj4gPiA+ICsgICAgIGlm
IChlcnIpIHsNCj4gPiA+ICsgICAgICAgICAgICAgZGV2X2VycihkZXYsICJyY2FyX2NhbmZkX29w
ZW4oKSBmYWlsZWQgJXBlXG4iLA0KPiA+ID4gKyBFUlJfUFRSKGVycikpOw0KPiA+DQo+ID4gVHlw
bzogcmNhcl9jYW5mZF9nbG9iYWxfaW5pdA0KPiANCj4gT29wcy4uLg0KPiANCj4gPiBbMV0NCj4g
Pg0KPiA+IGJpanVAYmlqdTp+L2xpbnV4LXdvcmsvbGludXgkIGdpdCBkaWZmIGRpZmYgLS1naXQN
Cj4gPiBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGIvZHJpdmVycy9u
ZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gaW5kZXggNTdhYzkwZTU3ZjExLi5jYjM1OGE0
ZTQ5ZDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTQ2
OCw2ICs0NjgsNyBAQCBzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgew0KPiA+ICAgICAgICAgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsgICAvKiBSZXNwZWN0aXZlIHBsYXRmb3JtIGRldmlj
ZSAqLw0KPiA+ICAgICAgICAgc3RydWN0IGNsayAqY2xrcDsgICAgICAgICAgICAgICAvKiBQZXJp
cGhlcmFsIGNsb2NrICovDQo+ID4gICAgICAgICBzdHJ1Y3QgY2xrICpjYW5fY2xrOyAgICAgICAg
ICAgIC8qIGZDQU4gY2xvY2sgKi8NCj4gPiArICAgICAgIHN0cnVjdCBjbGsgKmNsa19yYW07ICAg
ICAgICAgICAgLyogQ2xvY2sgUkFNICovDQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGNoYW5u
ZWxzX21hc2s7ICAgIC8qIEVuYWJsZWQgY2hhbm5lbHMgbWFzayAqLw0KPiA+ICAgICAgICAgYm9v
bCBleHRjbGs7ICAgICAgICAgICAgICAgICAgICAvKiBDQU5GRCBvciBFeHQgY2xvY2sgKi8NCj4g
PiAgICAgICAgIGJvb2wgZmRtb2RlOyAgICAgICAgICAgICAgICAgICAgLyogQ0FOIEZEIG9yIENs
YXNzaWNhbCBDQU4gb25seSBtb2RlICovDQo+ID4gQEAgLTE5ODMsMTAgKzE5ODQsMTggQEAgc3Rh
dGljIGludCByY2FyX2NhbmZkX2dsb2JhbF9pbml0KHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAq
Z3ByaXYpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbF9yZXNldDI7DQo+ID4gICAgICAg
ICB9DQo+ID4NCj4gPiArICAgICAgIC8qIEVuYWJsZSBSQU0gY2xvY2sgKi8NCj4gPiArICAgICAg
IGVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShncHJpdi0+Y2xrX3JhbSk7DQo+ID4gKyAgICAgICBp
ZiAoZXJyKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICJmYWlsZWQgdG8gZW5hYmxlIHJhbSBjbG9jaywgZXJyb3IgJWRcbiIs
IGVycik7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZmFpbF9jbGs7DQo+ID4gKyAgICAgICB9
DQo+ID4gKw0KPiA+ICAgICAgICAgZXJyID0gcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVyKGdw
cml2KTsNCj4gPiAgICAgICAgIGlmIChlcnIpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2X2Vy
cihkZXYsICJyZXNldCBjb250cm9sbGVyIGZhaWxlZDogJXBlXG4iLCBFUlJfUFRSKGVycikpOw0K
PiA+IC0gICAgICAgICAgICAgICBnb3RvIGZhaWxfY2xrOw0KPiA+ICsgICAgICAgICAgICAgICBn
b3RvIGZhaWxfcmFtX2NsazsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgLyogQ29u
dHJvbGxlciBpbiBHbG9iYWwgcmVzZXQgJiBDaGFubmVsIHJlc2V0IG1vZGUgKi8gQEANCj4gPiAt
MjAyNiw2ICsyMDM1LDggQEAgc3RhdGljIGludCByY2FyX2NhbmZkX2dsb2JhbF9pbml0KHN0cnVj
dCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYpDQo+ID4gICAgICAgICByY2FyX2NhbmZkX2Rpc2Fi
bGVfZ2xvYmFsX2ludGVycnVwdHMoZ3ByaXYpOw0KPiA+ICBmYWlsX2NsazoNCj4gPiAgICAgICAg
IGNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gK2ZhaWxfcmFtX2NsazoN
Cj4gPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrX3JhbSk7DQo+ID4g
IGZhaWxfcmVzZXQyOg0KPiA+ICAgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoZ3ByaXYtPnJz
dGMyKTsNCj4gPiAgZmFpbF9yZXNldDE6DQo+ID4gQEAgLTIwNDUsNiArMjA1Niw3IEBAIHN0YXRp
YyB2b2lkIHJjYXJfY2FuZmRfZ2xvYmFsX2RlaW5pdChzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwg
Kmdwcml2LCBib29sDQo+IGZ1bGwpDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGNs
a19kaXNhYmxlX3VucHJlcGFyZShncHJpdi0+Y2xrcCk7DQo+ID4gKyAgICAgICBjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZ3ByaXYtPmNsa19yYW0pOw0KPiA+ICAgICAgICAgcmVzZXRfY29udHJvbF9h
c3NlcnQoZ3ByaXYtPnJzdGMyKTsNCj4gPiAgICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGdw
cml2LT5yc3RjMSk7DQo+ID4gIH0NCj4gPiBAQCAtMjE1MywxMCArMjE2NSwxMCBAQCBzdGF0aWMg
aW50IHJjYXJfY2FuZmRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
ICAgICAgICAgICAgICAgZ3ByaXYtPmV4dGNsayA9IGdwcml2LT5pbmZvLT5leHRlcm5hbF9jbGs7
DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIGNsa19yYW0gPSBkZXZtX2Nsa19nZXRf
b3B0aW9uYWxfZW5hYmxlZChkZXYsICJyYW1fY2xrIik7DQo+ID4gKyAgICAgICBncHJpdi0+Y2xr
X3JhbSA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJyYW1fY2xrIik7DQo+ID4gICAgICAg
ICBpZiAoSVNfRVJSKGNsa19yYW0pKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIoY2xrX3JhbSksDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJjYW5ub3QgZ2V0IGVuYWJsZWQgcmFtIGNsb2NrXG4iKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNhbm5vdCBnZXQgcmFtIGNsb2Nr
XG4iKTsNCj4gDQo+IEkgZ3Vlc3MgdGhpcyBzaG91bGQgYmUgZm9sZGVkIGludG8gIltQQVRDSCAz
LzZdIGNhbjogcmNhcl9jYW5mZDoNCj4gRXh0cmFjdCByY2FyX2NhbmZkX2dsb2JhbF97LGRlfWlu
aXQoKSIsIG9yIGV2ZW4gYmV0dGVyLCBpbnNlcnRlZCBhcyBhIG5ldyBwYXRjaCBiZWZvcmUgdGhh
dD8NCg0KSSBhZ3JlZSB0aGlzIGhhcyB0byBiZSBhIG5ldyBwYXRjaCBiZWZvcmUgdGhpcy4gSSB3
aWxsIHNlbmQgbmV4dCBzZXJpZXMgYmFzZWQgb24gdGhpcy4NCg0KQ2hlZXJzLA0KQmlqdQ0K

