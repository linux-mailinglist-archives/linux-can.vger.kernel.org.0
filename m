Return-Path: <linux-can+bounces-3146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9806A65421
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36EB7AB306
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF354652;
	Mon, 17 Mar 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GD7o66fx"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011009.outbound.protection.outlook.com [40.107.74.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9B23F40D;
	Mon, 17 Mar 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222769; cv=fail; b=LxdxBUy5qU9NfA1mPm7ICVl5Kd+sVpTHt0qcZm2USFd4gIJY5/K/46OFRY3sPfa0ucbUO3Yn9X5IfSsF7C46Jz4FKnh02yzcK8PKZNVFU+BWclV1MZQbCmpmXbdYIzX6V0Z6f8Wy73A0Akg3x8NKO1Fuzfw+T+R5sO/sOoinGHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222769; c=relaxed/simple;
	bh=GNhXF4R7XtWy2SsFXSnC7hClBNCOPaiTs+lcDk608jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bLQKVTn3bjn1Pt4tLGxhkSF2ST7EKjCzTlPB9E1Oe28+sVYJJhtlE+6wfFthVnAPMkPFm+3/0Wt4aSWYFC4AerGdf/nrRSHkc4o/k+kQHApCK7A8XeJiXr4xCJH7MQUQ02YmihQyNw90ycWCMNb2/flrqT7Hw9SrczKLrnPxp3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=GD7o66fx; arc=fail smtp.client-ip=40.107.74.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJNI2naIxfq/piXX/RyUaNYPZX3XhdDfcO8UK+zpG51ZhBXmXg/rxqEJxfzyDP3MTW/0veGTL6cssLQj/wnuiJ3fvGWZuh4HyZ/ndBv/Nq1KcOGRAO6IehQTpjhPmGB07N/XXuomDQCYyqAaPATImoguT/RW+syiOreG+NmEwpzq/DcX/EpUylgEXVKj5POHiOtkG/1XjCJWhm/XO8ibFMaOqxyYRkW61vZoMdiNI5CBl3ZZ2hM7CT4NTaJLKguA1nv1SSQ46wqGW3UuZN3alwiDuHwxO0n96kfKrXSm1i9T/oivCnzWAeGC5fXpK7v+rd6f81Rtugt3csM30jbp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNhXF4R7XtWy2SsFXSnC7hClBNCOPaiTs+lcDk608jM=;
 b=U3sAOC5OHbFQEkSb6fy2r/mtr4DLyorwokQHuCMX0Hk+nvptKpsPTnPF48sb7CeaRK1tdYoDgQvm1pMkihYeof6YdnuQ/6K1/EPJNFB9lU/GZTGE1Yt+YjKhDiS3MSsNcyhOXP9mPJfOYwfIKlJJ0FQXziGN8qrCfCbKwCJSuBNUlqU9DlTDHDznAtpAly+88G2PHAfDLLxERM7qabWeUlR3kMpA28wa5lsjfCelhH0/VjoDUkAdSUPMNpsnU/TZxAWXpYYr+5BqqQFl9EOuiYifB9XaR94p+qOH4cnI2FGe8d01zZmdyirkc947+7ADgxMNOfLqeFRqEO+sO/2FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNhXF4R7XtWy2SsFXSnC7hClBNCOPaiTs+lcDk608jM=;
 b=GD7o66fxtU/Bma81YgJvbEohiE4h1UE9WFuJORJdaTmtUheOz0eg0oB/Dd8UiX9tbQsV9hWAAUpsgxfmWx3wDGdcPp4AQwjWceYbbBYJ144Bm30HsqES4Dqo3NI4Ed2cltRqbJ6BgllsiRMF5MBRyG81x3unlSuWS+uodBVwvnI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB13188.jpnprd01.prod.outlook.com (2603:1096:604:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 14:46:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 14:46:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index: AQHblzlRqz9AKXyTHEGDaGzuM2Z5HrN3XvaAgAAGwaA=
Date: Mon, 17 Mar 2025 14:46:00 +0000
Message-ID:
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB13188:EE_
x-ms-office365-filtering-correlation-id: e50a2d56-7f3a-47ee-d3cb-08dd65626f86
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0RDWFIvcmp4UURxajdpSTFDTFJqNzc2ODAyQ2dJUEQrRVZKNDZ1TEduNGhW?=
 =?utf-8?B?YXRwR3JmUmVIbE5nTVZLRXQ1RkM1dVVQc2EvWkhvczFkMGhjcjRBbUN3ZlZD?=
 =?utf-8?B?S2o1a3VRNkFZUmttTjdCZElJdzA2VzlBdlNXZGNBeDlWSFJzY1A5SWZqYkdW?=
 =?utf-8?B?d0V2TVd0S3N6dVVVeXhheDh1ODhvUUFMMDhBL3dmMG4xMTFMK0NndERobksv?=
 =?utf-8?B?YTdxSDRDMitvckJlRkIxVEFERXB5blIrNld1YXhqVmxrOEFwOW9BRjBtd3Nw?=
 =?utf-8?B?QjZySEZYSnNMZzlOMUJjcnZiK1drNUZHbVRwSmZMVnNDV09lREE4VktNUUk3?=
 =?utf-8?B?Y2w1L1RuNjBxTzdHWXJSSC9ORE5pTDRoRjloZGFqMy90eWlSWWQrT0pXTnBz?=
 =?utf-8?B?ejJ2RmpmOWpSaFI1SndSeFVDOHBqV1VmWkNheFg0Y0l6emwxeE9NSys0SERB?=
 =?utf-8?B?VGM0QW5PQW9mMWRzbmoxVXVIbVBCdkttVGJWK2g4bzdTNTh5RnNJRFJSMVdr?=
 =?utf-8?B?NHBUWTcvd2UvUk1OVlhJZ3RGUjg5OFhXVUdkM3FYdlNMWTRaSjdaMFY0QlZq?=
 =?utf-8?B?N21hUFVrNU8xbDRHS0p0eklaSXhNNW44R2cxT1lnTGIvQ3lxN3JncEZyeW5q?=
 =?utf-8?B?a1NPVmtiMzJEek90K3A1RmdqSnZxakZudmFFL0tvc1VqUmlsVHRnbkZ0TEpO?=
 =?utf-8?B?TDhqbm5HWWNsSjROUTlraU0rWTh6Wm8rMFpqejVSV1JYRkxsMUtubDVsNTBD?=
 =?utf-8?B?NjhMMm5xekRhL0lCaUF6RlptdHJmVmZrUEVHcGJpSHhwZ3U5dnN6WXdQV2JS?=
 =?utf-8?B?ck0xaVB6eTZmb04yUFhJREpjcDgyUXFSRnRXY1BMT0ZJU09EOEE4RjUxZFYv?=
 =?utf-8?B?cENSL01lSWd4bERBRnE3ekU1dFNDcGRKRUNwdklHYXFRbENtRDB5bTlGV0h5?=
 =?utf-8?B?bTc4Z21NQmVhS1FxWEJQbnJlZkE1Mlg0TVZPSDBZb2lvYlRvUUM0ZHFMeG9k?=
 =?utf-8?B?a01IS3JuUmZVMkNQK0pIN09sNWgrZmZLNU1TNjJUVDcvS2xpa2dxVGZlZFZD?=
 =?utf-8?B?Q1dnazdYMDNJYzJlWjQvbzVhZmR0YzBiZjJXbUtPVDIrVEtMd2doWkljd0VH?=
 =?utf-8?B?RFlGSU41bVZSOHVKaFJDMndNRDdHVE91a25VbVVXNjd2dFlKUU9XSUpTaGxt?=
 =?utf-8?B?N2x2bnJQT09ka2VWMWhoZHZ6MysxUGY2Sm44QnBQaWxUNXVjdFpHRmFIMHV1?=
 =?utf-8?B?K0hNa09DaDVNZXVaUlB4NmdDY1N3Uk13bk9meURjeFR5ZDRlRjRxaDFFb3l2?=
 =?utf-8?B?NUErN1pYOHFmeGlXL3pyTUFMSjN3eVk2UzVSMHZuYVQyWEh5cEEzdUhNcVVh?=
 =?utf-8?B?NXQyL2EvSVVySC9GVCtxN05MNzlYSE0xYy93WDNORWFKMnNDQ3NhS1hnMDJr?=
 =?utf-8?B?bnRzRlJYQ0NqMmRsVWlPaFJmblpzdGdyS0JpUzI2RXRPeEh1bVAyUzI4bzNK?=
 =?utf-8?B?RkUvLzVwc2prU001WGk4MFRONVJxamdLRUNSV0JZYWwvcmdUdXdkZG10cFRT?=
 =?utf-8?B?aVB4aWNJYm5vMFNaVmlTRTVWaDRncExxS2lmNjc4MEg2Qkw1V2VxMDh0ZDcv?=
 =?utf-8?B?cnVKQVoyUldUT3dCc3FuSW5BWHNzQUlDa3VuZnhkYktXQVp1Ni9wZTFPWjdh?=
 =?utf-8?B?ejMrNDZWZWkwd2RraVdKaDVJSkR6b2pqcC9BY1RQTk9MQkxMOGYrVkRmSnV5?=
 =?utf-8?B?TTFpaGhaSlkwZVhaamFtS0VDWG8vcW9KVmlEVTMvc2dHczRiZnRaUzl6cTZ1?=
 =?utf-8?B?djF0cE4vME5OS241UGpJY2NiLzc4UTZWcnNqbjdQeTl5WGwzcTlseWI5UWZ0?=
 =?utf-8?B?OGFuWkhpNS9qNWRPRGwrbWxiZGRzT2ZEeno4bDZKTE81cU9BZUs1NW5kQmNG?=
 =?utf-8?Q?cJ8krPN3l2/kqwYtQhb3Fca4bRAOQmXj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDA2N3pJTGRLTW9RTjAvcmoyL0tTbUNvREYyMDF2aGl0OEVZbmFmMDlMems4?=
 =?utf-8?B?N2ZiYURPN00yZ1JkcmovajBrUE1VbVczc2FUSTcxM09yZGhpU3JYRy9hTTNv?=
 =?utf-8?B?aDBpMGJqZER5VTc3MHErSERCWEIyQTNXa1NtL1lxek0yaXdUYzlMRHNkOUw4?=
 =?utf-8?B?SkR2SmdHWEc0anllQ2VyYkU3OVhObEszdHRPU1FxcWZrL0Z1d051M1ZEMnh3?=
 =?utf-8?B?a091am1DNGJKdHZ0Z2g0ZUZsQ2dMdCtjOWFKaXpuUzZhZ3dBQ3l2ejdhMjgv?=
 =?utf-8?B?OElVT3ZENzM5QVB0VEtnSnd5cTNTTmxEQnlGUVp3LzAyb1A1dmU2SklLTGxQ?=
 =?utf-8?B?YXplM2lyRTV1NTRqQnQwWC9tdk1YSGJQc0pWc2QxL3F4YTRJY1NtS2ZLbFhD?=
 =?utf-8?B?L29uajJtaWhUNHZJa0x2SDlsK3NTZWphc3Q4VWFXSGIyd0d4TGhhWGxpYVB2?=
 =?utf-8?B?MXJiN3Uxb2d4ZzJ3L3JZL0NFci9PYUJBcUgybUV3blVHbnl3ZlBWcWdBV2l2?=
 =?utf-8?B?ck4vMTJmbnNJcXJ2NlhRSjdHNTI0VytHRW1DVm1RQXBCRmg2VVFqeTJvT0dy?=
 =?utf-8?B?M1F5YS80Q25veEprRTc4bUNBNlc2T3JJdXhMZDByakJJVXQxOWxQeForNThF?=
 =?utf-8?B?TitpSnJZOFlhQkNCZEtHaVZYRnBpM3JKQlI5cTkycDByZjc1Q0lqeStjK1Vt?=
 =?utf-8?B?NXFkZEp4RVpIcFhyc0gvaWpOMkZpNitZSDZvb0YxcFVwMk9XTS83d3N5K2s4?=
 =?utf-8?B?VGZMQ29kTVFjazZPN2hNaWtkMkV5bGIzM3hMdFJZZkhJbnMyb2N0Q0Erd0FL?=
 =?utf-8?B?RUkxbXB3QWtZUmFoZUNMU2xNVUw5bTF0M0pHY1l2Tk95cEJZaUdNcU04S2tJ?=
 =?utf-8?B?dEFMQ09YTVNBSDdKL0Q4bmJwZnYvVWo1UFQ1eUtaaVpDYnM2eVM5U1lWanp6?=
 =?utf-8?B?emhYcGpDSFlCUll6S0FCQUp0VzZINW9wMWxSd0c3NXpKNlpZU2NhVnJsdnVC?=
 =?utf-8?B?bmRBWVc1eDEvQ1V6b3FPejN5b3JMTUdPZ2VxRCt4RTNKcVRlUFFIbWVSajV4?=
 =?utf-8?B?SWs0Zlp1enZNNVNpL2VXS1JWdUFiRS80L096aC8wcUVnZngvRjNoMktqUzVX?=
 =?utf-8?B?WWZLcldqYWpuK0RUcG5mOWJkNW56anVNRm8rVFdtOFVGbTJUbG4yUEZHUW56?=
 =?utf-8?B?dnY4TGdlWUVhQ3dtNmxjNUhZOGFOVUhZQ1JIZm4za0RaeXJIeU01MEF6R0tF?=
 =?utf-8?B?UnNCVExuY0ZSN1E0L2tUd3NIZERNcW5HeTJIOTc2RG5TcEM0cXg3UEJCbWdm?=
 =?utf-8?B?MmJWMlptWVFzYTZTZkM3ZDFDTUxMQ1U5OGxLemxETWpoUU1idzBXZjFTSEd5?=
 =?utf-8?B?azBQcVAxK2xFekZ5WVNoN1FRMUFlNWRDQlF6NldPei94VGgxU2hLMTN0VUN6?=
 =?utf-8?B?OVdSQ1ppaHZMaWYyZ0tNNlFoSTBsbC8vM1IxUUF6VmJCYkxjQ0xoVnRpVFh2?=
 =?utf-8?B?dXN1QkhtdGZiM1psT1poK2NodXdmMi9JSy9zVDJ6UHJESFI5WUg2VjE1dGNR?=
 =?utf-8?B?MW9MVUhWeHR3azkyc2pIL0tqL2IrS0g5bTBONlBCQXlPY0VZeUZaZjZGOUJG?=
 =?utf-8?B?L3oxTU1paWszQnlDeHRObUw3UmhYOG0yUkMxaWZ0eWlaVHl1RVpRanlER0RG?=
 =?utf-8?B?djdBOWl6Z1Z0OURQRnRXK0JiUDA1aEdMV1ZmQlhxdzg2cVJkZ1U4WVBzVndO?=
 =?utf-8?B?UWZIUFFzdEdMbE41cGs2ZkNnRFpNNE1qcVVLcnZuQ2s2VEIyUHlPb0RQV2RE?=
 =?utf-8?B?MW9STTZxSk9vWk1zemF4eUE2ZkgrWkJ5K2VKdXRKbWlVbW0rL0tDelFhdmtk?=
 =?utf-8?B?RFlGWVQ2OFBCVjVYdDJRdEczRGhmcEIrcVJYRmsvb3lmcXhIaDd3L1pLWmpV?=
 =?utf-8?B?ZndtYmxsNlFGM0R2QWxHVGYrUDhjZ0M5ZE9KU3BRbjgwc01NTE51aTEwMCto?=
 =?utf-8?B?WGtwY2dZS3I0SC94RE91R2hSbDRQdkRJcTh2Rkc0QUtxUDZqdWVZMTdFSnhx?=
 =?utf-8?B?ZTJUTWhBNkZjUFlpNmpGQWxnd1NSbU9WUDJ0bzhYZFFIQUhhVmxnUlNQM0JY?=
 =?utf-8?B?RXkrekFVRmFoS2RVa1BjWEI4dE00M3k0eWhuZHZ3RG80L1BDNFMvcGZuaitN?=
 =?utf-8?B?RlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e50a2d56-7f3a-47ee-d3cb-08dd65626f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 14:46:00.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7At3Y2TdTAPqAbhgWVQI9vLoPbrGNdQ9X/lFsI1W8Fn0cG6qrygTJjuGeoYoMVn7G72a9XDYNmQJ5iTLL1rxBt7LnaBb2+BLCIqbDnHgIuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13188

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE3IE1hcmNoIDIwMjUgMTQ6MTMNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NSAxMi8xNl0gY2FuOiByY2FyX2NhbmZkOiBBZGQgbWFzayB0YWJsZSB0byBzdHJ1Y3QgcmNh
cl9jYW5mZF9od19pbmZvDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCAxNyBNYXIgMjAy
NSBhdCAxMzozNywgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToN
Cj4gPiBSLUNhciBHZW4zIGFuZCBHZW40IGhhdmUgc29tZSBkaWZmZXJlbmNlcyBpbiB0aGUgbWFz
ayBiaXRzLiBBZGQgYSBtYXNrDQo+ID4gdGFibGUgdG8gaGFuZGxlIHRoZXNlIGRpZmZlcmVuY2Vz
Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNh
c0BnbGlkZXIuYmU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHY0LT52NToNCj4gPiAgKiBJbXByb3ZlZCBjb21t
aXQgZGVzY3JpcHRpb24gYnkgcmVwbGFjaW5nIGhhcy0+aGF2ZS4NCj4gPiAgKiBDb2xsZWN0ZWQg
dGFnLg0KPiA+ICAqIERyb3BwZWQgUkNBTkZEX0VFRl9NQVNLIGFuZCBSQ0FORkRfUk5DX01BU0sg
YXMgaXQgaXMgdGFrZW4NCj4gPiAgICBjYXJlIGJ5IGdwcml2LT5jaGFubmVsc19tYXNrIGFuZCBp
bmZvLT5udW1fc3VwcG9ydGVkX3J1bGVzLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0K
PiANCj4gQWxsIG1hc2sgdmFsdWVzIGFyZSBqdXN0IHRoZSBtYXhpbXVtIHZhbHVlcyBvZiB2YXJp
b3VzIHBhcmFtZXRlcnMuDQo+IEhlbmNlIHRoZXkgY291bGQgYmUgcmVwbGFjZWQgYnkgdGhlIGxh
dHRlciwgbGlrZSB5b3UgYWxyZWFkeSBkaWQgZm9yIHRoZSBSTkMgbWFzay4NCg0KQnV0IHRoaXMg
d2lsbCBpbmNyZWFzZSBtZW1vcnkgc2l6ZSwgcmlnaHQ/IEN1cnJlbnRseSB3ZSBoYXZlIHJjYXIt
Z2VuMyBhbmQgZ2VuNCB0YWJsZXMNCjIgdGFibGVzIHVzZWQgYnkgNCBoYXJkd2FyZSBpbmZvIHZh
cmlhbnRzLg0KDQpJZiB3ZSBkcm9wIHRhYmxlcyBhbmQgdXNlIHZhcmlhYmxlIHdpdGggbWF4IHZh
bHVlcyBsaWtlIFJOQyBNQVNLLCB0aGVuIHRoaXMgd2lsbCBiZQ0KbGlrZSA0IHRhYmxlcyBmb3Ig
NCBoYXJkd2FyZSBpbmZvIHZhcmlhbnRzLCByaWdodD8NCg0KUGxlYXNlIGNvcnJlY3QgbWUgaWYg
bXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZy4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQoNCg==

