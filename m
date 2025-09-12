Return-Path: <linux-can+bounces-4673-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9EB545E5
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3597B1C2823C
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906282DC793;
	Fri, 12 Sep 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Bj2Ikq+S"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2085.outbound.protection.outlook.com [40.107.114.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CB2A8C1;
	Fri, 12 Sep 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666968; cv=fail; b=SC3BALbyP5uvW1q0EjZaQ0x2bacgI+4yM3C7AGKSfS2k71LrN3E6CtJ9bZ+acr5026otFko5HoQ+tQKLyV0goUzFgHVGVcRmAbI4x2lllDQo/9O7RAXpJf0IFd4TH82RCZ2qHVu72ynF/4kD6cehPmZxrVa/MWjITo+L7lE9ofo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666968; c=relaxed/simple;
	bh=JRkG+dH+HDBz5dgP7sI4JcCAC5l9iZoEB9mzpDvIcGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3Jn05x6QaEFH/vCVa4JGCh4LeUJH9dvJnYCgzcq0gBc/QSebiK4LwDJMJhVxk53c5tNAgYvGZuD8kwq9duT1DAadyB5gBsUryNdmalYeEXbp7h7xuUCEMgH8pEI1oQZvmcg325OFKgKSWqm/B+VXyReDY8nHOCM5M5qc2O27Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Bj2Ikq+S; arc=fail smtp.client-ip=40.107.114.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjDFbLQElL9ONLf7Oy+dPmB8j7TerlTbxo6ynai4JNmSPPZQJiqcMaFK8g1weU2mZ4gRyd4NpFj6z0OvMc2+RnwMfwisfBfJa+TXrH7DyVSns5xmFXjAD+apM4eUA/em1itnMr6VI6xdlLP5k+1PJ0Pauu3mSCeBDNxACvRp5AlaMQlEB+1G4+DLFeq0aR/svri4qOgijezLvDVpQbP3fFD3CkUR/uunMap+9BTkN+9/fmSj7ECjEuw7PKr8sbJ091bqx48LNTfLt8QHoyZpMgwWDAPPx003VTHstW78/6WMZEo0VQx4XoOh4AbMp3rKd9/lioKXdaoYaTMpOEgs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRkG+dH+HDBz5dgP7sI4JcCAC5l9iZoEB9mzpDvIcGs=;
 b=ZpejoOwdmGPyPXfq8xh+P6Y/yIAeO1XSC5GCw2LQKVDOsWzu1f7PJAGIcr66w78O9w2bw1dGJIiOwrL4Yxla956aEZJXDaEVEenzGXoqopmA9LdbNqBEgNQaA4/woV+OS6lDqNqJKU3esZ3Yks10xSatFZRAi+fgEFBLOYwemNvH87svGbbBiXcUwaWVf5C8tHlvn9n6ZqCLug8pObjLsVn+xpGDQYIW1Lm+SW9thFw7CisPiIOP9mRRZSCGFJR5Z8kyryALHiOsdkOQ4mwVXMNn7iOxMFU8T6pjhgJLcjHiavLrmlJ1qHgzRVmlag6qpdmdF3Ue1ZQUNOSZyJyIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRkG+dH+HDBz5dgP7sI4JcCAC5l9iZoEB9mzpDvIcGs=;
 b=Bj2Ikq+S2HrYb5B9JIDqWIRXGwpIqNf2ppNl1ZiyyzymCFeV2PfZUuCz3ZIn+D7dVTQeWLdqSNYlA9fOVs7r3gPH6jlUTkg/IVaaJB81tlIxESjZrD7eGseN4es2c1xCKZwgz4Rgp/iJAEWgv0eeIZm6cCLz4ZCehoy5vLFrtaE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB8403.jpnprd01.prod.outlook.com (2603:1096:604:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:49:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 08:49:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7SPTPuwgAAPIgCAAAFPMA==
Date: Fri, 12 Sep 2025 08:49:20 +0000
Message-ID:
 <TY3PR01MB1134674E512321801F42B35228608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUrqqJEM4VWt5KzjPGkTHL4w5Sx9x1gC-yoRW2jEArMiw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUrqqJEM4VWt5KzjPGkTHL4w5Sx9x1gC-yoRW2jEArMiw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB8403:EE_
x-ms-office365-filtering-correlation-id: 36690c23-0cd3-4cae-d9d2-08ddf1d9440a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXFnV3c5ak5Ra3plcjI3dTVVeGJoeVYrMkd6YnkwcUdYK2xqZjZJcC9HcERX?=
 =?utf-8?B?UURaWC9SKzZYU285N1dtTE5qMTZRc3pnd1hkSXl2ajNzUjU4M3YyK2RBU01Y?=
 =?utf-8?B?U2dkYjNESE1lanJ2akZ4S0dkNVlBbEpWT3hMYzFJb0FMS2VYakNpUWdCeklt?=
 =?utf-8?B?N1hiV1FQMEREbVVjTFhhTFdnMHJtTTNaUy80c1I2WTNRREQ5RjFoVit3SjNT?=
 =?utf-8?B?djBNeFVTVTBBRlpMeVl1U1BoaTdKblU1Ymd2bUh5SmVNZWcwSnlmNFhVVWZR?=
 =?utf-8?B?Qi95YWFIZ3lnTm9yeHJsR09sWEZaZXY3NXpLdHloUzN4UFAxNllySU91NXF5?=
 =?utf-8?B?S2NQc1M0clRRbkxOZEduQ0lVSmhiK3RBZzUxZzh4akhPcU44dFQvakppZkJL?=
 =?utf-8?B?bElROUk1aFUyeTlZdXBrYW5HcldRemgwYU5ONUVOSFBkcWJTQ1VoRGNQaW1t?=
 =?utf-8?B?ODJkeXNBbGlkWHBwemlhSUtzZW1GSm0yQmdFbWM3VWhUOWFVcU5KUlJvUWJv?=
 =?utf-8?B?UkYyTmF6UmdUTlZqSFlrUEw0d1VMa1FFNHQxVkg1SVl2SnhIZnpBM2hQS0VS?=
 =?utf-8?B?Q1RmRlZRRWM0bjZzdGRXQTFhN2d0SE95ZElIOFRWUmFzWlBsSVZPamlJdm5I?=
 =?utf-8?B?K0JTZyswUnRuM0pMR3VYdUZuRmlGQmVCdWltL09NRlpBRzZ4QlVCeW5YRVIv?=
 =?utf-8?B?RU12bCtadmJiNlNyUjZVRDJ3c05ORDBDSGo2QzA4TXZ3S2FGa0xEeE5yMnQz?=
 =?utf-8?B?WjlseExPOW9GU2Y5OU5DT0JGcWtsTUtHM2YvcEJXeUNRTkNYVkNYSW5oUlhl?=
 =?utf-8?B?dXlLZXJqeVhROVMwNSt1YjlVWkFYZ1RCanJ3V1V0clFuaHpLa25mWUNNNHFP?=
 =?utf-8?B?SURGMzVMWk9RUE9lMFZsbUV6ejJyVEdQeElQb2VQL25LbmtiZnFqTDQzbENr?=
 =?utf-8?B?bFFGWkZ1UmlLTkNFRHlVaFQ5NVJSSWo4OXFsWFFGZkxqTnpKejIrZnFNcWNZ?=
 =?utf-8?B?Q0YrRUFHR0NPUlM5cUkrYzRoOWN0WFE3ODhHZ3NuUEhtTnB6NEFKTU13ckV4?=
 =?utf-8?B?NjEvNGxvUzBBZVJZeVpWQVh0OUNxd1dBRU5ISlBpcGo5LzF6NzBtTGxwaXpD?=
 =?utf-8?B?NHJJSVFhMEthOUdVK0R3LzZHRFJWMGw3aVdBZWJBb1ppWENrZHRHeE4xdjI3?=
 =?utf-8?B?b0NtcG5lU2pQckkzaXpkdGdmdHV4bVRNUEg5REliMWZtbGM2NWlpcDNJLzBV?=
 =?utf-8?B?OERCWnMwSW1JT1ZjL2s1Y3A4Nm5Jc1BsQjJBL3JTWE5mSmFzcXZZa3dJa2lI?=
 =?utf-8?B?b1NhY3RhMnRMaEtSN1ExY2xIUUF1aCtWSUhtNC9LanFSYWtWNzBsZ2ZRWjBZ?=
 =?utf-8?B?T3o5MVZVWHd6eVcrUGllTjVMeWZNVkFvL3RzdnhNU2RzcmRFMC9HOEJoU2Rv?=
 =?utf-8?B?U0E2WmVmdnV6TDU2KzVGS0U3bE1yOXhZN012MDQ5dHJsdHFCMkNYc2hSbTZw?=
 =?utf-8?B?dm52eVdabkMzbkJKd3hDUXd4UG5DV1NVVjZtc1h4WU1IMVkrYnAvcndzSi9K?=
 =?utf-8?B?a1ArQkxqT2RVd1BaYnJSYWZMaTdpSnJxTG1nYUxJMjR3alZQdDl4dnBIZElW?=
 =?utf-8?B?WWpwQU1nemJ0SVVXQ1lCMTlJR09lUStFcEFadUQ0SHV4MTV6QTFrdkNuc0wv?=
 =?utf-8?B?a3Rad2kwUkZtTSttcnhmRmRLZlhINWx2eVUwTzIyVC9CTXMvZEVSc0NzMysy?=
 =?utf-8?B?V1RqU0ZLWVZyeHhUNkR0WUV4aXhxeEhvVnpNR1VWamtZemZyaVFnRktJdEJO?=
 =?utf-8?B?RUhCaGQ1dmpURjB2NUlCQjJZK1QxdVkwYnpmTk8zUGxjTmhqMUdPdldKL1Fa?=
 =?utf-8?B?M3F0N2Nwd21BbFBiWTVveHV4YzBXVjRXQmxHNmhWYnk1V2R6QnBLUmtBa2s2?=
 =?utf-8?B?S0Q5dThRMmV4OVk1Um8zcHErSThWQ1RvcTF1TlJKMkdvTUFzMDRuMC9JdlFo?=
 =?utf-8?Q?5T/zk5F8vaeL9GkuU4XZO44n7kAjUM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEJsd0xiengvem5zQmcxeXVsLzdRRkkzTjZGQWo0OGlacTdwM29lTDIraC90?=
 =?utf-8?B?ekVXN2RNVHVCVG9yOXFLem5tcHRjR05Xa3grbE1jVzRzeEhXeTFBRk1ZcTE5?=
 =?utf-8?B?YVJnL2s1MXlHRDBhazl2TEhMRG9vampVdU03dGs3cTB0N3h4WTVtd251dFpI?=
 =?utf-8?B?WnkwRHd1SE5tN2Q0OEVHelpPaVB1YjRudGNSUUh2S09SWC9lTnJhbE1saVR6?=
 =?utf-8?B?bzA5R05yUG9vS0d6dTU1SzFXQUVLczhEQm80SE5udmNKSm1UemRMaFdoN0R3?=
 =?utf-8?B?MCt4NHZ6S3RMZ1Nqalk0WUx5QUNKaERzbGw0ZHNRWEZoWUs0VG12bjJLYjNU?=
 =?utf-8?B?cUFSK1duNGZXTVBaWWo4bkpRUzg2byttTWRNTTFLUGdOUFhrTFM0OHlKLzIw?=
 =?utf-8?B?TG9LQVloVlZrTjc3Q2NSd2FYV0ZOTGZZay9GNjRuL05idXdsbDdTVzRCUXVv?=
 =?utf-8?B?Zklzc1pxb3BlNjY2M0pRWi96dXZvem5WM0dBZmI1UytUSjNIeGUzOUcyT2ll?=
 =?utf-8?B?ZlJFVzV3aEovUFFCZGxXcElYYjY2THdac2lSUFhRM1pRL0dETU54cEhsNTVE?=
 =?utf-8?B?dmF0aFR1S21SM3ZGUUpsem50dWhTbit1WnhJWCtvMzBUWCtWa0IxdDlBVzFU?=
 =?utf-8?B?MDhTYWduRENkWkxpNStTa3d5SzlRUDB5eU9NVHY1U2hoTDU0TWJaQ2lBSkkv?=
 =?utf-8?B?VGtpT3hwRTQ2Z2cxdnVDNW5IUWFjSzdRenBERlI0cnBDMy90eGFjOFNmc0Ju?=
 =?utf-8?B?dXUxTEY5L2FFOWpCb3lZYWoyVmxFdEVjQXNFbHJsell3bk5FNUR2aS9TNEFH?=
 =?utf-8?B?NnZseExDVjVCZ0dKcjllcWNtejA4UkY5TlRNRDI0N3hZaW5RblBhSTRQdlBN?=
 =?utf-8?B?M0FHVVVrNU5NSVo3dFRWRkJEZG5YbVBvcm1Gblhha28rZUpHMnBmVmltSk9y?=
 =?utf-8?B?L3Z6ZURzMHVDMkVRZWhuSWRJMUV3NlRTTk5NTzJBc3RSWmpIeHdKQkhMQVVV?=
 =?utf-8?B?eEZZNVRQM3JMaWdnSnZDWGJkOXRkQVUyRk9VQy9oSWJZa005YzNPV0tVZDhs?=
 =?utf-8?B?Qyt5RWcyTGtzQXQzRCtwV00vYkU4cnRFZmhsSmsybEw0NGwxaGtFOXhWOUdq?=
 =?utf-8?B?a1pBRlNDZ3c4aHRmQXVvZG9XQXRCOVYzL1p2b3F5cjFCY09SNXZ6MnQ3Umtq?=
 =?utf-8?B?TTQ4Mzh5aUZkcWhBbkFTMWJ2UFMrNEFPaVRIZEp5R0Jkb2hFQmNPTmdza2t4?=
 =?utf-8?B?SEt5cVI3cWNUeWM3L20xeWhRV2ZHRi90ell1MzRSOW1NOXIxeThRbm42RGxl?=
 =?utf-8?B?TU5RaVZVNzVqdUVJM2E3MldhWnE0aGM4TDF0alp0YmU0RmNCM0xTUkhXK21L?=
 =?utf-8?B?UGJ6ZGYrV1ZlT3VBcW0wUlRlaGw3VEpaV2h5NVdlUmM0UHV2VXAvYjIzVWNq?=
 =?utf-8?B?MEVra3lXc0docmZqNkt2SkZYdFFNeGR2emgxaDZFaHljcmIvYVNrRU41b20r?=
 =?utf-8?B?OFpES2tucDNQTDJRZ29GTk5IcHdYaklBcmdQTzlIUnd3SGkyckJiVzhJdFJ3?=
 =?utf-8?B?ZHZZeGlyRFF0T3JhNlIxRzEwc3RWSWFpZmxyckYxVVRETEozWDVFeTRXcXFy?=
 =?utf-8?B?N2tRaHlwdTJZZG1UL3kyYjR5bFAxaktvRGNRODNvOWN4eGN3bm9TNy83cGlz?=
 =?utf-8?B?NmhOZW1Xcm1ZN0JVSDdzUGd6MzQwNEE3MnBTdmJvWFd5TnVCWTRlM2ppN0h5?=
 =?utf-8?B?TGRGaHg3U2Yyd1RHeW9mSEUvcWxMUWtLSFhqUnZuWm1LQlFiMHUxYkgxbUd6?=
 =?utf-8?B?aFR2MG0xSVNBSWVPQ2doZkN3QmluNjMyNFJla0tOdEloRFhYVWlIM1E3NllV?=
 =?utf-8?B?WkM5V1VvT3R6M2FEeTJFOHpvUkdQMEVFTDlBMjZFN0xwcERtL0h3WXpDTy9o?=
 =?utf-8?B?Vlh5d2RuVDVDZXVNU0w0RFMzN1grVmRCL0FSQjlKVlJTd2JnNjRlRGZkeW9L?=
 =?utf-8?B?L21tc2I1UWxaZVVOWjNBZXh0SUhIR0FmQjdiNDQ2UVpDRTNmTzlCMW9DcDZh?=
 =?utf-8?B?anZMK2VkR2RwN21ISjhCQUZNcm1FSlBJK25zbW5QRHArR3ZTT3RYeE5memZz?=
 =?utf-8?B?TFFhREVDbG03bllJeHRDa2x1eVRTTGRsb1dXUTVNUHZET3E0T3lqWFBlakJw?=
 =?utf-8?B?ZEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36690c23-0cd3-4cae-d9d2-08ddf1d9440a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 08:49:20.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpm0Ns+GeqCMYYg+mMAMHCOx2dgStKFvsEmokQaym3ju/QgQV0Ckdw7nCVBqa1h5Ey63e4AtDgLuQq8JOLyyv4fRhwxOPXJ+lHbOBzzMrPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8403

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTIgU2VwdGVtYmVy
IDIwMjUgMDk6NDQNCj4gU3ViamVjdDogUmU6IFtQQVRDSC9SRkMgNi82XSBjYW46IHJjYXJfY2Fu
ZmQ6IEFkZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24g
RnJpLCAxMiBTZXB0IDIwMjUgYXQgMDk6NTQsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4gd3JvdGU6DQo+ID4gV2l0aCBhZGFwdGlvbiB0byBSWi9HM0UgZm9yIHJhbV9jbGsg
WzFdDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+IEBAIC0xOTgzLDEw
ICsxOTg0LDE4IEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9nbG9iYWxfaW5pdChzdHJ1Y3QgcmNh
cl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGZhaWxfcmVz
ZXQyOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICAvKiBFbmFibGUgUkFNIGNsb2Nr
ICovDQo+ID4gKyAgICAgICBlcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3ByaXYtPmNsa19yYW0p
Ow0KPiA+ICsgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAiZmFpbGVkIHRvIGVuYWJsZSByYW0gY2xv
Y2ssIGVycm9yICVkXG4iLCBlcnIpOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGZhaWxfY2xr
Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgIGVyciA9IHJjYXJfY2FuZmRfcmVz
ZXRfY29udHJvbGxlcihncHJpdik7DQo+ID4gICAgICAgICBpZiAoZXJyKSB7DQo+ID4gICAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAicmVzZXQgY29udHJvbGxlciBmYWlsZWQ6ICVwZVxuIiwg
RVJSX1BUUihlcnIpKTsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBmYWlsX2NsazsNCj4gPiAr
ICAgICAgICAgICAgICAgZ290byBmYWlsX3JhbV9jbGs7DQo+ID4gICAgICAgICB9DQo+ID4NCj4g
PiAgICAgICAgIC8qIENvbnRyb2xsZXIgaW4gR2xvYmFsIHJlc2V0ICYgQ2hhbm5lbCByZXNldCBt
b2RlICovIEBADQo+ID4gLTIwMjYsNiArMjAzNSw4IEBAIHN0YXRpYyBpbnQgcmNhcl9jYW5mZF9n
bG9iYWxfaW5pdChzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9iYWwgKmdwcml2KQ0KPiA+ICAgICAgICAg
cmNhcl9jYW5mZF9kaXNhYmxlX2dsb2JhbF9pbnRlcnJ1cHRzKGdwcml2KTsNCj4gPiAgZmFpbF9j
bGs6DQo+ID4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZ3ByaXYtPmNsa3ApOw0KPiA+
ICtmYWlsX3JhbV9jbGs6DQo+ID4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZ3ByaXYt
PmNsa19yYW0pOw0KPiANCj4gU2hvdWxkIGJlIGluc2VydGVkIGFib3ZlIGZhaWxfY2xrLg0KDQpP
b3BzLiBXaWxsIGZpeCBpdA0KDQo+IA0KPiA+ICBmYWlsX3Jlc2V0MjoNCj4gPiAgICAgICAgIHJl
c2V0X2NvbnRyb2xfYXNzZXJ0KGdwcml2LT5yc3RjMik7DQo+ID4gIGZhaWxfcmVzZXQxOg0KPiA+
IEBAIC0yMDQ1LDYgKzIwNTYsNyBAQCBzdGF0aWMgdm9pZCByY2FyX2NhbmZkX2dsb2JhbF9kZWlu
aXQoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdiwgYm9vbA0KPiBmdWxsKQ0KPiA+ICAg
ICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZ3ByaXYtPmNs
a3ApOw0KPiA+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGdwcml2LT5jbGtfcmFtKTsN
Cj4gDQo+IFdyb25nIG9yZGVyLg0KDQpPSy4NCg0KV2lsbCB0YWtlIGNhcmUgaW4gdGhlIHByb3Bl
ciBwYXRjaC4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=

