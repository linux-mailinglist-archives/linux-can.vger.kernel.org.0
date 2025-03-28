Return-Path: <linux-can+bounces-3285-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E81A74DF5
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D31172971
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA911C5D7F;
	Fri, 28 Mar 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VpoozYE7"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B664C6D;
	Fri, 28 Mar 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176371; cv=fail; b=qc8LoOpU5oAcOqGrqThov7h6KXDV40d6VFb5Tx0levmZYGfVL/V2I5CWPY1QU1tnOota7HX9Ykd+CO6MB9VTylT9zggooUbSndOz2b0mS6IxXq9xmrvWG1WvhrY6x7EFfI6wvaxfTx2p8LVx+acU2ijwdzFUGlQQ8b39YcKpmBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176371; c=relaxed/simple;
	bh=DxvOHx2mB97rgjvaf5ifGEXt5HmVFir3oaagpnnVha0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J35bG+t6vIqZjFpo+vxr//PmvMZDfs0K+25hwX8AW67pPA6tZecr5UnUq4OGaCZaU0aXS/V0CkI62gaO6zmOkId6SldIgMCBks4yyttusHWIqHyV1OmcYjHYiKmUSRJmqgl5XOzBbt06bhZszFihiqhSqJlCN3BHK6ZfHZFJ6/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VpoozYE7; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trJp9/qeM7iTUrmXNArYItt3e8OHm9XmETXn4siXhMEnK8m06uLSjCLW8/Kic4giIeQNNSgMhQQM6krsxF6IhO7li2ceYzJcWGXRZBJ3tQOCqGHJieR+96MNHiNO354mRpaQcF//VqLo8QzXLBzJrVrFj62U3a2dwpHIdNziUvRJsH8bBA888itwkbYyD5oPp9Co33xTT+g31gQ68yrfKEdxYSY3c6fiRyc08Sgbr5bMkjNwKNZw3Y/4a/KtWOZScaI6wBy+16jCq4YoOISBoyR5iEkR8GxShHq87MvQHtnK/cg72nzIjnlYVdTR4u7IGCYPFJmhp/sTXuzcHToqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxvOHx2mB97rgjvaf5ifGEXt5HmVFir3oaagpnnVha0=;
 b=vlwFD7diK3+DzcN//Vk1fjbY3rnO69GC7BWsdblCvzg8SuxrcK9PhgSMrmDXADmw/ed9DFa8vWITrNbaAUiPxtSjIsDeMt94ggyzT95MatogpAGdtGCZ8SX5IeRY3qTkyXzZbYxwA/MX3m3bG6GUIdHzgfom7Aecw6Gsubd75h1yuKzT1IoYqAyDWwHAQo0yaZSiz7uf4fKr1qz1zjJ1s1vauQwnaUnKUAImJ1JpbCEaiJJB+lUX+re/r80JD/ao31VG3m0YHy33Hfjjnx2cg+0qzaxgiOrIDsQrs8jDX4ucavdSMIr2V+/+I7+AD2tW65XcwoFXhtiMZOvM+UhQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxvOHx2mB97rgjvaf5ifGEXt5HmVFir3oaagpnnVha0=;
 b=VpoozYE7Z4JxrbfhqgdvjYmMJnkw2fZzO9xTZHmiBKTXy4SpAvOLtFhmO+r9e0d96a2sP8nsp02J/8cTvBpEzbrk2cjKJTHOKEo6IFi6GwC4yGauqqckmkcQjME5QKAUEy3Zx/MtvNmkY82qIH+d0P7F82GK9McZqzkYGcvctlY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB15112.jpnprd01.prod.outlook.com (2603:1096:604:36e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:39:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:39:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkl9i1pj+Nv9/0+uivOvdWdzlLOIXgMAgABSoRA=
Date: Fri, 28 Mar 2025 15:39:24 +0000
Message-ID:
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
 <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
In-Reply-To: <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB15112:EE_
x-ms-office365-filtering-correlation-id: feb585e9-0c18-4497-bf2e-08dd6e0eb7b5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1MwZHpYWTZQRHZibHQweU0rOERFOE95TFMrVFo2N0JoM0ptVUUxYkFHQXkz?=
 =?utf-8?B?VTdXZ2ZYWFhHaFQvaTMvRnc3MXd2Q3daOEYzMGhBVkpiek51OWt6N2VGUkww?=
 =?utf-8?B?dFd2d3VJN29IVmZWbi9tOGxUN3pHNWJiMUExMW1LMlI1dXJZLzhEQjNucHpH?=
 =?utf-8?B?VXd5WGpIRnQxdzN4WXluTGpqdGZzRUhwaGdYdnhDSzhZdjNFZUlOTmgxcFN0?=
 =?utf-8?B?Qy9vUng0MDFWNko2U2p2WkEzQ0xuZFNJNjBDSmRRU1NMblZ5NVhRKzVrOWhP?=
 =?utf-8?B?ZHR4N3B5ZmtRbHlycXFHd1U2NTA5WGRRcW9LK0pyWWROOXZSaGN2Vms4Vkk1?=
 =?utf-8?B?S0ZWOGJrWkczRlE5eS9WSGlpZ2ZBaEQ4S3ZIdTZrUUkrUVlDdzY2QkdZTlly?=
 =?utf-8?B?Q3RDN0VPQkNGR2ZLR09ocHJnRHE2YTltV3VERVk3SnlaUjIvY0ZwVUcxT3NO?=
 =?utf-8?B?QlRPVzdJTmpZVmVmek90eDNmOEpHa05lYnlQZXRZdlREMXg4UXBxSFgza3FW?=
 =?utf-8?B?S0llc3ZWU1dOaVo0U0xDSkxsancraFR3bkM5L3dlTnNmZW5FSG1jRjh1c1Fv?=
 =?utf-8?B?L2tsejM0UXFlZVMrUVFvUEVOakNWbWVEY2tPeXNUQWNZK0JrU2k2QlRGaHhS?=
 =?utf-8?B?dVRXYS9reWd0ek1aWUZaTU5qbkhmVVpSWjIvWmQ0WlM3c3RkeExHcHZBNzFL?=
 =?utf-8?B?WkNaeXNNYk9QMDZrWnNVL0l4N3JSdVV6WmJVTCs2ZE1LM3VLbU9iMlhkYzNr?=
 =?utf-8?B?Q01XaTFNMnA1ZnZuank0czQ1U3VTN09ncjlGRGJBTi95bm41dnFMWnhBcFhD?=
 =?utf-8?B?NFhvK1RUOHdrL3NnSDlxdDZJU2RZb0lRbmxBUmJqNFhtU01LYjhsd2NPQWQ1?=
 =?utf-8?B?YWhFbndmUC9kZmdKME16SXJVcW5ZRTdJRmZiN1dBbCtuWCtybVRPbnZmQkVi?=
 =?utf-8?B?L3NxZnViWWwzcWZQMjNNSVhtb1doaXJsdFVKVzh5T1liMkZjR2xCY0JoRERC?=
 =?utf-8?B?bnFwSStwd0N5TllycVRHYm5FK2g1Vy9OK0s0WGhLTE13czV4a0llSjRYSG43?=
 =?utf-8?B?MWdsd3QvZmNqYlNocTdOK1MxQjd3N2FWQUMra1hiR3ZiT3FmSDd1TnhOT1Rl?=
 =?utf-8?B?ZmYvbjVMWjZta2szRUVPV2R6cHhjMG5iN2FmMDNPdnJFSW4veUpIWlRHd2Nj?=
 =?utf-8?B?VGt5d2xlczZRbWJQSENFMWpPeExhTW02VDRPTWVkYlhGSS9odzk0bGNKN3cx?=
 =?utf-8?B?RkhEWWNQb2xwdHFDNVcxMzFxK0JiRlJyc0hsWHB2TFRRRFZrbjYxNk5WZUdi?=
 =?utf-8?B?SXpSQ1p3YzhUNmxnNlVmZk5hcXNHZTF6MWpNMmRLTStrbjBTRXVWRGIwUzRU?=
 =?utf-8?B?aDBCZURUVHJUdWNjN0lPcTB2UnltL3d3dFBZRllrby9jS3BEemNuWnlHaDJO?=
 =?utf-8?B?YVE3TTU2NXZuNzJ2bjBjMTVlVDNjT3dEZzVYV3lKdGVvT0dUZXFkaW5pL1Jh?=
 =?utf-8?B?M3hzSXZkd1pvb3g5ckk3enVyYk04SE5sbEtwNEtid2RqNUxpK2hiNzhZZVpS?=
 =?utf-8?B?UDREVXNaczA3SlFlZitqWTl6U0djUFNDeDB6NmtFQ1VXS3BiOUdzQjFkZ2ds?=
 =?utf-8?B?U3J2MWlxNjltS2hYb3VvVEN0TWdOTndibWhQUVc5YWVjU0dXZW5aWVhNVHdJ?=
 =?utf-8?B?YWFCa21XdGZiay81cTUxTnhFTUJBNjhwWVRDd1FyVE8zWGh6djlwSkFKMGVE?=
 =?utf-8?B?VHhrNTRWMEgxQVVSdFk2Y2lENmROcG1JTzdkQit6b3liQUJTbVFYS2dxVzlG?=
 =?utf-8?B?clYxakRLdjN1RzRlNXVJTm9pMVNVbVdwR2VxTGxyZVhwVzZlK2NwUmlBcVBo?=
 =?utf-8?B?NVhtbjFsZ0tYWC9OdXZ5emE5QWNNMW9qdm5KK2FxZHVzTWduT3RwditxSWUw?=
 =?utf-8?Q?k7EZJVLgGB4NwDARi6g7koiFJ+QQEKjK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGlLS3c2akgrWENvSldpTWF2OGg4NzJaTWJMQ0xTenVQOHdnc3E5V09VNTlW?=
 =?utf-8?B?VThBeGQ3QWdwSmt2T2J0Q3loQXVabWJHR0RFa0VsSi9leGFPR0FCejA1aGJE?=
 =?utf-8?B?TS82U3hnTzRSUGsxSGYvNjd0UVJpckhZbldxaUZWYi9LWERYaXVOUU1lM3VO?=
 =?utf-8?B?TFlPZzU0eHZrZXVKU3JPdFVTekJSUnRHTEwxNFhYR2tLWkNPYmtCN05nMFJ4?=
 =?utf-8?B?Yk9tVWJFZUh1VnFRRkpIVzNLYng3UTZKamZOTE5CeG1LaEZUZjh2YVJnaW5j?=
 =?utf-8?B?cHMzK2dBdzBwWmdCS2NOdjdIZHFrVk9JYTA3dGVCcEphazc2dEkydU9wclRy?=
 =?utf-8?B?c1ZUZzBCVGdIRUFSRlM5N3YzcTVJT3Z5anJ6R1BkNTh5VTNNUkhSSitqNmZk?=
 =?utf-8?B?OGFIUStvRjdmWW56SUxyYnVFeTNOVXF1em5RTUFrSXVCcVAydm1IWXlyMzFZ?=
 =?utf-8?B?emRtVVcrTnZxMUo4cXhVbEQ4UDBTYUtqVGM3eXRSWWZWUktBdEtTK1VhWHRZ?=
 =?utf-8?B?ZWo2R2VjdzR5VWNYMGpYRElBNzdncVFGM1RzZncxZjdlNHFOYWxubEEvZTcz?=
 =?utf-8?B?ZU9ha2dXcUdLVUpBZlM5ZXQ2NVQra3N6c0x5VkNMOFdXbDdBVUY2TDNhdlJz?=
 =?utf-8?B?czZkT3krSG5LTk5iaWk4MERLSEhvNHlQWXBvM2dIcnRyUHM1ODY4QkNjSkht?=
 =?utf-8?B?ZHBpNW1yOUdTTnN5ZHRuYXVXS1g3S3NhQm0wZjRjcnU4d1BhRmcxYTgrckg1?=
 =?utf-8?B?aUtDMjc4d292ZlZWU0lWVC8yM0hWc2JrWUNPWmtsMjVzMkQ5NVE0Q1kzKzJ4?=
 =?utf-8?B?NUJNWlpNemg5UTUwb2N0R3g2MmE4OHEvOUYvQXdOUFlqVFR5c3JheXcrcnpC?=
 =?utf-8?B?TkdiMEEraHBzR3hKWTVZcWlWb3Jkc1FLckpuMHVHcG43WStFSVFaRTVWNkR0?=
 =?utf-8?B?cGhiMHMrOUpQVHEvZ2U0emZsVE40bzdEallxbzhSOFF0aE1od1lJeDJVQmM4?=
 =?utf-8?B?WGo5cFh4MTZRVWRYK1NIZVZITjFtaTVuK0h5Tk1vRjA5c0pjSlZNMXFJR0pX?=
 =?utf-8?B?dFFOR0xwVlVPWWxpd2dNVGFJYWR3ZkhtVkVpTDkxcW5hN0hJQ0c5b1ZaM1VK?=
 =?utf-8?B?V0hVSmlsM2U3OEh1dWpZeGo1VTJ4c2Q4ODVZcTBJSjBaSEh0U3F1ZWNSQ2Zx?=
 =?utf-8?B?NlVFa3M4TnI0NHMva1g1eUVKaDJmKy80Um56cEVtT25McG5yTDMwQWpHZVNk?=
 =?utf-8?B?M20xMEdmUnByc0RWZHY5dzUzMGx0OHNuckh1TEdlcVZGV3NPMWZGMHZDbUhJ?=
 =?utf-8?B?cVpkK3N2UExNcUdXQTMzVGRralNLVGVBQVdmN0t0SlU1MXNRNkN3L2pPcnN2?=
 =?utf-8?B?bVZyZzJZU2tQSmRMQ29TT3FtamRxZkEydkVwZFJmelhmeU9sQ0tBZElyQmx0?=
 =?utf-8?B?T2xOakxJQjRlYWJ3bG1pMzJzNVJlVUgwQStuZERlZUIxL0lEcHphR0lQZzlp?=
 =?utf-8?B?aks3L1RZTHQ0aWxaRVVDMHNDUW9yQjBUZ3R2ZHdyYUxNOTZUSHg2V3dyNDRw?=
 =?utf-8?B?ZlAzWGl1YjhkQThyeWRxOE5NKzh0eXFLSXMyYWhWaGdoK0h2dTVOL0tNOHds?=
 =?utf-8?B?b0JWV3hDamY5d0orbGpBSERmZlBESFZieStnOXhQZFhYZmUxMkhnRVU3bmd1?=
 =?utf-8?B?dzIrdmJXMEdvSTc1aFE5eWxIMVhlVFFjcFdob0I4dlFqZVZ4MEFUUkF3S1Az?=
 =?utf-8?B?OHVCMFM4b0lTZ3N5OXR0cW5nUEpUS3R1VFFVRGJFWmR0aEZTck5qZ1ZsYmUw?=
 =?utf-8?B?OVJhcGw4YXFIcVhReWt1NllmaUZ2bTFobGNIQmYyNW1nb2E4bW1Rc21lQlR4?=
 =?utf-8?B?RW1zQXNJUy9IMTg0Z1Q5bTNPZU1NeWc5bENvM1l3TUI5TkdxSklzNGR2TWsy?=
 =?utf-8?B?SHVBZ0JlMTN4Tzc5Yk5MZUp2eEhmYSt0V1lad1pRTjhINlV4aDE5cVlnYW4r?=
 =?utf-8?B?dlVIU1pBc2Z4aGkyVkR4b1hjQkFnOTRZUFVPZkVnTzBWTmpUWUwyY1o3RzFI?=
 =?utf-8?B?WVFwWEdTMWt4MWdmZWV1T2NtanBtTHd2N2t6TE5rS1RTYXZWM3BWQjg1SENv?=
 =?utf-8?B?ZUdta0NWUDgwS0hHdFh5Y3FZRjBZczlRWU5vcVVmQll5cmtIYWkycC9hSjdj?=
 =?utf-8?B?OGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: feb585e9-0c18-4497-bf2e-08dd6e0eb7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 15:39:24.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NSPdO8dWOMCjs5dvEf3eZethLYsTq6wwAB7JJ/JKjVmnV2lJznodMxn3rQT260phlhBf2pSioorM9n8j5jgwNL2uVErbWPncHRvX795r3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15112

SGkgVmluY2VudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gU2VudDogMjggTWFyY2ggMjAyNSAxMDozNw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDA3LzE4XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBybmNfc3RyaWRlIHZhcmlhYmxl
IHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IE9uIDI2LzAzLzIwMjUgYXQgMjE6
MTksIEJpanUgRGFzIHdyb3RlOg0KPiA+IFItQ2FyIEdlbjQgcGFja3MgMiBSTkMgdmFsdWVzIGlu
IGEgMzItYml0IHdvcmQsIHdoZXJlYXMgUi1DYXIgR2VuMw0KPiA+IHBhY2tzIHVwIHRvIDQgdmFs
dWVzIGluIGEgMzItYml0IHdvcmQuIEhhbmRsZSB0aGlzIGRpZmZlcmVuY2UgYnkNCj4gPiBhZGRp
bmcgcm5jX3N0cmlkZSB2YXJpYWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIGFuZCB1
cGRhdGUgdGhlDQo+ID4gbWFjcm8gUkNBTkZEX0dBRkxDRkcuDQo+ID4NCj4gPiBSZXZpZXdlZC1i
eTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0t
DQo+ID4gdjYtPnY3Og0KPiA+ICAqIENvbGxlY3RlZCB0YWcuDQo+ID4gdjUtPnY2Og0KPiA+ICAq
IFJlcGxhY2VkIFJDQU5GRF9STkNfUEVSX1JFRyBtYWNybyB3aXRoIHJuY19zdHJpZGUgdmFyaWFi
bGUuDQo+ID4gICogVXBkYXRlZCBjb21taXQgZGVzY3JpcHRpb24NCj4gPiAgKiBEcm9wcGVkIFJi
IHRhZy4NCj4gPiB2NToNCj4gPiAgKiBOZXcgcGF0Y2guDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
bmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYyB8IDggKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IGluZGV4IDMyZDcwMDk2MmQ2OS4uMDAwMWM4MDQzYzI1
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC0yOTEsNyAr
MjkxLDcgQEANCj4gPiAgLyogUlNDRkRuQ0ZER0FGTEVDVFIgLyBSU0NGRG5HQUZMRUNUUiAqLw0K
PiA+ICAjZGVmaW5lIFJDQU5GRF9HQUZMRUNUUgkJCSgweDAwOTgpDQo+ID4gIC8qIFJTQ0ZEbkNG
REdBRkxDRkcgLyBSU0NGRG5HQUZMQ0ZHICovDQo+ID4gLSNkZWZpbmUgUkNBTkZEX0dBRkxDRkco
Y2gpCQkoMHgwMDljICsgKDB4MDQgKiAoKGNoKSAvIDIpKSkNCj4gPiArI2RlZmluZSBSQ0FORkRf
R0FGTENGRyhncHJpdiwgY2gpCSgweDAwOWMgKyAoMHgwNCAqICgoY2gpIC8gKGdwcml2KS0+aW5m
by0+cm5jX3N0cmlkZSkpKQ0KPiANCj4gSSBmaW5kIGl0IHJhdGhlciBoYXJkIHRvIGZvbGxvdyB0
aGUgbG9naWMgaGVyZS4gWW91ciBhcmUgbXVsdGlwbHlpbmcgYnkgZm91ciBhbmQgdGhlbiBkaXZp
ZGluZyBhZ2Fpbg0KPiB0byBnZXQgdGhlIGdvb2QgcmVzdWx0cy4gSGVyZSwgScKgZ3Vlc3MgdGhh
dA0KPiAweDA0IHJlcHJlc2VudHMgc2l6ZW9mKHUzMiksIGJ1dCB0aGlzIG5lZWRzIHNvbWUgdGhp
bmtpbmcgdG8gZmlndXJlIHRoYXQgb3V0Lg0KPiANCj4gV291bGRuJ3QgaXQgYmUgbW9yZSBpbnR1
aXRpdmUgdG8gaW5zdGVhZCBzdG9yZSB0aGUgc2l6ZSBpbiBieXRlcyBvZiB0aGUgUk5DIHZhbHVl
Pw0KPiANCj4gI2RlZmluZSBSQ0FORkRfR0FGTENGRyhncHJpdiwgY2gpIFwNCj4gCSgweDAwOWMg
KyAoZ3ByaXYpLT5pbmZvLT5zaXplb2Zfcm5jICogKGNoKSkNCj4gDQo+IFRoaXMgd2F5LCBubyBt
b3JlIDB4MDQgbWFnaWMgbnVtYmVyIGFuZCBpdCBpcyBlYXNpZXIgdG8gcHJvY2VzcyBhIG11bHRp
cGxpY2F0aW9uIHRoYW4gYSBkaXZpc2lvbiBpbg0KPiB5b3VyIGhlYWQgd2hlbiByZWFkaW5nIHRo
ZSBjb2RlLg0KDQpOb3cgdGhlIG1hY3JvIHNpbXBsaWZpZWQgYXMgYWZ0ZXIgaW50cm9kdWNpbmcg
c2V0cm5jKCkgWzFdDQojZGVmaW5lIFJDQU5GRF9HQUZMQ0ZHKHcpCQkoMHgwMDljICsgKDB4MDQg
KiAodykpKQ0KDQpXaGVyZSAidyIgaXMgdGhlIGluZGV4IG1lbnRpb25lZCBpbiB0aGUgaGFyZHdh
cmUgbWFudWFsLg0KDQo+IA0KPiA+ICAvKiBSU0NGRG5DRkRSTU5CIC8gUlNDRkRuUk1OQiAqLw0K
PiA+ICAjZGVmaW5lIFJDQU5GRF9STU5CCQkJKDB4MDBhNCkNCj4gPiAgLyogUlNDRkRuQ0ZEUk1O
RCAvIFJTQ0ZEblJNTkQgKi8NCj4gPiBAQCAtNTA1LDYgKzUwNSw3IEBAIHN0cnVjdCByY2FyX2Nh
bmZkX2dsb2JhbDsNCj4gPg0KPiA+ICBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHsNCj4gPiAg
CXUxNiBudW1fc3VwcG9ydGVkX3J1bGVzOw0KPiA+ICsJdTggcm5jX3N0cmlkZTsNCj4gPiAgCXU4
IG1heF9jaGFubmVsczsNCj4gPiAgCXU4IHBvc3RkaXY7DQo+ID4gIAkvKiBoYXJkd2FyZSBmZWF0
dXJlcyAqLw0KPiA+IEBAIC01ODIsNiArNTgzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjYW5f
Yml0dGltaW5nX2NvbnN0DQo+ID4gcmNhcl9jYW5mZF9iaXR0aW1pbmdfY29uc3QgPSB7DQo+ID4N
Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8gcmNhcl9nZW4zX2h3
X2luZm8gPSB7DQo+ID4gIAkubnVtX3N1cHBvcnRlZF9ydWxlcyA9IDI1NiwNCj4gPiArCS5ybmNf
c3RyaWRlID0gNCwNCj4gPiAgCS5tYXhfY2hhbm5lbHMgPSAyLA0KPiA+ICAJLnBvc3RkaXYgPSAy
LA0KPiA+ICAJLnNoYXJlZF9nbG9iYWxfaXJxcyA9IDEsDQo+ID4gQEAgLTU4OSw2ICs1OTEsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbw0KPiA+IHJjYXJfZ2VuM19o
d19pbmZvID0gew0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmNhcl9jYW5mZF9od19p
bmZvIHJjYXJfZ2VuNF9od19pbmZvID0gew0KPiA+ICAJLm51bV9zdXBwb3J0ZWRfcnVsZXMgPSA1
MTIsDQo+ID4gKwkucm5jX3N0cmlkZSA9IDIsDQo+ID4gIAkubWF4X2NoYW5uZWxzID0gOCwNCj4g
PiAgCS5wb3N0ZGl2ID0gMiwNCj4gPiAgCS5zaGFyZWRfZ2xvYmFsX2lycXMgPSAxLA0KPiA+IEBA
IC01OTYsNiArNTk5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8N
Cj4gPiByY2FyX2dlbjRfaHdfaW5mbyA9IHsNCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IHJjYXJfY2FuZmRfaHdfaW5mbyByemcybF9od19pbmZvID0gew0KPiA+ICAJLm51bV9zdXBwb3J0
ZWRfcnVsZXMgPSAyNTYsDQo+ID4gKwkucm5jX3N0cmlkZSA9IDQsDQo+ID4gIAkubWF4X2NoYW5u
ZWxzID0gMiwNCj4gPiAgCS5wb3N0ZGl2ID0gMSwNCj4gPiAgCS5tdWx0aV9jaGFubmVsX2lycXMg
PSAxLA0KPiA+IEBAIC03OTcsNyArODAxLDcgQEAgc3RhdGljIHZvaWQgcmNhcl9jYW5mZF9jb25m
aWd1cmVfYWZsX3J1bGVzKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYsDQo+ID4gIAkJ
CSAgICBSQ0FORkRfR0FGTEVDVFJfQUZMREFFKSk7DQo+ID4NCj4gPiAgCS8qIFdyaXRlIG51bWJl
ciBvZiBydWxlcyBmb3IgY2hhbm5lbCAqLw0KPiA+IC0JcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2
LT5iYXNlLCBSQ0FORkRfR0FGTENGRyhjaCksDQo+ID4gKwlyY2FyX2NhbmZkX3NldF9iaXQoZ3By
aXYtPmJhc2UsIFJDQU5GRF9HQUZMQ0ZHKGdwcml2LCBjaCksDQo+ID4gIAkJCSAgIFJDQU5GRF9H
QUZMQ0ZHX1NFVFJOQyhncHJpdiwgY2gsIG51bV9ydWxlcykpOw0KDQpCeSBpbnRyb2R1Y2luZyBz
ZXRybmMoKSwgdGhpcyBwYXRjaCBpcyBubyBtb3JlIG5lZWRlZCBhcw0Kcm5jX3N0cmlkZSBpcyBs
b2NhbCB2YXJpYWJsZSBpbnNpZGUgc3RybmMoKS4gU28gSSB3b3VsZCBsaWtlIHRvIGRyb3AgdGhp
cw0KcGF0Y2ggaW4gbmV4dCB2ZXJzaW9uLg0KDQpbMV0NCnN0YXRpYyB2b2lkIHJjYXJfY2FuZmRf
c2V0cm5jKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3ByaXYsIHUzMiBjaCwNCgkJCSAgICAg
IGludCBudW1fcnVsZXMpDQp7DQoJdTMyIHNoaWZ0LCBybmMsIG9mZnNldCwgdywgcm5jX3N0cmlk
ZTsNCg0KCXJuY19zdHJpZGUgPSAzMiAvIGdwcml2LT5pbmZvLT5ybmNfZmllbGRfd2lkdGg7DQoJ
c2hpZnQgPSAzMiAtICgoY2ggJSBybmNfc3RyaWRlICsgMSkgKiBncHJpdi0+aW5mby0+cm5jX2Zp
ZWxkX3dpZHRoKTsNCglybmMgPSAobnVtX3J1bGVzICYgKGdwcml2LT5pbmZvLT5udW1fc3VwcG9y
dGVkX3J1bGVzIC0gMSkpIDw8IHNoaWZ0Ow0KCXcgPSBjaCAvIHJuY19zdHJpZGU7DQoJb2Zmc2V0
ID0gUkNBTkZEX0dBRkxDRkcodyk7DQoJcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5iYXNlLCBv
ZmZzZXQsIHJuYyk7DQp9DQoNCg0KQ2hlZXJzLA0KQmlqdQ0K

