Return-Path: <linux-can+bounces-8064-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1QfBlDYTGoEqwEAu9opvQ
	(envelope-from <linux-can+bounces-8064-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:43:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C271A8DF
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=IlKjU8e2;
	dmarc=pass (policy=none) header.from=renesas.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8064-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8064-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50EEC3087A6C
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A643ECBF1;
	Tue,  7 Jul 2026 10:31:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9523E559B;
	Tue,  7 Jul 2026 10:31:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420301; cv=fail; b=JPGs4Z7mabwzSNwCdeOhKxd1RjepCe7RKwXm6AscoB+3s7X4B8PI4vLGmryIYAa2JvAsPE+j7AIeKdB/U1KcAIMzIwcxye4qzrKoK37RbEK8Ci3o+am/loJ20oTzfH9Lox0sYlTBPFEdsPfNC7iJOblc5bzAhOCYgfEnF9KQ7yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420301; c=relaxed/simple;
	bh=pss5uPhFqkERGvFU+Byhi87Dn6HXTxJfu/R5HLM4mbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRgCSo10Aq2UdMhWFUyl2mE3qwVZU3W+mrTwaVxvVmJyakOm2dmeNJbX1ToZMSvnDnecdeAp6fyIsTQ8YFvaB3Iq5HF3mOXhQJExqenRCevivTc9xt6mZD66WI2gurh8D8Xi3u5HOkhiSIcDw5Wj4anKZMaToJRs7X/TvcTu2Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IlKjU8e2; arc=fail smtp.client-ip=52.101.229.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9qgGDNHZ/r67/u9ToPFv+aMkBeeTcDmnT5ph3j2FUvw1id2N0dCbPQ93PfoSuh1g2AUxS+n5Adjkvaxr0ln5pEfclyHzAUcYe8B7JH72bs6wn0bsskxI2lDGN2TkQCOhFZWolv0cZ+btKN8sSh90ZK1xre5LBPREaD9Lp5PgkWQZB57AZGOgGsUsSgFLqBdYAa02XmduqvQ/QSOR3h1ZktL00nmCYDRrwrzg2g7+joUpwBIZIri09UYmgOqN8v8Veq9wfz2vqgWWJPEVsHPJEQgBvFvM6nu6TaRF6nw0YfaySin5Nkui2jYrtHY6xzp3qsYLYcSAb+pDzSvv2ShjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2TtsfLb3k3PT380po1RAePaDQ7I6acPTAHTtCJwV4M=;
 b=gzG+SMHe7oUhuXsXvRR/QHz72NY4X7rj8leG/gipV5hT/OOTK9k/rSu200wsO4lxANwpcQiMc/1xdhabRVtqflMMzHh6u+VCrUPRAgpC9yKwMbrp3l1erCHaM0hUrr0ZUqB+x+Fn0QGL7RXJ8NvwPUB6EwjSrze+JrdiEoEXTQDCIQEI+3BNxJaOcSxH1vpQX22VsdWeYMZwh5zL8XJu998J4KGyff4n2qRpG6vnagmXDZScUViZtXlcc8wAYD9CdJipVReyO7VKgk0Ur3Xaf+OcGFUH6a07zTpwgqaeKyTKAr72pA9EvJ9i7fhGs3rtELL7Ew2YgpF9yJdcQUwmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2TtsfLb3k3PT380po1RAePaDQ7I6acPTAHTtCJwV4M=;
 b=IlKjU8e2k9U2SMmugYINIoO3DxLNSVA/IH6rDXRxqxCiP1t4EDDNEldPzpk/W/zfe/rJFW+ZVTfdl6zzgt071de3SDYCuVNV9N7mWdhhHRAAeDBAOkQHKuq0WUUtZfET3bTskirGyVFg+oiodFEtRuj1xUD7azZCM5gj4daWBnQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB15384.jpnprd01.prod.outlook.com (2603:1096:604:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 10:31:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:31:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, "mkl@pengutronix.de"
	<mkl@pengutronix.de>, "mailhol@kernel.org" <mailhol@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "bmasney@redhat.com"
	<bmasney@redhat.com>, Tu Nguyen <tu.nguyen.xg@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Thread-Topic: [PATCH 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Thread-Index: AQHdDfrLMN1l2qsqCUC2icPnLN2C07Zh21Rw
Date: Tue, 7 Jul 2026 10:31:34 +0000
Message-ID:
 <TY3PR01MB113465B4415A6F9A4665AA0E586F02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB15384:EE_
x-ms-office365-filtering-correlation-id: cda80b8e-538c-4be3-b395-08dedc12eb62
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 YYRKeLEyYU29j9FDSQ8aflGovWQUnelbZLfytUoShWWTRIenadD6dCKQ6WBagEuxLeN15miEB9bgmUEtiMo9Jqm+nT7CoxGY1wmtrQAEhwJueA+LHbFUvgfASkDOAdtFSqSb2DgCrnat4ELwnONVa+G+ihradGQl+WYla6OoWeRh9DxmdpRp+/M7xdORBNKYd911GyK8QE1kSkNca/15xvI0HxcG93q0b7QK/blxiPPsZSKQxXr7Wg+Vb3hGBjmff6y8ujGYxL6jxkRr2/VxVOk9QQWwLIpjbXkqEFB+5cgoX0FKXil7kza5rXF4ZRTd6OGlIiRipIUnwXwSD8krE4TAzYhHfR910B4ZLnHxhSf0v/W2Fs8AYgFvDVW6OVQ4v20sRcoMeRng1lpd66xanzDD+jzZwi+S/lw1HkhzBAPJPVBQCR8H5g6mP0HcUQFU0RCz5Z51AMZGHfnRq5Q9PZZrTwIeyDB/AXwbxfeL3KjUj6Y39UINHKanWrwgnqksXJXh2fPd9V8DGg5IUxzYtpWjMmPpoqZTtX1qiz9fczByMZWo53O23LS/Z3azq8Cr+75yKy+US780bmNLo+oOrPLomSKbTs0jDG9fwbrCOtOVNcAEbuVWxcxIHA+AFOsB4ga6hoMUCjoR5s4MeVdUln9sW1XqxY9Wmj6ShVKlrR4N/EDucEFZGySGVnlGmXteg7PPgjn1PymCaBtp4y75sX0U5fcn28eQ2e08MOm7h/081JycNXl/1MQG+zgXU9F7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tw5cxmPmiwbQTuP31CNfWbMSGrU5+kl63xrkzv2j3Uab6Gq4UMwUT4mkiAl+?=
 =?us-ascii?Q?MMUlHGBmvAPRf+sq5uiBcHefvfGwfwwNXS79a+3wv9fTImH0kDFCHgE6nLow?=
 =?us-ascii?Q?ASSvWj2qAUvuJv9YkizgxHq9H52WixfLT6aZSkLybdaOEKoLUuHT6Flk7jrS?=
 =?us-ascii?Q?p/riIe5MUHYrMnVt1Pf0dpdxuH26S7U+8UbxcgoJNvH+95dPfkwdqbNUGtpa?=
 =?us-ascii?Q?VHHfYp3JXMaTTLiHHLQGJIrObb41L1IM4lCO8g1LLqUTZ0uQleSXpEE3NLM1?=
 =?us-ascii?Q?AVXzgUeg1PLlx52f3kjbpgPvp/yOZW34kMQ1ZFKZo7AdKz9g9qGvXPLipiYQ?=
 =?us-ascii?Q?0CRP9AbRD7fM3AJnKtxB7XnWXTfSHMSBt8Rql6gysEmSsF38EV5tIdwvXs/F?=
 =?us-ascii?Q?Xhm13+wJUKizqB35xWKbe1VWVBkrTqNaCMWluD+D5qgalXnhJrncUN1acaHP?=
 =?us-ascii?Q?4RZmGUJyEIueXWDp3iUkO25mkKTFLUusieBc0oGPMXzAC9IO81HVvOhCPt3T?=
 =?us-ascii?Q?Uqp7p20Nxwr41fscP/qbl0poqtUQ6bmK7bAN/CIu1Cz/tWhr4JRo7gWut0Qq?=
 =?us-ascii?Q?5ThYgF4CXNI1mlNmMLX+OJq47NjcATt1BpFpbJ/lrG3gTOJN5Vwfrz/ghvyC?=
 =?us-ascii?Q?zJi5q71w3Hs4B9T047iMcUnXJzU6fSWIWXDZdzqcQXo4MXaaZFDZUr2BMXz3?=
 =?us-ascii?Q?tGx3iqDuQwc5WoibsOwWrNEtdqVDCyBnpsbr4ky7n7hTk9x2mtk1dKIXVTyZ?=
 =?us-ascii?Q?j5/w1pvDTZ3S/xGwdeUkutpJl0rI6WxzCZ6+96HrL65fU5WUjQ8QnoTVrnqu?=
 =?us-ascii?Q?pekO+TomdiyKhQugUuzffPWhDbz46tSJiHhUnMrzK9DP75/urbqyuCWWyvjx?=
 =?us-ascii?Q?W6qSbrzhABQ0VJiiX0r8uqA6Tuzo7wHmA4KqrQuH2vPQoz2ZAOZnnoy8JDdN?=
 =?us-ascii?Q?E3iXxFAnxdgJjkFSPgbZ/CzBbNLFD6d/tk1b7DFzglwgb1n9Nwe8mKG2P60o?=
 =?us-ascii?Q?jICJPSaY53ewP5zHSX7gcL1GozdLqxza3h9XKYMSDA/xr9afevo8FJktlowE?=
 =?us-ascii?Q?SFqww67T9EpblF3x8DXMk7O2EOLDbM09xf7MFOzFFaqUIX9mhHqfUHNwXtwV?=
 =?us-ascii?Q?3QYVFKPevwA9Spb+VD8bgqfyPvMpxFzetpIACXiRXeLmw2JQ4rcT3NiWzz1o?=
 =?us-ascii?Q?YR6bL9H2Am9ZrCZWi90kBpVobcmqpUahWCpRdmJiVxfQKBOL0Ij7VOSIYaTw?=
 =?us-ascii?Q?kEvHfc4EYe+CytHArViHly2JCduufMig3HvBnmSHEYbzAwUVSvTN3lAYa/uH?=
 =?us-ascii?Q?1r+PB8IP8Nm/5M/RXZ9AMs8UlgXowHiUdwe5EHExlGAW++jVXJW7pN71WBDd?=
 =?us-ascii?Q?gU2GYUPAMnIp+UyB27f43HJzY16OPPfSg/BM3UhZ8t4wXuDnhwyTpSQEsf0G?=
 =?us-ascii?Q?0orO2Gcxk+sMy9dlr2TCjgRTpHIUIeWn44TWwAZM/GVTmTGi27Q3E/ClffWY?=
 =?us-ascii?Q?GS8NdaWKjEq0IJutktGmI5WMBY8nlnvmS1hKGPMOqC7zwvSketSxU8atbNEy?=
 =?us-ascii?Q?j+PFivO5FrkJG7iaSjxhQdg6l6F06M6Qrv7B6pFMcRwtrmzWfBcmaLDvytGa?=
 =?us-ascii?Q?pES6BTgC63u9EA21WhcplGeCL5RpUfwbfhR2J/U/f6vCQ/4uvQFZoTlWzhFJ?=
 =?us-ascii?Q?ouB49w0k83xIEZiJZns8VqtcPheGpP6hl52EFvQGIBncQMDVIvbNBkOcE3Su?=
 =?us-ascii?Q?xUp4jkj2Ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda80b8e-538c-4be3-b395-08dedc12eb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 10:31:34.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdJkZbl+YerbB+a5/9s1Dj2si/DfMzCP+sPRbnXzG3DEDe4atq22ZuH2PAUK8rJ9BDRyryiAbnHFp3r8hCXGM5YuuQk7S6kU8lTzZKbjn9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15384
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8064-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:tu.nguyen.xg@renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[tuxon.dev,pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,renesas.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:from_mime,bp.renesas.com:dkim,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tuxon.dev:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 727C271A8DF

Hi Claudiu,

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
> Sent: 07 July 2026 11:24
> Subject: [PATCH 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo =
fix patch was added on the CAN
> driver.
>=20
> Thank you,
> Claudiu
>=20
> Claudiu Beznea (8):
>   clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
>   dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
>   can: rcar_canfd: Fix typos in macro names
>   can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
>   can: rcar_canfd: Do not set registers selecting the CAN mode
>   can: rcar_canfd: Add support for Renesas RZ/G3S
>   arm64: dts: renesas: r9a08g045: Add CAN-FD node
>   arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
>=20
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 17 +++++-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 39 +++++++++++++
>  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 ++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++++
>  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++++
>  drivers/net/can/rcar/rcar_canfd.c             | 56 ++++++++++++++++---
>  6 files changed, 170 insertions(+), 10 deletions(-)
>=20

For the series,

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

