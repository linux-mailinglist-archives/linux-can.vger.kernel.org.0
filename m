Return-Path: <linux-can+bounces-5032-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E5BA2271
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 03:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832CB323FCE
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A571A23BE;
	Fri, 26 Sep 2025 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Yg2ZbwD1"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023114.outbound.protection.outlook.com [40.107.162.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC841373;
	Fri, 26 Sep 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850517; cv=fail; b=AFopj0wmw7GVYGINgk1uerrgJdu8LqJ7fvaAbgxDffxOtfW7jIAXp9izHobVF6Ug470+0o7+YZ1MBpqqA25VcdKewHB1ZCO08BZxzLcmQIbt54Sa0h21/+EshPj1WkFeMB4sW1z9JrH4c4BnfYcvzUBwAlZ96ZxBQJonlWUs89M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850517; c=relaxed/simple;
	bh=7N8Kk05KY40NAbQHK+oWaodu4D7lrSTpm7iVxU6Mvjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUWMVxYigNDwkIqLp04ItUILLxaku+iHMxO/yjPehBFhkGu2AAal8qzKwp3XHEuUGMXBSf410HCYYXZ+WpWv4nZ4n03vVi1+tMXm/MvRUWRSrKqxmrBkjRIeuEM7yW0jokb2iP9YxbltZaOiwJHi0+9xdNNbebI9QC1MX8Hhjsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Yg2ZbwD1; arc=fail smtp.client-ip=40.107.162.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvdhe6l484YZhyEsTGDizQp/uT//OYcPGz1eTtn0zH+8tb1etzAAwHoQYdtnvHi9J8ivIDFcrD2C7MLus9/zJX5rpcsGBkR6FvH0xLUKqeRoUsWuoRc2ja2ULFbTAfRs1Y5Z8WXzZR1lZqBNdd3d8zMcYGU/xJqxgV1tAM97GZC3nZ4+nX0ZCyi9F8gvS80PETQ10suPaPRxmEsjpKJCC1kG/QVFd1JDMnPmlu5h0SCO0cRccyBKP6yoVC6ugVwn1UpkTlut9ia1ICGd31Yn5qlGMYhNQj3N30Z/PjH2+Trtb7V/7fKC2I9ZgAWxlbQEqC7MNimN2jyF3T4bog/xgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N8Kk05KY40NAbQHK+oWaodu4D7lrSTpm7iVxU6Mvjs=;
 b=VwNGil7WUB8S8CNRTd3uTCTT24GOwRJVHdYwXQl7nOI464CNui8+T5cJaHEeOx9fVypI17gCE4gTsj2zWE7BHbAWttYnZnb+GfgKlhQB9OZdSdtw4FM7toH5OAIlMxIgezF1W4mGzE4jW/r56PB6dMkw2JqvtQDNxq2oMU3KEQILFw86V2xDJBSOuuoGgX2zP5uC4QBAFqLpiNdaZFAWD/xT5ZfwmNEoe4NWk3hVVjCcE4zz+sZRI541jszBPcCM4tTpAI3wiI4u2FYjREDVp4M0o7EMBCk6hMHBwLNkuIzquOXQRMKH0F7DWCT8tysTI6gyisntAdLuv0l4t9NxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N8Kk05KY40NAbQHK+oWaodu4D7lrSTpm7iVxU6Mvjs=;
 b=Yg2ZbwD1gAwOdU2Tj3sZaoMTBsAdN2x6OyRDDeinqncLTNfqnhuWbknL4g4HtxRCioqjVEuOJtVSVU4ppHXKAP7+1Wz5GA32H3/DBCKsUrbt7vMAWtYHram2TsegNnWyQKzKnYQfyJzerBKLaoJVySlnz2mYMzpezSIBh+1oY9A=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS2PR03MB9878.eurprd03.prod.outlook.com
 (2603:10a6:20b:546::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 01:35:07 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%7]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 01:35:07 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] can: esd_usb: Add watermark handling for TX jobs
Thread-Topic: [PATCH v3 3/3] can: esd_usb: Add watermark handling for TX jobs
Thread-Index: AQHcLXj2G3O9Ap5qBEigwZCkQLr9ebSjC10AgAGlQoA=
Date: Fri, 26 Sep 2025 01:35:07 +0000
Message-ID: <1b539003186430591736552a3922c441da63a336.camel@esd.eu>
References: <20250924173035.4148131-1-stefan.maetje@esd.eu>
	 <20250924173035.4148131-4-stefan.maetje@esd.eu>
	 <20250924172720.028102e4@kernel.org>
In-Reply-To: <20250924172720.028102e4@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS2PR03MB9878:EE_
x-ms-office365-filtering-correlation-id: 86a95504-9dae-46bf-b7c6-08ddfc9ceca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGJWS1ZBK0hsT3FtcGpHSUNYOHFyWC9ickFFdnZWblFaakNjYTExT3Rpcjhi?=
 =?utf-8?B?TStQWDNGeno5dFhwV2p1SE9JUHJwTWdsN2hCMGg5NDhOcy9ObnR5YWg2OTlZ?=
 =?utf-8?B?cysyK3pFTHBxR012UGh6ZUdxa0VWajA5Zm1QWTRWREJpWWdwUFJKZGpWTzRC?=
 =?utf-8?B?RGpzNlEzUWd3aFNFcTU0bHdFU1lYR2pmbWtpUGtQRllvRmVLMFlzelJMVkZo?=
 =?utf-8?B?dEN1ajMvZ084TVdnbWN2YXBxZ2lybUxrOC9xK1VEam9iOG5FU0QyRHIxMG9D?=
 =?utf-8?B?ajBiNHB0T0ZMNUVGRWp2TXFFS1NGcmJvTEpVTTdad1dYV05jaUQwRlUzVUxi?=
 =?utf-8?B?MmZHZWdxRE9mWVJnSTBxdm1ITHh2TjRIZXdzRExSa09vNVNKR05HN3doZStl?=
 =?utf-8?B?TXJrZ0dsTnJEc0E3L1orTS9BTFErZG4rUkZqTnprZFIvSzRjVHIwYzVFRDl4?=
 =?utf-8?B?UldqWFN1dE42VXBJYndyckllZFZJNFFOTmlZTWR0NmlHajk3UzZ2anZrRkxG?=
 =?utf-8?B?eGE3WjJXNlhhTVV1RkJSRjV0ZlR4OWlsTk9CS0p4N2oyblVmVm05OHZMV1Rw?=
 =?utf-8?B?elhpdHhIQ0tlS3lQNlVzRHgxR3NHV2Q5YmRDeEsrdG9qNjMzczBGdWZFSENF?=
 =?utf-8?B?WmtEcTk3RWNGa1lreStxMVdlNTVlUWh5anBLVG51NTl4OVhZOFZ6cDdqT2tr?=
 =?utf-8?B?NUV1eTBUK1ZDTFczcEg5SHFnN2hybFp5RUFQbTZTTGpCZ3JOTUljblVmMExv?=
 =?utf-8?B?UXlFN25QMEdQNzl1NGdWUVgvbkF1ajB4N21FbXRuUnJyTFIwV3RWc2FzNGYw?=
 =?utf-8?B?Y3R2aFBGakw0bC9CcUp6b2FQRGdzUWFaSGNSc09yOUNWSkFMVXRCY1VhbElm?=
 =?utf-8?B?VEh2OWx2d1d5YTRabnpxaDJvWllIY2xZQno5R3dzNFcvMjlWWnR0aCtLSVBn?=
 =?utf-8?B?YndYVDVHWldNWmpPUW9tejZRMkpSQTFkY1NUdFJjZENISG1ZM0ZoNnZ4M1JB?=
 =?utf-8?B?T0hzaWc2OXVrMHh4VHRuYnlkdHZQNHpkRlRGcS9mcUFRQXRrc0JvSUxGdnhv?=
 =?utf-8?B?eUFualZaVmJhOGhJSGxRNGhENlM5VFZvZWRWbXZ4SjlUSDQ3YlcySnNpY1NL?=
 =?utf-8?B?T2JIMG1IUUJKeXgxdEZyZVVDM25iT3V2UGpWN2pydjAxNVNSTGVtMGZkWEpP?=
 =?utf-8?B?Z0piRzh6UlgyTm51OEU4M3VPK1duUlRoeTBPU0wrZkd1UDNnQjBMYjhTcjky?=
 =?utf-8?B?d0VZbXAzaXRMYkVzNENYVGt4TXpVb2JpeVZQRmF1dGphQ0xod1lJSFhLVXNM?=
 =?utf-8?B?Vm5lNkhIV3pOTFdBaGltdElOUWt3VThBWVdhbUE1ZXZmZ0k1OHhVQWk0eTZI?=
 =?utf-8?B?MFlqOEFxWGVLOFc2bTNNby9iVTRBTGczc29QNWJDZXpFWGdwQkVvUGxtMlh5?=
 =?utf-8?B?aksydEtXT0VEOHNMRy8zRkFpKzhQRm1ObTBwRXpScXMwdGNkSCtDUlpadDlD?=
 =?utf-8?B?ZXAvemlmSkNvMHFHTnZkS2g2cmFJL01xeW1TNlltUlVaMXUyOHpkTEtSdzlU?=
 =?utf-8?B?UjRjSUQyRGh1a1RNSCtPZE85VkFUbFBSNnR5VStUQXBtMmNVODZBQzFFWWlK?=
 =?utf-8?B?M2ZxZkh2RXVHaFZ1UGJEQlZINE1DK1Jnd0tmSkpoeUFWY1FRaElmazh2aWY1?=
 =?utf-8?B?WFM4ampLazNlTzcySmtrRGUvTmxBdHYwdTB6blVpUS90UEpIVGh1M3B3VkUz?=
 =?utf-8?B?SUdlMU1KRS9ZS0JGQUJETEVLYnhXNVNUc2J3UnU3TE1Pb1owcWF6UCtLb1Fs?=
 =?utf-8?B?aFFNVXNwZENGN01vWTZ3MWZzeFBzNzNhMnZZKzZXbGdmUldTYjdML2Rldjk5?=
 =?utf-8?B?WVRZOEdGcnpaREdkblBUbUhQYXhBQ3dXUXZXNXU0MWxCL0t2Tm9NUmNOVEhX?=
 =?utf-8?B?akM2ajQwODdMOXZQT2dhWktMcmI1ZkhqMy84enUzc0NQd3pNOTA3eXkxOHlC?=
 =?utf-8?B?TkFEVFpDS0NzRkRqdDhzakxhT2hwRjJrUDJycTZyMVlCSW1pSnlFbXlobC96?=
 =?utf-8?Q?NMVaNz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHhnTitiSDJqZjFRR0RSakFoa3ZDN3hiQTBmd0pZWHlGdzJWWktVOGc1VStq?=
 =?utf-8?B?QzJSOTRacEJtN3FheDZHcGNWb29kZFdlTGVZZElmVnM4WHh5Q1RITHgzVksx?=
 =?utf-8?B?N0o2eVd3WmNzMHBwNm82b1c2bHpCL0F5VCtndGJTeW5JWHYyMHNBNXpVcmZq?=
 =?utf-8?B?Ykp5QytYRnJNSkJjcVlsaW9mb29sdlpybW1jdE0xalNOREZpSzA3RHlUWG1P?=
 =?utf-8?B?eXQ2bHpWdzJCaXJVV0xHNlV3blN3YUJvWTdnbWpIOUZrM0cvRUpXYjJIQjRP?=
 =?utf-8?B?bUw2UWZveWRsL0xSM1Roajc5eTdndkU0QngwWDhuSDBLSnFiaWhFZjhyTXRN?=
 =?utf-8?B?U3Q1K0txOG5ETUhBc082VHkySHNwRGdWeUpQdS9ZTmN1dE5SNThXTFhHdyta?=
 =?utf-8?B?SCs5K2phWlFLK01ibTlhTlV3d2ZBSEw2aDY5aWhaWHpOcVMwUFRvaEQxSGlS?=
 =?utf-8?B?UjNqNW5ZYUg1dk1FaGcxSkVhV2hWamZ6ZElYZEpXYm11SEo3ZEQ5c1BFV0t1?=
 =?utf-8?B?MUJ4SjcwRno1WFc2MTRpaHhIRm5BQ2x0Mmh6dWVnV0pNckU4REVwclpuZjdD?=
 =?utf-8?B?UjJZWU9WeE5IK1FOckNZV0FRempSL1B5SlBvcytSOHRhNEQ1OU4vOGRlU0o3?=
 =?utf-8?B?NndZSUdhcjhqK3FSclZRek1xSi9rekE4bjVJaXFLdU42Y2dMNG5EOTh2ZTg5?=
 =?utf-8?B?Mmg3eGJveUQwcU9rT0dyTHVMWUsrMTVLR3AvSm1CTWpFMW1TM0c0aEdldmcv?=
 =?utf-8?B?NVJZQm0veW5ER0hNN1VPZmkrUHkveWZqOENHNnJFeGpSUDY4MDRrRTFqYXRD?=
 =?utf-8?B?MUI3TFVwR1FLYUViYzVlUURSeldWTnR6TVpzMmorK21XdkU1WUJxbFBUbkxq?=
 =?utf-8?B?QlBWOVNoOGg2RU5xeVlUalV2N1A2eFh2M2ZUaDg0c3pLRUxxdGNJM3R3K2pB?=
 =?utf-8?B?UnBNWlZsNTh1Q0RTT0NaYTBWcmhxeDY3d2ErWDRGS2pPaXpiZzZwN1pQTXAx?=
 =?utf-8?B?Zi9udkt4bmY4bmFnclcrcGI3RGpRcmxZVlY2anhoRU45RHpsME5ublNkdXRq?=
 =?utf-8?B?Y1pRMVRuckJCR2gwb282ZnRGSXlNb0wrS0xwWlpKZWJ4RFpKaG1jWXhwQ1Vp?=
 =?utf-8?B?dVJiU1BYSTVITFAvZTh6bFdWMGY1V051RWU1OWVsUW5RUURXUUE2VWI2OXNi?=
 =?utf-8?B?Y3ROVWJQTHluWmZIYitEeFBRWng5dTAyUklsSXQ4dmRNMXRFYk9IdGNJQnhR?=
 =?utf-8?B?SW5OcE9ES0RQOUpEaU5yNmFJOENrLzJJb2FJMlV5bkYrK1RYaG5pcnpOeWww?=
 =?utf-8?B?SUJ4eTFPNkVwNUZKOW5FKy8wQWNubVg3b2Z5QThzYWg0K3dWUDZPU3FiT3lL?=
 =?utf-8?B?K1IvS3ZtajgwaVBtTk1saEIrVW1KeE1HQjcvY1ZoRmppZzZKZHg1M1JXMnJH?=
 =?utf-8?B?M1NVM2RTYys3NU94Wk0xaWQyZkMwZEg0ckdXbnR3OTlFdmNnZVAxbm9wV2xv?=
 =?utf-8?B?QVlTOFRaYnJGT1RUZDBobkUzcFdSNWVQU0ZCckNtTi9SOHdGR2NmcFFPQ3dF?=
 =?utf-8?B?cWdYUFlPcHR4VTZrRGpYYmYwdGxNbmxEUE9rNlJFT2JKYlYvUWhIZEt1TG1o?=
 =?utf-8?B?ZWYvRkxVZzEzdThFYVhRQVBwUmxjOTU1TFhNaTg3Z3BiTjhhWXc5OXZ3L296?=
 =?utf-8?B?eUhVOWVHbExGSmJlOVdrYnBaUVo0WWFpYzY4V21mOG5TNGZ4VEgyTGQ1Ukt0?=
 =?utf-8?B?cWhUQ2h0bkszd0lIekk3aEJZbi93YWpINEF3SjU0cXNJMkFSdXVuSytmSTdl?=
 =?utf-8?B?RkVxam05OVBFTDMwV3djQjJBTDBKMFdMZmxadFhDOHlCZEx6L3JVRnF0UElV?=
 =?utf-8?B?MUltUUF0S0crY203R1hLMm9tS0ZJelZCcGF3cnNmK2prcDdXcytzV3RNN3c1?=
 =?utf-8?B?Q1g2c2FGbzhwaXZIeWNNK1pyTElBc2VqUEFnNjZUM0IzS2p4R2kyTzNpbVNB?=
 =?utf-8?B?UU15bEorMzFRVWNuT0QvV1paNjIvUDlXZUhPKzlOVEVORmcyMHgxdjI2dVhU?=
 =?utf-8?B?V3gzd3Z5ZG9ZRFdCSjNuZzVTZm1oejVXdzUvSkNjWnJDTUhCU1pNaEJFK0t2?=
 =?utf-8?B?akdwZjRieWVGOW5VMjFySU01SCsvd3dlaytKMmZUdkNtL3JhcXZ0T2FSNXd3?=
 =?utf-8?Q?2WM1eUSiOr+mV/Eha5i1YUOtQdcNIfYnrcuLlIEQDgLQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA2B8D40CC28C449BA7E8D18DDB76F7F@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a95504-9dae-46bf-b7c6-08ddfc9ceca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 01:35:07.1396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Pn7rf3wyMocEaiIXOCfn4r//kh7Km3glYTE6sYnWyyy9v572/wkzKbLeX8Y4uXRDHK5nv/8jWxkBWjbFvHlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9878

QW0gTWl0dHdvY2gsIGRlbSAyNC4wOS4yMDI1IHVtIDE3OjI3IC0wNzAwIHNjaHJpZWIgSmFrdWIg
S2ljaW5za2k6DQo+IE9uIFdlZCwgMjQgU2VwIDIwMjUgMTk6MzA6MzUgKzAyMDAgU3RlZmFuIE3D
pHRqZSB3cm90ZToNCj4gPiBUaGUgZHJpdmVyIHRyaWVkIHRvIGtlZXAgYXMgbXVjaCBDQU4gZnJh
bWVzIGFzIHBvc3NpYmxlIHN1Ym1pdHRlZCB0byB0aGUNCj4gPiBVU0IgZGV2aWNlIChFU0RfVVNC
X01BWF9UWF9VUkJTKS4gVGhpcyBoYXMgbGVkIHRvIG9jY2FzaW9uYWwgIk5vIGZyZWUNCj4gPiBj
b250ZXh0IiBlcnJvciBtZXNzYWdlcyBpbiBoaWdoIGxvYWQgc2l0dWF0aW9ucyBsaWtlIHdpdGgN
Cj4gPiAiY2FuZ2VuIC1nIDAgLXAgMTAgY2FuWCIuDQo+IA0KPiBJIGdyZXBwZWQgZm9yICJObyBm
cmVlIGNvbnRleHQiIDopIHBlcmhhcHMgdXNlIHRoZSBvbGQgbWVzc2FnZSBmcm9tDQo+IGJlZm9y
ZSB0aGUgcHJldmlvdXMgcGF0Y2gsIHNvIHRoYXQgdXNlcnMgd2hvIHNlZSB0aG9zZSBpbiB0aGUg
bG9ncw0KPiBjYW4gY29ycmVsYXRlIHdpdGggdGhpcyBwYXRjaCBiZXR0ZXI/DQoNCkkgY291bGQg
Y2hhbmdlIHRoZSBtZXNzYWdlIGJhY2sgdG8gY29udGFpbiAiY291bGRuJ3QgZmluZCBmcmVlIGNv
bnRleHQiDQphZ2Fpbi4NCg0KPiA+IE5vdyBjYWxsIG5ldGlmX3N0b3BfcXVldWUoKSBhbHJlYWR5
IGlmIHRoZSBudW1iZXIgb2YgYWN0aXZlIGpvYnMNCj4gPiByZWFjaGVzIEVTRF9VU0JfVFhfVVJC
U19ISV9XTSB3aGljaCBpcyA8IEVTRF9VU0JfTUFYX1RYX1VSQlMuIFRoZQ0KPiA+IG5ldGlmX3N0
YXJ0X3F1ZXVlKCkgaXMgY2FsbGVkIGluIGVzZF91c2JfdHhfZG9uZV9tc2coKSBvbmx5IGlmIHRo
ZQ0KPiA+IG51bWJlciBvZiBhY3RpdmUgam9icyBpcyA8PSBFU0RfVVNCX1RYX1VSQlNfTE9fV00u
DQo+ID4gDQo+ID4gVGhpcyBjaGFuZ2UgZWxpbWluYXRlcyB0aGUgb2NjYXNpb25hbCBlcnJvciBt
ZXNzYWdlcyBhbmQgc2lnbmlmaWNhbnRseQ0KPiA+IHJlZHVjZXMgdGhlIG51bWJlciBvZiBjYWxs
cyB0byBuZXRpZl9zdGFydF9xdWV1ZSgpIGFuZA0KPiA+IG5ldGlmX3N0b3BfcXVldWUoKS4NCj4g
PiANCj4gPiBUaGUgd2F0ZXJtYXJrIGxpbWl0cyBoYXZlIGJlZW4gY2hvc2VuIHdpdGggdGhlIENB
Ti1VU0IvTWljcm8gaW4gbWluZCB0bw0KPiA+IG5vdCB0byBjb21wcm9taXNlIGl0cyBUWCB0aHJv
dWdocHV0LiBUaGlzIGRldmljZSBpcyBydW5uaW5nIG9uIFVTQiAxLjENCj4gPiBvbmx5IHdpdGgg
aXRzIDFtcyBVU0IgcG9sbGluZyBjeWNsZSB3aGVyZSBhIEVTRF9VU0JfVFhfVVJCU19MT19XTQ0K
PiA+IHZhbHVlIGJlbG93IDkgZGVjcmVhc2VzIHRoZSBUWCB0aHJvdWdocHV0Lg0KPiANCj4gPiAt
wqDCoMKgwqDCoMKgwqBuZXRpZl93YWtlX3F1ZXVlKG5ldGRldik7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgaWYgKGF0b21pY19yZWFkKCZwcml2LT5hY3RpdmVfdHhfam9icykgPD0gRVNEX1VTQl9UWF9V
UkJTX0xPX1dNKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZXRpZl93YWtl
X3F1ZXVlKG5ldGRldik7DQo+ID4gwqB9DQo+IA0KPiA+IC3CoMKgwqDCoMKgwqDCoC8qIFNsb3cg
ZG93biB0eCBwYXRoICovDQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGF0b21pY19yZWFkKCZwcml2
LT5hY3RpdmVfdHhfam9icykgPj0gRVNEX1VTQl9NQVhfVFhfVVJCUykNCj4gPiArwqDCoMKgwqDC
oMKgwqAvKiBTbG93IGRvd24gVFggcGF0aCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChhdG9t
aWNfcmVhZCgmcHJpdi0+YWN0aXZlX3R4X2pvYnMpID49IEVTRF9VU0JfVFhfVVJCU19ISV9XTSkN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5ldGlmX3N0b3BfcXVldWUobmV0
ZGV2KTsNCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSB1c2Jfc3VibWl0X3VyYih1
cmIsIEdGUF9BVE9NSUMpOw0KPiANCj4gSSBkb24ndCBrbm93IG11Y2ggYWJvdXQgVVNCLiBJcyB0
aGVyZSBzb21lIGxvY2tpbmcgdGhhdCBtYWtlcyB0aGlzIG5vdA0KPiByYWN5PyBJIHJlY29tbWVu
ZCB1c2luZyB0aGUgbWFjcm9zIGZyb20gbmV0L25ldGRldl9xdWV1ZXMuaCBsaWtlDQo+IG5ldGlm
X3R4cV9tYXliZV9zdG9wKCkgdGhlIHJlLWNoZWNraW5nIG9uIG9uZSBzaWRlIGlzIGtleS4NCg0K
V2hlbiBJIHdhcyBjaGFuZ2luZyB0aGUgY29kZSBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0
aGF0IHRoZSBhdG9taWNfeHh4KCkNCmZ1bmN0aW9ucyB3b3VsZCBkbyBzb21lIG1lbW9yeSBiYXJy
aWVyIHN0dWZmIHRvIG1ha2Ugb3RoZXIgQ1BVcyBzZWUgdGhlDQpyZXN1bHRzLiANCg0KVGhpcyB3
YXMgYmVjYXVzZSBzb21lIG90aGVyIFVTQiBDQU4gZHJpdmVycyB1c2UgdmVyeSBzaW1pbGFyIGNv
ZGUgc25pcHBldHMNCnRvIGNvdW50IHRoZWlyIGFjdGl2ZSBUWCBqb2JzIGluIGZsaWdodCAodGhl
IGdyYW5kcGFyZW50IHNlZW1zIHRvIGJlIGVtc191c2IuYywNCm90aGVyczogZ3NfdXNiLmMsIHVz
Yl84ZGV2LmMpLCBidXQgdGhleSBhbHdheXMgc2VlbSB0byBjYWxsIG5ldGlmX3dha2VfcXVldWUo
KQ0KdW5jb25kaXRpb25hbGx5Lg0KDQpUaGUgb3JpZ2luYWwgY29kZSBjYWxsZWQgbmV0aWZfc3Rv
cF9xdWV1ZSgpIHVuZGVyIHRoZSBjb25kaXRpb27CoA0KImlmIChhdG9taWNfcmVhZCgmcHJpdi0+
YWN0aXZlX3R4X2pvYnMpID49IEVTRF9VU0JfTUFYX1RYX1VSQlMpIi4gQnV0IHRoaXMNCmNvdWxk
IGxlYWQgdG8gdGhlICJjb3VsZG4ndCBmaW5kIGZyZWUgY29udGV4dCIuIEkgYXNzdW1lIHRoaXMg
aGFwcGVuZWQgaWYNCnRoZSBjYWxsYmFjayBoYW5kbGVyIGNhbGxlZCBuZXRpZl93YWtlX3F1ZXVl
KCkgdmlhIGVzZF91c2JfdHhfZG9uZV9tc2coKQ0KYWZ0ZXIgdGhlIGNvbmRpdGlvbiBjaGVjayB3
aXRoIG5ldHdvcmsgbGF5ZXIgc3RpbGwgaW4gdGhlIHN0YXJ0X3htaXQoKQ0Kcm91dGluZS4gU28g
dGhlIG5ldHdvcmsgbGF5ZXIgd291bGQgdHJ5IHRvIHhtaXQgdGhlIG5leHQgc2tiLg0KDQpJIGNo
YW5nZWQgdGhlcmVmb3JlIHRoZSBzdG9wIGNvbmRpdGlvbiB0byA+PSBFU0RfVVNCX1RYX1VSQlNf
SElfV00gd2hpY2ggaXMNCnNtYWxsZXIgdGhhbiBFU0RfVVNCX01BWF9UWF9VUkJTIHNvIHRoZXJl
IGlzIHN0aWxsIGF0IGxlYXN0IG9uZSBUWCBjb250ZXh0DQpmcmVlIGFmdGVyIHN0b3BwaW5nIHRo
YXQgd2lsbCBoYW5kbGUgYW4gIm92ZXJzaG9vdCIgdHJhbnNtaXQuDQoNCk9uIHRoZSB3YWtlIHNp
ZGUgaW4gZXNkX3VzYl90eF9kb25lX21zZygpIGlmIHdlIHdvdWxkIG5vdCBzZWUgdGhlIGluY3Jl
bWVudA0KYW5kIGFyZSBzdGlsbCB1bmRlciBFU0RfVVNCX1RYX1VSQlNfTE9fV00gb25seSBleGNl
c3MgY2FsbHMgdG8NCm5ldGlmX3dha2VfcXVldWUoKSB3b3VsZCBiZSBnZW5lcmF0ZWQuIEFuZCBl
YWNoIGNhbGwgb2YgZXNkX3VzYl90eF9kb25lX21zZygpDQp3b3VsZCBkZWNyZW1lbnQgdGhlIHR4
X2FjdGl2ZV9qb2JzIGJyaW5naW5nIHRoaXMgZG93bi4NCg0KQXQgdGhlIG1vbWVudCBJIGNhbid0
IHNlZSBjbGVhcmx5IHRoZSBpbXBhY3Qgb2YgYSByYWNlIGNvbmRpdGlvbi4gV2hhdCBJIGNhbg0K
aW1hZ2luZSBpcyB0aGF0IHRoZSAib3RoZXIgc2lkZSIgZG9lc24ndCBzZWUgdGhlIGNoYW5nZXMg
ZG9uZSB3aXRoIGF0b21pY19pbmMoKQ0KYW5kIGF0b21pY19kZWMoKSBtYWtpbmcgYSByZWFjdGlv
biBvbiBjaGFuZ2VzIG9mIHRoZSAib3RoZXIgc2lkZSIgdG9vIGxhdGUuDQoNCkF2b2lkIHRoaXMg
SSBjb3VsZCBjaGFuZ2UgdGhlIGNvZGUgdG8gc29tZXRoaW5nIGxpa2U6DQoNCnN0YXRpYyB2b2lk
IGVzZF91c2JfdHhfZG9uZV9tc2coc3RydWN0IGVzZF91c2JfbmV0X3ByaXYgKnByaXYsDQoJCQkJ
dW5pb24gZXNkX3VzYl9tc2cgKm1zZykNCnsNCjoNCjoNCgkvKiBSZWxlYXNlIGNvbnRleHQgKi8N
Cgljb250ZXh0LT5lY2hvX2luZGV4ID0gRVNEX1VTQl9NQVhfVFhfVVJCUzsNCglhdG9taWNfZGVj
KCZwcml2LT5hY3RpdmVfdHhfam9icyk7DQoJc21wX21iX19hZnRlcl9hdG9taWMoKTsNCg0KCWlm
ICghbmV0aWZfZGV2aWNlX3ByZXNlbnQobmV0ZGV2KSkNCgkJcmV0dXJuOw0KDQoJaWYgKGF0b21p
Y19yZWFkKCZwcml2LT5hY3RpdmVfdHhfam9icykgPD0gRVNEX1VTQl9UWF9VUkJTX0xPX1dNKQ0K
CQluZXRpZl93YWtlX3F1ZXVlKG5ldGRldik7DQp9DQoNCg0KYW5kIGluIHRoZSBlc2RfdXNiX3N0
YXJ0X3htaXQoKSBmdW5jdGlvbjoNCg0KOg0KOg0KCWF0b21pY19pbmMoJnByaXYtPmFjdGl2ZV90
eF9qb2JzKTsNCglzbXBfbWJfX2FmdGVyX2F0b21pYygpOw0KDQoJLyogU2xvdyBkb3duIFRYIHBh
dGggKi8NCglpZiAoYXRvbWljX3JlYWQoJnByaXYtPmFjdGl2ZV90eF9qb2JzKSA+PSBFU0RfVVNC
X1RYX1VSQlNfSElfV00pDQoJCW5ldGlmX3N0b3BfcXVldWUobmV0ZGV2KTsNCg0KCWVyciA9IHVz
Yl9zdWJtaXRfdXJiKHVyYiwgR0ZQX0FUT01JQyk7DQo6DQo6DQoNCk5vdCBmaW5kaW5nIGFueSBp
c3N1ZXMgd2l0aCB0aGUgcHVibGlzaGVkIHBhdGNoIG1heSBiZSBhIHNpZGUgZWZmZWN0IG9mIA0K
dGVzdGluZyBtYWlubHkgb24geDg2IHdoZXJlIHRoZSBzbXBfbWJfX2FmdGVyX2F0b21pYygpIGZ1
bmN0aW9uIGlzIGVtcHR5Lg0KDQpVc2luZyB0aGUgbmV0aWZfdHhxX21heWJlX3N0b3AoKSAvIG5l
dGlmX3R4cV9jb21wbGV0ZWRfd2FrZSgpIHBhaXIgc2VlbQ0Kbm90IHRoZSByaWdodCB0aGluZyBm
b3IgbWUgYmVjYXVzZSBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGNvZGUgY29tcGxldGVseQ0KYW5k
IHRoZSBuZXRpZl90eHFfY29tcGxldGVkX3dha2UoKSBzaG91bGQgb25seSBjYWxsZWQgZnJvbSBO
QVBJIHBvbGwNCmNvbnRleHQgd2hlcmUgSSB3b3VsZCBuZWVkIHRvIGNhbGwgaXQgZnJvbSB0aGUg
VVNCIGNhbGxiYWNrIGhhbmRsZXINCnBvc3NpYmx5IG9uIElSUSBsZXZlbC4NCg0KSG93IHRvIHBy
b2NlZWQgbm93Pw0KDQpCZXN0IHJlZ2FyZHMsDQogICAgU3RlZmFuIE3DpHRqZQ0KDQo=

