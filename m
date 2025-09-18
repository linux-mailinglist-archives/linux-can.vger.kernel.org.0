Return-Path: <linux-can+bounces-4733-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E49B8340C
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1993D189CC99
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E82D9EDD;
	Thu, 18 Sep 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mjxXi29j"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC81C2DB2;
	Thu, 18 Sep 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179033; cv=fail; b=FYTwDSsZAMVcWs6Q7tG6hy+dcPdATioFZqSrxeOo3JBLq1LtSNdTDZSTdLWwSSKySEaTWfNjH0Ex/udvUJStUZxz7WeCOxFv7THn+7fxM/qHvjFDEo67ATTwN03JWIXuyHUqq9MxNUjRHPa+OmQugzidED0y1Eof/Zc5AbToIMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179033; c=relaxed/simple;
	bh=bA2wxrbQGDqm2+2P+CV0UU2IPg26VTosJmKW9kln9Tg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o93imUL6FRriIHmCapEWGJ0nOUU+97rD+OPsOfz5fN13S42zqcviYIUubgNjY1wD4Uhw0rOrheR0Ivq7b1liQTu7evW29JB5t4S99jZSkxXM+iQu5ToEec6CezEmrXYkDX+0C2bAo/sznRFmFFPKO+n3KZ5H3dFhfwIDx3Ufgjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mjxXi29j; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiNF3qtsWCj8I/0+Knjd5HtRGqxE8Le3s9RjTtuU6WRmCSWWCl8Jfab9D+Yemetf6DGNy8Alt+oZdq57ptTS8OALeYy7pRhb67mYN8Vm1WwMMW+tqAsSxUOf5S5eUDGWc3MsMuwCOF0UxnXhIVU2mrJbLT66jh98ytxHqejLG+uOnvG+sRjm/ipEqkwBekM8eiUDvszZqP/O3tABfNeYKgLhXLgIeEWvMOidrzFNH7zoKigm+JOWuMZ93u1+lXt/mY/Nm4Qlp/Sjqlu39hyuxM8zgdR0BYr4DtKmZOrlmG+WogReGHHEIF2oikhqugyrHZq4CCu+zBtYBlqmIN9H0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/BFre83pV/68CjmdLPbuEZCsZxq3M844sXBlnX/kO4=;
 b=Id8LdI6qgBWocZ3oAw3SGQEBGsPM2IRcZmWg1BkacJxPOlm5Ucmydz8bR6utSxoRVBIKe8b9i7knb+Wy7EB9RuKkSvouTrixL9mE2eGZMwPUR3lMUL7hIx+DCI76UD7K+T6PkvPwEwRE+lH5VtKXM7EQoXSsCqQK3H/p+bFTDJgRJUEqqULy/YlZcifMwZtnlpjjpNupwbQrWXjRP5ggC+6Zl7KB8dF+QKVt2x5t//La5oe/b7TW3OS043QgOM63zA/zescvrWqty2S8eN/1Qsf9O7VNwem+W/Mt3q4eG8cVcnDZ40GlHe4NDqTTBG7RzbzIVEJ84y4D6jznCB4XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/BFre83pV/68CjmdLPbuEZCsZxq3M844sXBlnX/kO4=;
 b=mjxXi29jDs+nU6iSvDy96lP7hcqMMXaaKfVoWVWFe0Vvo0lrzbf7q3+2YOQSsebYTgNo1UhWb4cuufq3FwLl2aLgt+tD69mGJ1bazBua9sxlimM8hN1y+ypfw6aGKwKyu7Sfqw9kwEHiAEGA0OyNiXT++BKEVwcYtyX0O6hP+LE=
Received: from TYWPR01MB8743.jpnprd01.prod.outlook.com (2603:1096:400:169::6)
 by TY7PR01MB13682.jpnprd01.prod.outlook.com (2603:1096:405:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:03:45 +0000
Received: from TYWPR01MB8743.jpnprd01.prod.outlook.com
 ([fe80::8c8f:9ed5:1165:887d]) by TYWPR01MB8743.jpnprd01.prod.outlook.com
 ([fe80::8c8f:9ed5:1165:887d%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:03:45 +0000
From: Duy Nguyen <duy.nguyen.rh@renesas.com>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"socketcan@hartkopp.net" <socketcan@hartkopp.net>, Duy Nguyen
	<duy.nguyen.rh@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Hong Thuan
	<thuan.nguyen-hong@banvien.com.vn>, Tong Duc Duy
	<duy.tong-duc@banvien.com.vn>, Tranh Ha <tranh.ha.xb@renesas.com>, Minh Le
	<minh.le.aj@renesas.com>
Subject: [PATCH] can: rcar_canfd: Fix controller mode setting
Thread-Topic: [PATCH] can: rcar_canfd: Fix controller mode setting
Thread-Index: AdwoagmMBYV1IYeCQISoRQ8FqM1iow==
Date: Thu, 18 Sep 2025 07:03:45 +0000
Message-ID:
 <TYWPR01MB87434739F83E27EDCD23DF44B416A@TYWPR01MB8743.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8743:EE_|TY7PR01MB13682:EE_
x-ms-office365-filtering-correlation-id: 2edd9409-45ec-4faa-ec9f-08ddf6818237
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D/NlN5MzN1TnGY+uJjqBfOr9IhK80MbVwGvffrmR9wBKNpJyQa4poSvtVgmt?=
 =?us-ascii?Q?+tmObnPe2bBONSWPJvc/DREH+oZL9URFYSfuUOATGZx7XrH17mCLDOs8JFHI?=
 =?us-ascii?Q?ghFtKjBFQfe3G0ZFRxEPXsoFLEknOqPeLJfC/5UF7w36JuzGsWgmErL2iZat?=
 =?us-ascii?Q?xGabXU0J55+mFpDtF8/zM/0/ySCihts4tEQx7NtKnnySxflzEkzMO/LkXjWA?=
 =?us-ascii?Q?Nt7uDpwplAi3hjva46CdXROKoCHgSPBuDy3b70E9AbnZU9pQPJdJK1FSfcLS?=
 =?us-ascii?Q?5EuLWJ4ms9Ob2MHvHeQVS+QakmqRK37lrycJ9zBMuFCH9fweOSzZaChklwdZ?=
 =?us-ascii?Q?p6lngCl8z/9a/7fV6vyEFZZWMwkyXTIyu+B3MVnQhv+G3yUSAAa8mquxnUUT?=
 =?us-ascii?Q?OLikBrsAlr1N90NsOvi7PUF/KcKg0rn10HrnURBHt0SCkl6J1RwO3nsh9cDQ?=
 =?us-ascii?Q?jy5aYdMmwRdNi1+Ak/7dHPglXmG9cBBUW9QWoiGz+WLkcTCE+IeQycmvOqqb?=
 =?us-ascii?Q?G2cXoALwvJsx95xMnwwD7CK+sWp9gST6kg2ZP/7AcLRBNkzm785Sgf/DGLGe?=
 =?us-ascii?Q?KmFqptnnZ31GIWvFHNz3urPzwjLpKupejtm0VL5V8X4UQFAHJUzLKAbWNeYX?=
 =?us-ascii?Q?IB3p9eYUzeTJzBikEVp/u6HWpyi77/PnPaDi3LGw1yDyn5w6MWJU+68KQjoN?=
 =?us-ascii?Q?gFWYVll498+MgoUEby5VsM/TbdCxx2xXmYPB3AT+KpY1ZldkQp5MZMYfKGyt?=
 =?us-ascii?Q?enVEr5XC7ZiuKhJE76x8Gk54exokkTi7Kj/nj4Dn5ur7GE7h/RduThb7xsqe?=
 =?us-ascii?Q?5oufthq23n58LtX9hMnMGus5fa2+2Rh9Nxi9Yedb9P8MCCAqoj4+aVInz+n/?=
 =?us-ascii?Q?/36F9FhD15BjX3pdQbVhlu0/A/MQPyQtp7aJdVDfkLqt79J2cJJMGxp3QqsY?=
 =?us-ascii?Q?NB76hlHjFmpgs0avX2VaCr9FXaOXewQMC8Jt3r42YgTP9oH04nPFZ6r7MjNr?=
 =?us-ascii?Q?XaM6Tb9+9e7To6Hn14p7ywQ0GML8Vbpf5BygsiV2KW1gU4/IsgpntgA2q5/Q?=
 =?us-ascii?Q?Jc7e8S8f1q7wQuM+F6qoXrgcJRrWI8RHp3tgwI1/8TgqYzWsTP4ZugirGeI2?=
 =?us-ascii?Q?7EpRrqQC2ogkFFLbBb//XYLLMJqLuAwGmAYrkmA+quIBC5ubJyIUeqtFKNwi?=
 =?us-ascii?Q?L+LiK3ZdItoLpIyplBRblH/J8xKrOxOK/6q0Pp+5r4vf4Q2noD/4SrJexSPb?=
 =?us-ascii?Q?NmR+MBScMzDSpQN7i1wDCairzNlMD4kp22TCBLg/h9XwZmq3QyzMjoKvekDe?=
 =?us-ascii?Q?XzClMCywit6qd9XPrHMpWahDR6142253n2N8cYyPW9bOW6j7KjG6DtyTBEZO?=
 =?us-ascii?Q?Pl8aNXQUpp5ooUl2T9vMGa+dhcGncIKOGpIY2+wSRJQCLp+eVkn/k338G1oA?=
 =?us-ascii?Q?3MLzxnZEVdHbLQ5aSNtE3h2d+iODNT21wpqfbWHymuhpv1Xge8XK2k1Wt7e9?=
 =?us-ascii?Q?oSQztQkMwPDe2Sw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8743.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?upAkBnceb4N2QMOH1Ni7fJHKk5hrwN7yBrERrk8l8eBRXrqGsRaQFUBi9enu?=
 =?us-ascii?Q?wl+23vWS/hkCC6UX5X4ciKYVsLidIsKlA0wuRaZzTUVMcYLtwD6ykVDJa/c9?=
 =?us-ascii?Q?nvqVxNOO5FpOw+ANIOyViD6NNUfAMnWeZmzb8t6NhYcv9xTs9fKyO36kkPF8?=
 =?us-ascii?Q?ctNFs1OF6UJzFG/OFEj3AEk8tm+4TlDTCxgdoNtLxzn3AE70L+H9GFtIUKXa?=
 =?us-ascii?Q?I89LM81LBjKDFNrTUXOoB1DQ7jPdIeoBNAOS9bRQtNSABoY+jwK+/cpEUvU+?=
 =?us-ascii?Q?FWGU4LokzLHSFCnl0DhyGerx8wu0esmMonVyMNWNAGG3j3lcocRWJ4uGUe2s?=
 =?us-ascii?Q?oXP29DxIUgrLIHR07jJCtClOQ6nhCpuzUD+JguvLo550kblt4pRf9PMQ++Vp?=
 =?us-ascii?Q?aBVYxgrr1znw8UISg68uX8Gl581ZUMMuNuLjAeiLoRbsnPbOcp9UU61tFFSo?=
 =?us-ascii?Q?UNxgrj+fC8GfjjJYVndW0Kpe1g9zcwpD3PdMbBqYuhXPnx2tBR6iXGyNeyr+?=
 =?us-ascii?Q?eiPoZ/3Y3EUGGxllmtcQlGSnPAXUToILUxrle2G52WQi5auuU7SgoLHt1CKq?=
 =?us-ascii?Q?rs5CJgbSqPiGh/nR37qCOPad7u4jBNgRBoJ+ul1hpm1+YiGdGAhFnd8OZ6D+?=
 =?us-ascii?Q?maIVrrpE7BO8NGDV7RS8f8ZS8MkXLJSJR+WfYhLGmwLOw0LcSqloDJXgNbVq?=
 =?us-ascii?Q?9IpL9Yxhe1xowgG/bdBQBspQqCE5YYUCxpMHLNCSHpvw4rdZzhx880ukCqxX?=
 =?us-ascii?Q?zSA+O1lCx+F9vwNg+FuV4p8JlJZN5SlsediYznR6EoBMuhx6UuBrIyliY4QW?=
 =?us-ascii?Q?4sK0qrahn61cvHtp9qEaKE1Nk1JtECB+Wnhf4Y0QmAJXFhnkK0Yo4iKVEuML?=
 =?us-ascii?Q?QsEP0PfGv8DSCYir2fZ91yzll9Ph1Jag7BCoOymDAcZSZhnwXvuFzAQwUqL8?=
 =?us-ascii?Q?+VZzbSgcxOqxsuUBss0DMPRUqeXh0zPumRFwUkF/H4VuEUwbFY2I7ia8rQLI?=
 =?us-ascii?Q?Unq3U2JT0ESowudzfTZBYh8SMF0JcCCjf07OcWAKhyLaq/uXdx52QSau04vU?=
 =?us-ascii?Q?0NCbhRZ8Yml4J5iut2Q0VuR+I67Bzi5OeOC5vKOLWJf7hvFWw7d5P8PtQ+To?=
 =?us-ascii?Q?vXBUFjrilKWFBnq8LN6rkxhUmmP1qOLpJw86cbzvtRMoCZivuFT1rCqHHepC?=
 =?us-ascii?Q?37mwGSMaIu65H7vqcyQ9c85O6MTjwBtroY7Jb0SB6THT9dQfmT19i7O8Dkn8?=
 =?us-ascii?Q?sA/fyfdphUQQYgDVzuld0ZbBHmhEoyc+oSD71z6s0cdZQNenJR4CylAbiqFL?=
 =?us-ascii?Q?0+5PiEKruSWkBKnyZTLK31oH11Q9RbVObnDOOa/qGpLeI70Etw/QgGdJXEti?=
 =?us-ascii?Q?3WpENRDxkIBqIYgJsdHvOd+PI8fGJNnSbbYyfzQMFJxkIVEOtXWV//CHU71p?=
 =?us-ascii?Q?4tTbuyhk+SvEO43G2dIL3WQuFogeJ1WV+5gSemp/spjR/6rR1ZfvQf5rJnOp?=
 =?us-ascii?Q?6xZngPQAxPop8jPqymf60DxeRKOoYqZs88x835cWn0Ma0a01lVM0en0CLy+/?=
 =?us-ascii?Q?cwN9WeK5ockeRMfBIGne88VgUhno6LXml1hq9ffa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8743.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd9409-45ec-4faa-ec9f-08ddf6818237
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 07:03:45.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYY2n177j9S6PGvtIdA375ZqGu5Lr19UQ7bTasJMo9t8slCUf0wP9gPb1U7gsQkT+YPNTOWFjx9xwJZ3tnWbyOeqKV3lD6SeInPoAIM+L1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13682

Driver configures register to choose controller mode before
setting all channels to reset mode leading to failure.
The patch corrects operation of mode setting.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Tranh Ha <tranh.ha.xb@renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_=
canfd.c
index 7f10213738e5..e2ae8d6a9de6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -870,9 +870,6 @@ static int rcar_canfd_reset_controller(struct rcar_canf=
d_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
=20
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
-
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -892,6 +889,10 @@ static int rcar_canfd_reset_controller(struct rcar_can=
fd_global *gpriv)
 			return err;
 		}
 	}
+
+	/* Set the controller into appropriate mode */
+	rcar_canfd_set_mode(gpriv);
+
 	return 0;
 }
=20
--=20
2.25.1


