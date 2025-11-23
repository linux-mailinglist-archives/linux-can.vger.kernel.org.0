Return-Path: <linux-can+bounces-5610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC686C7DFC0
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714203AA698
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488582D0C64;
	Sun, 23 Nov 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BBLO7SZd"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D7274FC2;
	Sun, 23 Nov 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763895004; cv=fail; b=lvBeVeKPilaqfMsz353zBMa5Ka3rBqd1NF7ygKCFQFBmOMg+CRNDbCtD7RJXIPuwF172EAse9IvW5omCxd15jkRZj5/6fB2F52L8FbTGL+IuG0amwTTgOXCx3xLEp98N3mBiysFyJ/TBFeeTXujOMFU/xPmr7LNIdx9uY9lAiV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763895004; c=relaxed/simple;
	bh=drOy2SBNECwhV2F/fVUDCuAAGx0FRPolaCPwq1vr+48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RspOW1q2hr4N/Me6L0WnQ+e5Qbtfj/47+RccZfmGFp5Xon/Y68Cn7wboGlA2pVpMZ1qMW/A8LfCjlp3gzVKM04AWszP5uzN0L6SeGlmuXvIPnPAO2WmO2AyI7jRnwPND8+Z6pvF3lu8HPmwfnjZ4Pe6WBy5UOhDvPy8hX4tsI1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BBLO7SZd; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huTqUItMPu4I5srJx+iopKAYRcoV1PfC4mURinZrTuai/Tu4IBg9Uke+6YG1mRztLXe/fc/xLo3ib/l34aSQ2PNUQG1pFFjaKYhkvPaOZepaqyK0NiT2dah544aQLsrz0bdIs6U3mVn+xalIJ8gokjhyxnzECb67Rrof0Bq9v864SzFkV6iuLWf2GZetj1bk4+GPNF6i7kHGAIm1mfhfzYuoK80RbDCnIgUPWSBMm6N0OC6FpqQRo/w2Pon9j6QYq22O643pswiWkdqpLM/O9yhUwrUiXe4bvCYy1vyABRu/Zuh5Or2WP0vakv9GZW2DT5NTHMAwy7mxVzkbCalJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drOy2SBNECwhV2F/fVUDCuAAGx0FRPolaCPwq1vr+48=;
 b=waMc3gqaOEcDu/DfAwhRn9Oui768MG+URSvSV2uY2kJR8zWP+gimC5KWS58PD/5vfglbXpNHZRt8O2ngMLm9O97ZMndsWPMwsVP8R2Tg7C6kw+DnrXLSx1XOOtggyHI3L87djweQ/8XxL21nJQ983QLXzZ573+8Paft+aKhrjs6CubRFoRHNXdTD8EhkWpBOy7KJc+ciJhCLlMXMoig72fwt9IwMk8bTs9gJxpOODPIAucUCWWR32ichXg1eybsmXn79XpCQETuGwt3Z871BTS+D67b6hJWZ9NXfrkusjTNf1gKx5Qvm++OrEExT8Y249dfFWlUBP1TUPUptYiywLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drOy2SBNECwhV2F/fVUDCuAAGx0FRPolaCPwq1vr+48=;
 b=BBLO7SZdVpcrIiIwNgVSsoCa9bTeJvX3tWGbIBXHq8AIlpxP25bHQzZTZDM9k8aetrOMaD8QIwCD8OqYeGgbw2Ua7roIR3pFg5yePPSIGIwxQwGfJG+Pur93UCavyy1YiOALGF1BECOSDmpKt2mgL5gPyL9n4rXXnEN1y7Om18Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB6615.jpnprd01.prod.outlook.com (2603:1096:604:fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.8; Sun, 23 Nov
 2025 10:49:53 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 10:49:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, biju.das.au <biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Topic: [PATCH 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Index: AQHcWJZBurQYMon7v0qJY3gOCzN2e7T7OLQAgATjjXA=
Date: Sun, 23 Nov 2025 10:49:53 +0000
Message-ID:
 <TY3PR01MB11346A0EA85ABB4EE69FBC7D486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
 <20251118141840.267652-2-biju.das.jz@bp.renesas.com>
 <20251120-statuesque-heavy-herring-e915f6@kuoka>
In-Reply-To: <20251120-statuesque-heavy-herring-e915f6@kuoka>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB6615:EE_
x-ms-office365-filtering-correlation-id: c5064c8e-d2e4-483a-d4d4-08de2a7e08ee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUtycDRrTThHdWtEaU5JOU13K0Q2ZG9yZ3cxWGxRRzUzemM2Zjc0cnkvaEpq?=
 =?utf-8?B?MFZTM2lDeDgyNzRGUzJtTlNsR2RwWVlwVklsREtBMWJIRktkdHBTWHlUNVZK?=
 =?utf-8?B?aVJERmpWZkd4YlRLVW9LZTFBR00zdnIzdkpIcEhXWC8zVmIyeitvbVRhWDZQ?=
 =?utf-8?B?UkZWOWF5MFBKQXh1UHBNekVFL0pmbGR2K1h5cE0rdzhaV3NYVDNKeHJXaWxD?=
 =?utf-8?B?RnlFdkhBSWpjSzMxai9IdVRXZ0F1R01nSHZTODM4ajhEbFVPL3JPMVU1dVU1?=
 =?utf-8?B?RWZBb0ZSQzBQc2FxYkZRTWg4QUxGZ1J4QVlYbWdWc1JNOWE4WUQrM2RiQ29q?=
 =?utf-8?B?Y3BTeU85K3RXUnpUWlV0a3J3WVhZTkVHdGRHemdQeExOTEFjeHVJTTRCNXFn?=
 =?utf-8?B?bGNEdDNQakNYMk5NcHBOT1RDRWdSQytPM0ZGUzJFc3FtWXJkR04yelNlVjla?=
 =?utf-8?B?QVZmZHVGYTRoL0tjUXo2NVZMekxVSXFBU1B1bHdqRnNUM0Y3T0F4bEFQaUxS?=
 =?utf-8?B?STBPL0luUU1FQ0VOTEF3eTdqWk1NMHRUR2VGbzgwR3Q3U3ZHT3YvZGhZb3g2?=
 =?utf-8?B?Rlk1T0VTdEcvSUZmUkhMSW5qR0U4ZmxqTXJ1ektubUx6WjAxSXAzYUpNaElm?=
 =?utf-8?B?OVYrMWlZdDRkUWwwVnlxN2N5U1hRMG5HWSsyazh4UmtHdVdxK3F0Ti90RTk1?=
 =?utf-8?B?dUJUOE9NUDJxeGZGVEFyU0prVWtYRUs2UG9yNUpEMFR5SkFpQmJBS1JRdkJv?=
 =?utf-8?B?NGRQbHN6cCsvQldVMHIzQUJTUXBLeGx2M1JySCtLblFPVTVFOVhSbTNwenZN?=
 =?utf-8?B?b1lGZFFrZS9NQWY1M3U1MG1DQk0wQnpGT3F1OUFkbm9hNnU4Tit0bmRab1g3?=
 =?utf-8?B?QjlJQ1duL3BBVXhQWG9kK25aSU9WekJGYjRMQW5vS0hiSE9MSWs1MjBHZFU1?=
 =?utf-8?B?MWdpaGFzT1ZZYUw2M2lLZlNlVk8yMTFCbHVaUElRQ09JZTRtcHh4MStrT05n?=
 =?utf-8?B?a0JxeWJiL3Z6WUdjTEVuOGF6eGdoNlB5WFFiNzZXNUR6NjJCYzBrYTcyZTU4?=
 =?utf-8?B?d0lpTmJFU2JLV29kTlpUb2kvWlhUS3lPR0lybkxPN1JpWW5pSVVEczhwRGgv?=
 =?utf-8?B?NDNCQWpqL29rWnJaOGtUQlZHbGtmRlMvOWdlNHJ2ZFl2VFBIN0w2d0VBMHYw?=
 =?utf-8?B?VnVyUkI2N1hBM25NdXJGTFBIOUU2RU5XSC9jb3dzTHJMRzhIVXRsSVAxMWtr?=
 =?utf-8?B?Z2RDMGtNVDFxU0FZZGJGK0JEeHovcnlGWXExWCsyM01teWtLN29wc0l1dExs?=
 =?utf-8?B?dTMrRjBIejFjS1dGb09TaGpoYUdkUk5UWno1ZG1XdUhFL2VjUktnTW5GQlJ3?=
 =?utf-8?B?c0RiZy84VDVkSVVVdDZwMU50RDVPTDdtQmJKMWxnRnFkRGxWUG5JOWpBNk5i?=
 =?utf-8?B?RTQwVU44WEgxWDRqTm44Zm5WVjJXTXZsVEVndi9jWG5sa2lMVU9NZ2dnUFox?=
 =?utf-8?B?emlGamxIMTJGdmUrUnVoTzZHTjJ2Z2VoOTV0RlE4dStsdDVaY0lvcC8yd3dI?=
 =?utf-8?B?VGMxTVIyaXBQVUpQVzQwbFhoZGU5T0lXV1pDZHdoMTVaOVlGWmlEb1p0UXdk?=
 =?utf-8?B?cTkrdVpxdmpRNk9LZVNGQThUWG1jS0lMZHZ5TW5JSUZmVXhJbER2SXg5bVhj?=
 =?utf-8?B?MlNYeHpnMkVSTmx1cDBDWXY1YmJTd0F2Z1JpMnM3aGE3ckVEZExJR0NXUEE1?=
 =?utf-8?B?VHFkNzNSVjRZdHBGK3hGVGl4UUdqZnY5Q1ZvM2FCTm51RU5MV2xldVM4L29M?=
 =?utf-8?B?ZmpqSUxyRkhzNmt6Qk92ZEsxbGVFdWVsSGYwSVVYVWJxU3hGU0taVnUrbkhH?=
 =?utf-8?B?YUJkOVB2bFYvMFQ2ZFhrWVhpN2dKbGRHVnNDN0p3Y3BOM0h5ZFd2Z0VjV2JU?=
 =?utf-8?B?aXFFaEZEQnl0cWJRTFBBZVFHdXBoVFo2R1FobldTU1A1MVdiN0lyQ0Z4bkQv?=
 =?utf-8?B?MnZPWm1uYW5ZYldZbk11N2d2TFZvWXZkTy8wUXYzak1wSHhWa0lva2w2TEpx?=
 =?utf-8?Q?n2Jj4X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUgxRHRVRDNMbFVQRUVZVmVhUG9WUGxXU2w1d00rSlZQYW93M2tWelE3ME9W?=
 =?utf-8?B?ckZQdXRVSUFQNG1naXZQOUE5NUVob0pTei93Y0NPVzdrM3RoVTk0RXoxSFVv?=
 =?utf-8?B?ZzVyTFpETk5mNXZqbXBJRktodHVJOGNRYnJYWUo0S3p0ajYvd0NaWUo5cW9P?=
 =?utf-8?B?VTRYYUFxNGE0SG1QWkZGQlFXSDVnVEs5bVlidmhOcTVueUxvNUV4VHFhSWIr?=
 =?utf-8?B?eml2N0xpTHJkYmhZMXNSemlVVHd0UHN3QXdsUlRkbHZTeEIxNDRHalYwaFk3?=
 =?utf-8?B?L091d3hkVm1ralNCK0RiQURueXRXU3dTRzY0ZmdPVnloY3FrUGpBS2UvTjlH?=
 =?utf-8?B?cVdKaDIwWXZBRExYOE01aWdVOHI4WDRXdEZVSENwWVp6QUxtaSs4NG5qckFZ?=
 =?utf-8?B?VVdMNDVjWW9DeWhDS2ZnalFjSUhJWERIQmo3QnM2Wi9YR1NmWTFVcnNLblpF?=
 =?utf-8?B?eGhLcjlsb0pHcDEweTNud3lXaXZ1TUpmK2NQOWRWdWV6UGlYNWd0Q2R0YzRT?=
 =?utf-8?B?dVgybldGdVNYb25TWm5QR09LekZpNnZxT0VDb0IzNlcrL0JhaElMaC9Jalkv?=
 =?utf-8?B?b0x4RDFERXZLSFNwUHJTMVBqV2gvdTdldEl6aE1uaHhreFd4YlBTQ01ROUl1?=
 =?utf-8?B?Q2d5UlRxekEzZ1Q4cE9CalBpS0grS0FEa1R6SXVhN2R0Z2lhalhDOTRtNU52?=
 =?utf-8?B?Umh5NUtLRU9qSnJhTGI0eHhTNGtqTTZsYSt6UFVXdW1ReE5HNXQyUGY2a0hP?=
 =?utf-8?B?MEtCSmxXOUpnWnRhZzhSa2VyTGRkWlZGbVVDa0g4OVdOVUsrZldKZE5JRUhy?=
 =?utf-8?B?b3dXQmZNNjVWVWw0N1dhK0NOR2JNb2tEY1JteWNXVm5RSVBSSk9KQjJHVFA1?=
 =?utf-8?B?Z1lmT1BYTHRDTXNMZjFBdmpjSWdDaFo4WXZaMzlveGFVUjh3a1ZZZWYybWFP?=
 =?utf-8?B?ZHlBUDY5dE1nUFNKR3gyWHNmcU5yUVR5Rm9KTkVwTnprcjJDaDRDdVRmSWI2?=
 =?utf-8?B?QVFHR3BNSFpQb3lDMGNMV0R2YTUycXh2ZVpydDNjMmdrMGVnZXo1VSt0QUVz?=
 =?utf-8?B?WWZTNHp2NzNuTGJaeW5pbXhKRHRVTTRGYkpyZkkydjh4VWpDUzdPRjRGOHBk?=
 =?utf-8?B?czZXSm9kWWVPWVR6cERCWkdIYVlMbTBIbWpWZ08rVkRKRS93c1FvU1lHdTVJ?=
 =?utf-8?B?SlJRbk45eHZTRG9pUzNBQ3FBdC9UdlFpbTZMSy9zbUZBZGZ1a2pWS05semI2?=
 =?utf-8?B?UUdOK20za1UrSWVZaDFQMGY4dFMvdlFoaWZhMTBFKzNscWVIS2xobFErUVdF?=
 =?utf-8?B?ZVFkc1d5Q2VtOFJPSllGQ05wSytsa24rSmlUUnl0QWhaaVVXbStGcUcyNTJl?=
 =?utf-8?B?ME5Hdm9WNDVpcFJGMmtRTjNqT1RwdjhEVnZGOS9Qc2hCVVN6OFlLaCsyOHQ5?=
 =?utf-8?B?SDM2Zkw1aGtCVVozRWc5S3NCbGpET1pxWjM3STRkWWxhVE14UlRkRDVoWkZn?=
 =?utf-8?B?eHFrTnFsR2lMalA3bVlkVkFGSm5qN1hhdDJtVXZSVTF4UkZjRHNFS2x3ZWtM?=
 =?utf-8?B?WnY3YWlRSnpqMllVVGY0ZUpMeVgyZ0F4L1JPUnNpUEdubjFRV3l1SWZ3Ykl3?=
 =?utf-8?B?RVErNkxVcGo1TE1FQi9nUmM3Nk5UYldvYjFNaHdDZjJjbXpiREk2OXczTkgz?=
 =?utf-8?B?cVgrZW5qNzFyTTVjQ3VneEFIRFl1RjN0d2lzY0hkVmI2QUtYUXk2V1hyclZ5?=
 =?utf-8?B?aWFrY3UrN0VQZHhYWjdxNDhDNWxaYjcwcDhmTlBBMzRmdjdXL0xSRjRsL2pD?=
 =?utf-8?B?enBWaWs5T1RmaEhlaGJhMlREVXlmYlpXTDQ3MDdmdlYvNmU0YUhWbjRvTzVl?=
 =?utf-8?B?Y294Q0JtRGF2YVNkMm9RaFdrek1FTVJqZGJaMFVoZ0g1eXp6YnJqUWtRZ0Jx?=
 =?utf-8?B?Sjh6QWh4K2ljNkJiUVBsQlBlWHB2bi8wejREQ2h1cFBJSEEzL21oRXRWQ2R5?=
 =?utf-8?B?ZjFTeDdKZDRQaU5yem1rYWV2aW1seXc3dDBoN1hRdkRuQ0g4dmY4VjlRMHZI?=
 =?utf-8?B?ZE5nOHNUYjhiMks1Tis4Rjc0SDNxMnlzTzRoOVhLQ2R5VlkvSE01YUNGMmxU?=
 =?utf-8?B?YzlvSGt0dUE1ZnNrZHdkNUNTZTRRNTJNeUlKUng1eE5ZcVYyUjl5ZDZ2ZFVG?=
 =?utf-8?B?VkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5064c8e-d2e4-483a-d4d4-08de2a7e08ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 10:49:53.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pceGPd6EVAkq/cYY9r+WhuutLg+B0A7Zaoj/+j5LVpjKUXmGQwx45TqMd4e1JLeG3z87JrC1rqkUGyW00Qucq4ei3D0o/OQ27Z/Vo6beGV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6615

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMCBOb3ZlbWJlciAyMDI1IDA4OjA5DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogY2FuOiByZW5lc2FzLHJjYXItY2FuZmQ6
IERvY3VtZW50IHJlbmVzYXMsZmQtb25seSBwcm9wZXJ0eQ0KPiANCj4gT24gVHVlLCBOb3YgMTgs
IDIwMjUgYXQgMDI6MTg6MzRQTSArMDAwMCwgQmlqdSB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBUaGUgQ0FORkQgb24gUlov
e0cyTCxHM0V9IGFuZCBSLUNhciBHZW40IHN1cHBvcnQgMyBtb2RlcyBGRC1Pbmx5IG1vZGUsDQo+
ID4gQ2xhc3NpY2FsIENBTiBtb2RlIGFuZCBDQU4tRkQgbW9kZS4gSW4gRkQtT25seSBtb2RlLCBj
b21tdW5pY2F0aW9uIGluDQo+ID4gQ2xhc3NpY2FsIENBTiBmcmFtZSBmb3JtYXQgaXMgZGlzYWJs
ZWQuIERvY3VtZW50IHJlbmVzYXMsZmQtb25seSB0bw0KPiA+IGhhbmRsZSB0aGlzIG1vZGUuIEFz
IHRoZXNlIFNvQ3Mgc3VwcG9ydCAzIG1vZGVzLCB1cGRhdGUgdGhlDQo+ID4gZGVzY3JpcHRpb24g
b2YgcmVuZXNhcyxuby1jYW4tZmQgcHJvcGVydHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9i
aW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sICAgICAgIHwgMTQgKysrKysr
KysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlh
bWwNCj4gPiBpbmRleCBmNGFjMjFjNjg0MjcuLmJmOWE3ZDUyODhkMyAxMDA2NDQNCj4gPiAtLS0N
Cj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMs
cmNhci1jYW5mZC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZkLnlhbQ0KPiA+ICsrKyBsDQo+ID4gQEAgLTEy
NSw5ICsxMjUsMTcgQEAgcHJvcGVydGllczoNCj4gPiAgICByZW5lc2FzLG5vLWNhbi1mZDoNCj4g
PiAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPiAg
ICAgIGRlc2NyaXB0aW9uOg0KPiA+IC0gICAgICBUaGUgY29udHJvbGxlciBjYW4gb3BlcmF0ZSBp
biBlaXRoZXIgQ0FOIEZEIG9ubHkgbW9kZSAoZGVmYXVsdCkgb3INCj4gPiAtICAgICAgQ2xhc3Np
Y2FsIENBTiBvbmx5IG1vZGUuICBUaGUgbW9kZSBpcyBnbG9iYWwgdG8gYWxsIGNoYW5uZWxzLg0K
PiA+IC0gICAgICBTcGVjaWZ5IHRoaXMgcHJvcGVydHkgdG8gcHV0IHRoZSBjb250cm9sbGVyIGlu
IENsYXNzaWNhbCBDQU4gb25seSBtb2RlLg0KPiA+ICsgICAgICBUaGUgY29udHJvbGxlciBjYW4g
b3BlcmF0ZSBpbiBlaXRoZXIgQ0FOLUZEIG1vZGUgKGRlZmF1bHQpIG9yIEZELU9ubHkNCj4gPiAr
ICAgICAgbW9kZSAoUlove0cyTCxHM0V9IGFuZCBSLUNhciBHZW40KSBvciBDbGFzc2ljYWwgQ0FO
IG1vZGUuIFNwZWNpZnkgdGhpcw0KPiA+ICsgICAgICBwcm9wZXJ0eSB0byBwdXQgdGhlIGNvbnRy
b2xsZXIgaW4gQ2xhc3NpY2FsIENBTiBtb2RlLg0KPiA+ICsNCj4gPiArICByZW5lc2FzLGZkLW9u
bHk6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFn
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIENBTkZEIG9uIFJaL3tHMkws
RzNFfSBhbmQgUi1DYXIgR2VuNCBTb0NzIHN1cHBvcnQgMyBtb2RlcyBGRC1Pbmx5DQo+ID4gKyAg
ICAgIG1vZGUsIENsYXNzaWNhbCBDQU4gbW9kZSBhbmQgQ0FOLUZEIG1vZGUgKGRlZmF1bHQpLiBJ
biBGRC1Pbmx5IG1vZGUsDQo+ID4gKyAgICAgIGNvbW11bmljYXRpb24gaW4gQ2xhc3NpY2FsIENB
TiBmcmFtZSBmb3JtYXQgaXMgZGlzYWJsZWQuIFNwZWNpZnkgdGhpcw0KPiA+ICsgICAgICBwcm9w
ZXJ0eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gRkQtT25seSBtb2RlLg0KPiANCj4gSXQgc2hv
dWxkIHJlYWxseSBiZSBqdXN0IGFuIGVudW0gc2luY2UgdGhlIGJlZ2lubmluZyAtIHJlcHJlc2Vu
dGluZyB0aGUgbW9kZSBvZiBvcGVyYXRpb24uIE5vdyB5b3UNCj4gbmVlZCB0byBjb21wbGV4IG9u
ZU9mIHRvIGRpc2FsbG93IHVzYWdlIG9mIGJvdGguDQo+IA0KPiBZb3UgYWxzbyBjbGFpbSBub3Qg
YWxsIGRldmljZXMgc3VwcG9ydCB0aGlzLCBzbyB5b3UgbmVlZCB0byBkaXNhbGxvdyBpdCBwZXIg
dmFyaWFudC4NCg0KT0ssIEkgd2lsbCBkaXNhbGxvdyByZW5lc2FzLGZkLW9ubHkgZm9yIFItQ2Fy
IEdlbjMuDQoNCkNoZWVycywNCkJpanUNCg==

