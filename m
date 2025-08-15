Return-Path: <linux-can+bounces-4251-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D94B282F1
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A868817AC10
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DF2C3240;
	Fri, 15 Aug 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Wl8YfE6k"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023074.outbound.protection.outlook.com [52.101.72.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935044315F;
	Fri, 15 Aug 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271769; cv=fail; b=NfBl7WE4SQwGN3ES/hXeuGCfx6nxq/ULOY3nUduq6DY81SOPTh4zNw/uH6Tqbar6SLGsBJynrKzEajMrZ1cwDXaWq4cgMKVzvqdEZrgfQR0WfBn5hBccwlV7wAqe1tp4CzjO3sMm/8rdaUunKXh4oooepGYTRN/smvfNQNdQ7/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271769; c=relaxed/simple;
	bh=bm/Ag5PGpQBr04sO3bD8M6rM/H/jb4N/9Eeg7d71274=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/rTNsOXInNqZKXkrzcLEKdceq/ZFVHhODqHKVJ1JHY08r3cdAmvAZSTbYkj0KT+sXNiH5IfLOXEj8fO7+9kDlzEVbzDllQoQNCM3epBtCpzzIqL/JkUSTgAIme/rmlmdQzzpsrO9QFUrZGGJrQd0fyAUhYlkyhLXV2EB996YQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Wl8YfE6k; arc=fail smtp.client-ip=52.101.72.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzQVcddjDZxubvTzBDl66CZ0MV0HDWSmjefO6PiYxPLD0+zUCYWod8lib4p/QhA81ktbbz1w0tnOLWdC5kYs7B0kVBimhYmzm5RfFBbbU7yzpy8Mstbdl9egcS/yO6bBV9TKf9avWp+obdQh6XfVeH1jBcSPpV7IVCOvsR7PpBVuR1VFOE/crbVa2HuqcVQIbpS8bUN5q8JcVcSW88TPfvBdIxRzy3KJjR6mXDtiJErPhkxfJ8ndP11ck9hIByDswnm79Qr2K6aCLgpnuLenKhBsQB7G8yLEj9wgI8mTous+/rCZ/GkIO5deIoV7pDED+2mm76GhNVNt84qTdYWeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm/Ag5PGpQBr04sO3bD8M6rM/H/jb4N/9Eeg7d71274=;
 b=tekOKGiny9jNuoBXB+eeBVaQPxmBiZ8XxdB7PwqQxB6xwjeLHXBPlEX60B7e8QuCIYO9FAAlhUBzUwb+jSkNZUFHpH5PAoS+Q6ZVNSwFGCZLUhStN4IVZw7i0NJ9r0CrxzgxGOxQL1byttIwpXI/06/yaAxKUgYSvU7Xq8Tm3Bou94Hart6zTGbn68BziSmDK3+VWK3AcyaiIXidr4Mvpx9HDmkrM77HtMOuXCyDQQi35hOTPD7DTzC5zB6jf+hiaNVsY8cxtv9NS1Ci47LDPBqFGUktyO7TqV4vpnqWHUtMen+CuZuYTkGYOBdxr+2KFg7mNMWXONt8KwCnI/J2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm/Ag5PGpQBr04sO3bD8M6rM/H/jb4N/9Eeg7d71274=;
 b=Wl8YfE6knGCmYxTZ6qYlDyN3mLbJVILWtDGF67xZvCWFSiBPzeP2d8xG0eIKRiziOh/pZBJiVcznaSqdFmaZuz372g6oSdZoclRGi1timiHFA1vPiDlaFRfg7dFk06hAfH4j0JKtuMsoZAIbXb4XeO7DE6wCnHjgmaUAYaEqYyg=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by VI2PR03MB10980.eurprd03.prod.outlook.com
 (2603:10a6:800:298::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 15:29:21 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 15:29:21 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 3/6] can: esd_usb: Fix handling of TX context objects
Thread-Topic: [PATCH 3/6] can: esd_usb: Fix handling of TX context objects
Thread-Index: AQHcCwPGsl1+WK4xN0ue1LGfuB8DwrRgPosAgAOeKgA=
Date: Fri, 15 Aug 2025 15:29:21 +0000
Message-ID: <35836b8f8b2d8e08679fa719a0f7902928fdc1d3.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-4-stefan.maetje@esd.eu>
	 <20250813-translucent-turkey-of-force-96bb34-mkl@pengutronix.de>
In-Reply-To: <20250813-translucent-turkey-of-force-96bb34-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|VI2PR03MB10980:EE_
x-ms-office365-filtering-correlation-id: b0686174-3258-406f-b4e7-08dddc1081fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUE1cE54VzF1UDlaY3JBdTI4eENna0oxTFpCYzV6VjFjRzZFemNOUXlUVTJ1?=
 =?utf-8?B?MGROenlkWDlhS3BLaGJHcHdpaktKR2pWQ0xVdFJucjNVOGpxYzlET0U2VllX?=
 =?utf-8?B?VmVFdlJWdmN3R0hoQUU4YkgzN2JQb28zZ2Z1Y250SUJ0djZVOWNrRzJzcE9P?=
 =?utf-8?B?KzZCa0h5Nzl3VVZUeGJ6eHRoV1JXNVpPUFZtc0dhNzFUZDRsMndKZkg4YnBu?=
 =?utf-8?B?YVV1RjNsZnZLTVNPOXUxNStya091bWdVT2lkMW9leEg3NGQ3Y3JMT2ROUXBm?=
 =?utf-8?B?c0EzWFJLeHpPSkVhZFQrRVZOYTg2ZFljR2pPaGRybk9ndU9tVzVRZ04wK3Vo?=
 =?utf-8?B?WGlvdzBJQWhaSjRJajFiK1B1STY0UUV3UHNBR3lvWEZrWFUwOVpHS3N2NDJ3?=
 =?utf-8?B?dVdCUzE2KzZEcFB6WWlzRUoveXBPWnJHM0RPdHJ4RldwVEpKU1VCcWE3TENk?=
 =?utf-8?B?aUFhWTVKZ01iT1hKWHo4L3l4MkVxVVZxbFM0Y0xFcDVCUitFOWx2dTl1MmFN?=
 =?utf-8?B?ZDc5V1I3ZWNQeEVlYnhaR0RYazBCeTJxTGNMVW9sV0h6SUFFT0orNldmNDJa?=
 =?utf-8?B?cUMxQmNVRlg1TWYxVUJ3UENJSk4zR2llWFRBZCtsWk55cVVVZWRPdE1ENmVY?=
 =?utf-8?B?Sjc4STI4bUFIMTRSOWI2Tkh2NkQ2TkhoVUtBcGo3ZG52aWJlY2lRZEtHS0Zl?=
 =?utf-8?B?aDhmdkFsYnFVN29nWUNVcmZScVh4S2RCQlhNV3hkMjhndjhOdkZBaU9SQmdX?=
 =?utf-8?B?KzdPcXF0VDBBbjhJTU05Z3VPT25tVkk2ak5xY0IvOGwxWWdPU0NMNTdGcmhM?=
 =?utf-8?B?ZkNzUHA5Zk45Qlc2SlhOOXV4K2lHVUhFWFlNSHNFdUpXcC92RWw4aDdnRDJ5?=
 =?utf-8?B?dlBnOTd1MEdHaHlOQTBNb2FiQTZkVlZxWURKNGZyQXlRbXZTZG1Uc2t6c1V0?=
 =?utf-8?B?ZTdBeWxqMTJCdXRGYmxsWUh4VFJONXdWeksxci9iZjNod1ljTWMzMHRFbHpE?=
 =?utf-8?B?cXJYYWE3YTdmTlk4VGVuaWdFKzVPRFN5TTQ1ZkRUZW56SW8vNjltc0dCUXhz?=
 =?utf-8?B?RmFKbkdoanhXNUNLRGxBU29uNlZhUzhWRWJiZHNKRzNNU291cTh3cFhuemFh?=
 =?utf-8?B?K0NsMncyZEt1L2xIOTJuaUdoZEV2cHlOYXpLbFZWYnVnT3FWYkJLZHB3eWM3?=
 =?utf-8?B?elNLYTd0bHkrRUhQcnNDdFFma0F4UXR6TmFaamdmK0JNMGNad3E5Z1lGV2xl?=
 =?utf-8?B?a1pubFFUeXFLL1BEeGJwWDRraG9qQlo1YjgrU3cyeko2Rjh6K2RNRUMwZ2FC?=
 =?utf-8?B?Nkd1aDRkOXRBaE9QUVBGWEFXNmkrK2xvYktKKy85WUJ1YVR2azdORHdqWjcx?=
 =?utf-8?B?K2owa3hKajFXU3ZBMFJoL0lPR2VDUFdSbDh3UDRobTBxbVZDSVJZWDhTMkta?=
 =?utf-8?B?S3dsWlNPQlBUdGpkNUN5NFFEbktDY1o4STB4VzVpTmVaWkxUYXJyRGdVMXYx?=
 =?utf-8?B?THhIRWRtWENNbEIvQldORXJzenQ5QXV4NDNKdlM2SlE1ZmFmdUw1YTFrdnBI?=
 =?utf-8?B?Y25raUdtNE16MFFUdjBxalAxcjNTNS9OdHRhNVNReVAwQWhiWlNOZHVFS2lp?=
 =?utf-8?B?Q2Q5UkRzYmNiZWdFbVhlUDNrSUxZdmFxWXJJamVBcyttYWNuNWlaeU1KYS9L?=
 =?utf-8?B?TGlJT0llYkU2alpDZVB0SEl2ajBWdlNKcVFJK2MrbS96c2RPNkpTZzBPbFpY?=
 =?utf-8?B?a0lMV3psQVFod0dMdm1SRU1VSFVNazVUOU5KekNtUWxxNElUa0EveU53S2hn?=
 =?utf-8?B?dFlaTUFZVFVMSWJHMEJnNzl1R21aeTFlVXJ6d2hGcmlKbkFIRjJaUUtmanYx?=
 =?utf-8?B?MTB6MW5Qamw1YUM2aXJxNTdrcURlTGNHeHJiOUxseGZUaTl1Q3pUWG5JMmxs?=
 =?utf-8?B?YUNOemNGVUtYQXcvMFg1WGd1ZzVhRWJOSXA1NnhVaUYrRGhubzRSUkZ1Z3hH?=
 =?utf-8?B?SDNxNVFIM0dnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmcvT2t1ZHZZR1NNNllTY01PT1VEeUdDanlwOUJ4Mk9YNmhRcllmdlFjbGYy?=
 =?utf-8?B?UzkwQ203cE5uQnh5VTc2ZlFQSVFnNFlMQzRhNlVzWk9NbUZ5K1c0c0R6OVdl?=
 =?utf-8?B?SnRSUVVRTXNUMUgzZEpVOVNuZWJJQVpmaDg4RVl6d0gyZGtXenlNbW9MRjJV?=
 =?utf-8?B?R3BsbnpERWg1VlYvbHp2VnNuRXl2U0RURWVyZXdGVDBRTkVJOVJFYlNYcWFP?=
 =?utf-8?B?NnpYZGlTR1RJL1hwK1pkZzl4Q2IyVzJ2MnJpd3h6YmRkOTJ1dzluWUhUdyt2?=
 =?utf-8?B?bVl3RlJrdGEyby9BTlFRYTJtdmdQSTZQZVp5ZzdzMGhzV1Jic0ZrTGNhM3Ro?=
 =?utf-8?B?T3EwTHI3YS9KdExlVDBZYVdYYVh3T3IxRFJiUzl1THRQc3k0TzRlZGVWd0dt?=
 =?utf-8?B?T1o4V0VVQlg5SndQMWdEZ1lCTmNhak5sK2xSWlJlM3hUS1dOdnVzcmUrUHoy?=
 =?utf-8?B?QndYSWRubC9Wd01LQ01aWWFQakVFdUVKby9FYnJ0bUVnQ2pja1p3MGpnc0JO?=
 =?utf-8?B?ekVkVk12eWp5VVJtODh0emdWSWV5Ukd1a3ljMVE2T094Z1lFcTQyME9uN3V2?=
 =?utf-8?B?U09QSGhSck5kaEp4MHlTM1l5a0syczRKSkYyRUY2aXFqUGNxaVBTSlpDdEJj?=
 =?utf-8?B?MkpZWktvUjlGWWtiM3hySlhNYWJBVTBXcnJSUzNpMjlXSm9pbWpNYXhoQVpI?=
 =?utf-8?B?OW9TdVJLd3k0aG43QzBXbnUyV3dqVlZhM3A2WWtnSnBhNmprdUdhMWhkYWVY?=
 =?utf-8?B?TDJMbXQyTDlpMHBIY09OdlFROG5jQ1E5TVBNVWU4ZFJJYnZtTURhdlBra1Zn?=
 =?utf-8?B?Ym00UWlzKzhobjNlQXNBcjVJOG1Gd1N3L2RmU2NFQWxWNEpZdU5qdjJ0VHhn?=
 =?utf-8?B?NGdYN2pualltZGpGY1ljQklKRUJKVWtzZ1hMSm5JSTFLcVRpL2NnSnZOeFJH?=
 =?utf-8?B?ZmVzbzBZcnpWUGxsWERocDRGam9XWmhTV0hwQmVZem1pYk4zeFNpYXlBSVl1?=
 =?utf-8?B?L3dPK3B1NDRqazUzSDFXNGRNOEZVSmtjd0l2SDhXNnFKVE9ML0MxUHRpZi9p?=
 =?utf-8?B?bXI0ZUZjQ1ZUWlYrR0MrcS9KbzJxazF0SHMxNE92UE1oK3N3eWkvckdFMS9s?=
 =?utf-8?B?c0pnZUdlejFhV1I4TVhLdVlIcFF4T2pUc0w0NHVBbjJZSmxsRkxtN0k2WjAx?=
 =?utf-8?B?WWFrYi9jUTh5SlZxb21mQ0FvYUJlZUhHam14aXVIMEhLWEM4cHNCemdyUHd1?=
 =?utf-8?B?aTZkWUd4bW5RVWZSUzRCLzN6Y21DdDlUZVN1SnZCbWpwTHFTQzQrdUF0WUp2?=
 =?utf-8?B?azB3dzlpNEo0OGJoUXcvNjdNeDZlU0VBNUV1ZU1ZSTJCa0Z0UEsxOGxRQUdi?=
 =?utf-8?B?RituajAzSXd4UUFkeEMxY3hkV2RRMzNCOTdzUUk2elFxbnN1SjU3WSsrNXpN?=
 =?utf-8?B?OGNlUm5VaU1EbHFGK0k1Y0Ivd0JhTjhBZ0NJZVh4OEdMc2swMEFwMDJvUUtG?=
 =?utf-8?B?SWNLS1o4Z3dLaTFRRVg3dDBTZkovdjZOSXpCeGwrNWNLeGppUW5nWnpuMysz?=
 =?utf-8?B?bXMxSVNkM2lZNkZPd2hhbEJNZWg0QWxHNk1IcW1BU0VyNE1mWjZrRENuZUVt?=
 =?utf-8?B?UjgxeG80WGlQWWpYMXk5cVZuWnpoa081VzFONVgweU04OGdXSFk2UDdwK3V4?=
 =?utf-8?B?UGNMN3IzZ1Vyc0hxSTdjY2kzOURKN1A4UVNDS0JMQ3RFdWxJU3VpeDNOZXBS?=
 =?utf-8?B?NmNKRUtXc2s5VlJxazIrWFoybGRIUTluY2RjWS9lRHJJampwemNoVHoybCti?=
 =?utf-8?B?UnRjamhoRGhKS0Y2RDZjR3VwcC81RkVPNHFsK0tXNStNS2kwWk5xVUIxZ1FB?=
 =?utf-8?B?TUh1bG9mZUFGOHdUem5DeUY0bVNxcTB3dWFRZG02MFZmMm5vYVRpbGNmbkJx?=
 =?utf-8?B?VGdqS2VMd1dyYmNER2ZSSmUvWXhSdHZjQkVwSUxmZ1phR3VmUy9VbVd1UTlU?=
 =?utf-8?B?dXlCclpxWUg4ZWpKeHBoQkVTb05HK1MwY2FrcDIvclZLZEZXOUZtcTZQQWI0?=
 =?utf-8?B?ZG9VU2ErVnRoN2FDZDVKa2dsemdCazNKZEFXZzhJUlRSZGdGRTBBNXd2MDln?=
 =?utf-8?B?Q0lQS2xGYUlRamFiUEM1RXFuRnZySnNMdjI3ZDJGTzArSnJCMHpEeFA0WFhR?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37B8EAAD0CDC024597FE4FD7D6990911@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0686174-3258-406f-b4e7-08dddc1081fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 15:29:21.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic73BvYpFSJAq7qlgPB3p6SLVPNTYXL/W7AE3Nh/wLI+SJktgaZPgZzhSdiNkhVzai/SEqqlrGBOgHWB2v/Q9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10980

QW0gTWl0dHdvY2gsIGRlbSAxMy4wOC4yMDI1IHVtIDEwOjE0ICswMjAwIHNjaHJpZWIgTWFyYyBL
bGVpbmUtQnVkZGU6DQo+IE9uIDExLjA4LjIwMjUgMjM6MDY6MDgsIFN0ZWZhbiBNw6R0amUgd3Jv
dGU6DQo+ID4gRm9yIGVhY2ggVFggQ0FOIGZyYW1lIHN1Ym1pdHRlZCB0byB0aGUgVVNCIGRldmlj
ZSB0aGUgZHJpdmVyIHNhdmVzIHRoZQ0KPiA+IGVjaG8gc2tiIGluZGV4IGluIHN0cnVjdCBlc2Rf
dHhfdXJiX2NvbnRleHQgY29udGV4dCBvYmplY3RzLiBJZiB0aGUNCj4gPiBkcml2ZXIgcnVucyBv
dXQgb2YgZnJlZSBjb250ZXh0IG9iamVjdHMgQ0FOIHRyYW5zbWlzc2lvbiBzdG9wcy4NCj4gPiAN
Cj4gPiBUaGlzIHBhdGNoIGZpeGVzIHNvbWUgc3BvdHMgd2hlcmUgc3VjaCBjb250ZXh0IG9iamVj
dHMgYXJlIG5vdCBmcmVlZA0KPiA+IGNvcnJlY3RseS4NCj4gPiANCj4gPiBJbiBlc2RfdXNiX3R4
X2RvbmVfbXNnKCkgdGhlIGNoZWNrIGZvciBuZXRpZl9kZXZpY2VfcHJlc2VudCgpIGlzIG1vdmVk
DQo+ID4gYWZ0ZXIgdGhlIGlkZW50aWZpY2F0aW9uIGFuZCByZWxlYXNlIG9mIFRYIGNvbnRleHQg
YW5kIHRoZSByZWxlYXNlIG9mDQo+ID4gdGhlIGVjaG8gc2tiLiBUaGlzIGlzIGFsbG93ZWQgZXZl
biBpZiBuZXRpZl9kZXZpY2VfcHJlc2VudCgpIHdvdWxkDQo+ID4gcmV0dXJuIGZhbHNlIGJlY2F1
c2UgdGhlIG1lbnRpb25lZCBvcGVyYXRpb25zIGRvbid0IHRvdWNoIHRoZSBkZXZpY2UNCj4gPiBp
dHNlbGYgYnV0IG9ubHkgZnJlZSBsb2NhbCBhY3F1aXJlZCByZXNvdXJjZXMuIFRoaXMga2VlcHMg
dGhlIGNvbnRleHQNCj4gPiBoYW5kbGluZyB3aXRoIHRoZSBhY2tub3dsZWRnZWQgVFggam9icyBp
biBzeW5jLg0KPiA+IA0KPiA+IEluIGVzZF91c2Jfc3RhcnRfeG1pdCgpIGEgY2hlY2sgaXMgcGVy
Zm9ybWVkIHRvIHNlZSB3aGV0aGVyIGEgY29udGV4dA0KPiA+IG9iamVjdCBjb3VsZCBiZSBhbGxv
Y2F0ZWQuIEFkZGVkIGEgbmV0aWZfc3RvcF9xdWV1ZSgpIHRoZXJlIGJlZm9yZSB0aGUNCj4gPiBm
dW5jdGlvbiBpcyBhYm9ydGVkLiBUaGlzIG1ha2VzIHN1cmUgdGhlIG5ldHdvcmsgcXVldWUgaXMg
c3RvcHBlZCBhbmQNCj4gPiBhdm9pZHMgZ2V0dGluZyB0b25zIG9mIGxvZyBtZXNzYWdlcyBpbiBh
IHNpdHVhdGlvbiB3aXRob3V0IGZyZWUgVFgNCj4gPiBvYmplY3RzLiBUaGUgYWRqYWNlbnQgbG9n
IG1lc3NhZ2Ugbm93IGFsc28gcHJpbnRzIHRoZSBhY3RpdmUgam9icw0KPiA+IGNvdW50ZXIgbWFr
aW5nIGEgY3Jvc3MgY2hlY2sgYmV0d2VlbiBhY3RpdmUgam9icyBhbmQgIm5vIGZyZWUgY29udGV4
dCINCj4gPiBjb25kaXRpb24gcG9zc2libGUuDQo+ID4gDQo+ID4gSW4gZXNkX3VzYl9zdGFydF94
bWl0KCkgdGhlIGVycm9yIGhhbmRsaW5nIG9mIHVzYl9zdWJtaXRfdXJiKCkgbWlzc2VkIHRvDQo+
ID4gZnJlZSB0aGUgY29udGV4dCBvYmplY3QgdG9nZXRoZXIgd2l0aCB0aGUgZWNobyBza2IgYW5k
IGRlY3JlYXNpbmcgdGhlDQo+ID4gam9iIGNvdW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbiBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1Pg0KPiANCj4gUGxlYXNlIGFkZCBh
IEZpeGVzIHRhZy4NCj4gDQo+IE1hcmMNCg0KSSd2ZSBsb29rZWQgaXQgdXAuIFRoaXMgY29kZSB3
YXMgYWxyZWFkeSB0aGlzIHdheSBpbiB0aGUgaW5pdGlhbCByZWxlYXNlLg0KSSdsbCBhZGQgdGhl
bjoNCg0KRml4ZXM6IDk2ZDhlOTAzODJkYyAoImNhbjogQWRkIGRyaXZlciBmb3IgZXNkIENBTi1V
U0IvMiBkZXZpY2UiKQ0KDQoNCg==

