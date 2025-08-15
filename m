Return-Path: <linux-can+bounces-4249-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DFB28282
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC9F18979F8
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4924BBFD;
	Fri, 15 Aug 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="HtR47fA0"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021097.outbound.protection.outlook.com [40.107.130.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7E1DE4CE;
	Fri, 15 Aug 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269871; cv=fail; b=tXRgKgRUxBtlNQM1RFzCIfPOyCHgQBqEBwwKH35phqy/SVfLnMqggowb48FfyecRXtT0G1dKOK2uKrFIt/JHneaXxijUcDa4PCYwsyA76ju8c+jv6AM+0YmrqcxSWnQa8ZEefxN5tY/hsK+RtuKouHXzkzeM3xH9Is7E5IqVrsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269871; c=relaxed/simple;
	bh=uZiMPGg4LvuBUBRmHTxYh68RC3x3HDWFL/y5uSQTC0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RM4g29nj0619sOHq+GheB92kfWfAlYr/eJc8bYVCTQauQX/H0jWEbh6QVi6yIz1+vkM8TkWnzpnzgbtUWvzCh0g9W/CRRrrCJtUrSv5+N9L4UxHjd0kBLB3uD36nfNKugKNNb2cZwU9QhhQvPjQgo5v+2b/tjpV4N1fEuFfchkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=HtR47fA0; arc=fail smtp.client-ip=40.107.130.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hibVscWP78b8ZPh+B/J3RAF0KSUZs1kN9IB9MRqrnqAnFkn5tDtwjFoy3494npg40hqFndphVPS0qX6COmed5zlmzBlSdVEXmGdQSxFcBTdd2JMzcVf++dtB72yIk93AFIxngtO3u6HyxlEhzXweFSlqOcY031GgGNo2O8uHuj36HEJS5fg7PSwVXUq3bK9bT7oGe2d6Ojcuck5GdmXXeAUVcViZ9F2kvWrZf1iYNOegF36h4xIrBRO778UCQCaSPsdLehtTtp0FEkFdA+fU+Z4VLKWj1KsnuDbwYfVR29lfpfjuGctHfpq470aAShumgp5c2i9DeU00/yMfubfHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZiMPGg4LvuBUBRmHTxYh68RC3x3HDWFL/y5uSQTC0s=;
 b=fHUOm/6/LcE2UjVKU88WWM61cKJnl5f5FcXTs0QzFqUCoTY76B7AOePiTfOo26Obno/B5t9CFRn/KT7kG3UbW3wyU0WFLjKl1cm+TKJDH8B735QUXRN/k3tIJ3TYtegGANBgRXHJn2RNmxWytdUn0wjBRbAjQa+uhW4R9/1WPq5s0e0RFNqwadT4ygAAcglFBQWRu4gJJ249ENVcXXzJWA4xP7igVZVo8HJ7dtiVKpJ5gmEDG6up7Tlh7xMCRiAHohGYOONBRLOqzIjkuhGgU5U2rc5vaaKhifBznknvJZMGFwXn6KeaxtjU6NAvfcDN/Re4eCcgr9wDhAIVh0t19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZiMPGg4LvuBUBRmHTxYh68RC3x3HDWFL/y5uSQTC0s=;
 b=HtR47fA08/Wx1/SC9h0pXwaw59vHaCLi7B8lslZkVkc6Lvco1+P/Rer7ZLCEsMxop3wZchpDmLmaTx4M3Hl3+nyAode3uwnOFlvdpmYu5i1JaBx3kQDEDuA491PsYBAfCPffCtknyGeykEnHFxjVr4j9o5YwYFKhdI4wBCSXztA=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS4PR03MB8627.eurprd03.prod.outlook.com
 (2603:10a6:20b:58a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 14:57:46 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 14:57:45 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de"
	<mkl@pengutronix.de>, Frank Jungclaus <frank.jungclaus@esd.eu>,
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>, socketcan
	<socketcan@esd.eu>
CC: "horms@kernel.org" <horms@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "olivier@sobrie.be" <olivier@sobrie.be>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
Thread-Topic: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with
 NULL
Thread-Index: AQHcCwPFrmv+HBR/vUi8Xlz4VVGjrrRe9KIAgATfPoA=
Date: Fri, 15 Aug 2025 14:57:44 +0000
Message-ID: <9e30abd4fe42b56158debde0caf71ebac89cc8cb.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-2-stefan.maetje@esd.eu>
	 <ee619a2d-a39d-4f48-ba18-07d4d9ef427e@linux.dev>
In-Reply-To: <ee619a2d-a39d-4f48-ba18-07d4d9ef427e@linux.dev>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS4PR03MB8627:EE_
x-ms-office365-filtering-correlation-id: 9f30fd5f-8c31-45a6-8382-08dddc0c17ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlkxRXJMbVZxSFhmMjd2T0ZmTkpHWis5cXFxdmhmb2U4Y0tyb1kyaUloRDBn?=
 =?utf-8?B?VldaODZncm1OamJ2SERLaXVQM3dMS21IQVd0QkZzNUh6dDlxL3BLOXdmbGFR?=
 =?utf-8?B?Y010OUZYYmNSSE1xTDMvNHUyaGQ2N2NLN0pYUGgwWUVjMmk5QWlQekx4WkFK?=
 =?utf-8?B?VXMzMmtUSmI3VmFmU0ZVTVNsZmdvTGpDSHBldG5WWHJ2YWp3cTlENldSb3g3?=
 =?utf-8?B?anZjNjUrTVVHN0I2K1U4VzFBY1BBa1VQSHJaOFFUNi9uSjdpd1hEVlUvNldX?=
 =?utf-8?B?bU1SUHp0WG1lVVhuRHFnSmhTWTdVd0pVMVVreVd1NEFLS0hoUmhoVlk5WFhq?=
 =?utf-8?B?TUc3c1VVb2hRV2x5NWl3aERra3J6THZQMkNIWGVmYm9KcnhRYVEyZ1FTNUhy?=
 =?utf-8?B?OXhhcXBER3NvU1ErTmhNU0svUHVoQTlqZm9WdXNjNTBFb2liMElKckJnWUFV?=
 =?utf-8?B?S2hEeHFDYk9KMk1ZQy8zZlA4YTRtVTdHbjQwOHVmay9RZEM5NDhDeUsvUVQ0?=
 =?utf-8?B?TU9kbDRvVThlTEh2Zk83R3dtOTBOUEdKcGx5LzdzUTdqWWR6cXpMUlRySTR6?=
 =?utf-8?B?b3dxU0l6YTFQVVpOTHhyK3pWYjZNQjhEbERMQStPWHRqT2ZlTlJHTDR2N0Uz?=
 =?utf-8?B?TWYySzNob0Y2YXhxc0JkemVSa0FFVkpYalRQQm1IYnl2SnpsUDZWS2lUTXJy?=
 =?utf-8?B?TFd4K0RsdU1hL0NYUjY1TEt0UG1SemxoS2dtYVEvc0h4Z3lEWE1aZStUc25q?=
 =?utf-8?B?d3NmZGhCWDJmbXF6ekxUSTNoU0h3cmZVUnJTNVRETDNrY093ZTBuMzlRVFBG?=
 =?utf-8?B?T0ozM2Jnc0lCQlppRkpyZFBzbzZIaTQ1Wktzdk9abG85a3VSL2NNQXRWUm5O?=
 =?utf-8?B?ZTFFTkZ6UzlVRDJDQzFYODNDNHF2VUhJVUp5dmYxNWxXYWVsN3NsT1dhVkNt?=
 =?utf-8?B?Y3p6Ny9rT24rdzM4RUkzdWxHck9TenlqbGtPaUtrV2NXWlY2TnBmZlBpUDZV?=
 =?utf-8?B?WXBvMWIxZEYzbitmSWE1YjBBZ2NZNVd2SVRDS2V5YzJOeEJMN3NNOTVvSFpZ?=
 =?utf-8?B?UjErSW0rWStOMWt2Mkdpakp4RjNxaC9KY3J2UDJLdldNU2dRSkc3YU4wcDMv?=
 =?utf-8?B?eDc0MFYwdXoreWlNYm9tVG05Zmx0ZldPT3lBMUI2U0prWll5RFc5Q3NSdXJS?=
 =?utf-8?B?SXlsMjRTTHlMa3JEK09NODhNSjdVTENHRGxTTHEvU3Zab2pyYVVzOW5IUUla?=
 =?utf-8?B?Qzk2RldXT1I4NEpmRC9xYmlYZ01QbjdpMFpnME9La1FlR0xWTDJ4OUJIMThV?=
 =?utf-8?B?d05xVXZESVRZaDYxYmp0SlBhRWdES0tmSDBrVXdEYklyODhtMUdSUkZFT0p4?=
 =?utf-8?B?akJhQ3VTSVRZN2phUnp1d3hHcDVVRVZXaWZHNk9jdWlYd0NQOG4rU0hCRC9s?=
 =?utf-8?B?TW96elprQTQzZWJCMDdMZldKMURFOUQzSmxjUzlVaHhFSHRBSWp3cDJZV09W?=
 =?utf-8?B?UkpPV0NYWkRlaEZHN3hndks0RTE1NmpMb0ZFUHNkVFhqUkNtRnk1MFZkMHZx?=
 =?utf-8?B?SlFFQ1FlUG9iRi8vQXUyVVozeHBIS2pZQktUbmRrZW5Oajh1NVllTGhsQk8r?=
 =?utf-8?B?eFo0K1BpV3M3WFh3QUo2TVRKTGliQmljMVg1eFl1TEFMQk5PZmFIQ1A0OXFM?=
 =?utf-8?B?RXV2ZFN1REE5WDU4UHFkYUUxWWx2UndVSS85MGh1dFovcTdaOTdEeW9RVktS?=
 =?utf-8?B?eGZ5K0hKYTlNcHNmTzR1ajZHYUlZVkpqTHBvVHNQNWw2QmxRbU9FVUQ2THBK?=
 =?utf-8?B?dWNsMW9kZWhTWTZGTU85RmJGaUd6U2NLWjVnS21GUlE0RERCY0dZRFkzdmF5?=
 =?utf-8?B?UVpjYnNDSFBzUkJ0Y2ZTRkxZd3RhZGlyeHd4cGNpQmxNZnRiNms5YTZSejFw?=
 =?utf-8?B?L0VtRWpQTEFnMEhZNEM3eHZ2ZmNJZFV1SDJxMkhwWE4zMnRhYVU5RmpTWDZY?=
 =?utf-8?B?OTFUMUg1N0Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REp6QS9YUnoyWjIxSlN5dlY2a3NhVnBWNG9xRzA1U0VqbERPeWlCZnlOU3BH?=
 =?utf-8?B?R0ZPK2xld1RIV04vUlhEbEFGT3QrQ1NIN0EwM1c0VmVUV2NFdy9RRWxJa2RP?=
 =?utf-8?B?Sks5U1o2TmVob1RIcVNNaXRlZnFFYjdrSU1HaGtNTlBNbVdxL0YzaDRjQkJL?=
 =?utf-8?B?REJyL3dvUjdnaXpiUEllZnZMcm85Q3JwNENiUTZyQW5DclFtVXFlK0UyTEo5?=
 =?utf-8?B?WndOaXd2N2VqaW01MUZFcFhEL3Q3WFZEa21JNW1zZUxWdjBHc0VFUHVqWktB?=
 =?utf-8?B?Tm8vaDVPbkZvN0JjUU1aOE96aWRFeEVBR0NYY0NNVFhhU2JCa3VEQ2JOY3Y0?=
 =?utf-8?B?UVpMa25pMHpBekg2NzBiUmlFU3pSWlhCOHA5VnpGZHJ3S2FsTFZBZTJrOGdL?=
 =?utf-8?B?aytwSVdjTFNBN2pFdmlTVkRXTk03S3BvOVRJU01Bc0RLZW5IbHlXZkNZbTla?=
 =?utf-8?B?WHd1dnR5c1VjYTNwUERmK2VIdlp1Z3FPYi9vT2ZZYkZRN2dwRXNmVndyS3BU?=
 =?utf-8?B?VFBVeXdPLzdIWXdXMHFvbXJDOW9KVzVYQjVnY09yRWVaQVpUSm5TMEdNWHli?=
 =?utf-8?B?ZnNEdE1uYlN3N08yTEpiY1A0WFBFMlpoUUw5TGovYTZocXJxWXZOMEhpZFYw?=
 =?utf-8?B?YzM5YjM2cmFDY1RJQUZSSFRBalAyTTErcGRySFByRVRCVGpkVjM3UlA0SmhP?=
 =?utf-8?B?bURucEMyMUhGc0ZFbDBLTHNUM0hLNHR6YnZQUGh4YXZiblRMaVdSYkYrZmd4?=
 =?utf-8?B?ZE1Od3FhL1dkMVFJQmEzZnJpQlY4cWxQNVF4LzJNeTVBaHRTSGxKRE02LzJR?=
 =?utf-8?B?TFE0akpPVitYemgwYXhSY0dmRXNVZTR5QjkvcmRjL2JvQmNnR2svbGw3SHlO?=
 =?utf-8?B?VkFIckN4MW9MYkFGc1htVTBPT1djWU5PbDFBZ096MGdTZ3JDVDBjOGMvQXNO?=
 =?utf-8?B?QlVoRTZ1Z1FmSE5oSXE1TXkwc0hXRUxHbFdyTXMxRVNIclZxK1hCV05xZ0VZ?=
 =?utf-8?B?NkZBSnFBeWpaZzhwcWdISVdCZGZ1SGhseXpBaVR0aVZtTHBhN1ZvUHAyZk53?=
 =?utf-8?B?NnkrTDhKb09EdWtwcXIyVDE0YXJVbzVkaTlyKzdnelRlWHNacmwxSVJzMGVW?=
 =?utf-8?B?OE9VdWYrclZZSkIvdGxEWHdIelh1cm5lQk95T3ZTNWlnOUw5RFhBc3NrUkNH?=
 =?utf-8?B?b0N1NEtTc29PamNDZXpGdDVQUXhSUGkyOHhYTkttNFMvZVhWTVhUOGlheFJo?=
 =?utf-8?B?ekxEL1FhMUlWYWpJOUVXd05ZY2NuV2U0aTUyR2E3bWo2V2tWbHNsd2l4WnZQ?=
 =?utf-8?B?RUZIZ3A1SU9MNGtzVjhES1QwSjVuNElNKzI4aHNBT2F6U00zNU1TU1crd3ZH?=
 =?utf-8?B?L2NMaTZDWTlHbXRTRDAybDJMNytFNTkwODlZUmdhZHJPcU5RUFpTak1NTkpn?=
 =?utf-8?B?eWpPQVVITU1UTkYzZFVRWDNtamZYZVUzc05DdlpRM0Y5TlFSUnFoZVVjTnBp?=
 =?utf-8?B?cWRIZ1NGWlNnRmJmUkN0L3V1cExrK01TSTNra05zMGd2MEp5Y1lPcHNYVFRv?=
 =?utf-8?B?N3JOc09WNU1YUFZzMndkY0dWb3lhZ1I3QVNvcDVUWGRqNkg5eTliSXh6c3kz?=
 =?utf-8?B?YzZ0N2cyd3RQM1FORGhoMWdnTU9aWTRpWnlzbmVkUEEwdml5bWhqOEdycUZD?=
 =?utf-8?B?TWUwTkl6YmpnZE11NkQxNFZ1Ly9uRnFjNDF0bEpFYXVvZjBnakRsSzhqcmh1?=
 =?utf-8?B?VW42VHFhYm93YktKSHl3L2lmaU0vSUswVlpia1VubUwzUHVoS0R4N3VQd1lk?=
 =?utf-8?B?ZFlrRVJjWjVlRDFnWnNjdWxJRmMxYWd2ZDBMS3pTNGJ3dDUyZmgwNUYrZThB?=
 =?utf-8?B?akEwOTVmcWU0akdKSTlvZmIwOVBMdnhVOWhzR0c4L1hGUm43Nk9oK3doTTFL?=
 =?utf-8?B?dmRZbTRESFRvV3hTTnNieGdyRDJ4dW5paFRVNXlQWG9WYkN3dWExZ3llWG5N?=
 =?utf-8?B?VXhHb3NwdE9ya2Fjdkllek12dTZTdCtPTHlvcmwyRGdiMyswZ0JEbllHOU5L?=
 =?utf-8?B?ZXVYOUpVM1MySXNDM1BtRUtrNzVMSmt0RkR3RTIwVFlRZVZwQVE4dFB1VlBM?=
 =?utf-8?B?YmxnMFNPSGs1ditHaVcvT0o5KzBPRDBEakx3YTJ5S0xaWUdBNzgwYmdPNWVT?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BFB1596BB18CE4188B43875A8C4195F@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f30fd5f-8c31-45a6-8382-08dddc0c17ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 14:57:45.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8zTq7j7s2WBgP3mc2Ktz7pkA6Ikw9Pc0AEY71XTpMag0W3k4Dl19z4RRvgJbQzWYkK9Fx/m8ZfhwloKoptfRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8627

QW0gRGllbnN0YWcsIGRlbSAxMi4wOC4yMDI1IHVtIDEzOjMzICswMTAwIHNjaHJpZWIgVmFkaW0g
RmVkb3JlbmtvOg0KPiBPbiAxMS8wOC8yMDI1IDIyOjA2LCBTdGVmYW4gTcODwqR0amUgd3JvdGU6
DQo+ID4gSW4gZXNkX3VzYl9zdGFydCgpIGtmcmVlKCkgaXMgY2FsbGVkIHdpdGggdGhlIG1zZyB2
YXJpYWJsZSBldmVuIGlmIHRoZQ0KPiA+IGFsbG9jYXRpb24gb2YgKm1zZyBmYWlsZWQuDQo+IA0K
PiBCdXQga2ZyZWUoKSB3b3JrcyBmaW5lIHdpdGggTlVMTCBwb2ludGVycywgaGF2ZSB5b3Ugc2Vl
biBhbnkgcmVhbCBpc3N1ZXMNCj4gd2l0aCB0aGlzIGNvZGU/DQoNCkhlbGxvIFZhZGltLA0KDQpJ
J3ZlIG5vdCBzZWVuIHJlYWwgcHJvYmxlbXMgd2l0aCB0aGlzIGNvZGUuIEFuZCB3aGVuIEkgcG9z
dGVkIHRoZSBwYXRjaCBJDQprbmV3IHRoYXQga2ZyZWUoKSBjYW4gY29wZSB3aXRoIE5VTEwgcG9p
bnRlcnMuIEJ1dCBpbiBhbnkgY2FzZSBjYWxsaW5nIGENCipmcmVlKCkgZnVuY3Rpb24gd2l0aCBh
IE5VTEwgcG9pbnRlciBzZW5kcyBzaGl2ZXJzIG92ZXIgbXkgc3BpbmUgYW5kIEkNCndhbnQgdG8g
YXZvaWQgdG8gc3R1bWJsZSBvdmVyIHRoaXMgYWdhaW4gYW5kIGFnYWluLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQogICBTdGVmYW4NCg0K

