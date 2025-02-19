Return-Path: <linux-can+bounces-2851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA59EA3BB4A
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B833216A47A
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A161DB546;
	Wed, 19 Feb 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=liebherr.com header.i=@liebherr.com header.b="iSmk/iGU"
X-Original-To: linux-can@vger.kernel.org
Received: from mx08-00701402.pphosted.com (mx08-00701402.pphosted.com [143.55.150.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFA1BD01F;
	Wed, 19 Feb 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=143.55.150.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960067; cv=fail; b=V+J0B3TVq/9FQe8FsNgsGJS019mCnp4mg2oEMaZ5FONuTzTxQRZCsLec1wHDdtougbOZ9YeKciYBP0Dr9IVXAMfkSBMhzownQZ0N0QG63/yZJB7KvJHfyeaDShPg+fRPn2fyjlAH8JSKxE733JXc3SM36KGzpr7FYqH+d3/gIYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960067; c=relaxed/simple;
	bh=gSS2eoTOUdZYmSXNVdkhIzs35X6AvqQdg9en+eBXmgc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KTNcxlqjtdPqiWJzwVlCCMfzyJRg1JkQnRdrG/jMOUQ4ktGNIG6XZopJYKbIRvUZtbDIrhm/+5+8hLYY/jLoe6BR1sJ3v0EJ/JoLYf9YFa+60+5LPHgmHCm24Qu9G30bZK/4gbXPDL6txVvz5BojvxZPfs7xBg7ZyaVVQ6jDNFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=liebherr.com; spf=pass smtp.mailfrom=liebherr.com; dkim=pass (1024-bit key) header.d=liebherr.com header.i=@liebherr.com header.b=iSmk/iGU; arc=fail smtp.client-ip=143.55.150.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=liebherr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liebherr.com
Received: from pps.filterd (m0408743.ppops.net [127.0.0.1])
	by mx08-00701402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9gCu8021477;
	Wed, 19 Feb 2025 11:14:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=liebherr.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=key1; bh=gSS2eoTOUdZYmSXNVdkhIzs35X6
	AvqQdg9en+eBXmgc=; b=iSmk/iGUjxZ+0WNQpCZPAheIRV6BCRCMRBu9Ahqu0QJ
	qi1gXEH/qSX1kZUMX/uWTjMG4483FO+2i7kFdM9kpZFIbhieLO/sJYobWY4J8ANq
	1x3FMxhRzQthfBS973gWftzhPDCLT7AblHI7+ut+wuCJxaxJXuFmAFdsIAEiHd0s
	=
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
	by mx08-00701402.pphosted.com (PPS) with ESMTPS id 44wcw0r29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 11:14:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGYzMl2Vn2SFMqYsc9S2fi5ToR6rHfdw212EYck+AN+DWvXj6m4D/6Jx26/Vh7iZGV2Ek+3Rh7S+LBqg08pNEMBLqn7j97C36YunUrFh/CZuxvzQ1IxJulrmcqTH4cEBjthTY6uPBTTtb82WuFjV+VtsmQfWyph9Kzng2N+AP6QuG5v0j1gc2zVd3PClHXLSH9id5rKRYL4bDiRcF2iHeDlahVhx4bFcegcRMikBL0MFVXy23QFLqRRasLZBHyoaNhESL6XinYx0goJhn6H+Ubl9p/DxdfpbMWIg1NXHCVjTsZKRFwfccJkuXVe30llpo8lGWoA45lebxdMTCPO8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSS2eoTOUdZYmSXNVdkhIzs35X6AvqQdg9en+eBXmgc=;
 b=o8DCSxNaa4y50q3VNalGrvOSvhcPkArNyrd/f0Ae1P/o/5HJalA9JjYCbihmZ3IlwKOd5mjK/sPKPCg8CVFSKhmUj8K/rqaZccu0fDCSvNLHcX7g2orgF6POTQj769YLq7KLL5N0t4df+sz592VhaXI1z5++eajLtDIcBHumVY61uHfDXUsWGE5BUvefwIAXkFsL7cF+YqK6WfiwDKPuWA//zTIQ6lmoYkZWL53gsV+/wxBOl+9Ux6XmGmwvC7oK7MAHjY++006ZK/n/OhelubFFc137gjEoqsNGa9+d2d9tPZKFGkoeXbTEsiSGltvFHNOYw0Q+Run2DVBpJvu04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=liebherr.com; dmarc=pass action=none header.from=liebherr.com;
 dkim=pass header.d=liebherr.com; arc=none
Received: from DB8P192MB0838.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:148::24)
 by GV1P192MB2417.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 10:14:01 +0000
Received: from DB8P192MB0838.EURP192.PROD.OUTLOOK.COM
 ([fe80::5952:3024:60c4:b090]) by DB8P192MB0838.EURP192.PROD.OUTLOOK.COM
 ([fe80::5952:3024:60c4:b090%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 10:14:01 +0000
From: "Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Dimitri Fedrau via B4 Relay
	<devnull+dimitri.fedrau.liebherr.com@kernel.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Thread-Topic: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Thread-Index: AduCtjTQ3DuqUqMRQdSX0Y8xpYX3LQ==
Date: Wed, 19 Feb 2025 10:14:01 +0000
Message-ID:
 <DB8P192MB08383B8F82FA5C490A1463F3F3C52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P192MB0838:EE_|GV1P192MB2417:EE_
x-ms-office365-filtering-correlation-id: 25d0d7ee-0bcf-4b45-2f8c-08dd50ce21bc
x-pp-secret: l9btit3ms7a.tlaangawwjp1g9smhjqpmsmlcnax
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkszRFRmVitDLzhlYUpVWEcvdnpnS1o0RlhOQk16RmRCL1hYVTNubWdaaWsv?=
 =?utf-8?B?MWpQcGg2UnBoQTQweVRIcmo4NCsyNHNURTNPQy9YYkpiRFp5WXU1VDd6aUN3?=
 =?utf-8?B?OWoyRFU2cHk3Y3I4ZTdWdnVVR3dlWnBiSnNPaHAwaEZOYlF4WU5SVU91dTM0?=
 =?utf-8?B?MTRjQzU0ZUdUOUVPS1VoazJDK3dQbDhRenhwSlhCTjhUQnJHQ3RFRGRENjJW?=
 =?utf-8?B?YUhaV3dtYktrOUdXVXo3eDZvcUVPUHd4cGtmejZyTmZLTjVaNWE3b3dJYWZO?=
 =?utf-8?B?a1FXOWYxaWJDNmJwT2xwWWZPcUNJNEVsa01tS3lFRzNyN1d4cHUzcGZXeWRE?=
 =?utf-8?B?YTFaKzhxYmcwUWl3ck52RVFJQWhQcGsxbHJsRTZqZkRQVnlMNURLK0dib0hx?=
 =?utf-8?B?aDFqa1BoVFY4bWs2cWJLZmhMV3ZaWDNFWS9SUnY3U0pIcnZWWmhpNHZzWFRD?=
 =?utf-8?B?UHRyTlpEZ0F0bGZEMTNlOG50TTNQcVB0UVgyYlM1eUhncnRUQktjZ3pBazNM?=
 =?utf-8?B?NmxKd29uWXhYbEo4WHRKc0hEdGc1RTlhZGJrdEhxNGR3OUtGUGNzWWkrNTc3?=
 =?utf-8?B?dDhQUzVzVjhrMlVJT2tpc0UyV0huSVNQSXV2RTIycTBUV2hzNFZucTZHK3NY?=
 =?utf-8?B?OTBjM1JRQjlLdWZrY2Y5VXdUNzVBQlRXalo2NXRYOTBWNFFlVk5BeHRrNFFm?=
 =?utf-8?B?RXRJb0VqV1Bhb0lvN2c1ZFFIWDlyakxGTWJZUi9wRnJmS08zVDk5bEpXTkVs?=
 =?utf-8?B?ZFpBem5YSDIzRmVCajdXZ1hYeEJVZk1UMjZxS3kxWXVZUjVHU0hjQlJiMGUx?=
 =?utf-8?B?TXFsSHJPbFo4cjBMczc4Y1RJbVZTZ1FaaTFmMUxJcjJTN2tHWmxTenVJVU5l?=
 =?utf-8?B?WEVxbWxybFBMOWNhRXRNNlFoZ2UxWmJOV29MeWZydXpFbXl4MjZvU0N4eTh1?=
 =?utf-8?B?ZDlFSEJtWkR0SDNzOHBCMm8zYVI4alpqRTVRWnJ0MEhtWS9KMFd1U2FKb3ZP?=
 =?utf-8?B?VlZXOCt2TnZPWThPc3NqcUdyRGdZcUtrOHk3SFJZMTllYVhRczdMWVlaaDlq?=
 =?utf-8?B?N3lGeXBad3NRWnJZOGQ0ZUF4N2FKb0s0ZmVieWhDUVZCUFFHTW1UNFZiTHZj?=
 =?utf-8?B?VDc3M1hzUVUrS0lZblpERVUvTVlBcEZkRzVlcTVHOHJ6cnV6QTZWUCtnZlFD?=
 =?utf-8?B?N1ZPait5dER5djI1aHhGbEphN1FOZ3N6d2I0OTUyVm8ySE9LdUdzUURhS3Bq?=
 =?utf-8?B?REpaMlpsY0JySGpvT1hyVm5kUWJ3azB0SGxoK2dCTm5DbzZIM0U5T0dveFdt?=
 =?utf-8?B?b243blBMYkZBUnZyTzB3OGRqUk91QWpQM05pdk9vMFE1VzZXeVprbHZVSk1P?=
 =?utf-8?B?U2x0eE9PbmdsZWRBWDNvM1FPSE81bHFMM1JJbE81UUpNbG16S1ZRS01iSEZI?=
 =?utf-8?B?V3BSeklRNWxvUkZsTytLY1JtUGloRHJtUjk4K2NWcXAxcm9NampYTGRSS0dh?=
 =?utf-8?B?bnczb3Y3NWIzeUpXb2ZZZDhFL0p2MTRTaXFxaGkxMnVxdERwZXUzMmVsS3lD?=
 =?utf-8?B?ZDZBY3FNQStQWXA4dHFJTlI3MjFjckdmQzFCQzhLWHE2eU5NUXNNdDVjMGpZ?=
 =?utf-8?B?TzhqeFNWSDFzeHBkTG9ZeDNhZGJFZHJrc2ZQK3A0bm02aUpWNzVCalduTkpL?=
 =?utf-8?B?R0h5WWtFWW5WazZHY0xma3g5ak9ubmpRQ0tNMjlZOGZSOWlhMjZvYzZKM1Js?=
 =?utf-8?B?dW5RSjVBdDRpQis4VldkL3pHdU5Ca05EQldBMGx6bFFkQzFTYklqdll0Rng3?=
 =?utf-8?B?NVMwN0pWQnRzdWJBd0lxbHVaV1RhUTkrNDI2cGxaWVI4cjNEV21NQjVuVHJ0?=
 =?utf-8?B?WEh3bCtIc3Z5cUx6bjVCSzhWS1RPOUxGTEhwdlNnMjU1NlRFblRHN2Qyck5w?=
 =?utf-8?Q?XI59A/7BtfE0bht6BmZU0dn+mZoJ1eW8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P192MB0838.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0hqWHZyWFFmeVU4WmV6bHRBWFdFREtLamtWTmtRQWRWWnhnNVNBYkpmVi90?=
 =?utf-8?B?ZEl3ekduQjJpTTdVS29uSm9nODVBT05Ic2NUZ3pRRi96NE5RNzVBUDRVNjNy?=
 =?utf-8?B?RWhMQUVrRGs4VWJQYU14K2ZOaUlCNDVmVnFQTEUrSFFaR0J2dFJjQ0w5YnZm?=
 =?utf-8?B?S0VuMWkrSEY0Ykk1K0NpNit0L2M5TU4zOGx3bElqeEprSmsvNi9ZY1E0b0Jr?=
 =?utf-8?B?bmVweTVQcmVDdzhsazM2VXVsZ1NSbXJsd0FQKzFjMHh2ZCsrM2hHREVYVXF6?=
 =?utf-8?B?SVhZSU11T2hVOTMyajQ3Q1BYaWNDdWlWT0FhMW1KMS9YaHg3U0o3eS96RjlZ?=
 =?utf-8?B?OENzU0JNcU5tT2VJVHp0aFlWK1ZJbXRNbkZtK1RBZ3Y3MVJTSndRbHZJeWhv?=
 =?utf-8?B?RGRRTWxOdVIyL2NQbldqTEhjQ0kydmI4Z1pVd0l3SHlBczZWMmRqNHVxWkJU?=
 =?utf-8?B?QmRTRC9JOXo3NWg3cWh3UUNaZHhONHVzZkt4VjJTazl1ZXl0dWlWdjIyK0wr?=
 =?utf-8?B?YTA1UWNEeDRQODZlNTY4K3o3MXhkRmlTRnpqZWxoVUU2OTJlSXoyM0thbjlN?=
 =?utf-8?B?aVZmaTQ4YW9mRjhCd01MenJCUWRIUHVSc3BTemY2UjY4dlhIR2Q0Z29oMGxh?=
 =?utf-8?B?amlrOGc5dC9EajFvWXJWWXpqNkhMUCs0TGtoQ25sQjRqMWd0YStzT0djUmhw?=
 =?utf-8?B?M1I1UTU5RDZvOTBEM2FXR1RqSzA0c2M3cUdBRFg5aUlSMGczT3dYR21GNC9r?=
 =?utf-8?B?YUsvQ293MFlxZ204NHUyaWFUbGZXblhjd3JZTC80MTNqbjQ3dU1RTjdPdFIv?=
 =?utf-8?B?RXVaVWxFTFh1SWNaTUpDZVlNZS90akpTdTM0TkVDSTJOWTRZamNudWMrWVkr?=
 =?utf-8?B?OExFWHcxMTZZcHgxVU1BYzFaejdySWM1dmI4a09uTjk0YVF1V1VYdE9HM1B2?=
 =?utf-8?B?RkU3S2F4M0xLdjY1Vk1XTEtKMFVaYjB1WEJNU0s2NmpOcSt5bXdQOXdveVMx?=
 =?utf-8?B?VFdROEpGZ254RjRDRnpTbXdhTGhKMVpYL2lRQUtBUTQ3Y3p2YTU3L1BpbnFI?=
 =?utf-8?B?RXEwQzJMK3VHZ01KS1RHZHVqYjF2QTlhMHRvQmZZbW1lblc5N0o5T1JrZWVN?=
 =?utf-8?B?RDZKZGgrMWY5dGxpd0V3RlQxSURlOU1jMFAvOXozUUpIR2hKblRCZjdtMVFN?=
 =?utf-8?B?WXZHZ21DeGFzSDRBMjN3eVBPSndydkhSTGhTOVBBMEhNTlZqSXlUV0laT3Jo?=
 =?utf-8?B?V09WNXRNdS9INTYwcGp5bUJOazZxTE1LREE5YkZzZnZVNjdzZ1c5T3Q5Z3hn?=
 =?utf-8?B?K3pUQW5qMzZheEhHZXVwL3RxSjJ2MEtUaXdlUnU4ejlqMExZU2xvZUV1VVdl?=
 =?utf-8?B?MGNScDVMdmtQQXJQY2hFTHRnWnpkcTdSMTZ5WFBpRkt0VWZjaEluUVBSMFVV?=
 =?utf-8?B?T3h5V1I5ay9HTGRTMEZHWkY3dy9SQkRXK0pRZ3B3NGk3aW50MWVOQzdiTWFY?=
 =?utf-8?B?VjFEdmxlSXA4RGE2K2locUdEOFZYQmM3R1FtbGUvbVZoY1JVRUNxZ2NZS0ww?=
 =?utf-8?B?VEVpbVh5a2VtVVg2UTJ1Ni9OVVRaK04xUUJZQjBoV0EzdzhnSGlma2JnZENq?=
 =?utf-8?B?aWIwYjEwTjRvb21qbldUUFRuVFVUN2dZUXF2U2lEekJDQWFkUzRZYXBpdnh0?=
 =?utf-8?B?dW9PMVBxdFEzY0MyUy93YzVQOHNWTXRyMkpwb1FyVXd1TXdxNjJsZy9XQTIx?=
 =?utf-8?B?b29QS1FBcEtDYzNROGh3YW9TaFZhVFpXSkhqTGxNUURSRXJ3Y1JiMEpVNVdL?=
 =?utf-8?B?V3Q2T3h5Wld3bmJMeU5zOFU0RktXakxCOEwreGVaMUN2SEpsc3BhQVBhQ25Z?=
 =?utf-8?B?NFdlYU9NYXRpeFFCSHRNaGw1cmYySWx5SG5WWDhzVTVkcm1IQXV4M214ZVZQ?=
 =?utf-8?B?UjRDU0U0TGJBVHNsamN1TkV4WU5KSlVyU2FYeE1RL05ieEJ4ektZcmlybFRl?=
 =?utf-8?B?MDk1YjR1ci9hZHFyRjlyZHNXWGg4U1pORDFBc01DZm9BUzFZclNOYld2RGxq?=
 =?utf-8?B?eG9qZWVZbEZnVi9zZUZhRzFtTGl1Vjl5ZTZQcXVheTN6eFM5c2xoTmxzWnpS?=
 =?utf-8?B?TW1rK0IyWmUzendtbkl5NzV0NktYU2xqRG9hODNuekw5NE5CWnI3WXhzT2lt?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	is6IKC70tmhGhjy9LK9YIn3Cxqq705xPQDgIHAMScLEb93Nb8VQ1479k9s7Zz5lkeQb8SgvoRXggeT0xBaNZKdMeaCm5WLm1mNYnVw2W5bca3aIruOTxlOXTxLeH/xXBtKRvypH4/r7T1c3NhYjkgZi05lYvjfil6ruIVvAabOUjrQn+a8t6wQKUWLySpng9+oWL8f8LE2aJ4cjCQB8OQn7CTXsLM/K1vyxLei3YY9AIQpphF/S42cvkiRUWRbGsbYeY92BX55h7flg3GOkKjKVj7yQInLYQNI6qz0AdtK4RO2hQHHTIDy+patLexFkMGHYZmiugbNToEpxciQsYT79/rsCLlMy8PCIqQHseraiRxpH7295+4NAsR3EOqJ+oR6LBkhQJr0QLws3bFi7/lzqk3mA4AJt57d3UOGiT9XO8kaO78oh3x4XyPX7Ok7Th8wQnBQHSzJ4/oMJQstvTR4iRP7c7ta0fO7umCPtzQL+CZ0WXHmvF89SvA1le9DEC8hpTSvxqz4Hs6BtP40ouPzW9eLYeL079mTGz5aMS62BmsyrvKXMxgqc08QTK4KJ72N0rTMrC1krKIcTucdbe/DxzO3Z78GSbyt4H61UsDguMnRGqEsUYw0h1ynAU1pf1+tTAar3jJj2jV/ANlVglaA==
X-OriginatorOrg: liebherr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0838.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0d7ee-0bcf-4b45-2f8c-08dd50ce21bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 10:14:01.5893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3336d6b0-b132-47ee-a49b-3ab470a5336e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ThSh7nLSAanRQDp3INGY8MXI5Yq0kZDBPWCDVB9NJ/9SS4MLvJMy2yE5JKdVm1x4BeN6m/ed7wU5VSOB5YERNQrneAwQBfqEq2oePP1BZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB2417
X-Proofpoint-GUID: GmwQD_dH3PwnBivRIRygG6WHkNGeVzP4
X-Proofpoint-ORIG-GUID: GmwQD_dH3PwnBivRIRygG6WHkNGeVzP4
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=893
 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2502190081

Vm9uOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPiANCkdlc2VuZGV0OiBN
aXR0d29jaCwgMTkuIEZlYnJ1YXIgMjAyNSAxMDoxNQ0KDQo+IEhleSBEaW1pdHJpLA0KPg0KPiB0
aGFua3MgZm9yIHlvdXIgY29udHJpYnV0aW9uIQ0KPg0KPiBPbiAxMS4wMi4yMDI1IDE0OjEyOjMz
LCBEaW1pdHJpIEZlZHJhdSB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+ID4gRnJvbTogRGltaXRyaSBG
ZWRyYXUgPGRpbWl0cmkuZmVkcmF1QGxpZWJoZXJyLmNvbT4NCj4gPiANCj4gPiBDdXJyZW50bHkg
dGhlIGZsZXhjYW4gZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgYWRkaW5nIFBIWXMuDQo+DQo+IFRo
YXQncyBub3QgMTAwJSBjb3JyZWN0LiBUaGUgZmxleGNhbiBkcml2ZXIgZG9lcyBzdXBwb3J0IFBI
WXMsIGJ1dCB2aWENCj4gdGhlIG9sZCBjYW4tdHJhbnNjZWl2ZXIgYmluZGluZy4NCj4NCj4gQ2Fu
IHlvdSByZXBocmFzZSB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCllvdSBhcmUgcmlnaHQsIHdpbGwg
Zml4IGl0IGluIFYyLg0KDQpCZXN0IHJlZ2FyZHMsDQpEaW1pdHJpIEZlZHJhdQ0KDQo=

