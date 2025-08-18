Return-Path: <linux-can+bounces-4257-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80FB2A18A
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2966617133E
	for <lists+linux-can@lfdr.de>; Mon, 18 Aug 2025 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4A2264B2;
	Mon, 18 Aug 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="E1yZvJNR"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020137.outbound.protection.outlook.com [52.101.69.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21518E377;
	Mon, 18 Aug 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519689; cv=fail; b=bSdndIpvSIptj6ZNM6U35RlPRCEFn9tXPpNL5rWLjIOR6NslotcvATkUNPsRoygd/w8/JIKDk8yFNH0IBOgrMKUg9WQ1tTYaRQY6HCgWJUxavA9pb2iyt5S98N2uhAsLZnwarmzChRQd0ezijfZb6KYmWZJ9byyfiHl8AYdY4Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519689; c=relaxed/simple;
	bh=wnzJhH4e0YTNxkQcyuMozMFNSF9o51War1bS516EmYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aOyrPEajmVCveLo/IHSGwiwTLl5Q7uZxFP7XdXKTNFJqTgIS/4W5rBABuGY772Z2ayppFcyJ4x9SrfI7urHkeeEbQcugRf07iw0mx0wWCksWTfXR7tQbRkHkASaWCGOpNsNcKwogDw2o+kuH83kXTzzUXMI44AW/D8BJtzaxBto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=E1yZvJNR; arc=fail smtp.client-ip=52.101.69.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUJnSMjzqwnMjSwBmSvNdQAHtttOwKuCMLQX656nDbcbZJGjcKDSVulCOSuSN5l/n/X0+k5NgV3bCVzKkJ9jMPZkJItbSJQFdtIGiE3pyRuIR+a5cBqBo/ML05nI91u1/93DWqtqmnKc6i3ZHnHcbUqLiDZAHAaZs+0LCRjQ33KBvx5z9bg5+27maebHOBegjMMSe5Da/CUybxVh6RVom1XR2XXeFGHwkgcfIXKAUKR5Ig32LB/RThf6LS+GUMOK4KRN8KTRSt8oYYuAMJFqm6HMZxx/xyEGHSmnKoPAE8afdbAnyVLL/MuzmK0gWSRIL6XkvAO1TFi9bKk66TM3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnzJhH4e0YTNxkQcyuMozMFNSF9o51War1bS516EmYo=;
 b=IXqR91KsJExPSNxjlqzW2wf1DPJpo8fPgl5nTG3OD9fLAaecuWDhqN02VnpjHNfAGVQ1u7HONSVyZsWzI6RmZZ8GnynT2tL8ZvCDWDj2bwqg2qYI8CBW975c4B1AiCWr+UB+RppfaU1RWKVu3eh6IBcUuXB+1gGZAIPVMUdnm2C+BJQ8G8ZA7I2VIcSvSWTWIf23Is1hSDHr5FutzjIgzbfCX6nkVUnSf2NRHe/MaJYDMPfNwDiPIO0bvXza+HpMoPvrJ5ugyBx9M46fFmckyWitrjuZd2+UYy0zThx0Zrxy+tWcU3f2qUofGy/RE/2gHrIQg1ySgU8SUg4oYwvbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnzJhH4e0YTNxkQcyuMozMFNSF9o51War1bS516EmYo=;
 b=E1yZvJNRw82UWJuzdeBhQVHqi5O6aIa4Tp/qnG8ve52mOj+5ARZfVr5eE0+0PtmrYSiXgbW1J8Q22nKZWtQ5MX3AHnTY61gw/fhr+F28y++V8l4C9ZxBiSKpPzJlx5fBz1mrszaTa2cZ24L7pSI/QmzNg6sCQYh4t9oMWwBxba4=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by PA6PR03MB10572.eurprd03.prod.outlook.com
 (2603:10a6:102:3cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:21:23 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:21:23 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mailho@kernel.org"
	<mailho@kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 5/6] can: esd_usb: Rework display of error messages
Thread-Topic: [PATCH 5/6] can: esd_usb: Rework display of error messages
Thread-Index: AQHcCwPGb9lMS595kEqtR8pFLm8fNLRgPd+AgAHemYCABkK3AA==
Date: Mon, 18 Aug 2025 12:21:23 +0000
Message-ID: <781debe349bbb7b757038ddbef9fbea5b5efae89.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-6-stefan.maetje@esd.eu>
	 <20250813-small-pampas-deer-ca14d9-mkl@pengutronix.de>
	 <20250814-uncovered-debonair-porpoise-28f516-mkl@pengutronix.de>
In-Reply-To: <20250814-uncovered-debonair-porpoise-28f516-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|PA6PR03MB10572:EE_
x-ms-office365-filtering-correlation-id: fcfbde51-37a9-4653-8e51-08ddde51bef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEcwd0R4TWhzaFh3cTFDQ0Q1Qml1elloOXMzUUZLTjdVeU9GNGJrQ0tlUUlX?=
 =?utf-8?B?QSsycUZZTG1GM2JjdFcySWFWSnhUNUV3dTB2RDVVS2VKS2E4NTRiWWYySyty?=
 =?utf-8?B?NWY5ZFNVOGNTMW02cFlKaUlEL2xxdUlHMlVtMmJtaStESUJPUjQ0QldrWnA1?=
 =?utf-8?B?dVRuQWhtaUgvcngydUdHK21vU0lTSklhWFJTUmhwRHdvQlVtektGRTdEVDRE?=
 =?utf-8?B?SkF3Rk5US1FVOXdhY2syRjBYVTFBQ3ZlUk5hSlF6TU5SUGVrVnpuK29yOUZR?=
 =?utf-8?B?VVY3SHU5bmxxMm1obHJ0RzJ6eFNnZVF3MzdsU3dsNXcrT1BRRUY5aE5VbkhH?=
 =?utf-8?B?eGpwVFprc2tub1pmSityMjl4SGlWa2NLZktoR0JEZ2lCWThGSStBSVkwVytz?=
 =?utf-8?B?bHE1bFViRzBBMmlIdjVhejFSbFJPMVVPZlh1SzdJL1UzOTVBQUczY1NZWFlR?=
 =?utf-8?B?Y1E2VGFLOVNlWFh2dDhYZWFJcTNzSVJyMnpyeWJGOUZrT25yd3JpV2JkWURn?=
 =?utf-8?B?SnN6VUY5QXdXbmNoRW42ZGxkTkJyS1V2bEFqVU93VmplQ21WVXh6djdGTWdm?=
 =?utf-8?B?K1pjV1B4YTVuMU85SVhYa09RcUVvZkthc0JtTXJNTlJqaWRxeTV4ekdBekFj?=
 =?utf-8?B?N1YvT3gxQjdrSG1Zek1iSEtna3llbUFuanZ1S2JDQkVGYWF6TTdoYzNHZ3ZR?=
 =?utf-8?B?ZXJBNm91MTVsa1h4M2d0NkJ6cGlTU3Nra2ZnRHNGK3gvTHBDZHQ0aEhIRXJr?=
 =?utf-8?B?MEIra21KdWw1bytIUk5hUnJlSk1FbkFFNVJvUkkwYnJMVjNwcXhHODNjRnJw?=
 =?utf-8?B?R1ZaU2JBVUpTT3NnUEx5YUdUSjIvSmNDNCtTUzRmSTNxWkhZNFpLRHV6YzlP?=
 =?utf-8?B?VnFPdi84SEV0RXZTNUZRVHFFK1h5ZkFJbFVXb1Z0UGNoVXhhcGpkOEdXbnpS?=
 =?utf-8?B?R0RNL1FJdmZmQmhkeW05bmlzTlFWMSsxcUU4aE1ybTdwZm9VaVNYalUvSS9i?=
 =?utf-8?B?WDc4Qys1U1JGRTlUMzA2MkVkTUNPTXdJaWZiaXlvaTRibnZzWHpwSFpENkRD?=
 =?utf-8?B?Q2VWb3pQQWZ0MUFobVdvODI0N0x6NjRvRmRwVEtSZmx6Y3p5c20xSkxZNjN3?=
 =?utf-8?B?SzdkY1FPOWE4NEFpVkFuemxvRDhIeDE4VFZSbHFGTnN0L1lKT3owOUFmWXBT?=
 =?utf-8?B?ZU9Eb0dtenhLd3o1NGh5bW1EZnpBbTFDb0R6a2dBWW9BUTRzQ0crbDZlQTNS?=
 =?utf-8?B?UzB0SkphSUFOQTZJbUs4d0trTlZYZnEzUGxpZUtMZnBQRGhoM1lHZExYZHgy?=
 =?utf-8?B?RFRJNnhFN2FVRmpMbjRxaTlUTTVQWkdKaTNEeURnZTNwamlpd01HSmwxZGpQ?=
 =?utf-8?B?VnpxYXpFcTRPOGs2dkZrUUpBT0Nkc3BDTmMvaDlBNWthbGllM0grRG5lMUhH?=
 =?utf-8?B?VllzaDVxaWVoRWszSDZxUC9jZHQrT1ZoelFrcDczUFV4Z1ZJdi9ld0FBTjR5?=
 =?utf-8?B?OStNOVJJTDFuN3VISVJmd1Mvck9OZEZFWXlJTlBrN0w5cmFFejN4TkJudnRD?=
 =?utf-8?B?VGVsb2tVTDNEK3ZYN1JsR1daRjNDczdUSGJWSGNqcG1QSTdpZzR4eXJUbjJZ?=
 =?utf-8?B?UjN4NGw3Tkl0cmJmcklzZGN6ckROM2F3WUlSenAwWEQxUzFmVS82cGl6bzZ4?=
 =?utf-8?B?VmdWVTh1VmsxTnZtdnVUcTVobHVqUks3Q2IwL0NncDQzeUFnZGI3dUJRbkwy?=
 =?utf-8?B?Sy8rY0VGOGRjMmd3ZDhacmg4REpKSDFiRmd5UTE0RU8vbkkvWGo4Y3NsOXVi?=
 =?utf-8?B?R2JBaGgrRWNzVE50TTdtVWo1TEtSVGpPSzBqMndvekt2ckV3YWRzRFFHQ3JZ?=
 =?utf-8?B?STM2NFhXYTgybCtpVWFtT1lzTzI4WnhPRzFhYlYvcHpUbVRJYmRtOXNXZE80?=
 =?utf-8?B?QXhaVHZUdFJ2RnZmVmZKVUdUYlBmaWwvMjcyUEVaU09ZR0poUUZ1YzVKaUIr?=
 =?utf-8?B?MEovQnczL253PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmlFS3VPejdzUWdxcm94UWZnRkR5c2ZmbXlOQUpMZndhQ2MwbGtWZFM3RDJ3?=
 =?utf-8?B?MUx1bEhFemNBS1o4QnBBU2JtRTZvamxUQmxpaDhwN1o0K2dxRHppbjJIVGNC?=
 =?utf-8?B?cmJad3JiRUxYbXB3L1NsQUN1aVhNY1VWT2licVBOTWdldUdxVlJpQ2xHRVBX?=
 =?utf-8?B?ZWUwSmU2MVFPOTRxaG5UbkJGNnN5dVY1THNpQmpwNXJKZWFZaWF2ak1YN1R0?=
 =?utf-8?B?YStTRGRiYTlaVVN6TzUrSUxYRDhBcklIc3d2RnlSZFEyNEVPRDczaklYOEJR?=
 =?utf-8?B?cTdzZlBRaWpFVytVeUllbXRYcEdwclpkcHVFMW5vY0xKL2VvUHlSd1IyTUpH?=
 =?utf-8?B?aDVmMnlFL1FPUGd3RFlXbTdWSlJldkhpdFNnQ3RURys3QzM3ekZxTGFTRDRj?=
 =?utf-8?B?REJ1bUhwWmFQQU5BbXUrNnJpUXdJSUpETFp5TkVBeFFJeGFRd3JhVEZSU3R5?=
 =?utf-8?B?WXVnZE9lTmJpSWkzT2kxbTBxSEN2ZFd3VFBLaUQwY3VqbUFwdTl2NnVOM1Nu?=
 =?utf-8?B?ZU0vTzdNalNZQ09UaEdWanRpTHFEVXVMczlRT0VuanQ4SXFnQmZGRHViWUs1?=
 =?utf-8?B?ZTY0MTFVdWpNd0Z5Q2FEWWVYSFFhTGV4SEJkbHd5YnRxMHhIV1g4NENzV3hV?=
 =?utf-8?B?S2RYMHVCSmp4cFJPU3JTTHRyckFXSWhvSTh1RmhCdnlRZXN3cUhFaElZbTE4?=
 =?utf-8?B?ZDE0cnpKTFVxTk1BcVJYSUZaK1hHUnlXOTIvWlZ0Ym1UckdTMm1LMU9nd1dH?=
 =?utf-8?B?ajJENCtSNFZkOEJIM1ZYajR0MUtVSnVuLzZ4MVpnd2ZuekdmUENzTjhHQmN6?=
 =?utf-8?B?ZHV4VnNjSDVsdTF3TlFIaitJSThJbXFpeGoyUEk5cGhFbDEzK1paQXpNeHM5?=
 =?utf-8?B?NjFRUFBibFlOZFo0UWlJM2JGTEN0anZCS0NyZ2FJNW94UW5XZDh4QnNrV016?=
 =?utf-8?B?VHhwZ3RmOVFlc2JlVFlqY0VWSm00VTl3d3U4YXU5NXByK001bVZQWFRDK0NF?=
 =?utf-8?B?eTVBTVBFWmxaTFI4RitqNDkxUzByMm43QnhwYUNrMnB2ZHI5Y09JY0JsZ1hx?=
 =?utf-8?B?RjBDZTdSS2xFVC9tZms0bmZCTHVUZm10dWRzcFRIK1hhcmtzamJNV2c4aDZG?=
 =?utf-8?B?L2pqVGxNSE9iN3RLZ29IbE9UaHZJa3ZsOFI2L01LbWlNMy9TTGxiYVVoR0Zz?=
 =?utf-8?B?YWNkTzBaVlZEZFBZUUlCcit2UVZrMUJTTS9PVzhqay9GbXRaM0ZIUU14UmJu?=
 =?utf-8?B?L3dqbzJCbkFDMTc5cUxVeFhqSzRFWDlDQTM1aGpLTWpXVTlUSmU4a0N0S0Nu?=
 =?utf-8?B?N0Q0dHdtSHlXNUhTWDd4L2ZrSXBCWklIem1VV1R3RWlCZVNIL24wWnJiNnZO?=
 =?utf-8?B?VUF5Vjh0ME9Lb0U5OGt2WkwvL3VnV1ZuZTBJVG1NcmtYb1dVOVJ5QTBiNTJx?=
 =?utf-8?B?ei9NV2NMcUZrOUFRVjhyOVY0U2VFTlZDYkxJVmNXZnE4NXRPYmppaVRhZzJF?=
 =?utf-8?B?R1RqcnNuWnd4Z01QL1RJcmtiaW9xM3BMdFR6aGg2Um9UV2RGa282ck9TY2pk?=
 =?utf-8?B?WTJLaEFPZ3ZSVFB2TU5sVXJWNGM4Z2VUU2d4L0lYRWRvcHk2N29JWGZSLys3?=
 =?utf-8?B?UTF6R2tlcXlYaVZzdndqQmtKelBYT1NwN3ZTRHJiTnpPQVR2TjhQV0hTeVJP?=
 =?utf-8?B?dWJ2L0p5dE1hTjVYY1BiM2Fwa0Mwc20zS3cwMk9DM3BYRnJLU3lXZXJsQUI2?=
 =?utf-8?B?SnZtWVlTSTRNWklJdDZTM253TzAvUzBJVmRSc0hOMXZRZmhIUjA3MTdFOFJU?=
 =?utf-8?B?YURUMHVFbC9aODhEN0hEcGEwb3Z2a0ZMNWlzcnNnV1pXMkNLUVBleVNhVXcw?=
 =?utf-8?B?MHRWVzV4S3AxM3ZhWDRVdEpGd0grdDFpVTB6VUFQbXBEMVFpb3J1bzlxczVO?=
 =?utf-8?B?YVkwR3YvRDdvcUxMd2ZFNnQ5TXpJa2dFSy83OVdTMnJ1anZuaktEQWVLOWQw?=
 =?utf-8?B?V1M2cEwweU1Ca25PRlZkMVh2QUFFRjlOc2FtSWtzYVRycTFHS3J4N2JiSVZO?=
 =?utf-8?B?MG5rMGJ0WFhQQ2FMT0w0NUpXbVB4bGd6MDVRbVRqSFczNStha2VZVzV0NDFX?=
 =?utf-8?B?VGgwK0FuaUx1NTIvazBzRkNPK2FiOURKYnFCRnB4Qk9mdzUrc0pLa1NOUVZy?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB451B6E22C374E9F5611777113C63C@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfbde51-37a9-4653-8e51-08ddde51bef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 12:21:23.3541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NViQdmdqpxqiNkIuy5RC3ct0y+Da8FjgWb3B2wZZtjbeRUzzBCzP6yD7IoyoHNPNfFAEvLBKyFHLH1Jgd4R9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10572

QW0gRG9ubmVyc3RhZywgZGVtIDE0LjA4LjIwMjUgdW0gMTQ6NDUgKzAyMDAgc2NocmllYiBNYXJj
IEtsZWluZS1CdWRkZToNCj4gT24gMTMuMDguMjAyNSAxMDoxMjowMywgTWFyYyBLbGVpbmUtQnVk
ZGUgd3JvdGU6DQo+ID4gT24gMTEuMDguMjAyNSAyMzowNjoxMCwgU3RlZmFuIE3DpHRqZSB3cm90
ZToNCj4gPiA+IC0gZXNkX3VzYl9vcGVuKCk6IEdldCByaWQgb2YgZHVwbGljYXRlICJjb3VsZG4n
dCBzdGFydCBkZXZpY2U6ICVkXG4iDQo+ID4gPiAgIG1lc3NhZ2UgYWxyZWFkeSBwcmludGVkIGZy
b20gZXNkX3VzYl9zdGFydCgpLg0KPiA+ID4gLSBBZGRlZCB0aGUgcHJpbnRvdXQgb2YgZXJyb3Ig
Y29kZXMgdG9nZXRoZXIgd2l0aCB0aGUgZXJyb3IgbWVzc2FnZXMNCj4gPiA+ICAgaW4gZXNkX3Vz
Yl9jbG9zZSgpIGFuZCBzb21lIGluIGVzZF91c2JfcHJvYmUoKS4gVGhlIGFkZGl0aW9uYWwgZXJy
b3INCj4gPiA+ICAgY29kZXMgc2hvdWxkIGxlYWQgdG8gYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyB3
aGF0IGlzIHJlYWxseSBnb2luZw0KPiA+ID4gICB3cm9uZy4NCj4gPiA+IC0gRml4IGR1cGxpY2F0
ZSBwcmludG91dCBvZiBuZXR3b3JrIGRldmljZSBuYW1lIHdoZW4gbmV0d29yayBkZXZpY2UNCj4g
PiA+ICAgaXMgcmVnaXN0ZXJlZC4gQWRkIGFuIHVucmVnaXN0ZXIgbWVzc2FnZSBmb3IgdGhlIG5l
dHdvcmsgZGV2aWNlDQo+ID4gPiAgIGFzIGNvdW50ZXJwYXJ0IHRvIHRoZSByZWdpc3RlciBtZXNz
YWdlLg0KPiA+IA0KPiA+IElmIHlvdSB3YW50IHRvIHByaW50IGVycm9ycywgcGxlYXNlIHVzZSAn
IiVwRSIsIEVSUl9QVFIoZXJyKScsIHRoYXQgd2lsbA0KPiA+IGRlY29kZSB0aGUgZXJyb3IgY29k
ZSBpbnRvIGh1bWFuIHJlYWRhYmxlIGZvcm0uDQo+IA0KPiBTb3JyeSwgSSBtZWFudCB0byBzYXkg
IiVwZSIuDQoNClRoYW5rcyBmb3IgdGhhdCBoaW50LiBJIHdpbGwgcmV3b3JrIGFsbCBvY2N1cnJl
bmNlcyBvZiAnIi4uLjogJWRcbiIsIGVycicNCndpdGggYSB2ZXJzaW9uIGJhc2VkIG9uICJFUlJf
UFRSKGVycikiIGFuZCBzZW5kIGEgVjIuDQoNClN0ZWZhbg0KDQo=

