Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A711325AA6F
	for <lists+linux-can@lfdr.de>; Wed,  2 Sep 2020 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBLne (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Sep 2020 07:43:34 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:62560
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgIBLnQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Sep 2020 07:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M727TBKavBhwcd9HpNSWJShui5JDvWPth57qG2iU8NPTSUk63J36gkBK0Vwo6QffsLZfui8i88cl4QzrLRob7BqcOt59WqD4ZaVIW+llLbs65AHNAOra2pHtSpbgedPznjMuWBNIbesDL+m6D9ThB8jZqe57Y32CPjjSF7mQCBD9ZH/RLhVXcSRU738fs1vpQtGiIZDDmIZpc7EkC7F9oCMLWUfAVHQNwDnuI7FhxOuAz5CBSQXakA0nJXY6/9iRAAUMVn3D75EcZT70vYy/FPm2T9BR0oQaYp/16QogLcjQ6/s0oAx1xkD1eqO8V6dbsaCPnPDRsbAJ/V4KQ7zUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcuSETBioeklfoP3yGnudip+8j2onHgHWrbXvlEPCfw=;
 b=f6UzAh/Ve0i1igEXSjHDnfBragFTnaVLGoioJU/hpd97sincdxumIuSSR77Vob58Yas76DZTle+NJCr0iH0O+xb1Fyd2bM5ENK5NbrtCo0KSbDIT/VE4DoEh02FjRm/m02zE0Mqb9T5cvRfAdq+hlvn0WDQcIglUf89JyiIX9VzPrJq7UpoPBVPh6c2nb5gfER554nXEa/TxLePJXerUwU0aFsHKzsg2aCvFai8CxC5We9vHDAxYC40pg3RooFJOqpi4XVdClL4CgHlv/Y0oYqox8ycKNfGm7VmR8OLOQTUiaos1kkxayDgQN6zjalYHRaKV0jNW+cFudPkAeEGE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcuSETBioeklfoP3yGnudip+8j2onHgHWrbXvlEPCfw=;
 b=vY0P9L3oJAi/mwvJP3wwPwrKXB24+HVaO+YJoZ++WV/6XKGQEnOGIE0r12vuMMmVIPZI2ZFxn9QzpMPBIejXOAnXW3W+lnvYOFb/p1uB2Q5WwBkvRf3okbEZrWdcmF7TrVq+Mpf295w2DUCXcU2TrBkq0/nDzIdGXR/r5BaAeZg=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VI1PR03MB4158.eurprd03.prod.outlook.com (2603:10a6:803:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 11:43:12 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 11:43:12 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: TR: [PATCH] can/peak_usb: fix timestamp wrapping
Thread-Topic: [PATCH] can/peak_usb: fix timestamp wrapping
Thread-Index: AQHWZL6W2FUY3y8U7UCpLPF7h/8KzqlVcoTW
Date:   Wed, 2 Sep 2020 11:43:11 +0000
Message-ID: <VI1PR03MB50536800A01EB17C97D9B6BDD62F0@VI1PR03MB5053.eurprd03.prod.outlook.com>
References: <20200728090736.7628-1-s.grosjean@peak-system.com>
In-Reply-To: <20200728090736.7628-1-s.grosjean@peak-system.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d73a7fe0-5050-4353-863b-08d84f355f17
x-ms-traffictypediagnostic: VI1PR03MB4158:
x-microsoft-antispam-prvs: <VI1PR03MB4158E567023A6243027ABE4BD62F0@VI1PR03MB4158.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55JIAk4k7xaGpLNPNPEwd7PCqmZXWqsZhRT7MwC+Bs1iowllmP7XAFfTd89kH7VZmK6nHcPzHPxy7XT01k2H9RzSRRHNhQPsa14mGhmBY1fa27z0n8Xld04V27orV/rLbIc1o5tJkXZM2UskcTJn5etnuFj41z10D1yHZxJoR6dFVB7NGMKz6yVqCfUTQmCtYPsYBzXdp0MYM1pijlByfpPc6+Bt3PPPHTZp4HKknRI5CydVdy06IwqkN8YlEdu3w+RypDGStiy6Oc6PTm0LmUYgh2SqUf6PzioxIJGMuBTZbivnAmDdGQcWV8kbUmX1RvVxXjGcC1uKCA95ATIg+R3sltuTLGUri/uDCUxTxvHuAxVJiQzFYQOq/mA90Bs8KI7ch9x6zMwkOkDJZyA8GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39840400004)(55016002)(316002)(8676002)(8936002)(6506007)(26005)(186003)(7696005)(5660300002)(86362001)(71200400001)(478600001)(4326008)(76116006)(91956017)(15974865002)(52536014)(2906002)(33656002)(6916009)(66946007)(9686003)(83380400001)(66556008)(66476007)(64756008)(66446008)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: veIvm13EmKjkWzu03vjVH1kqqcNF0xlWkYGYYJJ8QBwJfu/jyCq2D8UBcwhT9skpHJcAM1FXfao4TjlZUNIb141RTpbPl/oqnJ57x4myS0Hmj01wuNPdwPwalRoSlXRb5RE0OsEoa3lopSqwuBikN547fn06KH2mQU6KWvpjJK7o4iXPUaRYiLEDo0sbDYnClxmv9GZhTthmCAXFb849dXScN5mTL3d1ji1JQr4CScuwvrP/2GSJ4Mu/9wW1EmVlCDqwRRxbMkWJulv8iAICNwA0JFc0jDmQKl2ZS81u/3NYut51d5nUIwKwTuuVLNb/L8l1fN1312M8BBHQPekM0imvPM+yv6TI4Zn5uQhNF8dKLrJkZ5aqRBPG2Yy5lBctig4ecZrByaw8cu6ul22hWq+Y7eQ8xkHviMKwb4nYGzlDarhp1T3RqVWwy9AzxlkNiRzQpyvBabJSKxTd2yQa1w9GvJ9N1p2aYUQ7BjMHejvQhP6tmUheCMGeMuKmmWbFB4/Y35MBzcndhfx6Mx0Xlk1M3rHdcOlACoxVvgHLszj+hc63vDdZVvzJompOqP/+VWVhrCCuZj9Tt2m01rZSnMeeWQcw4IJlOkUg/z7T1asaMA8wqfJQLdpTrfmv8ntn8DJdbbZMB6HcsQwfwnfwIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73a7fe0-5050-4353-863b-08d84f355f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 11:43:11.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g54xucFO6enGoA2F/R5oHmJuMnmaXRKAedBvbYNiymvDZ1nod228V5iGQhYfb3rvQGxm4tNEculohpVfeMgKiC9o6GnrWIvFVkyBs8F9f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4158
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Any news about that patch?

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97


De : Stephane Grosjean <s.grosjean@peak-system.com>
Envoy=E9 : mardi 28 juillet 2020 11:07
=C0 : linux-can Mailing List <linux-can@vger.kernel.org>
Cc : St=E9phane Grosjean <s.grosjean@peak-system.com>
Objet : [PATCH] can/peak_usb: fix timestamp wrapping

Fabian Inostroza <fabianinostrozap@gmail.com> has discovered a potential
problem in the hardware timestamp reporting from the PCAN-USB USB CAN
interface (only), related to the fact that a timestamp of an event may
precede the timestamp used for synchronization when both records are part
of the same USB packet. However, this case was used to detect the wrapping
of the time counter.

This patch details and fixes the two identified cases where this problem
can occur.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 51 ++++++++++++++++++--
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_core.c
index 0b7766b715fd..267ddc18ed51 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -130,14 +130,55 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_=
ref, u32 ts, ktime_t *time)
        /* protect from getting time before setting now */
        if (ktime_to_ns(time_ref->tv_host)) {
                u64 delta_us;
+               s64 delta_ts =3D 0;
+
+               /* General case: dev_ts_1 < dev_ts_2 < ts, with:
+                *
+                * - dev_ts_1 =3D previous sync timestamp
+                * - dev_ts_2 =3D last sync timestamp
+                * - ts =3D event timestamp
+                * - ts_period =3D known sync period (theoretical)
+                *             ~ dev_ts2 - dev_ts1
+                * *but*:
+                *
+                * - time counters wrap (see adapter->ts_used_bits)
+                * - sometimes, dev_ts_1 < ts < dev_ts2
+                *
+                * "normal" case (sync time counters increase):
+                * must take into account case when ts wraps (tsw)
+                *
+                *      < ts_period > <          >
+                *     |             |            |
+                *  ---+--------+----+-------0-+--+-->
+                *     ts_dev_1 |    ts_dev_2  |
+                *              ts             tsw
+                */
+               if (time_ref->ts_dev_1 < time_ref->ts_dev_2) {
+                       /* case when event time (tsw) wraps */
+                       if (ts < time_ref->ts_dev_1)
+                               delta_ts =3D 1 << time_ref->adapter->ts_use=
d_bits;
+
+               /* Otherwise, sync time counter (ts_dev_2) has wrapped:
+                * handle case when event time (tsn) hasn't.
+                *
+                *      < ts_period > <          >
+                *     |             |            |
+                *  ---+--------+--0-+---------+--+-->
+                *     ts_dev_1 |    ts_dev_2  |
+                *              tsn            ts
+                */
+               } else if (time_ref->ts_dev_1 < ts) {
+                       delta_ts =3D -(1 << time_ref->adapter->ts_used_bits=
);
+               }

-               delta_us =3D ts - time_ref->ts_dev_2;
-               if (ts < time_ref->ts_dev_2)
-                       delta_us &=3D (1 << time_ref->adapter->ts_used_bits=
) - 1;
+               /* add delay between last sync and event timestamps */
+               delta_ts +=3D (signed int)(ts - time_ref->ts_dev_2);

-               delta_us +=3D time_ref->ts_total;
+               /* add time from beginning to last sync */
+               delta_ts +=3D time_ref->ts_total;

-               delta_us *=3D time_ref->adapter->us_per_ts_scale;
+               /* convert ticks number into microseconds */
+               delta_us =3D delta_ts * time_ref->adapter->us_per_ts_scale;
                delta_us >>=3D time_ref->adapter->us_per_ts_shift;

                *time =3D ktime_add_us(time_ref->tv_host_0, delta_us);
--
2.25.1


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
