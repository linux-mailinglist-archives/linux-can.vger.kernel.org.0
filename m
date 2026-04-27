Return-Path: <linux-can+bounces-7402-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEbQLFgN72kq4wAAu9opvQ
	(envelope-from <linux-can+bounces-7402-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:16:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D546E369
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FF13004F63
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C3374E4E;
	Mon, 27 Apr 2026 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BmJYdPzv"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011042.outbound.protection.outlook.com [40.107.74.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7C282F18;
	Mon, 27 Apr 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274081; cv=fail; b=VXM1D0iXOEDRJoJ/OSjVS4AXarP45VnCsTJiXrL0PibFRLnAPu+/pLa039Jtkh5NV5NuEkBB0Ai8zqaqkJrjKciX0tYbuKqbP7/sEWE3xHYn2XXtTHhcxfgM4wXEVDnVC5rujUpj5AED2dmV3sd7ZzHO2hbYhWN/4KIMwpU2E3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274081; c=relaxed/simple;
	bh=Jv7OtJIzX5+9JT8PyS7+8X5odX0rxl7uWvo0++WX9XI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIPx3v69eirK2L0tEki7vd/gDwkHic08/FWxcZLUAL1xHpYPZvPMbaUA9F3R5QdpYXxWmDRxTlQzIZwWS5MEiDrvLl+aaqGWdmBKw3jnDTMwfMzIlXyIcnhhjKEbyqimrYPuxMA03xGweWjfuvNqZkCA2qo33rw5/iYoBhwNKYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BmJYdPzv; arc=fail smtp.client-ip=40.107.74.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6rBR4pbSYyHSpWvJmH79lGwz2HrE169oU4TPQwyxQ23H4CW9ma9dsKuznlSjJrhk3w6aBOGnGy7U8EXpLO/weFO7DKYuFYDW2O1Wajkumo8LfB27Gfi2+Lz/DlrfLAt7+RD+D4iMqlEe5FjUwg/L/TvKocQbDqkHWDl4aZFAkNQ1PNNGEHbTCnZ0RVGvOOaDzxFuaLixY0vHrALTqODxJlOYkjZhXrJP3X5nxrQlnGPQS3JYk7+3WfIJspsa0j4VNrt2XIWPK2LE0ODSKH+s/zlHEyGh0Hb2eihozNy6v8eAF0YIZMijmadmgSCsQeGcWJKxGRfCMKuOGSKnO238w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv7OtJIzX5+9JT8PyS7+8X5odX0rxl7uWvo0++WX9XI=;
 b=n48RCZohccqosqHf9w5TtbliN/4bNUrREJwzOeBq1F0hNUZRorlGqiG9kwgUfwXW+oqfAKPI/GMRSpCOr8YjpJ4GezJj0KOOtvaA1TADmpzGjlCZhrefBefykhrQggsFBPQp8CStVsWgGLtnWSIdTg3I7AgO5YjcEJygNypi40cwbld+NoR0o8HUO4oqyg6PkD0XTNztFWxNpJeM6wR7XzTZyrFxt7ERJuZ8NgaB8H9wk3TfwZ8DKsemwLeS89E7kiVBEAFWCu/yCOc1yJNjj9PnzQW0LHuCL3SyDW30EhBCHTLczAgOHT2qmqmg6MRWugMjpjf5ujXpSTGh0TjScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv7OtJIzX5+9JT8PyS7+8X5odX0rxl7uWvo0++WX9XI=;
 b=BmJYdPzvHvlyraq3FgPDCc8/ZQAz20+UabqrcERzz2kI8mTPeNms0uQsVfuyrbCK5ZAwbySLWMZKmpQIQ8nAbFWxtmueOcXW2aA8+5YG7ZttpMVccRdgcN14muFKA5uA/ipKe3+nE04GL1kNGFAOAmHiVP9h9mc+ZoBkGiJ6YzM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB12050.jpnprd01.prod.outlook.com (2603:1096:400:405::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 07:14:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 07:14:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, biju.das.au
	<biju.das.au@gmail.com>
CC: Vincent Mailhol <mailhol@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/3] can: rcar_canfd: Handle Bus-Off recovery interrupt
Thread-Topic: [PATCH 3/3] can: rcar_canfd: Handle Bus-Off recovery interrupt
Thread-Index: AQHcw09G+sq9OMw4z0uHKFUlcSX5wbXN3DQAgCTGrAA=
Date: Mon, 27 Apr 2026 07:14:35 +0000
Message-ID:
 <TY3PR01MB11346409038B4E77C407BCF9986362@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
 <20260403095003.104542-4-biju.das.jz@bp.renesas.com>
 <20260403-accelerated-resilient-lemming-963c0c-mkl@pengutronix.de>
In-Reply-To:
 <20260403-accelerated-resilient-lemming-963c0c-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB12050:EE_
x-ms-office365-filtering-correlation-id: bd6bd7be-ee4d-400c-c127-08dea42ca305
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 gwTsmS3+jQG1afKEQ81T06gwYe+DZSpjue+qTsKS4CSj4ndBvl1G+qUb82nRn8HYqjmZkJjudzGaPQlATrnTlfV3Y2qtcyA3MnSAYae1SgMKfCStAjyAHf/wSHytsvbkuF/0laf6bhrqe6AjxuqsfnofzGKGmJM+AjxsPE91Oa4jsTXt9EAZkjQUrkwSm0q+FCVLMWSmyRwZkCav+H5xbOQ8bzEhrUunWMD32e5oOoXbI7vJCHZp8j4eGLQqCq79TVeYib43l1V7UBubh5J4ydJyTXkaddDE03wEWaYpsNwVznQMpASzOo62EmJHizStMSK8K4sEpj7NcqLffq/8pLT1O+r2zdT1lKlbbvtF1dfKBnAmv1O9jI1FFye3vVcawQXscX1tMCHAnAdS7hUNcoJqsMgUokYgdHyX6B8FrAeuF/Hd9w1kFDMpyuydIiGXrGT/rdEgK694MF1H4njr4SaFbEM0MTHSUYZH+JGBecnXeTf0fB62w++2++34fuZ2A3dtkamoS9zNFWZlwjsLQY4EiFcGHuTiHqpUdacmfpi1XcomixnsD9op5XX9p3+Z8i4Vq8w2GF9vA7rXno3kIg80lEVeukd6viRcmWRdzglTtMee5gTtPaW78kIoRJpTbdlhPinweZx0RJ/gD487LnREE9Y8FZRfdmH+GLfwWpQ6zNrmeN8verVSf+F6s7xxZjLQDseVDQSbuG2CZvI5x6bhxjGZzHticixAO1dWSKEyrdWXUZfMSjOc2EnZ+XZcrRopE5YfkmjKVNoSZDeZHHwgVUz1FZWAVaQdpnQ+v/8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkE3SDcyaTlOMUF4RHlBaG43clh4LzNNMFBJNlBFOThUQS9NaXVWWUxZazVj?=
 =?utf-8?B?MmMvVWpkVldVTGd2ak9OcFlFbUxpSWRsajZaKzZ4RGRLaURDSnJWOFhrZjJl?=
 =?utf-8?B?cTVjQkpUeDlyZHpYY0l0WkFyeVpzWGdwakhmN2cxbzYyQXZJRjRGZTVDUVBI?=
 =?utf-8?B?S2V6UWtvc2dnK0dHUW9pRFFjQ0ZCa3YzdUFpcXc3MDJZTENwOFJIdGd3YzBU?=
 =?utf-8?B?VjRuNU5ZNDdMelF1OENNa0FMM0tXWFpRSWtDQkZsaW00N2c4R2hSN0VONjJu?=
 =?utf-8?B?aWd4WjRDaVBjU1lvVEJtVmVKQXkyL3d4TElBbndYTGRENXRiS2hEYTMzM3pK?=
 =?utf-8?B?ZDZZaE1CblFpNmFLbTFOMGZ0ZVVjMHVFVEtZZzZTNkJSOHp6VitOUnB5Umx2?=
 =?utf-8?B?Szh4R2hyQVUxcE5OaFZmdVhGN3JtTEErSlFYRzFwbWRzUGp5MVNsQTMxOVNu?=
 =?utf-8?B?S0xMTUIybStabWI4cWoza3YzaHFTSkVUY0F3R2JEb05Iem0rVDhFZmQ4cFpI?=
 =?utf-8?B?T3U1YmdiVUhDRFVDNDBBS2NyYzRWN3c3REdnaW1KNVM4Q0ppQnJlVWVuV2RV?=
 =?utf-8?B?bHI1OFVzOTRkY3huWkxpSmRNTUlFcFNvNXVYRE4vdmk0enEwOFJJOVdJb0Z5?=
 =?utf-8?B?dHVzb2paTVBsZjdEMjN1a2o5Z05rUFQ5bEtPUld3MWVmcTlxaE16c1lTK1VC?=
 =?utf-8?B?VnJLUnNTOHFvbjJHS3Bjd0JxL3dIQTlyekF3cXlUUUU3L2liOHYwSVV3MzU4?=
 =?utf-8?B?ampCTmdWa0s0WnF3TnJORzluSVZRZDR4VmxsMkxpS2p1WWtYaVJTZUE2WDNt?=
 =?utf-8?B?ZnhlUFFnWDV2cXJHR0ZaUXF4UVp2anJ2Y3ljQU1ab1JVbXFpdnliZ2Y5M2I0?=
 =?utf-8?B?dDdOam54aEdsN0lhc1JUaWhZR3NYRndDeFQwWnRUVmkrMHNFSlltTnJFQUpB?=
 =?utf-8?B?ZXVkM2RLdENyY2pSazhvTXBGbTdSWkZRSDBGb0EzeXdzSi8xT0RUdmpjdWE1?=
 =?utf-8?B?VmFnRTlBQjZnSXB3cWtkYkhHVG8yVFBta0tjazBRZzJ0RE9iaHpqMzFLZDNU?=
 =?utf-8?B?SWMvYUZRSTl5bGozSXNtY0ptSmRlMWZ6T3kzR2lyeXVZTmhsbEpabVN0T3FO?=
 =?utf-8?B?aHptbjVRblo1MHMxQVVvZlJ2elRoUDJyQUpLeGdBQy94NE45OTJvRWVJbTNB?=
 =?utf-8?B?YWFWTVdMcWphdUJ1U1BpR21xbDkxWDlvQ3c3dVNHWGZsOXI5bmFGcm1OUjdW?=
 =?utf-8?B?bjRmYW5PVUdsOStTRkgrb3Z2RU9kdFdQWEkrQXpCd0tzUWFOakdTTHFGQkFI?=
 =?utf-8?B?UkVSb1ZZc1JLSHp1RzkwK2JHTUh2TFpUb2RVV3BUQ1NvU1hFQk1CVnU4b1hN?=
 =?utf-8?B?Wm5QV0JBWm5YbFlqYWpDZzIwa3NuME9xUlJtQ3dMR0dOenI0VFQrZURldVB0?=
 =?utf-8?B?YWRxN3dEaXQ0MzlvczZOZFFKWURjWDBCSlNWaGFJUkM4Y0t4Tk40d2VhZjZB?=
 =?utf-8?B?amxHN3hkZWd6c0w4VUpqNWpRV002VFpEYk1SZTdFNmwwOUY4cG1BYytkVG1Q?=
 =?utf-8?B?MVpGdGpwY1F4d2tXWkw2YzZJT1FwTkxFVGVXcXJLUDVCeEYwRkV1b2VJRnRa?=
 =?utf-8?B?R3JQTW55bmJ0VDBhVHVqK3EvVzB2dWNEV3I1R1IzZVVsMlpPTjZjcHhDdm5q?=
 =?utf-8?B?TFFSZ2dNZFI4V0lqNlpRTFo4U2lMVS95V29PSXlyRUpFZE0rU1prZk0wZGN3?=
 =?utf-8?B?NFRqdks5NHdqQzV2SENVVDEzL252RGtrbXBGbWV4a0NqWnZSMG40Vk1EcUs1?=
 =?utf-8?B?LzdwbDNLdGpsRyt2M0ZSblhkN0c1MlBkb01HaDdwa2QzUmtaS2wzK1p4VGU1?=
 =?utf-8?B?eGs4VHNhZHdJQzQvSW1aUExOT1RJMFhDOW1ubmgvQnN1aDBlaGNkRlE1cHRP?=
 =?utf-8?B?dVZMZTlIOEFjeng1UFBTSmtGTmJmcmw0TWJxVlFsMkFrdnFTTFc4Z1MzRzAx?=
 =?utf-8?B?dFhBZ1I5RDR3WDloTnRVNVZUdWZCbmFQNElEYTBtUTMrVWVrcWE2ZjJxR0Fn?=
 =?utf-8?B?d2t1blplRmE0c1ViL3h0MGlEcnFtNWJLQVZVWDRWcHdlVlp6LzdYOHB2UHNs?=
 =?utf-8?B?WnRZTmhFcDhWd0hZRHo0YTNBeTJHTVBMdGlDOGl3cmkxUEc4YzVRN1JLcXpx?=
 =?utf-8?B?U0lMa1huNHhlYjZQNVpaQUhyS2dwOWJPYU9SSW9sejF4K3BLd0FtT3NCUFJ4?=
 =?utf-8?B?YkRMYlBudEdPTDliVXRuQlVPWnlMUXlSWHBlQXJxWU45OGRPc2pOK3diU29m?=
 =?utf-8?B?eHpyN2twTTVsNXJaT0JhaEFWOENicnJtNGdCMnhZK2ltM0NXTTRrZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6bd7be-ee4d-400c-c127-08dea42ca305
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 07:14:35.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPT9le1Izq6bDSGjsJHzf0hd2Vzba4smA7gFfKlrLw9DR9KsfrULG+OsxsfJqna5B4UGSEuh+xmwRKAm+pvWWEgW8qawq7eAA9TiEcjGHUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12050
X-Rspamd-Queue-Id: 124D546E369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7402-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,vger.kernel.org,bp.renesas.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMDMgQXByaWwgMjAyNiAyMjozMw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMv
M10gY2FuOiByY2FyX2NhbmZkOiBIYW5kbGUgQnVzLU9mZiByZWNvdmVyeSBpbnRlcnJ1cHQNCj4g
DQo+IE9uIDAzLjA0LjIwMjYgMTA6NTA6MDAsIEJpanUgd3JvdGU6DQo+ID4gRnJvbTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gQWRkIGhhbmRsaW5nIGZv
ciB0aGUgQnVzLU9mZiByZWNvdmVyeSBpbnRlcnJ1cHQgaW4gdGhlIGVycm9yIGhhbmRsZXIuDQo+
ID4gV2hlbiB0aGUgY2hhbm5lbCBidXMtb2ZmIHJlY292ZXJ5IGludGVycnVwdCBpcyByZWNlaXZl
ZCwgdHJhbnNpdGlvbg0KPiA+IHRoZSBDQU4gc3RhdGUgYmFjayB0byBDQU5fU1RBVEVfRVJST1Jf
QUNUSVZFIHRvIHJlZmxlY3QgdGhhdCB0aGUNCj4gPiBjb250cm9sbGVyIGhhcyBzdWNjZXNzZnVs
bHkgcmVjb3ZlcmVkIGZyb20gYSBidXMtb2ZmIGV2ZW50Lg0KPiANCj4gVGhpcyBsb29rcyB3cm9u
ZywgYmV0dGVyIGNoYW5nZSB0aGUgQ0FOIHN0YXRlIGluIHJjYXJfY2FuZmRfc3RhdGVfY2hhbmdl
KCksIHNvIHRoYXQgY2FuX2NoYW5nZV9zdGF0ZSgpDQo+IGlzIGNhbGxlZCBhbmQgdGhlIHVzZXIg
Z2V0cyBpbmZvcm1lZC4NCj4gDQo+IEJUVzogVGhlIHRyYW5zaXRpb24gdG8gYnVzLW9mZiBzaG91
bGQgYWxzbyBiZSBkb25lIHZpYSB0aGlzIGZ1bmN0aW9uIGZvciB0aGUgc2FtZSByZWFzb24uIFRo
aXMgd291bGQgYmUNCj4gYSBwcm9wZXIgZml4ZXMgcGF0Y2gsIHRoYXQgc2hvdWxkIGdvIGluIGZp
cnN0Lg0KDQpJIHdpbGwgcmVwbGFjZSB0aGUgZGlyZWN0IGFzc2lnbm1lbnRzIHRvIHByaXYtPmNh
bi5zdGF0ZSBhbmQgbWFudWFsIGNhbl9zdGF0cw0KY291bnRlciBpbmNyZW1lbnRzIHdpdGggdGhl
IGNhbl9jaGFuZ2Vfc3RhdGUoKSBoZWxwZXIgaW4gdGhlIGVycm9yDQpoYW5kbGVyLg0KDQpQbGVh
c2UgbGV0IG1lIGtub3csIGlzIHRoZSBiZWxvdyBjaGFuZ2VzIG9rIGZvciB5b3U/DQoNCglpZiAo
Y2VyZmwgJiBSQ0FORkRfQ0VSRkxfRVdGKSB7DQogCQluZXRkZXZfZGJnKG5kZXYsICJFcnJvciB3
YXJuaW5nIGludGVycnVwdFxuIik7DQotCQlwcml2LT5jYW4uc3RhdGUgPSBDQU5fU1RBVEVfRVJS
T1JfV0FSTklORzsNCi0JCXByaXYtPmNhbi5jYW5fc3RhdHMuZXJyb3Jfd2FybmluZysrOw0KLQkJ
Y2YtPmNhbl9pZCB8PSBDQU5fRVJSX0NSVEwgfCBDQU5fRVJSX0NOVDsNCi0JCWNmLT5kYXRhWzFd
ID0gdHhlcnIgPiByeGVyciA/IENBTl9FUlJfQ1JUTF9UWF9XQVJOSU5HIDoNCi0JCQlDQU5fRVJS
X0NSVExfUlhfV0FSTklORzsNCisJCW5ld19zdGF0ZSA9IENBTl9TVEFURV9FUlJPUl9XQVJOSU5H
Ow0KKwkJY2YtPmNhbl9pZCB8PSBDQU5fRVJSX0NOVDsNCiAJCWNmLT5kYXRhWzZdID0gdHhlcnI7
DQogCQljZi0+ZGF0YVs3XSA9IHJ4ZXJyOw0KIAl9DQoNCg0KCWlmIChjZXJmbCAmIFJDQU5GRF9D
RVJGTF9FUEYpIHsNCiAJCW5ldGRldl9kYmcobmRldiwgIkVycm9yIHBhc3NpdmUgaW50ZXJydXB0
XG4iKTsNCi0JCXByaXYtPmNhbi5zdGF0ZSA9IENBTl9TVEFURV9FUlJPUl9QQVNTSVZFOw0KLQkJ
cHJpdi0+Y2FuLmNhbl9zdGF0cy5lcnJvcl9wYXNzaXZlKys7DQotCQljZi0+Y2FuX2lkIHw9IENB
Tl9FUlJfQ1JUTCB8IENBTl9FUlJfQ05UOw0KLQkJY2YtPmRhdGFbMV0gPSB0eGVyciA+IHJ4ZXJy
ID8gQ0FOX0VSUl9DUlRMX1RYX1BBU1NJVkUgOg0KLQkJCUNBTl9FUlJfQ1JUTF9SWF9QQVNTSVZF
Ow0KKwkJbmV3X3N0YXRlID0gQ0FOX1NUQVRFX0VSUk9SX1BBU1NJVkU7DQorCQljZi0+Y2FuX2lk
IHw9IENBTl9FUlJfQ05UOw0KIAkJY2YtPmRhdGFbNl0gPSB0eGVycjsNCiAJCWNmLT5kYXRhWzdd
ID0gcnhlcnI7DQogCX0NCiAJaWYgKGNlcmZsICYgUkNBTkZEX0NFUkZMX0JPRUYpIHsNCiAJCW5l
dGRldl9kYmcobmRldiwgIkJ1cy1vZmYgZW50cnkgaW50ZXJydXB0XG4iKTsNCiAJCXJjYXJfY2Fu
ZmRfdHhfZmFpbHVyZV9jbGVhbnVwKG5kZXYpOw0KLQkJcHJpdi0+Y2FuLnN0YXRlID0gQ0FOX1NU
QVRFX0JVU19PRkY7DQotCQlwcml2LT5jYW4uY2FuX3N0YXRzLmJ1c19vZmYrKzsNCisJCW5ld19z
dGF0ZSA9IENBTl9TVEFURV9CVVNfT0ZGOw0KKwkJdHhlcnIgPSBDQU5fQlVTX09GRl9USFJFU0hP
TEQ7ICAtLT4gVGhlIElQIHNldHMgZXJyb3IgY291bnRlcnMgdG8gemVybyBkdXJpbmcgYnVzIG9m
Zi4NCiAJCWNhbl9idXNfb2ZmKG5kZXYpOw0KLQkJY2YtPmNhbl9pZCB8PSBDQU5fRVJSX0JVU09G
RjsNCiAJfQ0KDQoNCisNCisJaWYgKHVubGlrZWx5KGN1cnJlbnRfc3RhdGUgIT0gbmV3X3N0YXRl
KSkgew0KKwkJZW51bSBjYW5fc3RhdGUgcnhfc3RhdGUsIHR4X3N0YXRlOw0KKw0KKwkJdHhfc3Rh
dGUgPSB0eGVyciA+PSByeGVyciA/IG5ld19zdGF0ZSA6IDA7DQorCQlyeF9zdGF0ZSA9IHR4ZXJy
IDw9IHJ4ZXJyID8gbmV3X3N0YXRlIDogMDsNCisNCisJCWNhbl9jaGFuZ2Vfc3RhdGUobmRldiwg
Y2YsIHR4X3N0YXRlLCByeF9zdGF0ZSk7DQorCX0NCisNCg0KDQpDaGVlcnMsDQpCaWp1DQo=

