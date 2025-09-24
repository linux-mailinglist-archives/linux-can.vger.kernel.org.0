Return-Path: <linux-can+bounces-4961-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229DBB9958A
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4609332285B
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D72DC357;
	Wed, 24 Sep 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="ADhW7Mit"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8E7E105;
	Wed, 24 Sep 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708334; cv=fail; b=e0IWBMJEOA5py7RQ4tbsdAw6ixHcjNPDHCAdUTDqfvJ65BkVO2Ky1rnl6Nira9HDkNgswh8PdFANMu+v2UKjTEpcSbl9Z51k/l+gXYtXf2AVPqZRJBkTBo6ZOKP3Sr73cLKmIyBwPEhqJyruFKkKfeMNtWIjspOhYZq576hd/Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708334; c=relaxed/simple;
	bh=SoAXfAnRCiGEWf6yfyh1PCdpprO+EXZvJHPSkGjxGFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrC/m3h4/PHOTFc4C66QxG9quICWfe34fEM0gqtcNP7R0csmlo/pr40jUYHwtxmeJJScH8vWzua94kkoS2nt9NCAVBOoZZDY06SyfGtjPt1hxmv6bSHQbNaVDUwjQz89XuL4x71dxvHFh6xXVj682aXJ8C9EEwNjd22YIwSCxy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=ADhW7Mit; arc=fail smtp.client-ip=40.107.159.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k69WkBPOIp7kcZvX93QSoWFkGX1Iy3IDOvJrkJL1EacqUTtYsEqw8CR/bbYEw1dIZi26PdjAyNVvSopTWF1vF8zrx1jOqEA9guj2rW/tAV1GfH7d2hUO0emYV6OKla+ssRl+ky2V4Ujt7+y9Mbus5N2XbirBSHgKEwXW5BjAFtLJBHSNcKrlZsE3Uo685Xued5vH9FPlMMJ3DlpmMKYtM5NT0t92mAHdmXX9whhyBeDg8w4Bg9vxgahre7KqCwEkwEUZ5fqaSlu3VWZ8pFsbAaw9afHHPFIcIoP62GapTgUOoQ8KwExAswsylMDtLGH+O3funtIz8c2x3Ep1uA43Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoAXfAnRCiGEWf6yfyh1PCdpprO+EXZvJHPSkGjxGFc=;
 b=s24wsRYfd340mqIedCDqJVnf/abGDxWCKqGQnfQjkJO/fsFB44c/PJkdcNhrIRhHvqTQQ/9VYpM3ap+gRkZkgz7NlFBlKyTVYeTMpVjGsDI+K+8mlUMUXcUGfpkeczHy5rGcNPlVp7kQri/qP0OTio6+lr5ECrzRKtGJ57s8YNSMK64s/BFfZLAllt0DTm5Gzq4J2Ud42bhTGvQiw6Qb0d9SLyF2ZVdBzwl/LynJMNMhONuZ9i7YRkSSgm4TlEpYx5mIA1rGE8OtCQqih34IOPJ95Q7vXw6zM+JGEOaw6LrMt9q9cvcyiKoL2vdDdl/O8pCCrYBke8YKdHBEkHKt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoAXfAnRCiGEWf6yfyh1PCdpprO+EXZvJHPSkGjxGFc=;
 b=ADhW7MitFZ8Qjiug0a9m9SJAkh+M70pPdtyBqameSCJZmK2fGqp/jfqwqpXgcQFyitIuxzK5amLC3b3oJ3SoB2JVR3SbCTw/CLX1Ha4IE5IMTS3RFRZI2KV5Z/FxOPafC02yz3YqqbeZkN08iXE1u+Qj/XSnq6vzoTV9qpq0BiQ=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by PA4PR03MB6765.eurprd03.prod.outlook.com
 (2603:10a6:102:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 10:05:24 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:05:23 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net 08/10] can: esd_usb: Fix not detecting version reply
 in probe routine
Thread-Topic: [PATCH net 08/10] can: esd_usb: Fix not detecting version reply
 in probe routine
Thread-Index: AQHcK6j5Xy+USGTRb0Kjt+dBKvg/GLSf50cAgAI24QA=
Date: Wed, 24 Sep 2025 10:05:23 +0000
Message-ID: <543c19b1ef99f9e4234750f401457cb1b83de2c6.camel@esd.eu>
References: <20250922100913.392916-1-mkl@pengutronix.de>
	 <20250922100913.392916-9-mkl@pengutronix.de>
	 <20250922171626.2ebb1e30@kernel.org>
In-Reply-To: <20250922171626.2ebb1e30@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|PA4PR03MB6765:EE_
x-ms-office365-filtering-correlation-id: 8a656765-651f-47c8-4efe-08ddfb51e0aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDloTUtMU1E2VEtGakhVckQrUUVoR2VxRzhaS2FCM05nNU0vZTcxeWRBckYr?=
 =?utf-8?B?WkF6ekdTMXE4OGQ2UU9EczVEOGRIZnBqeXl3N3lFMjJ6MnBheXhGRUFZWHdK?=
 =?utf-8?B?UUg1MXMwQzZ5eG9tTHFvdGFidlZ2bUljU05uY2toU2ZVeW5JMks4eE9lVml5?=
 =?utf-8?B?U0FRY2hXanlhUHRQRHI4UUU5d0dnN2orS3AzZ0JrSWhrRDVrNkFObElJVG00?=
 =?utf-8?B?VjBXeWJxNVRDREZ3Y3JaWlIyb3kwK0tDa21WMUdlU0pXdGNUcG1VT240S016?=
 =?utf-8?B?R3RPbHJnSkJEM2k4WWs1Mm14bnlWb2x0bFNMVnBUVGVTdlVuS0pPcHJOMGxJ?=
 =?utf-8?B?RlVyVm9xbTV6dDZINlNFcXFQS3BpeWhKbUpWM2ZyWmF3ZnhpdTQ2YjgwR3pJ?=
 =?utf-8?B?bEJDaWl1cmpYeUozMVFCeGppREVEcDRzTCtDR0E1MXIzWWh1UnFiclFmcE84?=
 =?utf-8?B?NStYWEJBYjNSN1c1WHFIdGlLNW0yQjlQMzA0R0VEaDl0Y0o5SkpHbU51LzlO?=
 =?utf-8?B?ejJZU1k0N3ZIQ0IwVGpHTjN2ZGJ6Tk5MeTE1Y0VmM2tZZmUwdjdReHpIMk1t?=
 =?utf-8?B?ZEtGYzhsTDk2bDdPZjNrRnVEYk9RQTVUTnA2YnVRMkcyS09VdWlaeHZDSnpu?=
 =?utf-8?B?NFJoZ3Y1RVFFL0JoN3MycS9ETTdYUTVYVTB0Y2RrR3ZQUUlhMDAvSDNja0Zw?=
 =?utf-8?B?dGh1TkRJbGt2eVpEa2lBRVM1K0kwTk9xd2kxUzdnK1JEMDl1cXNEN3RiVTQ5?=
 =?utf-8?B?RSsreGIwMHJ4RzZWeCs1cng0NXZkeU54WmZlaEYyVXhiaWRHTlRtcjdOZDVY?=
 =?utf-8?B?TzBRTzNQWG1iUVBYNXJLNUlRNmdhSkxCMkVFSkdabXBCQzF2b3JQUnhEWVhW?=
 =?utf-8?B?ZUsxbHgwcTM1SHZkQVYvZmZmMTAxaWhWU0kwSnhlL2RxcUpKeEduTWJBTFgr?=
 =?utf-8?B?VU56NzZjdCtrelR6VUtDOUpCeFgrMzFQSDU4T2VLVUhQMnQxcU8rZHNyMTlk?=
 =?utf-8?B?UVlmczdWdVRiU25aMXQ5TUpIVnVXbXNheHYvN24rbElrVEJoSDNaeXM3Znk5?=
 =?utf-8?B?b0R2N01RWGlpMkt4OWZBRWFpWW43Y3N6clBpUHM2NEdFS2FlOFBVajVHZ0Z4?=
 =?utf-8?B?YWZjYnRXV3RPcFBVS1JKN0dmeEFJMWdiaklrV0gySzNSNHFBNnBYTmc1UGNP?=
 =?utf-8?B?UHV5bmtlNVo4SC8wYmhPRWFkd1hzZTZ2WGhPLy83Qm9oZEJSa1N4NFJNY2xz?=
 =?utf-8?B?Z0djcWNzK2s3MDViUTRVNHJZTXlYWXBSSnBQUnJTdytQeEhYakNPY3I3dkl2?=
 =?utf-8?B?aEt2SHA4RHFwcjBCZ283blNUcHlIOFdHdlJlTnhISWtKUHE0ckpjelQvK1la?=
 =?utf-8?B?NTZRb0Q4REowbjQ2cGpiUnUxMWtYUUFBU3JHVFNnSVVpVURpRGRrT3o3T2t0?=
 =?utf-8?B?dDY5NmpZRUFUM1A3Q2MyMnZLYktNVmM0NkMzUUVsWi9NM3JKdnZuNzNWWnQ1?=
 =?utf-8?B?R1JGK1dlaDNDS2ZXMkw0K2wzM2xNMVJhYU91cUJIRkdlQndsRElsd3hWUXlv?=
 =?utf-8?B?QWp5RmFhNWxDMGdoakNwMk9LbXlSUEdGakZGaEI5MXFSQmRZZ2dzWk5QcXRV?=
 =?utf-8?B?SklQOTdUWm9hQW1HWnJ6cFZPNDZNOGxhUjVOSDZtYnlkSjhlRDZlQXZTZU5R?=
 =?utf-8?B?WDV2aTh0enJXU2tJbjV5N0wxdDdDQ3FWK3dTTUZXUmZDOUhrVHNYNm5RdEZI?=
 =?utf-8?B?MUw3elFPYTA3alFFeXdSL3cySkJpeGxCMmNGMEhvSlV1OTFvYm9ROEl4T1d4?=
 =?utf-8?B?S2pDZlFxSzRiZGRUdEt6WGlOVkxOYnYxQThNdTM2bWdFRllzOUQ1eE05OWVM?=
 =?utf-8?B?R3VsM3Y1MFhxaVFMNU9SWDY3ZllId3I1RlZVN3B2djJVemNvS3lJWXljNUR4?=
 =?utf-8?Q?IwykUyCSXeU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eitxK3BkcllNTFJ6cFZRdTdUU2FkUUp4alArMlBNbWxuWG5tM3prOEg5MnFs?=
 =?utf-8?B?UjFtSmN1VmlSZTFVUTlDejZ4N0NVRjFVYks1cjM1c2hwNFBZbGpiL1phZmhz?=
 =?utf-8?B?MWNKZEJVclllaDNiMHhMSTRKSHhNM3VGUm12QjlteHhlU1Y3Q2JaaXBKdjk1?=
 =?utf-8?B?KzlIakRqVmsxSkxJTVFCY2VPb3pRSndkUnRZRUswRXh1U2tqQThIdmdWeFRo?=
 =?utf-8?B?Z1lHd2Qrc0dIZkJPSHdvQ3M4T1VnVTRhL0pXa3lCb1J2VVhScXZ1VFdMUk1K?=
 =?utf-8?B?YkNkbklrYTBJaHNZSmxWZDdEQmpYNHY3ZjhsdGZzVFloUjRNQVhNVkFmWEFh?=
 =?utf-8?B?dnhOcHpHSG1ieklKTUljZzlRemZQOUtnRG1EdE9na2N2aGhvTHJVZk5aNWk1?=
 =?utf-8?B?T0d0WmVRRTJjMUE2eGtHQWd0eWxGd3VERmxBWTBBa0dIeWd4OXlGSjlhNFpO?=
 =?utf-8?B?MTBPejNCeXBSMzVST2FRb3dPdGZINFIzdzFJSUNlTDgxT3k5ajN1anB5QWUx?=
 =?utf-8?B?M3o0V3d6S1NZV0V3SzdpSjZoc0pvVTRLaUNFQ0tvZ1VkbmFqYm1qbFdYNFBn?=
 =?utf-8?B?ZmFEbzVxRXdNNzNVMzVrNnNKNUJPVEI2RkVsWllBNm5BYklPWnpaN0V6RVJF?=
 =?utf-8?B?WTZyc1pJVEVrK1NhOVlDRnVvbGQrdW0zR08yeitJaXF3UTN2ZnNTOFdROGlw?=
 =?utf-8?B?Z2NEdGtJZERWV1c5cVZ0VWNvV2M5aWhCeXZlWTl2SHR4bjczcENEY0dRN1Ry?=
 =?utf-8?B?OXYzT3FZa1FyZ1Uvb3FQWERIRGs0OEV5UzJWNXV4b2NJZ0RqaFJIZHp3WEFq?=
 =?utf-8?B?NjUzN2dZaXZTNXpqSWxBdjdXeDJFbi9ML2M2VEVzUDErTXBNY1ZzUE1hdnNI?=
 =?utf-8?B?OEFtbkpLWGk0VkJwSXozWlhWenM2MGVjMUJnWkxzejM2WlorR0pPVjBFVURs?=
 =?utf-8?B?aXl0KzlrTWpzUnltc3UrOVBkV3JWeUFTb2syd0VmV1V2YTR0VkJBUDZrUmZN?=
 =?utf-8?B?ZE9kTG45RTE5MzBFQkc4MEw4T2x2ZWJrVllQdWFHb0JLcUpmMytTbXNYdFdC?=
 =?utf-8?B?cEY4aTNaamU2RkovVGZHWXJERkNZRzR0dkFVdDRPMzZKaVYvcnlPR1RUUzVZ?=
 =?utf-8?B?TEhhUUlJUVZVcDZkL1VRdlhnaVlPcUFyQmltT3V3QVAzUDlTaGlGVG4waExi?=
 =?utf-8?B?cHhJWi9EY2JFQVNVU1oyQXZTMndpYklDQ0ZYYVBGUjNxQkM0cTV3Q3VnSWhS?=
 =?utf-8?B?QVZVemQ1VWI3a3UwcTdsbE5GNUVlenNNVGpsa1BHSUNmdEovT0FVenF1cE50?=
 =?utf-8?B?MVlwd3hCU2d6MFlvSkgzVHVpUXR5RlV6MmR6Vlh2aklGc05vZjN0UXNkVnlq?=
 =?utf-8?B?V2xwdDU5VHdHZjhpWDBpQ1RsTWtIK1ZSdWFpMzc5VWp3eE9wTVMyU3prOW16?=
 =?utf-8?B?VU8xUW8wbDI4SlBEZWVFYi9DUi9pNmY5dTRDUjlsSy9qVzZBVlJHZXFlTldN?=
 =?utf-8?B?VVNqcXh4L3JxNkoxUUpjQ2FqZUJ2cnU1UG1VM0NGZUpPOE1BMC9qKzJWYXFZ?=
 =?utf-8?B?ZThlZGhpb1lxNGo0V2pKdndRWEhoa3BMTjBhQU9QR1orZ3FlM3JCT2JaWEVV?=
 =?utf-8?B?cmNoeHhKSDdpNkxFUytaMFB5Sk10N2thb2RhaXJZUHErelI1MkhQN3ZPQ1B6?=
 =?utf-8?B?TTAvenA3MFpOKzFWSFFJZFNQdlhiYkl6Nmo5NFEvZmNaTk1DZmgxalBiTXlM?=
 =?utf-8?B?VGttbFZzdmZhVUllUFgzd1pYT0JuNklWY1UzZ0xpcmZpZWdaQlg5aVhEb2o5?=
 =?utf-8?B?a2VES1QvTW5zbklGWEVaWWpLbEkyLzAyak1MdVlWZ1ROUXZ4K3ZBSnE5VGpy?=
 =?utf-8?B?NzYyejJNU1VWSW5vSHNVMlZvMDhTQ201b2pNUUNRbEtWR3FaU1JoOTBpSWVS?=
 =?utf-8?B?ckMyUEN5OFByL2xlOWVucUF0Z28rSGM5SG54bGFjYkR0ZHc5KzFPQVVoOFl4?=
 =?utf-8?B?YzFCbTUrakpCYUQ1VHRCaXU2WEVqRnNkSFYxbzU5ME5FN0xCMkxMU2tHUGEx?=
 =?utf-8?B?TWlZS0hLN0VmL2l5b1A5SndRSlZkb1A3M2k0dGVyaFVhSDBHejNpdzFHaXdJ?=
 =?utf-8?Q?3xEFKWjD70hEQtW4rqL8QBTsT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9C8B38C960DF547A22DD07E3D9835BE@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a656765-651f-47c8-4efe-08ddfb51e0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 10:05:23.6128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rynK5sXB67sc551Ko4Krnv3WHltYH4Y3d9VGbAC3MzEi+nyyDCQCuy65wRSPcg+1dmXT5Cm4KywUxkzij2hagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6765

QW0gTW9udGFnLCBkZW0gMjIuMDkuMjAyNSB1bSAxNzoxNiAtMDcwMCBzY2hyaWViIEpha3ViIEtp
Y2luc2tpOg0KPiBPbiBNb24sIDIyIFNlcCAyMDI1IDEyOjA3OjM4ICswMjAwIE1hcmMgS2xlaW5l
LUJ1ZGRlIHdyb3RlOg0KPiA+ICsJZG8gew0KPiA+ICsJCWludCBhY3R1YWxfbGVuZ3RoOw0KPiA+
ICsJCWludCBwb3M7DQo+ID4gKw0KPiA+ICsJCWVyciA9IHVzYl9idWxrX21zZyhkZXYtPnVkZXYs
DQo+ID4gKwkJCQkgICB1c2JfcmN2YnVsa3BpcGUoZGV2LT51ZGV2LCAxKSwNCj4gPiArCQkJCSAg
IHJ4X2J1ZiwNCj4gPiArCQkJCSAgIEVTRF9VU0JfUlhfQlVGRkVSX1NJWkUsDQo+ID4gKwkJCQkg
ICAmYWN0dWFsX2xlbmd0aCwNCj4gPiArCQkJCSAgIEVTRF9VU0JfRFJBSU5fVElNRU9VVF9NUyk7
DQo+ID4gKwkJZGV2X2RiZygmZGV2LT51ZGV2LT5kZXYsICJBVCAlZCwgTEVOICVkLCBFUlIgJWRc
biIsIGF0dGVtcHQsIGFjdHVhbF9sZW5ndGgsIGVycik7DQo+ID4gKwkJKythdHRlbXB0Ow0KPiA+
ICsJCWlmIChlcnIpDQo+ID4gKwkJCWdvdG8gYmFpbDsNCj4gPiArCQlpZiAoYWN0dWFsX2xlbmd0
aCA9PSAwKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gDQo+IGNvbnRpbnVlIGluIGRvLXdoaWxlIGxv
b3BzIGRvZXNuJ3QgY2hlY2sgdGhlIGNvbmRpdGlvbi4NCj4gVGhpcyBsb29rcyBsaWtlIGEgcG90
ZW50aWFsIGluZmluaXRlIGxvb3A/DQoNCkkgZG9uJ3QgdGhpbmsgc28uIEEgY29udGludWUgc3Rh
dGVtZW50IGluIGEgZG8sIHdoaWxlIG9yIGZvciBsb29wDQphbHdheXMganVtcHMgdG8gdGhlIGVu
ZCBvZiB0aGUgbG9vcCBib2R5Lg0KDQpTZWUgYSBjaXRhdGlvbiBvZiB0aGUgQyBzdGFuZGFyZCB0
aGVyZToNCmh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vYS82NDEyMDM1NA0KDQpUaGVyZWZvcmUg
dGhlcmUgaXMgbm8gcG90ZW50aWFsIGZvciBhbiBpbmZpbml0ZSBsb29wIGR1ZSB0byB0aGUgY29u
dGludWUgDQpzdGF0ZW1lbnQuDQoNClJlZmVyIHRvIGZvbGxvd2luZyBjb2RlIGFuZCBpdHMgb3V0
cHV0Og0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoj
aW5jbHVkZSA8c3RkaW8uaD4NCg0KI2RlZmluZSBMSU1JVCAgIDQNCg0KaW50IG1haW4odm9pZCkN
CnsNCiAgICBpbnQgY250ID0gMDsNCg0KICAgIGRvIHsNCiAgICAgICAgcHJpbnRmKCJUb3A6ICVk
XG4iLCBjbnQpOw0KICAgICAgICArK2NudDsNCiAgICAgICAgaWYgKGNudCA+IDIpIGNvbnRpbnVl
Ow0KICAgICAgICBwcmludGYoIkJvdHRvbTogJWRcbiIsIGNudCk7DQogICAgfSB3aGlsZSAocHJp
bnRmKCJDb25kaXRpb246ICVkXG5cbiIsIGNudCksIGNudCA8IExJTUlUKTsNCiAgICANCglyZXR1
cm4gMDsNCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cg0KT3V0cHV0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0Kc3RlZmFubUBwYy1zdGVmYW5tNjQ6fi9UbXAkIC4vZG9fY29udGludWUgDQpUb3A6IDANCkJv
dHRvbTogMQ0KQ29uZGl0aW9uOiAxDQoNClRvcDogMQ0KQm90dG9tOiAyDQpDb25kaXRpb246IDIN
Cg0KVG9wOiAyDQpDb25kaXRpb246IDMNCg0KVG9wOiAzDQpDb25kaXRpb246IDQNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpTb3JyeSBiZWluZyBs
YXRlIHdpdGggdGhpcy4NCg0KQmVzdCByZWdhcmRzLA0KICAgIFN0ZWZhbg0KDQo=

