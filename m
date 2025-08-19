Return-Path: <linux-can+bounces-4265-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53394B2C94E
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD33A2C03
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9881448E0;
	Tue, 19 Aug 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="M/oe6Svl"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023076.outbound.protection.outlook.com [40.107.162.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504623741;
	Tue, 19 Aug 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620185; cv=fail; b=Z7klqUcBxqkG8VCOk3fMaVJySbrS087YS054jscrwW8mnViVzai8S/jTgoWbgmQwUi3a6H8HWxL/hE8aVu5ESuK/+pZNW1gMalC/B2dsVgWdAFmRtRt6Qja+SoojNABYFFAv3wXZlEYNrAT4fgC5z3bcFeMAMaPkjpk2cmZ7au4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620185; c=relaxed/simple;
	bh=sbkM4iDHpbq4oqlCfqhHY6SjVnWIqaAZxDQwSa201QE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=na6OQDzBGzWlBFIGUFsxc7w6+3+YV1SudYX4G8x3i9vpM/T9AK2OxI1ltRtI8KoWVkY8qsZ1xuXsyNXsk9esP/c3dojg8BZzU53TW1ImsSalD7xp4f9QcGTPih9lEMAW1otM2ekC31F13XChVBtYW5MSJhwmtEHn23GArT1uPWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=M/oe6Svl; arc=fail smtp.client-ip=40.107.162.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n67Ti1YFBl3d0OH7U2D9A3Z2e6VJu/4O+DUXHPRmi3/I6D5Hn9m/gywzXs9cgBlEMUkSqba7ngoy8esuSw3eDxYuzyBZk/MnmMaXDTpGc1p08eDHAdkq5sR87/PSCaxAjc+Dqh7P1ENssP6O9D6NouXIPexjMPfb59LB02RujJsxu7vqGjG/z4xv6dxd/9e/3AaUHMsHgOGE+O68Yte0BHpH3BR6Ysce5xmnEOV7FJAdqmbie3I7dgyo6F3/PhCqzZJfg22Gg7TjgAoYzT35I8NodA5iQ3oYrLeNEHINR9+1H2DS72b8PmwPWxpAaFvUIaiedSE4eHsLjni1EFdR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbkM4iDHpbq4oqlCfqhHY6SjVnWIqaAZxDQwSa201QE=;
 b=hBYSwC417ZIxgeFyGPeEzRZGxxRD+lDLlfgbLEOH2gGZvkENwLopEYOXDebOLa3exmZyXFI6SSbu5vCkK7hkJxqH+JL+kAX4PHI6WFfJB2Yb1W77gPr3gg0NoaRWvweFM0rfTMRw3ozcX0SxODuNBlW1kwpAXKnqajKSDoRdCFN0fMgJjTPt+5/1E/vcC4AYLKV8f5EipY2xajHIJROHQiz/63t3rqeFygFDDbaJDM5MIdMmgw68263heysB4c4b15kGtAjRt90JTp3WSN1o8kfwjtV/4SuxRFSLbfYVHVFGHdjEfTeSfBXqIrTtYv7vWSf7keOrRdgKM+J/CoRjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbkM4iDHpbq4oqlCfqhHY6SjVnWIqaAZxDQwSa201QE=;
 b=M/oe6Svlax5YWiQvlopveM29nsKhF6SiTswPOFpTleuyEbO7vGqxAHvfd9r0wnh2IhutPUyunHxCRfvYghHpyB713a0OkUV/D/z6Utfmqkdmil2MBzZaDGQAxVy8SU6gGjdhwiTvadc3iWxApSCixsCOSLe8B5BzwSpq6lSi9mU=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS8PR03MB9415.eurprd03.prod.outlook.com
 (2603:10a6:20b:5a2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 16:16:18 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:16:17 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
Thread-Topic: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with
 NULL
Thread-Index: AQHcCwPFrmv+HBR/vUi8Xlz4VVGjrrRgUPUAgAOEMwCABl38gA==
Date: Tue, 19 Aug 2025 16:16:17 +0000
Message-ID: <cbd6a3785645a6740de2e7e09b07e3fdf9392bf6.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-2-stefan.maetje@esd.eu>
	 <20250813-crafty-hallowed-gaur-49ddac-mkl@pengutronix.de>
	 <f5ac3d3331bcd2403df33be05e0b928cf38c35dd.camel@esd.eu>
In-Reply-To: <f5ac3d3331bcd2403df33be05e0b928cf38c35dd.camel@esd.eu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS8PR03MB9415:EE_
x-ms-office365-filtering-correlation-id: 4c869d03-9d32-43d7-9631-08dddf3bb9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTJkdkJsWkQ2VHc5WVNQcGlJdjd5U28raCtLejBJWTBTUUdVamVacWxsOE9k?=
 =?utf-8?B?WTh6M3dyakk4Y0tQQzFzeS9za0VEajY4S1FIZnBHS1lPL0NIbkFkY05sTEhB?=
 =?utf-8?B?ck9YeExwNDRXbmt0aG1GS282UmZXSWJFbU9uUGl2ZDUwdndPbjA0eVc3bnJI?=
 =?utf-8?B?Mis2MmtQRjVwVksyL1JYYVFGa3lONVhMS052bHNGYnYvNE1OVXVhY01iK21n?=
 =?utf-8?B?NFFzdys0M1VZS2Z6MEVObFlTZ1NKYksxMTIyaFBnWURjc0pvOHp1RUx6VnZ3?=
 =?utf-8?B?RnVOZDNPaXovd0x1ditpcFdWVUorSUFGQTBIS1lQTEp0TytjUHRGenp3WDEx?=
 =?utf-8?B?M20zSXc5dVlIbi9mY0xFOXlveFBsNXdpWlcvaVQ4NXdBR3dSaGowVm5SMUh1?=
 =?utf-8?B?VGQ3a1ZJK3QvR3U2TmVQcGFyMXdiamRYSm5FWU1TZlYydFJ0ZTZxTzh5U3Zn?=
 =?utf-8?B?RjcyR0xMOWo2aWV3MXRqRk9iSHZGZjZDS0FvVzU3MndLczRxdmlBTFZzMjA5?=
 =?utf-8?B?aFpEUlF1dkl3c2dMcUhFUzh0MkpNMitNTU5VTmVWcm1CcW94QjJMN2ZlMHQw?=
 =?utf-8?B?QTYvZlRmUEo4aEhBTHBnYSs5dkZHUGFObzh2YnJVQjFFNG5xelRyOFpXc0tC?=
 =?utf-8?B?NWpqRnVJSUVmRmY1eXluM0NudDhWMFoxbkVrSG5IRVRBNnYvWUJUMkszbjJ4?=
 =?utf-8?B?aVdub3FvSHBTQVdSQmxMMmVoU0d4OGNxREpQeUVOZjhDQU5yKzdHOGFtOWdY?=
 =?utf-8?B?MkRaZ1RZTktmUDNLOUtFNkRjYWhycXZqaVp3YXNhaW14M0RyY0ZaQjNFdGpN?=
 =?utf-8?B?WjVUaU1XOHdVb05GbDJudzZieURLTitHZ1oxaGlrSVZKaXA0aDFkQ3ZWWTFK?=
 =?utf-8?B?SmZqbmwzNmxYNzIrSmJVMWxreWdWcE9iVUhtenB0b2g2dkJrdUdNdkxsYlN6?=
 =?utf-8?B?WlFvUHdpcUxXTEVRM0t1N2dhVzZXcFFLaXg2OEM0dG8vaHZwV3ZVWmNMVVpL?=
 =?utf-8?B?OVZFaTJ5R013RlVGSnhYWElNbitERElIaStZbWpya0V0TGdxa01VLzVoV01G?=
 =?utf-8?B?SXlLTE5OdzRpN0I3cE9pWlQvKzkzcVV1UzV0dTBhTmd5dE1aRkZzd3pDSXF4?=
 =?utf-8?B?SS9VQWZZQm1WdjZBcFpFNEZYQWF1UVBVZnUrc1I0dUcxNC9hdktad1JMQVdr?=
 =?utf-8?B?OGs5NjhZemFXc01jRTgzZTh1UVN1SkdjSS8yby8rSFY2ZW1HMnRVdFFtb1Ew?=
 =?utf-8?B?QmRhR3B4MzViOENtZFpiY0JlTnQ0ZVNOR1ErS2pRU3ZOYkFoNjA2Q1VYTjhH?=
 =?utf-8?B?RE40M2JTNCtpVnJBdWYwYU1KQWY1dWVnQmpDWndOY0dNUnl3VnBNNEJPdlB1?=
 =?utf-8?B?NDVHRkpSOXVOc3FweWdMT0hmMkVpclI2b05JRmNpazhGUjRDcjRkSGcxS244?=
 =?utf-8?B?cldlYXhZcHkyQ3d4am9OUkVBdnVkUnRwUkJaZE16ZXJLVHJKWmhkVm5ZR1Bu?=
 =?utf-8?B?a1JjMmE3UGF1OTVLQnoxcGZpanN4Ukp0VGtmbE1vZGhOUCtmM3p4ZlJ6WmN3?=
 =?utf-8?B?ejR6NlkyMHNsMUg4WVYyL3kranZyTmJDcTlKdWdwQ3hENXFac29sR1RmRTdy?=
 =?utf-8?B?STJ3NTYzV1p3MzhKTGgvWU5ob1AveVNPVFA2eWhjeWxtT1BubUZZUWpLZFZC?=
 =?utf-8?B?amg1RFJNNWpOcEJJYVhqUExDNGRhYXE4RmRHd1FHYmJ1NjFLYjdtVkJWekc2?=
 =?utf-8?B?ckxUTEFsUEw2ZTlwSTJlODd2Tlc3Z25RQ2Z5OEdwSUh4Q2FoRjFaRis1V1hS?=
 =?utf-8?B?OHVxV0VQTmZFenhNVndVSDJibEJ4ZGU0cmphSm9pOWRvaVV4TGJ1ckpMM3RM?=
 =?utf-8?B?UnlFSno2cCt4dWl4VDl4dlFKMEQ5d0RKakZRR0ZhT1JvdkI3MUNoSDJ4cXI1?=
 =?utf-8?B?S09LZ3F5T2ttUnNEMWNsc05BTm9tUDloYk1lSTFvUUVDbGRDSGcwYmhTeVNp?=
 =?utf-8?B?SVZycjVXazJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0F0TjJJVGZVZXdtblNrUHpvcnhONHdKaVA1RmRyNDZxSjg1WkIyck9ISjFv?=
 =?utf-8?B?Z1QvUHBEOVFNSlJQNFRXQ05teHNiT01MZU9NNER6ajc0VXBQRjhjb2w3ZXZj?=
 =?utf-8?B?RHBHWmMyemcxaHlva2FUT2tHMVZ0YkpGQmhNZG9oU1FNdS9RUDFnRDNMWFBF?=
 =?utf-8?B?TnVVNWN1MjhkVzdlKzBjb3crbHJ5eXVTN0NqOTVQeXM5MEpFeWIwcWswcHVU?=
 =?utf-8?B?bTZXLzFNY3A5ajRvcllORUlpN0NVMUswVTVaOUFVM0VjNERtTWdDMjNrRkVI?=
 =?utf-8?B?eDJCNkRUNW14M2xzNFI4YXJzVXM5MUhSa0piU212SHUwbWt6YnpyVm01Y2hm?=
 =?utf-8?B?TWtKbHR3QnZCM3NsdVdXaStpR1lQOTEyYmxrd0Q3djJVdGNNc293ckhXZ1ZN?=
 =?utf-8?B?cWlzaTFPamsweHpnS3dlSERKRVlVdlp5dVNIVjJ1ZXZoUS8xUjRhUlhDRFgw?=
 =?utf-8?B?ZFA2ejdiNUZzbldxV21ESHJFay9xZEZDeFFWcDB0eVBQaVNrNC9GUVRKbG1j?=
 =?utf-8?B?RzdKUWdwajN6ZHU0a0xqakNtOFpJZHUxK2xOQjFjY2QvY0RvcVFaSkk5L3p0?=
 =?utf-8?B?RmFSWGxXbkJJckRsUjJxQ2ZQekczR1VoMTlJTzRrT0dSTHY1ZHhYaDNEQTMw?=
 =?utf-8?B?WWozeHdVWmpISjh2bGR6Ky9iRjZHbFJZVzAxVjJCS1ZWcmlSdVhXdDFRNU4r?=
 =?utf-8?B?ZzVuWkNaZ1ltOVVHcUs4VW9ncGp3UVV3QnhBYmNNZklwL2NrL0pSckpMYldC?=
 =?utf-8?B?cGNYNFd2bFFMZklsZVdyOVNlcEdqSXEyT2lvRmZNc2MzNFVBbjhiZ0FlUTdF?=
 =?utf-8?B?YzdjYUJpYkFycGtkY3BkRDNQZm5MMnk2ZXNPZG1SaEhNYTk3bmV4K3E4cllB?=
 =?utf-8?B?bXgyVXhmY3NrM01MVzVua2d1M0ZVVnMwcTVMUi9SUTRHYkQ5RDVpa0h6aTlP?=
 =?utf-8?B?dXRFaC8zdUZndU5xcEhYNU96NjgvT3daZzN6K0RnWVhobTVIcENzN0FmQVU5?=
 =?utf-8?B?c0tPU244RnlvNlRpZHMweDRHa1V0UUcyaFhmbVJtYi9HdUJhMTZ6NmpVdzVB?=
 =?utf-8?B?VjQrcHBxWVFUVHZnem9BNHYyZzJ2YTduMlhQbk5uVXo1YkhvS2JIYmxWcklY?=
 =?utf-8?B?VXNIVG40aEp3QVE2YXRwTHJRUVZqV0NuTWxvTitDeGhLVWxFejY4TGNPSEFO?=
 =?utf-8?B?ZnZscDcrc1Q3MnNBc3NMdjlVREt3b21EN2tpei8yNVpUckVQTkNVaVYxd3JX?=
 =?utf-8?B?M0lNZDhFbGVFZlNGQ1hwSFptOFU2NUs3N2drM0hLd1NaY284ai9Ib2k5NzFj?=
 =?utf-8?B?dFBGd240WlZSQi9ibkFGcjN5dGRTNkFOYWtWUHVISHVDOGtmRFZ4ZXVUR2w5?=
 =?utf-8?B?S1NSNUVmUUhlRy95djVmakhPNWdCc3Z3blBiN2c0VmF5dVlRNVhTWldYTnlk?=
 =?utf-8?B?SHo2Z0hiUUdUV2UxKzNZelNFVUNDL3crSGc1dGpmQkxIdkl1Q2E1VDRqSjU0?=
 =?utf-8?B?VDllUVZ3ZyszOUxQNGhaZnBrRjlZSC9MUGd2SWFabmxXMXozRW5IZUErK2hL?=
 =?utf-8?B?VTd2VFBqbnduK1Z0YVhUWUEyNkQrWHhVYjJ6dFFvSnRMRWc0TzlkZkFmSW02?=
 =?utf-8?B?NWtzR1lwaXdNYnZjcHBvQW9lYkF5dW1QNURPckRWYzVQcVhsK2daL3AyTXlT?=
 =?utf-8?B?MGZnbUpJSFVLNTFCSWVPd3JzVTNaNG1QekxQSmxtbXVQays2cTNCSnVwWkg4?=
 =?utf-8?B?YlpqRjlkUDdmU0FINkVHSnZUMGRlUDRtOEFCaHpiUmlHaW1lSTNxdU5MeEZY?=
 =?utf-8?B?aDB4alpCWU5xY1EwdGdkUU9jdEhmSTBQOFgxZUR0ZFFySGRqSFVRYWNPM015?=
 =?utf-8?B?SW44YnVEdWxXOU5wcitzUmx6WExwSm1ocUFNeEowV0srRVZOUkVOMmRSS3hD?=
 =?utf-8?B?b1hMRlJsN1RrSkdSbFl3UTl0QXdaOUs0L1JLSzBKalRCWncwdmxxRUsxNGlz?=
 =?utf-8?B?MGd5SC9YVnRXLytvZlB0ZVBWQ3EyZlFpbEtNL0N2NFZKb0NiM1lqZkdKalFu?=
 =?utf-8?B?Wi96aDI1TlBIY0ZSNE1ZckZoS3BiMXN1YXpNVVJ3azl2SGhCQTl0Y25SM1Yz?=
 =?utf-8?B?Q2c1VTNyQUVCVWZjTnR3M0FYejBWbEkzRzJwemZadXNPUVJlMVBncU8vWGIz?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D635CEF7BF1954D8659F2C6BFB76EBA@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c869d03-9d32-43d7-9631-08dddf3bb9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 16:16:17.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: on+TCJaksOju/uMzPoCLR0Ak4g4ACySVmygFL7pPSk98qvQnsXtwGNZ4KNo2oLPL45++H72CXtNUxjrwSkxPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9415

QW0gRnJlaXRhZywgZGVtIDE1LjA4LjIwMjUgdW0gMTU6MDIgKzAwMDAgc2NocmllYiBTdGVmYW4g
TcOkdGplOg0KPiBBbSBNaXR0d29jaCwgZGVtIDEzLjA4LjIwMjUgdW0gMTE6MjAgKzAyMDAgc2No
cmllYiBNYXJjIEtsZWluZS1CdWRkZToNCj4gPiBPbiAxMS4wOC4yMDI1IDIzOjA2OjA2LCBTdGVm
YW4gTcOkdGplIHdyb3RlOg0KPiA+ID4gSW4gZXNkX3VzYl9zdGFydCgpIGtmcmVlKCkgaXMgY2Fs
bGVkIHdpdGggdGhlIG1zZyB2YXJpYWJsZSBldmVuIGlmIHRoZQ0KPiA+ID4gYWxsb2NhdGlvbiBv
ZiAqbXNnIGZhaWxlZC4NCj4gPiA+IA0KPiA+ID4gTW92ZSB0aGUga2ZyZWUoKSBjYWxsIHRvIGEg
bGluZSBiZWZvcmUgdGhlIGFsbG9jYXRpb24gZXJyb3IgZXhpdCBsYWJlbA0KPiA+ID4gb3V0OiBh
bmQgYWRqdXN0IHRoZSBleGl0cyBmb3Igb3RoZXIgZXJyb3JzIHRvIHRoZSBuZXcgZnJlZV9tc2c6
IGxhYmVsDQo+ID4gPiBqdXN0IGJlZm9yZSBrZnJlZSgpLg0KPiA+ID4gDQo+ID4gPiBJbiBlc2Rf
dXNiX3Byb2JlKCkgYWRkIGZyZWVfZGV2OiBsYWJlbCBhbmQgc2tpcCBjYWxsaW5nIGtmcmVlKCkg
aWYNCj4gPiA+IGFsbG9jYXRpb24gb2YgKm1zZyBmYWlsZWQuDQo+ID4gPiANCj4gPiA+IEZpeGVz
OiBmYWUzN2Y4MWZkZjMgKCAibmV0OiBjYW46IGVzZF91c2IyOiBEbyBub3QgZG8gZG1hIG9uIHRo
ZSBzdGFjayIgKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIE3DpHRqZSA8c3RlZmFuLm1h
ZXRqZUBlc2QuZXU+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91
c2IuYyB8IDE2ICsrKysrKysrKy0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvY2FuL3VzYi9lc2RfdXNiLmMgYi9kcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91c2Iu
Yw0KPiA+ID4gaW5kZXggMjdhMzgxODg4NWMyLi4wNWVkNjY0Y2Y1OWQgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91c2IuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9u
ZXQvY2FuL3VzYi9lc2RfdXNiLmMNCj4gPiA+IEBAIC0zLDcgKzMsNyBAQA0KPiA+ID4gICAqIENB
TiBkcml2ZXIgZm9yIGVzZCBlbGVjdHJvbmljcyBnbWJoIENBTi1VU0IvMiwgQ0FOLVVTQi8zIGFu
ZCBDQU4tVVNCL01pY3JvDQo+ID4gPiAgICoNCj4gPiA+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTAt
MjAxMiBlc2QgZWxlY3Ryb25pYyBzeXN0ZW0gZGVzaWduIGdtYmgsIE1hdHRoaWFzIEZ1Y2hzIDxz
b2NrZXRjYW5AZXNkLmV1Pg0KPiA+ID4gLSAqIENvcHlyaWdodCAoQykgMjAyMi0yMDI0IGVzZCBl
bGVjdHJvbmljcyBnbWJoLCBGcmFuayBKdW5nY2xhdXMgPGZyYW5rLmp1bmdjbGF1c0Blc2QuZXU+
DQo+ID4gPiArICogQ29weXJpZ2h0IChDKSAyMDIyLTIwMjUgZXNkIGVsZWN0cm9uaWNzIGdtYmgs
IEZyYW5rIEp1bmdjbGF1cyA8ZnJhbmsuanVuZ2NsYXVzQGVzZC5ldT4NCj4gPiA+ICAgKi8NCj4g
PiA+ICANCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvY2FuLmg+DQo+ID4gPiBAQCAtNzQ2LDIxICs3
NDYsMjIgQEAgc3RhdGljIGludCBlc2RfdXNiX3N0YXJ0KHN0cnVjdCBlc2RfdXNiX25ldF9wcml2
ICpwcml2KQ0KPiA+IA0KPiA+IAltc2cgPSBrbWFsbG9jKHNpemVvZigqbXNnKSwgR0ZQX0tFUk5F
TCk7DQo+ID4gCWlmICghbXNnKSB7DQo+ID4gCQllcnIgPSAtRU5PTUVNOw0KPiA+IAkJZ290byBv
dXQ7DQo+ID4gCX0NCj4gPiANCj4gPiBDYW4geW91IGFkanVzdCB0aGUganVtcCBsYWJlbCBmb3Ig
dGhlIGttYWxsb2MoKSBmYWlsLiBUaGVyZSdzIG5vIG5lZWQgdG8NCj4gPiBjaGVjayBmb3IgLUVO
T0RFVg0KPiANCj4gWWVzLCBJIHdpbGwgbW92ZSBpdCBpbiB0aGUgbmV4dCBpdGVyYXRpb24uIFRo
YW5rcyBmb3IgdGhhdCBoaW50Lg0KPiANCkhpIE1hcmMsDQoNCnNpbmNlIHRoZXJlIGhhdmUgYmVl
biBzb21lIHJhdGhlciByZWplY3RpbmcgZW1haWxzLCBJIHdpbGwgd2l0aGRyYXcgcGF0Y2ggMS4g
DQpUaGVyZWZvcmUsIHRoZSBmdW5jdGlvbiBlc2RfdXNiX3N0YXJ0KCkgd2lsbCByZW1haW4gdW5j
aGFuZ2VkIGluIHRoZSBuZXh0DQppdGVyYXRpb24uDQoNClN0ZWZhbg0KDQo=

