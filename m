Return-Path: <linux-can+bounces-4254-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68882B28E06
	for <lists+linux-can@lfdr.de>; Sat, 16 Aug 2025 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AD188F556
	for <lists+linux-can@lfdr.de>; Sat, 16 Aug 2025 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55014285066;
	Sat, 16 Aug 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Gj8RGqMV"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020090.outbound.protection.outlook.com [52.101.84.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9F23ABA8;
	Sat, 16 Aug 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349875; cv=fail; b=hREsAC0zKhNYkMqkK+mFWXFqhQ4YGSx8TKN0ALtySSEakjmWpgF9JhOjJuUO+NDa2aeVjaXx6xq7a2hGZy0T+jk/ILTrzbYHqLG1ml1zwIj/ye+G85+pG/slFp5jnTI4VQ5KfSCUagamJBOlVwmCOThjDcpGmILuVxi+P1k/YQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349875; c=relaxed/simple;
	bh=1AlrVyjIaB6yE385pOav8ZNtdmbhMJ7kEib9k6ICF0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hRIGbpWGz7RIK3O4zH1/G6OW901C9as4nd5dHZwQ1g6uZRWT4MBL18uPiXZYU+fT7WlSIQVDRjZ/GkDpbHBQpXLp0yvykf5Sfd4WYUTHbCyZ31/8ucLorYbr5AIu4YTO8+Q6yrzCBhy0GKjKQ6j8fPpyYDsnuf7ih7koy10pcwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Gj8RGqMV; arc=fail smtp.client-ip=52.101.84.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCyMgztOQ9Bmu+GkI/BDt3uSOivB3m8NOw9fPL4Up1m1MKVWFLTlrnqE6pr02By1aInqIZ3ZPog8YGNQ6U8wcZxiKVaXAHfvECJK03NS6bctbp8rLstGtPfIqFQB3DXGqDZd728siqGO0rTnOHO5GmeJUvkfBY2O82cPt/EZ0np7rng6RUS5lsNXWLxorxoChb9kCN5XJ6aOauGNRlHyPogw44C5EfRztPBvo8YWi/5VAkFfRbpkjSRttAlg2mpMYpztXFxc4APvBbbmasMbvt3WUvqoTxJLxNxuf4n8fUtamES9MdphkENRAhGErgMuDvbs4zccYxuF4IazuEJA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AlrVyjIaB6yE385pOav8ZNtdmbhMJ7kEib9k6ICF0g=;
 b=RdGkc6wJ3KeXP6JEN5e8XVoWuO2Hhr/tNYOp36JJGLCkREysPSuFQPrKLCluQU4uPV3Nl24Ob6122MmaJ/lVdkvWo5auVBWiz5Mfr6PM5iEXQb5RpP46WiJfk+1XtYqJQF0zoHCriIhwD/glqTXE9hUKBIyiZq6g2Dk7jLjMcSzA4xIMSPcQwOOsvhkn3i9uCXzjVuosW1kp9HUvAU+1UUW3sdnZTWkW6NOlY/18oGQ01xK8rsky2yxXP3ogUn2ttW89qJRUCrQiUpTVoBovZojPLjqbh7NTW0XrffQ7wkRfIuCnAMjM1QFszu1aAiMsIz0u5uB13NhS307+2Wqcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AlrVyjIaB6yE385pOav8ZNtdmbhMJ7kEib9k6ICF0g=;
 b=Gj8RGqMVsdAieIWhLb7zxydj2ivMJa8KoG0yMTdCQokm5W9GnAfQfxt8WeysaqTi7o/6Icok+EKH6vLYjmXdGAupb7B3j92uGqc1hDggbvCnrpa97phXK+BFC/7cmmvOAoE+rn7Gcsir/es5e6nXX/4nheGumoeuNrjBex2yo78=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by VI2PR03MB11002.eurprd03.prod.outlook.com
 (2603:10a6:800:299::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 13:11:07 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 13:11:07 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 6/6] can: esd_usb: Avoid errors triggered from USB
 disconnect
Thread-Topic: [PATCH 6/6] can: esd_usb: Avoid errors triggered from USB
 disconnect
Thread-Index: AQHcCwPHkFnx9vO9JEe6dF2O5eCDo7RgPUGAgAULKYA=
Date: Sat, 16 Aug 2025 13:11:06 +0000
Message-ID: <10424c1b13dccadfcdb9fb8b6c0f32f5da37457a.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-7-stefan.maetje@esd.eu>
	 <20250813-tiny-bird-of-painting-999c89-mkl@pengutronix.de>
In-Reply-To: <20250813-tiny-bird-of-painting-999c89-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|VI2PR03MB11002:EE_
x-ms-office365-filtering-correlation-id: be7c16d6-90da-476a-a76c-08dddcc65c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFhCTnRHREhTQ2MzRkF3aTArMW5SbVFYeDVrWVZyZGc2bTlsZ1VtY0FWam1Z?=
 =?utf-8?B?NGpDU2FoTnRqSHdZTzZkaU1wcmpzR3licW92dCtmU0Y3K0xJUy9WczJjZFVj?=
 =?utf-8?B?Z2tHREZxK0N3YjFjay9zWE9OZmdOYkUvM2NQTmhXL284d1EzaXV2RksvMnN6?=
 =?utf-8?B?UVRpK3prY3Y1d0grMnhWaTNnZlBwS0Z6SDd3VmtJWWFaOE91TVJ3cEVpK0RS?=
 =?utf-8?B?Nmt0WXRTR1ZBclZBc0JDc043Q1YrdTVoeFRCL21NYWZ1OEgraE80UlIvU0FV?=
 =?utf-8?B?UHNVYzFBNW4xeWZpR3ZRdHFrbWxpTUxRZFNOc1docnorU1VXSjQ0NjBpcnBK?=
 =?utf-8?B?NWEveXYrL1JWYzlBNVFpVlJlMDRVUUFZcU1oYWM0WGdUSjhicW5NVmcrV1VW?=
 =?utf-8?B?NUUwYUtVd2NZL3BncXc1dWM1UGFySENsSEVudjI5UlU4Nm40L0VoaEtLRSt4?=
 =?utf-8?B?QzhsY2NTbGRnS1NrOWp2bkRsenRPWGpsYlFLWDJVdGlIT28xbis4N2dHeTUz?=
 =?utf-8?B?TThlOTRjRldTUVpTRHVubmI5REhGZVQ3TlBrRDRScU8wVXFrbEY2Z0g2MmdI?=
 =?utf-8?B?eW40YTRBcDZxTEp3QkVBWXZ3UktVVnJEcVJsWkJrRklxakgwUnpRQzhFdDBD?=
 =?utf-8?B?dWVBMW9ucE5oR3ZPa1BIR1NtdlFYVHFvd215dG5VUHRlYW9hQ29UenkwNzBx?=
 =?utf-8?B?S3VYWVl1K1BkVXBMSWxTRHV3RXJWcnhydnJRVzBveDJQa3ZuV0o4aFR5amRF?=
 =?utf-8?B?ZlVlSXY0MVJDOGFRZ1dNMFNLdElwbnl3VGJUSDRLWU1WaUxrOGk5V3pKL3Vp?=
 =?utf-8?B?WEozVGR2b1NTMldUZ0RiL1FyRG9TNVl1QVFEcEZIUVpSbHJMNGZIOXk2VUVQ?=
 =?utf-8?B?R0FiWlJTcEZrbHg1Vy9pUFNmeDdTYVE1YmdTZERWNURnTTRVOE9ybXRSM2xM?=
 =?utf-8?B?WnV2Ylg3QWdUOE9zS2lkVkdOeStUOFJDc1FVKzlKS1pwdUZaZzFpMlpRaXoy?=
 =?utf-8?B?SHk3QjdPdzdST2JlbFhac0Nyd0psOFk5UzFUNzZyeU9qeGxuV1BZbmt1L2k0?=
 =?utf-8?B?a0ljUGE5UkxYaDZ3Uy95di92ZEZLdGNhRjFRRWhka0JHb0ZTbDR5dWNicFIw?=
 =?utf-8?B?OFh5SG1jZGVmWWliSnl6eTNtbnJyZit4WXROa0hkYUM4dUNzSUQ4OUdmUEpy?=
 =?utf-8?B?TXFmb05Hc2paN0pQc050YmNkODRQOVd2VlFRMVh3LzVaMmFEbzlwMTJla1Vs?=
 =?utf-8?B?OW5vSm9qUjc5UGp3cEVLK2kyMUp2bmVjelAvQ016dTV1djNnS3lvTzE4eGpR?=
 =?utf-8?B?ZkZ6UFpRaEJ6TDRLZlFmWFBlSHg3RmhucUpLN2NpNC96eE1na0pobnNBRTdu?=
 =?utf-8?B?blhaOGZCNW16UjRGSTVKMU9mMVFFSE9FUmNHMlZWL0NqSS8rSzBGSDNpUHcr?=
 =?utf-8?B?OW1QWndGa2dFMDJNaEhvQ1VNUktoc3B1ZGNNeDhMbnIydlRic1RzQTdYa0NN?=
 =?utf-8?B?R0ExUlJ0bWRycWEvZUxkaGdEM3hXK0tEZDNjTmxNenRPTlhyR2JqQ3hsbGZl?=
 =?utf-8?B?ZEtnTHJPUDUrUTgrWExlVXBCNVpCMDJoa0hNYW1Yc3o3Zzh4a1NKOEtNaStT?=
 =?utf-8?B?WkluU2lvd2RRZG1hVlpwMTZYbCtjZHliek9sWlRlMzlCMnFsZGpKNE1aOWFq?=
 =?utf-8?B?dVQ2bHBtYXFDWFVyZWQyd09Ub0ZzZ21ZNEJtM1N2T2lNZWYwRTlPbE1ZOVYx?=
 =?utf-8?B?VTlVSmtxQWZQMnFIeXlNanJPSDBSc2VJRzJkZWxwQU5CbUkwNXdPNjVCdDRo?=
 =?utf-8?B?V3kya05aU1BhMldoT3BsRHBJL1Rnb20xcVViTXppMFc4YjhpSXZ4T1ZKcnV4?=
 =?utf-8?B?OFE1MWFlN3JKa3c3aU9WTC9YaGIrRE9hbDdSQ25BcnBFNDFnemE2eTJqRFR4?=
 =?utf-8?B?blRLWU9aSG1pSTU2MXBxeDBOejlBSHhHd0laQ2czRGpYSFZhUWFYSk1DSUpw?=
 =?utf-8?B?VlBsMHB5c0ZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1MxT0Rkd1VUaGpFNEp4dWhOQUYybzFoVWhINEdBbzFYVUxuOWZ0TXdMUFFW?=
 =?utf-8?B?UG5wM1hOMlJnOVY2cWJwbzhkNkhwWERoVTNUT1I5TkN2Q2RyN1BEcElNbjhk?=
 =?utf-8?B?ZjliTXhsSVBObFNOdldmOTVQUEduUnhpL2prSWxTMzFkamZPU052RWlOcDJU?=
 =?utf-8?B?TkhaTXpOR3FoU2pTV2lxb2pOemtvSlhMM08yZis1MXozT3hpWlNrRG85ajZl?=
 =?utf-8?B?NWZVKzBQTVdZcGJ0VGcvTTZETFZoSzYyb3BkNU5XMThvcWJka2pWVHQzOHN6?=
 =?utf-8?B?Nk5MUmJaempvRnk0TVo4ZHFGVkZVZVNqNUxZMGJSYXFoQ3hsL3Eycmg2SG41?=
 =?utf-8?B?NWNBczNlc3A4ZlpVdDdEemZDNnRvbWxtMjNRRjhGOVY4ZXc5eGtVSXAvbGV2?=
 =?utf-8?B?LytnWjBZd2l2ZUlScnl4SzFIejlldzlURkZIMFMyZlh5QVg5YnMxUHRUeDdh?=
 =?utf-8?B?TmZTUDVEdEVZbURMOWVmTHowcFFENFhtRkI4U0V4SC83dytSK1ZMRFMvZW4z?=
 =?utf-8?B?VWRJb0pUTVFIV24wSkR2Yis5RG1KUHdGZTZOS1ZmUXFTeC8rNnkvZHM4OUY1?=
 =?utf-8?B?MDc2NHlxSXpwNkVBb1FoR3NmSTBjM2xYUE9yQ3kxUUFMZGlRc25jYlpibFcw?=
 =?utf-8?B?WGlTSmNHdnE3WWNEenh1VEhxZzh4eWxZS2l0NlhIelg5R0gzQk1RQWxDdWdn?=
 =?utf-8?B?Y1hhZHBrSGgvRFBvaU1qYzZmU0g0TEtzOUVpTjZVWU1KMWovdjVVUm0yRDgv?=
 =?utf-8?B?NmR1TFZ4eGl0TkVOT0c2dVpUWXl6Wlc5SnpjY0U3WlNBZkVsamhweDZ6UCt5?=
 =?utf-8?B?aWM5aU01Rm9oRERKUWVHMlU1Rm45VDVaWVZZdXBDQVVyS0lFbDZXU3R3OU5m?=
 =?utf-8?B?QTRTMStNTW1ZWHZUWUYrSVBDTkR5WURiNFpEcm5VbWxlWEp3ejVINHJWZ2lw?=
 =?utf-8?B?ODI5bUhZOGlkT25BdGhUdUZQZWl0UGYzL2tUdEFaZmkvbDhWK3lmS2dpdnIz?=
 =?utf-8?B?ZlFBUzJLZnE2bVZRR2EwRVY4bGNDcXpNczk1bEdWeXRYMDVsekpwaDN1Q09q?=
 =?utf-8?B?Nko3U3hBaWpkVFdKMUZRTUdUaS8xQk0ycE1wSVo3Ri9KaWdWVEs3dW9sTzEz?=
 =?utf-8?B?eHBCVFBhb2dqSzlianI0bjFrNHdnVTRQS0FDYXVQRG9tYlJSQzh2MGRhSVJm?=
 =?utf-8?B?NDc4aU9ySEJRYVJHelloSk5Fc1ROaG0rSWdSK1IwQXZGSWRTdE44Y0tWaDYw?=
 =?utf-8?B?K1E3SmdQbG42SFEzZ25Ea0NNZTNBc2xUeXNWem15RldVZ09HYmpodm5JWmFq?=
 =?utf-8?B?UzVPcHJCYTJIM1ZVSlJzMGY0TzQ4MHFkbFVveDBPQ0ZGYmdDdDlSL1loeFJq?=
 =?utf-8?B?ek1TcGQzdUtTWDFCN2NHWEp6VDZ1WXNWc1Rxb2JMMmMrdE9LYXJGZUkzOVNh?=
 =?utf-8?B?eFI3bUxSNmxDZUxiUW5kNFU1S25qc1FhanZoVzh5TzlVd3NWMEo4amVwZ0ls?=
 =?utf-8?B?bXFhRG1kMW5Bc1N3YmFJTGtGN0t5azJzTXRpS2h2blE5RURhdkpVWkZ4Y3d6?=
 =?utf-8?B?WEFpazJkaHFvcWduRnkvRTdJbUtZU0tyWm5LcGI1NmQrUHFxT0srUHBHelJz?=
 =?utf-8?B?T2tidVQzNlFwMkZTZ09hMWlXeGxaaFNkODFtaGZraHUwOUpmWkVUYVVTeEJy?=
 =?utf-8?B?T2FuTmF2Mll3RVh3bG9hQ1NudnJxT0J0MVdxbGJEcmovN01raEEvcmIzOVl5?=
 =?utf-8?B?QzdxblM5ZEF5dE9vSkM4Wmd1N21jQ2VDRysxTVlFcS92YmpjQ2NCNUpPYTFK?=
 =?utf-8?B?STNpNjlPMXBTamQrQ1BUc05BYnBwUktrL2ZTYUFtVXBoYjNQUzhEa2FlZmR4?=
 =?utf-8?B?akV1TElUanltbFplSEx4NWVmbVJOQzZqbXpnRitKeGlrN2Q5b001RjVWVUlR?=
 =?utf-8?B?bWVmaTFiZzY0MlFMZ3YrM3pldVJJSkVUdzZTY1VGMlFRWnhBbVJVQyt6LzNw?=
 =?utf-8?B?bE9OWkVsUm9DVlJMbXoxWERud2hQaTlDZGNhQnQ0cmxhcEFHaVZFUllIZ0I3?=
 =?utf-8?B?Y0hVV1JxQ0hCK2c3ZHdRUGo0SHArcEoxMXEwYmlnTVlLYkp2Vis4QlEwNjB6?=
 =?utf-8?B?MjhmZHFsSTRXdzVFTWxlOVJCcTdpeVVqUmRBclh3cGFiZG9seVE3RFpmUjYy?=
 =?utf-8?Q?elzjiWxwBdOKlZQPaFyrBiLO4CH2qIP0eYArpJLgKhS7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24DF60A28B7CAB418FCDC1FF81C5A3E1@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be7c16d6-90da-476a-a76c-08dddcc65c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2025 13:11:06.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hMrZPLfjK2WYImQiq6Eev7UJiqY84FkwIN7LPSYHvlejzU1GU/S+wLoKB66ZUlJaI5HypO1vNmn8WCcLJ0qcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB11002

QW0gTWl0dHdvY2gsIGRlbSAxMy4wOC4yMDI1IHVtIDEwOjA5ICswMjAwIHNjaHJpZWIgTWFyYyBL
bGVpbmUtQnVkZGU6DQo+IE9uIDExLjA4LjIwMjUgMjM6MDY6MTEsIFN0ZWZhbiBNw6R0amUgd3Jv
dGU6DQo+ID4gVGhlIFVTQiBzdGFjayBjYWxscyBkdXJpbmcgZGlzY29ubmVjdCB0aGUgZXNkX3Vz
Yl9kaXNjb25uZWN0KCkgY2FsbGJhY2suDQo+ID4gZXNkX3VzYl9kaXNjb25uZWN0KCkgY2FsbHMg
bmV0ZGV2X3VucmVnaXN0ZXIoKSBmb3IgZWFjaCBuZXR3b3JrIHdoaWNoDQo+ID4gaW4gdHVybiBj
YWxscyB0aGUgbmV0X2RldmljZV9vcHM6Om5kb19zdG9wIGNhbGxiYWNrIGVzZF91c2JfY2xvc2Uo
KSBpZg0KPiA+IHRoZSBuZXQgZGV2aWNlIGlzIHVwLg0KPiA+IA0KPiA+IFRoZSBlc2RfdXNiX2Ns
b3NlKCkgY2FsbGJhY2sgdHJpZXMgdG8gZGlzYWJsZSBhbGwgQ0FOIElkcyBhbmQgdG8gcmVzZXQN
Cj4gPiB0aGUgQ0FOIGNvbnRyb2xsZXIgb2YgdGhlIGRldmljZSBzZW5kaW5nIGFwcHJvcHJpYXRl
IGNvbnRyb2wgbWVzc2FnZXMuDQo+ID4gDQo+ID4gU2VuZGluZyB0aGVzZSBtZXNzYWdlcyBpbiAu
ZGlzY29ubmVjdCgpIGlzIG1vb3QgYW5kIGFsd2F5cyBmYWlscyBiZWNhdXNlDQo+ID4gZWl0aGVy
IHRoZSBkZXZpY2UgaXMgZ29uZSBvciB0aGUgVVNCIGNvbW11bmljYXRpb24gaXMgYWxyZWFkeSB0
b3JuIGRvd24NCj4gPiBieSB0aGUgVVNCIHN0YWNrIGluIHRoZSBjb3Vyc2Ugb2YgYSBybW1vZCBv
cGVyYXRpb24uDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgY29kZSB0aGF0IHNlbmRz
IHRoZXNlIGNvbnRyb2wgbWVzc2FnZXMgdG8gYSBuZXcNCj4gPiBmdW5jdGlvbiBlc2RfdXNiX3N0
b3AoKSB3aGljaCBpcyBhcHByb3hpbWF0ZWx5IHRoZSBjb3VudGVycGFydCBvZg0KPiA+IGVzZF91
c2Jfc3RhcnQoKSB0byBtYWtlIGNvZGUgc3RydWN0dXJlIGxlc3MgY29udm9sdXRlZC4NCj4gPiAN
Cj4gPiBJdCB0aGVuIGNoYW5nZXMgZXNkX3VzYl9jbG9zZSgpIG5vdCB0byBzZW5kIHRoZSBjb250
cm9sIG1lc3NhZ2VzIGF0DQo+ID4gYWxsIGlmIHRoZSBuZG9fc3RvcCgpIGNhbGxiYWNrIGlzIGV4
ZWN1dGVkIGZyb20gdGhlIFVTQiAuZGlzY29ubmVjdCgpDQo+ID4gY2FsbGJhY2suIEEgbmV3IGZs
YWcgaW5fdXNiX2Rpc2Nvbm5lY3QgaXMgYWRkZWQgdG8gdGhlIHN0cnVjdCBlc2RfdXNiDQo+ID4g
ZGV2aWNlIHN0cnVjdHVyZSB0byBtYXJrIHRoaXMgY29uZGl0aW9uIHdoaWNoIGlzIGNoZWNrZWQg
YnkNCj4gPiBlc2RfdXNiX2Nsb3NlKCkgd2hldGhlciB0byBza2lwIHRoZSBzZW5kIG9wZXJhdGlv
bnMgaW4gZXNkX3VzYl9zdGFydCgpLg0KPiANCj4gSSBjYW5ub3QgZmluZCB0aGUgcmVmZXJlbmNl
IGFueW1vcmUsIGJ1dCBJIHJlbWVtYmVyIHRoYXQgR3JlZyBzYWlkLCB0aGF0DQo+IFVTQiBkZXZp
Y2VzIHNob3VsZCBqdXN0IGJlIHF1aWV0IHdoZW4gYmVpbmcgdW5wbHVnZ2VkLiBJIHJlbW92ZWQg
dGhlDQo+IGVycm9yIHByaW50cyBmcm9tIHRoZSBnc191c2IncyBjbG9zZSBmdW5jdGlvbiwgc2Vl
OiA1YzZjMzEzYWNkZmMgKCJjYW46DQo+IGdzX3VzYjogZ3NfY2FuX2Nsb3NlKCk6IGRvbid0IGNv
bXBsYWluIGFib3V0IGZhaWxlZCBkZXZpY2UgcmVzZXQgZHVyaW5nDQo+IG5kb19zdG9wIikNCg0K
SGVsbG8gTWFyYywNCg0KSSB0aGluayB0aGlzIHBhdGNoIGZ1bGZpbGxzIHRoZSByZXF1aXJlbWVu
dCBub3QgdG8gcHJpbnQgKGJvZ3VzKSBlcnJvcg0KbWVzc2FnZXMgZHVyaW5nIGRldmljZSBkaXNj
b25ubmVjdC4gVGhpcyBpcyB0aGUgcHVycG9zZSBvZiB0aGUgcGF0Y2guDQoNCkl0IGRvZXMgdGhp
cyBieSBub3QgdHJ5aW5nIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIGRldmljZSBkdXJpbmcgVVNC
DQpkaXNjb25uZWN0IGF0IGFsbC4gVGhlcmVmb3JlIG5vIGVycm9yIG1lc3NhZ2VzIGNhbiBiZSB0
cmlnZ2VyZWQuDQoNCk9uIHRoZSBvdGhlciBoYW5kIEkgd291bGQgbGlrZSB0byBicmluZyB0aGUg
ZGV2aWNlIGluIGFuIGlkbGUgc3RhdGUgZHVyaW5nDQoiaXAgbGluayBzZXQgZG93biIgZ29pbmcg
dGhyb3VnaCBuZG9fc3RvcCgpLiBJbiB0aGlzIGNhc2UgdGhlIFVTQg0KY29tbXVuaWNhdGlvbiBz
aG91bGQgc3RpbGwgYmUgb2sgYW5kIGFueSBlcnJvcnMgc2hvdWxkIGJlIHByaW50ZWQgaW4gbXkN
Cm9waW5pb24uDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQpTdGVmYW4NCg0K

