Return-Path: <linux-can+bounces-7401-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF+4EqIN7WmqegAAu9opvQ
	(envelope-from <linux-can+bounces-7401-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 20:53:22 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FA4677BB
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7F230086D1
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8737FF75;
	Sat, 25 Apr 2026 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dBEQ71C5"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011003.outbound.protection.outlook.com [40.107.74.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725D37FF6E;
	Sat, 25 Apr 2026 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142913; cv=fail; b=bLmi8xS/eciJ6mZnjOzrTiAfjrlpx7GrLtJxE6zyxm0le+JPAmQkiWPmyIpb8cq788VHSE8z7s8L1cKOIavJwq+5a9qRJ7uaU6p5ZYEaILtqVR/0lFoKRC2FSDpJ8UeggaFmBkL1WL94J1LVJcscYrXT7HuhZVACK96rIhUaQsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142913; c=relaxed/simple;
	bh=HVTmmP1x24Rys7ip8bHGUwcQpUp/6FdVtzW7iwL4t0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rq0o8kDtDCaaJpu8PXfiV3+wbZDLbZlMeCvE1ky7aHsc4zMXW9ciTuOIvqTKPGzGyn3sTwkZwkvTkRomPY2D6YaJQaS00oHa+Jrn6nc0nIwSi5FDCqYcCozacOns0GCjeP0yMGhTWCZZ1exYWA50t73yg8oIl7MpXu2ukWq/68U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=dBEQ71C5; arc=fail smtp.client-ip=40.107.74.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANK0YGm3TYT2Ls1Rr+A7960p49e4ttS3Uo9+APfoj2q7kS1yGum4pQy4Lvv9ZrK5MY6X7C6fuMDmGMz79Fd208J2D+3d6OnSrty69aTihK2QgL9LXuvJl+vwallOlGxNse96/SpN17Orw4wDXoSuix1I3P+QgL+GNb2dV2iaDVezrbVKsk0n7CtkjiPYimXq8yHyC4ke1+GY5htBlG8ZpzpVw9f8nj8OdU1fEAYD1R8tkKcSKYJL+DcOYMXYv7TgFIITCfbWOTtYmVnH6Ug7CAWbYcIDvju8LtDcr8mtVRtRNCX3B8n8LUGz3p2HDvgHfbD5jvacu+oKhO04jHiH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVTmmP1x24Rys7ip8bHGUwcQpUp/6FdVtzW7iwL4t0o=;
 b=IVcnRkwH48Q3VBgrN8eg+FIGRWfL6a1W4CKZD0JDRgkxeeTS76/15/+rVJ1iIa5C33UE2xZ25UodJ9zPRq2k+2VwbDSvopL5pyGV0hfgw7Cx8xVf6yD0/Hkh5X+jvZQpcXE3uezSxLVD561OIdZ+E1RUWlKqku3P6iCJVEN4vjL5l+aGdoVdq/ZYaim3vxHlV/h3UsLNuafwoTOWne5dcY30s2Odycg3DxaVBDPP58t3BVH9KDb3VTvElvwyRdjLlzk3Pt7t1B0bRGUlc0XKqNDQEG8OSBZGxgNQ5/pmYsjC1G0XTJmw7EDt394zEDxYd9woVWXU+dqJlp5lM3uMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVTmmP1x24Rys7ip8bHGUwcQpUp/6FdVtzW7iwL4t0o=;
 b=dBEQ71C5Vjcdvag/0LWPFIeSF2Zkd7vTFFmp4Ajb68/cse6t3JL615X6YQyaWluf12LaJhStkmcQDNfRotDgsWjGIva6X6LOkNLW0eCiIeXfIsCbe+Yg6so0XPsbJ0vJmgXUbIrK/hDiI0aLqqfB/QW6kRdJORrO0rdWT6ELuSk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSOPR01MB12185.jpnprd01.prod.outlook.com (2603:1096:604:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 18:48:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.022; Sat, 25 Apr 2026
 18:48:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, biju.das.au
	<biju.das.au@gmail.com>
CC: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
Thread-Topic: [PATCH 0/3] Add support for Renesas CAN-FD Bus-Off recovery mode
 selection
Thread-Index: AQHcw09Ev5ct3x/nM0OumdjMeeQLJbXN34OAgAWMM4CAHIqC4A==
Date: Sat, 25 Apr 2026 18:48:28 +0000
Message-ID:
 <TY3PR01MB113460325D94739C6527CDAD286282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
 <20260403-camouflaged-original-tortoise-ec0f7b-mkl@pengutronix.de>
 <TYCPR01MB1133243B5501A2359CA63648C865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1133243B5501A2359CA63648C865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSOPR01MB12185:EE_
x-ms-office365-filtering-correlation-id: 76598518-2bc9-4b64-6588-08dea2fb3d55
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 /DcUliWW6rAUf4Y1UfuVxeygy29oyJbK23sc7y8UbxmhxAi/F20Tqt9VgbJ+FbJBkYv+yA060/CCiGQxGyI1pZn44LktFOeSuN73dv12mNY8nGsDeIgeW1uHaELdlFeb0WoScDjB0PpUMu0ql7g8C+Mc8ItbdiS+58OcMJO7VDgAO2Efhqbty+wtHAPfTSPS0ojWFF6RFvBYBsTNZKlCxw3sUJ5FLcONiYU+IW+/ANU9SHvgeqvKECAbZFWCz2OB7VV7ruH8Y3s56OfJBd1nLwffwzZrqHZyALzyOTXSyrHeg/GCjzlYAlSbNqzcX86y40s3bsM7pAOuEBhxdi+HB9dngClxyIRZFZKutIC5AFgHnAa0C8BEjs/jtgDklrW4aYfdKMZ6hIeYNzHq+z2bwaCo3SiHYmP/ucYYzgBXYYqkF3VddY20dc2UX6M+8ShAkFVaVkXPSn9srg1KBf/xQTMHDrMeKM4lKXmIcLXv7RRHMLGVq9omEU/wbbn7neLhZbxzTSMkuuAbl2AF6XLt9xElOUbZ4aJ8rCAvNu/yy13eJ+153jQWQEpqQss7bpA6Mxh4wAVDVIkElEgzA0/1pzmFczLNJMXsqc4bcarYrFWDLZ8zS6l+Y4BGqqDBGW1fi6TztAg9jN+Psgqy2zP4xsOq/PvhaUX7pQEOiM6pmBXviYjO9kOxadkLCoGOq/Hm0zX8NEITh9qYw57T/oB4VCYuCBZv/KxJYTm9zCu73C78VXt7L4PqDvXn9ZErBOp35T4WccnyIg/XYX+3hYRCBSJwYOjK6NjTySgGuo34S9Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVRoSEI5cDFIL1ZuelVMYnVHbENXVTUxQmpjRCtXZXF6WFJva1pqV2taOGlJ?=
 =?utf-8?B?TVhPM0VUeWh2ZVo5Sm5kekdwNDJYTWlyN2RsTXJrZ3JJTHdkRmlXR2ovWW9w?=
 =?utf-8?B?QTVCSW5GdUFNYlFQZkQvajQ1K014RDd6Mi9FcHNuYmlTMVJLUWFaaEhLajVv?=
 =?utf-8?B?MmxVdnM3VUN0c3o0Mk00dkdqc2JnUG9FcUVHbEMveGw4Z0JmUGJIWGlPbGhK?=
 =?utf-8?B?dXF0VTZNTWJ3MlYyUklGSy80ZUxaZ0Y2UTQvSnk0RGs1bUtKcVBpbWNXRWxk?=
 =?utf-8?B?MitEWTkrNHk4T2VPUzRrS0pBWVJrOGdVS3hGNmllRmlPTVdOV1JFSVJ2a1FB?=
 =?utf-8?B?WFhoVFp1clhGcWx2dlBEV3I2US9QOUlGNHVRdUVDb2lHS0s3OXpoVFJ3M3F1?=
 =?utf-8?B?QUxjZUxSbU4xUVAveDFjZEJPUm9VUEFzeVI2ZG9ETTlGRCtkWUJqa1daUVZn?=
 =?utf-8?B?Rm9UaFFlVXUzN0RJdnF6cTVWcVRzRFo1L1paMXJBSURRZTRxeFZPSnl5cW5L?=
 =?utf-8?B?di8rRXhqdmZCVTRqWTRvblNlZDkzanoxV1RkRFNHZE0xa0RKMkZQOVFIZFUx?=
 =?utf-8?B?ODVNK2p1cldYdUdOTHBzTDJzK1ZQYWNuck9zWUJ3NWtQMmJXOVg0TnhTTmp4?=
 =?utf-8?B?WkpoelhGNUZRSFkzM2EveWlGK2xVMXU4S2llUjJpSVdGN2tCQjdqOUp3YzZF?=
 =?utf-8?B?TFk3M05HM2xnY0x2NEpLSEM4S0g3QWlJZ2NuZTFUZ0FLOUMxbEs5UVI3aEI3?=
 =?utf-8?B?TFQwVHFFM2hmdmY4SVl0Rno1bDV3bnNhZmhHeFJJekJsTWkrU0piWHBrSFAz?=
 =?utf-8?B?ME12Z1RuMGcreG5ubFd3a1dPWkcxMk9CWlRpZVkxZ0dWcVdrVlNuZTN4UHlO?=
 =?utf-8?B?NmtTdkhCMTZFVEZ4MUUxcUtpemlVYmpFaTVIakcyOUZZQndVcHlPWFg4RzhN?=
 =?utf-8?B?QkJiU1NZQ09UaGM2TzI4dnRSR2F1eXZFZkFsRUpWN3VOTE5wNmwzaFZIVmEr?=
 =?utf-8?B?aGN2bk9Bb0U3MjlsNE5Bcm52aXlNRTF2NTdvRUMrdW5qTVpLZ1FuNko1cWtP?=
 =?utf-8?B?REd1WVpvQUwyRzNMQkF4TExVL2hMRXRuaXFyRXVpdGNtVkJ6UXRiRWZpZGhF?=
 =?utf-8?B?RUFCVHVvSlorNS83cXdsK1pwVEhRWUlqRDNyV2tDdjhkT3pUWUlsb3Rtdmpl?=
 =?utf-8?B?MkVOd0hzemJBR0liYmNHTlR6UUpMejNRREVMRkI3WHpzd0J4N3h5cWtDNTAx?=
 =?utf-8?B?YjYzQVJabjZLbCtVN0g5Q3d0NmlFWm9obStkdU50bUcvNFllalVocWRFQWRX?=
 =?utf-8?B?UHlZMUFqNzF5dVBScjE0RTFuQW96cDdDc3hDTHRUZVJ0OEV5NUhGbGdNeDhB?=
 =?utf-8?B?cTJyOWhDSVloTWpGaWQrY2FvRmtlR1ZFYmYwVUZ0aVU5bURsNk5iSUkyT2tr?=
 =?utf-8?B?SEsrSDNReUwwZURhL3lSaDgxSzI0ZVRmOUt5RGdJdGpZRmJIY1dkd1RJZVlr?=
 =?utf-8?B?TEhsRkR5M3kzcFN6a3lUYThyWkNDa2VTYTg3TTlHNWpwbVYrVWpPOVdBSzdL?=
 =?utf-8?B?Ylk3YnplWlVqWFo0RXRZbnNUdWtBOFAyeVlyYnhoek5YcjQvbDc5cU9sRUhp?=
 =?utf-8?B?eERKcDl5bjd6U3lQeS9STXFmU01ObUZFazlwOXhjQUJmTVdIdnAwRXB0M095?=
 =?utf-8?B?YWt4dlk5V1NBK0pucklNUXN0SUhSdzZkcVdseWZaVHF4YTBYTUJnNVVEMGhI?=
 =?utf-8?B?dHRWc3hCNW5Oa1FGL21sRExkbERMNmQ2WVkzbWc2K1orbm9hK0xESDlUcGRR?=
 =?utf-8?B?M2szTGJ6LzM0cUdvdzIydXN4TVJONzIxVnRvRHZNY2pyQ3NHSXFQT3Vab2R6?=
 =?utf-8?B?eVYyT2txenl2N3ZTS0lxZGVHSTJWdXZsSjc2Umd6RkRvU1U3UDI4cGlQYVJJ?=
 =?utf-8?B?U2M0aStBVVBheTZ5NmtnRU5YTGIyRTZCSlNNd2U0NUZWZmt6T2lLYlJiZDdV?=
 =?utf-8?B?djhwY0UxR2R0dEdGZFBQQ1c5K3ZHN2NUdENKSDh0MExxdkdBb29NTFZjcXh1?=
 =?utf-8?B?YStOWWN0dmJyY1JOTzE0dXltVUpPWDI5MXY5UnpNWTAwQjRvY3FxRlEwdHNW?=
 =?utf-8?B?ZmFWRE15YnNNWG9EL3NZcytqdE8ydTI1TEw0OXc1WTE5WERpcjQxZG56RTQz?=
 =?utf-8?B?a0IrZkZ6dzh4N2hxQU55VE5jVlU2SGgyVEl4b2dqOUIvanpBU2FuWVUydXNx?=
 =?utf-8?B?Y1NucG9VMzRMTlJRcGF5TDNLajlDVHMwNVpkd01jRUZlZmVMV1p1KzNuWmdI?=
 =?utf-8?B?a1p3L213VG04RVYyQ1ZvU3NNbTY1cm4zSzN4VklTM2JMbXl6UzhpUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76598518-2bc9-4b64-6588-08dea2fb3d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2026 18:48:28.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHYA1HxLlPvrTGiVyqxlwoVQHT77tH2uTkeO2QSNmlXME8nLuWC1wX0emSWFZPbchAWyg9YAMp40kiDuqpX7SMDz2hifOsYWPj3fD6Lv3NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12185
X-Rspamd-Queue-Id: AF9FA4677BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-7401-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,renesas.com,vger.kernel.org,bp.renesas.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,pengutronix.de:email,bp.renesas.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMNCj4gU2VudDogMDcgQXByaWwgMjAyNiAxMjox
Mg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDAvM10gQWRkIHN1cHBvcnQgZm9yIFJlbmVzYXMgQ0FO
LUZEIEJ1cy1PZmYgcmVjb3ZlcnkgbW9kZSBzZWxlY3Rpb24NCj4gDQo+IEhpIE1hcmMgS2xlaW5l
LUJ1ZGRlLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5n
dXRyb25peC5kZT4NCj4gPiBTZW50OiAwMyBBcHJpbCAyMDI2IDIyOjQ1DQo+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCAwLzNdIEFkZCBzdXBwb3J0IGZvciBSZW5lc2FzIENBTi1GRCBCdXMtT2ZmDQo+
ID4gcmVjb3ZlcnkgbW9kZSBzZWxlY3Rpb24NCj4gPg0KPiA+IE9uIDAzLjA0LjIwMjYgMTA6NDk6
NTcsIEJpanUgd3JvdGU6DQo+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gVGhlIENBTi1GRCBJUCBzdXBwb3J0cyB0aGUgYmVsb3cg
QnVzLU9mZiByZWNvdmVyeSBtb2RlczoNCj4gPiA+IDEpIElTTzExODk4LTEgY29tcGxpYW50DQo+
ID4gPiAyKSBFbnRyeSB0byBDaGFubmVsIEhhbHQgbW9kZSBhdXRvbWF0aWNhbGx5IGF0IGJ1cy1v
ZmYgZW50cnkNCj4gPiA+IDMpIEVudHJ5IHRvIENoYW5uZWwgSGFsdCBtb2RlIGF1dG9tYXRpY2Fs
bHkgYXQgYnVzLW9mZiBlbmQNCj4gPiA+IDQpIEVudHJ5IHRvIENoYW5uZWwgSGFsdCBtb2RlIChp
biBidXMtb2ZmIHN0YXRlKSBieSBwcm9ncmFtIHJlcXVlc3QNCj4gPiA+DQo+ID4gPiBBZGQgc3Vw
cG9ydCBmb3IgQnVzLU9mZiByZWNvdmVyeSBtb2RlIHNlbGVjdGlvbiB2aWEgdGhlDQo+ID4gPiBy
ZW5lc2FzLGJ1cy1vZmYtcmVjb3ZlcnktbW9kZSBkZXZpY2UgdHJlZSBwcm9wZXJ0eS4gSWYgdGhl
IHByb3BlcnR5DQo+ID4gPiBpcyBhYnNlbnQsIGl0IGRlZmF1bHRzIHRvIFJDQU5GRF9DQ1RSX0JP
TV9CRU5UUlkgKGVudHJ5IHRvIENoYW5uZWwNCj4gPiA+IEhhbHQgbW9kZSBhdXRvbWF0aWNhbGx5
IGF0IGJ1cy1vZmYgZW50cnkpIGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+DQoNCj4g
Pg0KPiA+IFdoYXQgdGhlIExpbnV4IGRyaXZlciBzaG91bGQgZG8gaXMgb25jZSB0aGUgSFcgaXMg
aW4gYnVzIG9mZiBtb2RlLA0KPiA+IHN3aXRjaCBvZmYgdGhlIEhXIGFuZCBsZXQgdGhlIC5kb19z
ZXRfbW9kZShDQU5fTU9ERV9TVEFSVCkgY2FsbGJhY2sgcmVzdGFydCB0aGUgaGFyZHdhcmUuDQoN
ClNvbWUgcXVlcmllcywNCg0KQnV0IHRoaXMgY2FsbGJhY2sgaXMgY2FsbGVkIGZyb20gY2FuX3Jl
c3RhcnQoKS4gDQoNCkhvdyBvbmUgY2FuIGNhbGwgY2FuX3Jlc3RhcnQoKSwgd2hlbiBJUCB0cmln
Z2VycyBidXMtb2ZmIHJlY292ZXJ5DQppbnRlcnJ1cHQ/DQoNCkFsc28sIGhvdyBjYW4gd2Ugc3lu
Y2hyb25pemUgdGhlIENBTiByZXN0YXJ0IHdpdGggcmVzdGFydF9tcygpIGFuZCANCmF1dG9tYXRp
YyBIVyByZWNvdmVyeT8NCg0KQ2hlZXJzLA0KQmlqdQ0K

