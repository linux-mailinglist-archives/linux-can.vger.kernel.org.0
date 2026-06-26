Return-Path: <linux-can+bounces-7903-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5lx9E1VBPmrBCAkAu9opvQ
	(envelope-from <linux-can+bounces-7903-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 11:07:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECA16CB923
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 11:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=WXU51CmC;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7903-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7903-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E40302E41D
	for <lists+linux-can@lfdr.de>; Fri, 26 Jun 2026 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8F3E44F6;
	Fri, 26 Jun 2026 09:03:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324433DC85B;
	Fri, 26 Jun 2026 09:03:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464596; cv=fail; b=G+5+S6UH4W8YGqq6AWSqWFRgSCgV+cDhQZJsm/K9RdRoDRZRR90UoKzyUL2pIeE4t5HExLAnU8ecTqqygXi6HTNukndwgyi627eGNT8rYTPggNP7Rl772rDqL0jI97Fqn4q9Xx02KYA5nWV5NMVsMCgaUnFR/yl+N3oN4hsFPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464596; c=relaxed/simple;
	bh=kJr8oqS6IkrG1rTXO9jxfKX1KKvBYbdKLnBWqpMkq7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qriJHSdCy2I+RUuvw+OcRoKPZN9a+PYVaqaOowbsjBwO6L6Hx20PtwP7WegBffHC5uMaZ7k5g1UxpAWiMWnmTwz4i6doxtCiL5j1H3Zmw70rKOTJDk4MyZax7PixBsXpN7zq2Q7fZ3SzETorh6xFAXlXQzPUqXpxzB5dUUAKQdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WXU51CmC; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahyq8L3sPdeenBqQ3lWUvOAJaqU29aUPquaKZGnoiABlrTtH6BH1jo3wE+WgHUuazoFMn3jxPEvpN9/DLhDmEfixKuY3zbpWYUnFRFR5QSoGWWT8kjCQyvzXfrI9+7Lz3JnKNWYKNqjLwmRJaqRO05Jr7ygvaFQVrIZ2uQOz6cONAVsrRDTu82PRFm66r8nRQqKe2oHiJewo4GL4HIx5xKPaogfgH5IxC1tQkn9F6iPi+/83rGGtBd7wafQ2IL9Y7xVoo2DNd1paOaP5EVjkHgV00Cjb8er1coeDWQNKWR4yENuMY2/Wl4/GqV202GHtThte1fZ21OBXZ6LSoZqSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJr8oqS6IkrG1rTXO9jxfKX1KKvBYbdKLnBWqpMkq7I=;
 b=oWiT5ZVIYNBykmrePuaNG4274MiPY9T6gRnAgtX1YlUT+Ev3lRfeX6/kVtQtH/XCtdnU5e+RCIBBZl7Nk3V7WoVxCV7C372nygIF3Vasg9FZaT2cfho5APoy5RH/qktvd6qyjsvleUmDCVppeilegdTECH89G9FKiOVEPcwmQ5DZSDLqgKdWbcikmnLtoi/NdYv/j3AdukcCpPuUpsIj7igSRQ4iIMYhThsQKrSGwbRdbW0pmNNC7njCB5B0O2oj2MR9SdV85JcsR0ImEYjQfB3pZvGRJ7jCgmluu2p/rQxNIHIk2gPF91gAUGFTleUGYdlFGKD6OPzdeiU0KwYlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJr8oqS6IkrG1rTXO9jxfKX1KKvBYbdKLnBWqpMkq7I=;
 b=WXU51CmCd9Cq48hQYkhMa3Q3zOthdp3o/KXM1fULkTIZw21l/h48GHL4qCHWx0LgskkK8zdl+pmVbgEpmbrepAdvhhbMAL7sSDthG3LC5IDl1W1StDp01uSfbiK3HbJzQIxNYXRX5rni54a8EpuV5vyMHWZqU7USachKPCvI65A=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14131.jpnprd01.prod.outlook.com (2603:1096:405:20d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:03:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 09:03:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, biju.das.au
	<biju.das.au@gmail.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Topic: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
Thread-Index: AQHdBKnahRscR7xhqUa4HQBpTADRvbZPuI8AgADSl6A=
Date: Fri, 26 Jun 2026 09:03:04 +0000
Message-ID:
 <TY3PR01MB11346A4B1104C2788F4079DC886EB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
 <aj2PBvZYaVs0G-be@shikoro>
In-Reply-To: <aj2PBvZYaVs0G-be@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14131:EE_
x-ms-office365-filtering-correlation-id: 36215243-3128-4455-78c7-08ded361bb9d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|38070700021|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 c1BRg6vGlcirEOaP4ctVdrusRwSRYBnmq5VEiEy5oD+lVhWj5IyvFjJQjtL4BIMaoOqu+KLWPxLE4WaYJhY72zmXf3q7etIgO0Iyb5ZX4aq6lIYExLlgMid8jlD3gviOz1/QiXzc/Ei0drOTI5QvjZu50lj4mntr/ri++3ByBan6AV3XzPTjbPQmrqzJN/GKs8geJ1c0CiyJ3W0Wo1+bEOh4eT0pp+mmsxWJNYDFY4yLPjKVCtyIA7wJLN8IYcE6pcD4URYllhn5ZMTugsYyWkCTAIM5FIdryk7LUwUXZLpxFmj5DDognO4ZCecfej1hNx/Af8G0pRmWbiZ9w12hCnEiGnQ5mCvUhJLoDqXTfzYYPE7UdAffM9fol6FHehLq/ZPSpKsbLxj7R5ZRwOb0dNwzosIK5VpILC2ma9zzCMia5H+nDmu1ExVKt2mpt17TmodQQBkPzvt3s7oDMZE0/XQws30ZSpC2PySUqaerfzaChA8fR+BMoBJjhvqbYqxtJ7BlLQ8Y/c80ztP+p8+YUFiZqtdBFfDbxMrozo6dCz7+ub/ZmuqlasgGu/FLzMLf1ezZNadgvBvFnFlaMW92YowXj/usOsT1Qhr8rROHjzmT6KdpzCWhHBj5tCy/BnBu5hHrI7+MwLOtQnK14IUjYPK2lDrEXJ03BUd5QJCc+rgZB2SVey9sWlW+tr4JMVqYEH9cCc4N76BvQyVWdxekjgd/xlW1klnec2qnyhRkP+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VExZMC9BQm5vbkYreW5xYk9vQmdEOWRvR1laR0UwMWNwOVlwUHg5bWJpcHV5?=
 =?utf-8?B?RWxqNmtkckozYXF5dUszVmdacXdEYXJUVTFobE9NSVNFTkVHYkQzZVRaRnh1?=
 =?utf-8?B?c2hQVGpyYmt3YWZjSlpYaWpYMW1DVDJXdy91UmpwNURuTlk0dTh2MXFBck1y?=
 =?utf-8?B?VHA4OE1tQ09NQ0swNEQ0VEI3cHNQMk5IQ2Z6YWx4MW9FaTN0aU84aGFXY2hz?=
 =?utf-8?B?bE9JTmR5K0RsSzFWNG5ZQ1ppTVNlamErMGQ2aGlhdXhXZ0l1TFhnbmd4bVpj?=
 =?utf-8?B?SmtNKzZsdjVKa0FSMVRjeGVTMUpDcHFNL2VML3RaL2YwcnVqNlRpdGZCcWR0?=
 =?utf-8?B?TDcvZ0VaUi82TENXdFU2VlJXK3J5bmZDWjhwWExUY2xrU3psRW9KZnBhUzVs?=
 =?utf-8?B?RFh2bTdaOUdpa293ZUZwUUFwWm5IZCtNK29uTVZvUktBWGlZWDdabC9MR1BR?=
 =?utf-8?B?d2xENzB2SW1Hc1RRNkQxNDRpelEwL20vcXE3UkpkRVY1Z05aTXFydy9qZHJE?=
 =?utf-8?B?anZIWVMrS2djUUZjcU1iSXJqMjgyV2dhTStZQkEwNDRTR0xmSWRUV2tiTWZv?=
 =?utf-8?B?SS9LQ2Y3RlJNL0k1UGo0czd2VVYrYzdmeWMrVWNsWGZhelViQUZyZ3BHdllG?=
 =?utf-8?B?cDlTNEFHRmhjd0FXUlBjTno4YmJlWHluRXhLSFhHSmYzdThHZnlBd0k5a2Yw?=
 =?utf-8?B?WmtrSzRvMG1Oc1RZY08yYnZweStpOER1SlpLTU9nU3dVVktSKzlabkpSNzVK?=
 =?utf-8?B?TC9hWjlybVUzbitONXh1d3F2Wkxwd1NvUU5CYi9VRytzK05yR2N4eGE1VlhJ?=
 =?utf-8?B?NHNKUXBNUldYRnpsS3NZRUMwUTVGcjIwK3dKRkUycGlhRHRpM1hOT2tCVlpi?=
 =?utf-8?B?RUxSaUk2WjA2R1FmWVRIUE9KWXdRSk1Jb0g3S24wY081MDZmbzlPUjc4QVlM?=
 =?utf-8?B?cHZKK290TGpIenl2S1hEVFNQRWVla2FsSU56OUVhQWNhcWxiWnVqaXBwV0lw?=
 =?utf-8?B?clVzTHZHNTliOTZoRUlHZ0ZHSUd4Z216My9nb3NZQmtjVkRRMUUyQjNWcU5I?=
 =?utf-8?B?b3pCVFFSa3dXM1B1VjNMZGJhYWtkcTR4cE02R2lKZHdIRnRkUnJ6aVVGdHNr?=
 =?utf-8?B?eUtyMDZxRFdQb3BISG11SFhXczNFVjBnaFFuVkxQZHZEUnEvVHNCYmJaRC9h?=
 =?utf-8?B?L1ZUZEdDWE5FcVNML2gxYkJTOGlnTlcwUXZwTlk3WXY4azdscytpQi9QVmVZ?=
 =?utf-8?B?UlJBTXM4V1NYTjVWOXk5cmhqTVhWSlFvOHFub0hyMFc3Y0xYYjBYUDdKbVZO?=
 =?utf-8?B?Ym9wZFZqN0NWMXc1T1JsWWs4Vzg4c2JGblBrZFNKTE5iUjV0dGxGVmFKUWZE?=
 =?utf-8?B?K29BZ1JPRWNoeFk0T0Jjei9MQWhCZDVINlFqRWNLSTk0YVFWL0hMcE1UVTVp?=
 =?utf-8?B?ZkltOFVkNkczYVFURDNtUkFxd1RBcXEyWnd6czBrUjIwN0xXVkJ0SHA1V0py?=
 =?utf-8?B?V0o1MFcrcy9WV2FFYUoxZnEyekVjMmdyWE1zb09mNGpuRVBZN2o3N3Zhc05j?=
 =?utf-8?B?bHdkRitmZEQyNnVlL04xbGs1TWR4bmRBM2lpOFZON3M2Y2sxd0lGMFh2cDNz?=
 =?utf-8?B?alRFREYzeDl1MlVrRjZNOGVKRDM4OXNYbXlURFphenJ0ekRVRyt4UnJqZUdK?=
 =?utf-8?B?elJIQ2k2SUJtZHZBYmd2TVhPdmQyTjAyYWs3OHdRRkF6OE1iV2pLdTJ6WGxy?=
 =?utf-8?B?WkhnNnlrSGFYVHBSUlRmWEppZ2ZjYU5MdWkyYTI0cTdMWW05OGJSdTJMRDhJ?=
 =?utf-8?B?V1NMWVN2QThjNngzUThmL2lFeWlYZ2dleHNpb0Y0VjluSEJyM2dNei9mZTNU?=
 =?utf-8?B?WVB4Ky8rSEZkRUFtSlQ3TVlIa1pGUnFoTEFqMlRIbmhDRjZIVjBvL1FBQUxD?=
 =?utf-8?B?czUwZXdFdWxMdSt6aVljSnFzZ2k3NzJXbnBPUHl5QkNpWVlWV1M3MkFqS1J0?=
 =?utf-8?B?L1ZxUWI4VUZjZEVlQmdPUTd4aHUvVXljemFjQXlvcnJ5S055cTJZeHRYeDhR?=
 =?utf-8?B?WldyYW9mMTdzTkJGTnI1UjhLTGNJV0N1S0wzcTRHR1FOZ08wNFltTG1lYWtP?=
 =?utf-8?B?U3FhcUZlQXFtc3NmNVRMOG9LM2Nnd0h6MjZEd2tHaDlLZ0dCN2hBVS83NFlT?=
 =?utf-8?B?NzFPa1lnOHJjbFlHT1ZoZFdFQVdHeXl5RC9EOEt3cXV4eU9sWnovcWtFRHV1?=
 =?utf-8?B?N2k5dG5jOC85czdaUXF6UE01alhsSGVkUEx1VU9wdTJxcFhwM2VDclEzTFJQ?=
 =?utf-8?B?b3pYYTdKMDZnY2lZeWR1MjZEaDdOZVJ2VjNJRUE2azBHS0o1a0ZoZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36215243-3128-4455-78c7-08ded361bb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 09:03:04.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc5Hcgjsp/qZaFzqXE7ypRsOXT5dGSeZs41kQLFfOTwd0LViPdvyisar8tdSIOf0t9JVakKO/fZjblivYULvBFRQYBGL3nw71OMq/cRRSXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14131
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7903-lists,linux-can=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[sang-engineering.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wsa@sang-engineering.com,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,renesas.com,bp.renesas.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,bp.renesas.com:from_mime,vger.kernel.org:from_smtp,sang-engineering.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,renesas.com:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ECA16CB923

SGkgV29sZnJhbSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb2xm
cmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPg0KPiBTZW50OiAyNSBK
dW5lIDIwMjYgMjE6MjcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FuOiByY2FyX2NhbmZkOiBD
aGFuZ2UgdGhlIGluaXRpYWxpemluZyBmbG93IGZvciBjbG9ja3MgYW5kIHJlc2V0cw0KPiANCj4g
SGkgQmlqdSwNCj4gDQo+IFNhc2hpa28gZm91bmQgaXNzdWVzIHdpdGggeW91ciBwYXRjaC4gSSBj
dXJhdGVkIHRoZSBsaXN0IGFuZCBsZWZ0IHRob3NlIHdoaWNoIEkgc2VlIGFzIHJlYXNvbmFibGUu
IEkga25vdw0KPiB0aGF0IGJlaW5nIHBvaW50ZWQgdG8gcHJlLWV4aXN0aW5nIGlzc3VlcyBpcyBh
bm5veWluZywgYnV0IG1heWJlIHlvdSBoYXZlIGludGVyZXN0IHRvIGxvb2sgYXQgdGhlc2UNCj4g
aXNzdWVzPw0KDQpTaW5jZSB5b3UgaGF2ZSBnb25lIHRocm91Z2ggdGhlIGxpc3QsIEkgd291bGQg
bGlrZSB0byBkaXNjdXNzIHNvbWUgb2YgdGhlIGlzc3VlcyBoZXJlDQoNCj4gPg0KPiA+IFByZS1l
eGlzdGluZyBpc3N1ZXM6DQo+ID4gLSBbSGlnaF0gRG91YmxlLWNsZWFudXAgYW5kIHVuY2xvY2tl
ZCByZWdpc3RlciBhY2Nlc3Mgb24gaW5pdGlhbGl6YXRpb24gZmFpbHVyZSBpbg0KPiBgcmNhcl9j
YW5mZF9wcm9iZSgpYC4NCj4gPiAtIFtIaWdoXSBQcmVtYXR1cmUgcmVnaXN0cmF0aW9uIG9mIGds
b2JhbCBpbnRlcnJ1cHQgaGFuZGxlcnMgY2F1c2VzIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBh
bmQNCj4gdW5jbG9ja2VkIHJlZ2lzdGVyIGFjY2Vzcy4NCj4gPiAtIFtIaWdoXSBEYW5nbGluZyBw
b2ludGVyIGluIHRoZSBnbG9iYWwgc3RhdGUgYXJyYXkgbGVhZHMgdG8gYSBkb3VibGUgZnJlZSBv
biBjaGFubmVsIHByb2JlIGZhaWx1cmUuDQo+ID4gLSBbSGlnaF0gTWlzbWF0Y2ggYmV0d2VlbiBg
ZGV2bV9yZXF1ZXN0X2lycWAgYW5kIG1hbnVhbCBtZW1vcnkgZnJlZWluZyBjYXVzZXMgdXNlLWFm
dGVyLWZyZWUuDQo+ID4gLS0NCj4gPg0KPiA+IGNvbW1pdCA2YjZhODMxNjlhYzBhNzI5N2E0ZGMy
Yzc4ZTE2ZGQ5OGY0ZjJlZDBmDQo+ID4gQXV0aG9yOiBUdSBOZ3V5ZW4gPHR1Lm5ndXllbi54Z0By
ZW5lc2FzLmNvbT4NCj4gPg0KPiA+IGNhbjogcmNhcl9jYW5mZDogQ2hhbmdlIHRoZSBpbml0aWFs
aXppbmcgZmxvdyBmb3IgY2xvY2tzIGFuZCByZXNldHMNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdXBk
YXRlcyB0aGUgaW5pdGlhbGl6YXRpb24gb3JkZXIgZm9yIGNsb2NrcyBhbmQgcmVzZXRzIGluDQo+
ID4gdGhlIHJjYXJfY2FuZmQgZHJpdmVyIHRvIG1hdGNoIHRoZSBoYXJkd2FyZSBtYW51YWwgZm9y
IFJaL0cyTCBhbmQgUlovRzNFLg0KPiA+IEl0IGVuc3VyZXMgY2xvY2tzIGFyZSBlbmFibGVkIGJl
Zm9yZSBkZWFzc2VydGluZyByZXNldHMsIGFuZCB1cGRhdGVzDQo+ID4gdGhlIHRlYXJkb3duIHBh
dGggdG8gbWlycm9yIHRoZSBuZXcgc2VxdWVuY2UuDQo+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvY2Fu
L3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiBpbmRleCBlYWY4Y2FjNzgwMzg3Li5mY2MzN2I3M2Vk
NDM2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBbIC4u
LiBdDQo+ID4gPiBAQCAtMjA5MCwxMCArMjA5MCwxMCBAQCBzdGF0aWMgdm9pZCByY2FyX2NhbmZk
X2dsb2JhbF9kZWluaXQoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdiwgYm9vbA0KPiBm
dWxsKQ0KPiA+ID4gIAkJcmNhcl9jYW5mZF9zZXRfYml0KGdwcml2LT5iYXNlLCBSQ0FORkRfR0NU
UiwgUkNBTkZEX0dDVFJfR1NMUFIpOw0KPiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4gLQljbGtfZGlz
YWJsZV91bnByZXBhcmUoZ3ByaXYtPmNsa19yYW0pOw0KPiA+ID4gLQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZ3ByaXYtPmNsa3ApOw0KPiA+ID4gIAlyZXNldF9jb250cm9sX2Fzc2VydChncHJpdi0+
cnN0YzIpOw0KPiA+ID4gIAlyZXNldF9jb250cm9sX2Fzc2VydChncHJpdi0+cnN0YzEpOw0KPiA+
ID4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3ByaXYtPmNsa19yYW0pOw0KPiA+ID4gKwljbGtf
ZGlzYWJsZV91bnByZXBhcmUoZ3ByaXYtPmNsa3ApOw0KPiA+ID4gIH0NCj4gPg0KPiA+DQo+ID4g
W1NldmVyaXR5OiBIaWdoXQ0KPiA+IFRoaXMgaXNuJ3QgYSBidWcgaW50cm9kdWNlZCBieSB0aGlz
IHBhdGNoLCBidXQgdGhlcmUgbWlnaHQgYmUgYQ0KPiA+IHVzZS1hZnRlci1mcmVlIHZ1bG5lcmFi
aWxpdHkgd2l0aCB0aGUgZGV2aWNlLW1hbmFnZWQgSVJRcy4NCj4gPg0KPiA+IEluIHJjYXJfY2Fu
ZmRfY2hhbm5lbF9wcm9iZSgpLCB0aGUgcGVyLWNoYW5uZWwgaW50ZXJydXB0IGlzIHJlcXVlc3Rl
ZA0KPiA+IHVzaW5nIGRldm1fcmVxdWVzdF9pcnEoKSB3aXRoIHByaXYgYXMgdGhlIGNhbGxiYWNr
IGRhdGEuIEhvd2V2ZXIsDQo+ID4gcmNhcl9jYW5mZF9jaGFubmVsX3JlbW92ZSgpIG1hbnVhbGx5
IGZyZWVzIHRoZSBjaGFubmVsIHN0cnVjdHVyZSB1c2luZw0KPiA+IGZyZWVfY2FuZGV2KHByaXYt
Pm5kZXYpLg0KPiA+DQo+ID4gQmVjYXVzZSB0aGUgZGV2bS1tYW5hZ2VkIElSUSBpcyBub3QgdW5y
ZWdpc3RlcmVkIHVudGlsIHRoZSBkcml2ZXINCj4gPiBwcm9iZSBvciByZW1vdmUgZnVuY3Rpb24g
Y29tcGxldGVseSByZXR1cm5zLCBjb3VsZCBhbiBpbnRlcnJ1cHQgZmlyaW5nDQo+ID4gaW4gdGhp
cyB0ZWFyZG93biB3aW5kb3cgYWNjZXNzIHRoZSBmcmVlZCBwcml2IHN0cnVjdHVyZT8NCg0KU291
cmNlIGxldmVsIElSUSBmb3IgQ0FORkQgYXJlIGVuYWJsZWQgYnkgdGhlIHJjYXJfY2FuZmRfZW5h
YmxlX2NoYW5uZWxfaW50ZXJydXB0cygpDQppbiByY2FyX2NhbmZkX3N0YXJ0KCkuIEkgYWdyZWUs
IGluIHRoZSBwcm9iZSB3ZSByZXF1ZXN0ZWQgSVJRLCBDTEsgb24sIHJlc2V0IGRlc3NlcnRlZA0K
YW5kIHBlci1jaGFubmVsIGlycSBoYW5kbGVyIGlzIHJlYWR5IGZvciB0cmlnZ2VyaW5nIElSUS4N
Cg0KQnV0IHdpdGhvdXQgZW5hYmxpbmcgc291cmNlIGxldmVsIElSUSwgRG8geW91IHRoaW5rIGlu
dGVycnVwdCBjYW4gZmlyZSBvbiB0aGUNCnRlYXJkb3duIHdpbmRvdyBhcyBtZW50aW9uZWQgYnkg
c2FzaGlrbz8NCg0KRXZlbiBpZiBib290bG9hZGVyIHByb2dyYW1zIHRoZSB2YWx1ZSwgcmVzZXQg
YXNzZXJ0L2RlYXNzZXJ0IGluIGdsb2JhbF9pbml0DQp3aWxsIHJlc2V0IHRoZSB2YWx1ZXMuIFNv
IHRoZXJlIGlzIG5vIGNoYW5jZSBvZiBmaXJpbmcgaW50ZXJydXB0IGluIHRoaXMgY2FzZS4NCg0K
UGxlYXNlIHNoYXJlIHlvdXIgdmlldyBvbiB0aGlzLg0KDQpDaGVlcnMsDQpCaWp1DQo=

