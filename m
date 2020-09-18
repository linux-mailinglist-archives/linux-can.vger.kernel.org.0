Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334C826FC78
	for <lists+linux-can@lfdr.de>; Fri, 18 Sep 2020 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIRM1W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Sep 2020 08:27:22 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgIRM1W (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Sep 2020 08:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyjQbPF85OgWFOJLVLlUywi+h7yo5no4cpd50sJoRe/wyZ0UtyXgE04y1R0HKe6t+4w2A07MdbC4md6HINWpMNd2dkuwrSV7GKZOCoyEhox3mxy58r1u29+ESB4dyuovF3Q+CQU36JIkK2iwuxZmXgsOSU9KTAI3lZ7S8YPUGaNf52C8zEbhFM7lzYetcQy9vib6sAbsAu5EjEvEB/ncSccw5YuiDuer4GCCJ0+RG3Y1dJ882fqDJP/0kzgitQqXYfizu83nBL/P5i1hXALm7eMMB1h2LYpQzsRXqXgnPzrw+00dt8nKNsgUtwIL4hBt1KWA6tCq+w4MNIdK3lGTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiwmSe5tHiq5dnYDlGeJv1WvNQkuHBourUpkxXGTz1g=;
 b=NkG5Q/2TmOObT4RGPyuhw4odq+4nY1gYLbrd+XZy8+dt8d0uYJi1SuMvCPnpyyv8GjWwcL8SLj5Z/fisD4aG8EN9UF8YMnWge5mmZb/B4kSGJH0nbHJqrujRf074CEXrdw23WFORQs1ibapVZoXpBkisjGY52a7z1p9DhZ+akwyPnRdfYD5SSR+cHMTpBO1+LyFQhF34D7nvJEqGuykWxs6MNI4d4K4bCb2yF0Ql7WKyTTxO2KVopDXRw+hFOuXpSLjVuOtOwkE1UcrELzi15lomxiED1Fo5BJ98GkUXvpolgOgFf400Vx3uAmu+KH6M/jNm7CvdZahN8VKdbT3hfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiwmSe5tHiq5dnYDlGeJv1WvNQkuHBourUpkxXGTz1g=;
 b=eExDoLt19IFjmn26onwEpxwpjTQAucspgLIQA81iTIXwlS2abhgjHUdmXfsKBOOYkFbkVKpEVhkososcyYFxZ62CZwmlEloc/6oX177qhWB3xWq51HNmGsLouuD6/hfpNBhlswqkiblP3FhRGJdpyLFlZNmVrYiwKZI0MKG7SZ8=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR04MB5695.eurprd04.prod.outlook.com (2603:10a6:803:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 12:27:17 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d%3]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 12:27:17 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Vladimir Oltean <olteanv@gmail.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Pankaj Bansal (OSS)" <pankaj.bansal@oss.nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: canfdtest on flexcan loopback
Thread-Topic: canfdtest on flexcan loopback
Thread-Index: AQHWjbcMFapPv3u3OUeBeJqncySSRA==
Date:   Fri, 18 Sep 2020 12:27:17 +0000
Message-ID: <20200918122716.kzxvocxelqwdw7uq@skbuf>
In-Reply-To: <26eccae7-e6bd-dbe4-abb6-4e71277a012a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.217.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e04d85ab-7cc4-4eaa-ac83-08d85bce2ebd
x-ms-traffictypediagnostic: VI1PR04MB5695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5695D50C6813C8BAC1282980E03F0@VI1PR04MB5695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHJDiu8ZZ89Bcfwnm4KC1buFisGW7vwetxBT1IrY7yL2nrADVlD3hORX7nqoX+xgQnZfZNEdGOD+FyPtbT1SliZJcXN1TdmMyI4Kk9kmd93HFHudV4aDhBHP5o3mnfrtCc8l0jDMYxClpHgDiHk17iZ49XdYIZ5hSteNnZVJjiTENH52dX76B+fsBcZe1AzJ04hnD7KeS+MOY/U8Gomnv2Ss1HvqEVtNip62ZUSFrYKnySNtv4aM3nqqWZEfibl0WgTvgDj58bAcFU+0dugcSFDbaItgIpoDckaC06N+99gKHUPqL+VvRNE2CRtJOGJu7hhAQrPpYR1kcrxbaJDaKLl2quaVciM/OXLTAdhiCXIN1FKH+UNcx78NBgx0pdbvddZECO9KcyccmqfyyebqyK7i21KAnq9BcTGzgwqP5irvamkZeHhbPgO1eq3US6xkiZ1cHkttCaCBaGwH8aa4Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(44832011)(26005)(53546011)(2906002)(83380400001)(66946007)(33716001)(6506007)(4326008)(86362001)(83080400001)(6486002)(1076003)(8936002)(186003)(76116006)(8676002)(6916009)(316002)(71200400001)(91956017)(54906003)(6512007)(66446008)(66556008)(478600001)(3480700007)(66476007)(64756008)(966005)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: o1LUZ1SZjhPB7wrIU+s4a34mnRffPO1ccJrHX6qK7Ai64rBoDWlPdinkHicKjEK8QRG4eEerwQg+2FunOws1c53xUSrIc+NS0F9rEeStowroP9kHRVxIbSWLq+0kBTvZbsCS6IhrQKlXmJ087ic2cGBAXK+rREba1RdOXTYr9keB+mRQD9DBZvkCf7gZwzsmb3htUhSmpr2bfAbuhEH041aNpge+O+deWD3fE1vyDgCKSSQJ/ukEgk0g+kTcA3GUO76DG4sbt5PSEr8p3pxxPpyts4eRaiDCrWRUqcQDiwGUuVR8Fte+T5K7mfVN6OxjKyunWDrKpJWLCxjRCJcUvhFrKnTVTTiV125C2REN0ctBEEVDWRHhRXH29C/AOZh4jHAeSeaUnzX7JS+iQvDxxDC4Zt2xtKmVAoKubXWGMto9ezBtdPgstGDHlJW+Rm1LXh5I2qtDgKGdKCfilj0KyNK3WVxRqKHjpUqFG5vcewidf1aGerce1fgIK9hRtDNjtEC1CZ21TYktbVayxZmLxGpKxgE4Hngl/BH+CbU6tLobQ0biiL+DgRsnnJsJ1BUhUddaL9EwbGzF2KE+I0ZFX1ntnR33bLfHyT2skXHJ81IJ5OodegcxBOT/dNWnPhldTQm7YfYCN0bA9A83BH+eBg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07CD7F48B3866844B1C0DDB5DDFE0F93@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04d85ab-7cc4-4eaa-ac83-08d85bce2ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 12:27:17.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0XLJs/HBCPDnnBxOBCE8pEvzhHpdPwd2beyqpQ3pMqJSmDp1H2XonEgQxH9SXIVoDIP4lYVRuOQeLwRs1nfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5695
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Sep 17, 2020 at 03:10:28PM +0200, Marc Kleine-Budde wrote:
> On 9/17/20 2:59 PM, Vladimir Oltean wrote:
> > On Wed, Sep 16, 2020 at 03:14:37PM +0300, Vladimir Oltean wrote:
> >> Nonetheless, you bring up a good point. I'll try to bring into net-nex=
t
> >> the minimum amount of required delta (which seems to be the
> >> fsl_lx2160a_r1_devtype_data structure only), and I'll re-test.
> >
> > So I'm back with some interesting results.
> >
> > Test 1:
> > NXP LSDK 20.04 based on v5.4.3 - reordering reproduces instantly
> >
> > Test 2:
> > net-next 5.9-rc3 with upstream defconfig and all downstream patches
> > imported from LSDK - hasn't reproduced in 20 hours of testing
> >
> > Test 3:
> > net-next 5.9-rc3 with .config imported from LSDK - hasn't reproduced in
> > 335 iterations
> >
> > Test 4:
> > linux stable linux-5.4.y - hasn't reproduced in 137 iterations
> >
> > Test 5:
> > torvalds v5.4.3 - reproduces instantly
>
> Is there a bug in v5.4.3? v5.4.66 is current latest v5.4.x
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>

63d5320a0c9b9867628a3a5a12e7f11d4cc109c2 is the first fixed commit

commit 63d5320a0c9b9867628a3a5a12e7f11d4cc109c2
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Feb 18 18:15:44 2020 +0100

    Revert "net: dev: introduce support for sch BYPASS for lockless qdisc"

    [ Upstream commit 379349e9bc3b42b8b2f8f7a03f64a97623fff323 ]

    This reverts commit ba27b4cdaaa66561aaedb2101876e563738d36fe

    Ahmed reported ouf-of-order issues bisected to commit ba27b4cdaaa6
    ("net: dev: introduce support for sch BYPASS for lockless qdisc").
    I can't find any working solution other than a plain revert.

    This will introduce some minor performance regressions for
    pfifo_fast qdisc. I plan to address them in net-next with more
    indirect call wrapper boilerplate for qdiscs.

    Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
    Fixes: ba27b4cdaaa6 ("net: dev: introduce support for sch BYPASS for lo=
ckless qdisc")
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 net/core/dev.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)=
