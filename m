Return-Path: <linux-can+bounces-8424-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l/KvKbZoVmoV5AAAu9opvQ
	(envelope-from <linux-can+bounces-8424-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 18:49:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C5757132
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 18:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lumal21.com.br header.s=selector1 header.b=LU0qtIIk;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8424-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8424-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=lumal21.com.br;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F80A30F47B3
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AB4D90D3;
	Tue, 14 Jul 2026 16:49:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CP4P284CU005.outbound.protection.outlook.com (mail-brazilsouthazon11021096.outbound.protection.outlook.com [40.107.202.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB73A4F36;
	Tue, 14 Jul 2026 16:49:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047746; cv=fail; b=WmWrofed38iJWRaWuyKP46kufxfmnewkaMrjKCar+whbjZ1kVU9zaVyr7RHe3hvoxfVdPtnXxVyKkEvSP+9bYPsMprNqum2iDLbVcdq0P1M8cp0qU/v0yTK6DUw/ZL5wAYrvjIp2XD40IaQEKHSeHnqCmThpvIWpSoZX3093/M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047746; c=relaxed/simple;
	bh=1Ib0Ae8YqXPuUPzuzhSQw5qKVlxlEwcrWywPvwQpYfg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oL0cjU7h7xK0iTE2hSyYWYJevA26ngoN43cs9lzSGZ1/0IHby3/aQ3aJb9bQ2FgUPmnyeNMSIVFKb9wBJYCpAqLNgfZIMwvab8q4xpCQXOeVU7InzMOW49j7U2RB8RmcbHh6rVElViDcU0ZCJxUr8/IyHHZLDinZhYGmjfUubts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lumal21.com.br; spf=pass smtp.mailfrom=lumal21.com.br; dkim=pass (2048-bit key) header.d=lumal21.com.br header.i=@lumal21.com.br header.b=LU0qtIIk; arc=fail smtp.client-ip=40.107.202.96
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM5BLuHgqES03isbmXPZnpyR2BBHieYwKoWucYcffkd6d6W1XdbvoxH29kUzmFrSdIceEp0azx1sGlyk69kT80POCSdn9xjvcgxzjQExC82fyLjg7DLB3hYMPvy7DfVhJp/XP5X4Aw6htWTTrUAxw//W1vj+/WoGHGdSlT+BmZTU64u1KaDbfZtHLg2kPIMIwBoSoJb+mAwK/jbVWrFoAG6I+4dI5aFXB1/5gLyIg7RipwG6gSjDKqvIejv8Y1CYbH/G9YsGzgD7ewdxMGQ0rAMVwsH45uRMOo481MLNEM6oQ6Gmg5kViqXCHu7FI0wHOolFL7qtOxAiWEa5Os5NFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ib0Ae8YqXPuUPzuzhSQw5qKVlxlEwcrWywPvwQpYfg=;
 b=v18rOow7L2o5UCzTHdl2xD9OcYVoXkUlay9/Uuz21ufMgvbxiDxu8RKLw35KT5WP9jn+JqCnc9Fx0ktdrLe7dtXFWVdO0GjHjlQ7uZAgLQni2yaoaY+7v5Fv6MzsMOLtxdpHF0lcWXZFPVXwIqmzFtYB8mTg/R+2+xyjOqxs9D2Jz0S5W/7xT4Cx9EbEkvi4oARSPbG4x7mxCfb1RjvWLK+aClHjYKmBdiUIbKgrczu9MfX+ouQ9zh0B/yVs0lyGjRfTdP66/e+70FDeFeXMC0i/GylwJNbmbgX7K+niycRG7HTn6xooS8s0G7mlg+ajXvVfWjMibTuf7V1PSGt4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lumal21.com.br; dmarc=pass action=none
 header.from=lumal21.com.br; dkim=pass header.d=lumal21.com.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lumal21.com.br;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ib0Ae8YqXPuUPzuzhSQw5qKVlxlEwcrWywPvwQpYfg=;
 b=LU0qtIIkmJPWambsIB2w/WxheMfR7lSeUVlLPlDAUkONzIQSFYCNpYJtxrHo7JRtB4ghWrkzn70xwpE9ZRM0T1HcX2Cllu7ynZlaemLo5t+niPieP3ykB9KJFv3/GsQPLWqDfjsjfer3lzMk2nIGbDzrMQXMSuGPGOrPYf+gCugTtcGuQukCWnRhXk54Q1LiSiybV3ZUSsnMMi17cSChzPISc7ygEIKOymRM+tbpnhJ4BzRKAfTBzMUPgYoJlcDxgz36CMEjhQl74i8yQVn4L/XO9lFYgPc128h3NrVhSo058TL0UHdQKJ6rh3olWN8+ujXWsc7Lg0IDCmQdgvMmtQ==
Received: from CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:2aa::9)
 by CP5P284MB1773.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 16:48:57 +0000
Received: from CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
 ([fe80::7b77:a104:ca62:b600]) by CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
 ([fe80::7b77:a104:ca62:b600%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 16:48:57 +0000
From: Lucas Martins Alves <lucas.alves@lumal21.com.br>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "mailhol@kernel.org"
	<mailhol@kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lucas Martins Alves
	<lucas.alves@lumal21.com.br>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"mailhol@kernel.org" <mailhol@kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Lucas Martins Alves <lucas.alves@lumal21.com.br>
Subject: [PATCH] can: c_can: keep controller in init mode until bittiming is
 configured
Thread-Topic: [PATCH] can: c_can: keep controller in init mode until bittiming
 is configured
Thread-Index: AQHdE7CplrlLzliLtEqKKAcufEv+XQ==
Date: Tue, 14 Jul 2026 16:48:57 +0000
Message-ID: <20260714164839.771123-1-lucas.alves@lumal21.com.br>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.53.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CP4P284MB2402:EE_|CP5P284MB1773:EE_
x-ms-office365-filtering-correlation-id: 9aaff7d6-a9ce-4b00-b5e9-08dee1c7cc33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info:
 nJ6Oftb9iyv7XcySFELEHv25P/1PwqwV5nhu56jW1/Q3kG1GrIRN7v30yM7KvShwRZrQmQa8lQe0dGzIgwhXxPBQaOyxib8Gf6ABG6FFtC+vRuwAXgVEpcHtA+V3/XRwPzS4Q9qNOOut6JyJ+Bufga8chsbDoe0TCJHe8tUYS3aH0i0tT4QV6fh/nvCITxp1XYLH+kYj/Yt/4uHJXpdssgURvnMvwRstlf/T0ROb8gQRuBzxOFIfj28hspTqglqr6zZB/amAE1S3TbUQKDGq2FwjlhG2uU+bXhtXRXmbwaDIsnOOjkGCjq9yfvIkVH4dxYyG4yTRygSi4MfHS2Z7a4AMrqBrM5jVK9OuMF54YjlRX07B1Tq92IEVZH3aL5G1MO5ffBSJm9Zg8ln6Za8McfGobXZumCDE4OUBjgMPaHGVM1uO2638rzTP32sebOmaL+0XNuRaQv26GUqaVj11x/hq/XtJKnoj+oNQ3uqXonsEsncl8NPT1R7o7oA0tY9yGuiKFRQm08um0D47FEKGWWTtk+mw0GVtJH9Bnp+c3OG1j38BZNhRYVzkX2XLEwkW2NHcrQryESRhJX3E7hbhaRSQFp34vjZmgP72CDGX9AonIi+ELSJu6VhZNbiC5K5U29b4SoJNFXvGu9OHJugDaL9+Ji+4hlc9XAtu0qIRDpWWgEd2njXa4g1Fm8mNgLM6PwaE2VpDHzPrRzkdAllm6bX5lI9xCgjGo1X2tN4Km/s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3hPS3pGSHlhVkpCa3poUXZNSnBMS1pYMzJZVE1TZTR4cnNYLzNoT242VVdQ?=
 =?utf-8?B?cnk3K2tBMjVjVEtqME1iQlVFM0hmd0hoalh6WUxqQURDNDVEUFZrVDRadVU2?=
 =?utf-8?B?VVUwRHhXRU5WMHZuaHlNMWJUZm41d3p1OFRiNWtvRzFmUDVsMWc4anNRWTJ2?=
 =?utf-8?B?dEZJS3BKck5kSnBKdmZqeTBCa1hKSnBWRkg2NXo5OXdvWWM4QkhGd0MxY0Ju?=
 =?utf-8?B?WTdZanhsNk1YUlFMUzdyV0RUcGpwZFYwOWVwYlIxV0svMk05UkRONk9NNmR4?=
 =?utf-8?B?VE1qRTZjVDZsNWUxeElqWE9Bb3BkYzBXQjJ3K2Nlb1RLYzlRcm4vdVZvVjZW?=
 =?utf-8?B?U2dVVVV0TVpqcm9XVGplS1hmNjNKa2xsRTNGQ3BDVlZCTDZzWTdVWVdZcnlj?=
 =?utf-8?B?TW1YUVdYN3lBalRXNGw3M3I2QVFYWm5ONUs5bFN4aDE5MVhGa3pITVpkazh1?=
 =?utf-8?B?MjVJOUVFWkJzc1RRYngxQnRpVVhOempuVTFmMDJlWE9yd1puaDYrN3FiSUpw?=
 =?utf-8?B?aE9ybFNpVjhYSEpHTlp2blEzN2FMd3U2OEszbThodFZYNGNmSE5qLzRtN3Qw?=
 =?utf-8?B?eDRNc2M5NjBWMjVRc2hPWEhXMDNRTjdlaFR4VFVZRWNYcVFpUkk0eUFLMEJC?=
 =?utf-8?B?S1N3VUw1UHc4NGJiMEZNRUk3T1ltQmhBaEtRWkJod3QxTWtENUtpcUdOU0hm?=
 =?utf-8?B?ZlBIc2dSdEEzK3ZhUVhJREdFREhubm15YXVPU1NhV3JaYTNvWFhablRqNnEw?=
 =?utf-8?B?VUNNSGZFRVYrZU5ZeDJ0bjBHY3FCZVRYaDRKU1NOTmErODg3cm5HekJLOUxY?=
 =?utf-8?B?cHBMMFB3YUZpSHBpUGJNVFJpMWVSS1p3SVEyaUhCUmMrcHY5dWxxR0c3Ym1J?=
 =?utf-8?B?eld6cFhsa1hheEwrMnBYU201elFMQlFEOEdUTEdUS3JjVzJhL1lSaERsaHov?=
 =?utf-8?B?dS9YTUFSWXNDNXNKUUt3L1RKcFhGYjN0bW11dmxVbzlvT3BWc1VpZm5sa1p3?=
 =?utf-8?B?WWx4V3FNY3g2b3ZjTkExNVhPMElENXlDdU1USGRpY1BGQ2tDQUhtL05kYkhw?=
 =?utf-8?B?SnJCTGl2RzB0SHNJREVhZHdmVnBhU3REWTBFa0lidVV2bS9SWWZZc0VmN0hI?=
 =?utf-8?B?Y2dVV296bEZ5bGtpSWIvYk1RY1lqakxGRVRGUS9Hb0R4MEI2Qk9UaTlJbFNB?=
 =?utf-8?B?UGVUNWVlSmJSUkx0QnRJY0paTWxVbTZJdzgzLzBvRmFyUnhmRTRXcjh0MTh2?=
 =?utf-8?B?VEZraDR0R3JYNzlYeStjLy9ZbmpuZUZrZ1dVSlFoZldGT29iT0IwZlNjb3BU?=
 =?utf-8?B?YmVLeWMySzRlWEM3M3RVQzNhTmlaM3pzMUFSUG1janVFUWZBOTVZejd2ZUQw?=
 =?utf-8?B?RUxaVDYzeWpqR1pCQlZYSXVLVmMrd0NoMm56TFdtOWNtbFgvQlQ5SUhMdmds?=
 =?utf-8?B?QkFVTkIzL0NFcnFmM1ZnSUtHTTk2WUV0S1hPN0lKZDlIZ0ZBNFJVa3JsRjRN?=
 =?utf-8?B?bk1ia2ZFYjR3UzA2ejhJb0ZMK3l2ZGlvbW53Y1NFZGlkem56TEtVT1ZLdnNC?=
 =?utf-8?B?bmJRYVhDbzY0NERzd0hmTWdab3o2MkNDeC85bHhoWmpXRlZqN1Q3NTFUMGNx?=
 =?utf-8?B?dFNXSEJyQUs5Tmpqb2lsZGhlelZzTU1WTHNYcXJydWVZNVFsbG1VcVpZdWp3?=
 =?utf-8?B?dmZFMURackwwVmVwZG4zL2x5YXJ4VVowK1FhWldXMDlJdFZOeWZXTTArQ0oy?=
 =?utf-8?B?Tk5OVUxPS3FRR2RtWUQzK2RySjFvK3lWdlFhMzVUb1AvV2RQMVVQQmliQUNQ?=
 =?utf-8?B?TUhPM3BZN3FiS01lL3BEbjM5MWloU0pDYU8xZFdqQWFRWDZxUkFzYktBRnJO?=
 =?utf-8?B?SjZUWG9lUDhBUFNEcjBRdGF4SjVmSlM4eUtmWHBQcXdOUFJicjVrc3VqK1dU?=
 =?utf-8?B?WkVvK2UyWW5sU3dUWnM3NEJOS294d3lUQVI4amVVTHhtQ0JJVG85dUtJdC81?=
 =?utf-8?B?V2dWMXY5azNHZ3g2MExIa0JMNEVvR1hZaTVDellxa0NDZm1jWVlPTlM1VzFm?=
 =?utf-8?B?Um9GOERMN0hhNjJvSlZsNWF2TEZRTGxwYXVWT3pka2JWN2t2ZHZmTTJLc3NZ?=
 =?utf-8?B?ZG83a2lHaEVwZ1lNTC9hZlFyR2lwNmhLMUc1U0FRdHZIcUxPNHhjR2RLSEJx?=
 =?utf-8?B?UnNBQmxMYWhIbUgzQkw0eXZrWmd4L3NmTHNKMU9kUmRmd0gzbXVRRHVlVkRY?=
 =?utf-8?B?R1J5TmFtbVZiazN6R0RWNFdsb3BpY25nWHRmWW5sRERDY3VtS1ZwYjZ6TWd1?=
 =?utf-8?B?YXBGa01YMUZnTmlldFpWc0c2elJvTWtDUlBuditOMG85WlU4Q3JQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lumal21.com.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaff7d6-a9ce-4b00-b5e9-08dee1c7cc33
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 16:48:57.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99055dd4-6575-473d-944c-c3b1a5a6649e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1igqYHYVSzyr2hJAwdKJQ9/EJSeMSNXww3RVpmrDlS5ycURczeLPHRSZab42NqMLd7NjY59w8voSxO77B/jf64xnZhgMQBHYuCtxao1ARuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP5P284MB1773
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[lumal21.com.br,reject];
	R_DKIM_ALLOW(-0.20)[lumal21.com.br:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[lucas.alves@lumal21.com.br,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8424-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lucas.alves@lumal21.com.br,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lumal21.com.br:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucas.alves@lumal21.com.br,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lumal21.com.br:from_mime,lumal21.com.br:mid,lumal21.com.br:email,lumal21.com.br:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C1C5757132

RnJvbTogTHVjYXMgTWFydGlucyBBbHZlcyA8bHVjYXMuYWx2ZXNAbHVtYWwyMS5jb20uYnI+Cgpj
X2Nhbl9jaGlwX2NvbmZpZygpIHdhcyBwcm9ncmFtbWluZyBDX0NBTl9DVFJMX1JFRyB3aXRob3V0
IENPTlRST0xfSU5JVCwKd2hpY2ggbWF5IGFsbG93IHRoZSBjb250cm9sbGVyIHRvIGJlY29tZSBh
Y3RpdmUgYmVmb3JlIGNfY2FuX3NldF9iaXR0aW1pbmcoKQpmaW5pc2hlcy4KClRoYXQgY3JlYXRl
cyBhIHNob3J0IHRpbWluZyB3aW5kb3cgd2hlcmUgdGhlIHBlcmlwaGVyYWwgY2FuIGludGVyYWN0
IHdpdGggdGhlCmJ1cyB1c2luZyBhIGRpZmZlcmVudC9kZWZhdWx0IGJpdHJhdGUsIHBvdGVudGlh
bGx5IGdlbmVyYXRpbmcgYnVzIGVycm9ycyBhbmQKY29ycnVwdGluZyB0cmFmZmljLgoKU2V0IENP
TlRST0xfSU5JVCB0b2dldGhlciB3aXRoIHRoZSBjb250cm9sLW1vZGUgd3JpdGVzIGluIGNfY2Fu
X2NoaXBfY29uZmlnKCkKKG5vcm1hbCwgbG9vcGJhY2sgYW5kIGxpc3Rlbi1vbmx5IHBhdGhzKSwg
c28gdGhlIGNvbnRyb2xsZXIgc3RheXMgaGFsdGVkIHVudGlsCmJpdCB0aW1pbmcgaXMgZnVsbHkg
cHJvZ3JhbW1lZC4KClRoaXMgcHJldmVudHMgdHJhbnNpZW50IGJ1cyBkaXN0dXJiYW5jZSBkdXJp
bmcgc3RhcnR1cCB3aGVuIHRoZSBjb25maWd1cmVkCmJpdHJhdGUgZGlmZmVycyBmcm9tIHRoZSBh
Y3RpdmUgYnVzIGJpdHJhdGUuCgpTaWduZWQtb2ZmLWJ5OiBMdWNhcyBNYXJ0aW5zIEFsdmVzIDxs
dWNhcy5hbHZlc0BsdW1hbDIxLmNvbS5icj4KLS0tCiBkcml2ZXJzL25ldC9jYW4vY19jYW4vY19j
YW5fbWFpbi5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vY19jYW4vY19jYW5f
bWFpbi5jIGIvZHJpdmVycy9uZXQvY2FuL2NfY2FuL2NfY2FuX21haW4uYwppbmRleCAzNzAyY2Fj
N2ZiZjAuLjMyYTM5NzViOWQ2OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvY2FuL2NfY2FuL2Nf
Y2FuX21haW4uYworKysgYi9kcml2ZXJzL25ldC9jYW4vY19jYW4vY19jYW5fbWFpbi5jCkBAIC01
OTcsMjAgKzU5NywyMCBAQCBzdGF0aWMgaW50IGNfY2FuX2NoaXBfY29uZmlnKHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpCiAJCXJldHVybiBlcnI7CiAKIAkvKiBlbmFibGUgYXV0b21hdGljIHJldHJh
bnNtaXNzaW9uICovCi0JcHJpdi0+d3JpdGVfcmVnKHByaXYsIENfQ0FOX0NUUkxfUkVHLCBDT05U
Uk9MX0VOQUJMRV9BUik7CisJcHJpdi0+d3JpdGVfcmVnKHByaXYsIENfQ0FOX0NUUkxfUkVHLCBD
T05UUk9MX0VOQUJMRV9BUiB8IENPTlRST0xfSU5JVCk7CiAKIAlpZiAoKHByaXYtPmNhbi5jdHJs
bW9kZSAmIENBTl9DVFJMTU9ERV9MSVNURU5PTkxZKSAmJgogCSAgICAocHJpdi0+Y2FuLmN0cmxt
b2RlICYgQ0FOX0NUUkxNT0RFX0xPT1BCQUNLKSkgewogCQkvKiBsb29wYmFjayArIHNpbGVudCBt
b2RlIDogdXNlZnVsIGZvciBob3Qgc2VsZi10ZXN0ICovCi0JCXByaXYtPndyaXRlX3JlZyhwcml2
LCBDX0NBTl9DVFJMX1JFRywgQ09OVFJPTF9URVNUKTsKKwkJcHJpdi0+d3JpdGVfcmVnKHByaXYs
IENfQ0FOX0NUUkxfUkVHLCBDT05UUk9MX1RFU1QgfCBDT05UUk9MX0lOSVQpOwogCQlwcml2LT53
cml0ZV9yZWcocHJpdiwgQ19DQU5fVEVTVF9SRUcsIFRFU1RfTEJBQ0sgfCBURVNUX1NJTEVOVCk7
CiAJfSBlbHNlIGlmIChwcml2LT5jYW4uY3RybG1vZGUgJiBDQU5fQ1RSTE1PREVfTE9PUEJBQ0sp
IHsKIAkJLyogbG9vcGJhY2sgbW9kZSA6IHVzZWZ1bCBmb3Igc2VsZi10ZXN0IGZ1bmN0aW9uICov
Ci0JCXByaXYtPndyaXRlX3JlZyhwcml2LCBDX0NBTl9DVFJMX1JFRywgQ09OVFJPTF9URVNUKTsK
KwkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIENfQ0FOX0NUUkxfUkVHLCBDT05UUk9MX1RFU1QgfCBD
T05UUk9MX0lOSVQpOwogCQlwcml2LT53cml0ZV9yZWcocHJpdiwgQ19DQU5fVEVTVF9SRUcsIFRF
U1RfTEJBQ0spOwogCX0gZWxzZSBpZiAocHJpdi0+Y2FuLmN0cmxtb2RlICYgQ0FOX0NUUkxNT0RF
X0xJU1RFTk9OTFkpIHsKIAkJLyogc2lsZW50IG1vZGUgOiBidXMtbW9uaXRvcmluZyBtb2RlICov
Ci0JCXByaXYtPndyaXRlX3JlZyhwcml2LCBDX0NBTl9DVFJMX1JFRywgQ09OVFJPTF9URVNUKTsK
KwkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIENfQ0FOX0NUUkxfUkVHLCBDT05UUk9MX1RFU1QgfCBD
T05UUk9MX0lOSVQgKTsKIAkJcHJpdi0+d3JpdGVfcmVnKHByaXYsIENfQ0FOX1RFU1RfUkVHLCBU
RVNUX1NJTEVOVCk7CiAJfQogCi0tIAoyLjUzLjAKCg==

