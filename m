Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9B15C38E
	for <lists+linux-can@lfdr.de>; Thu, 13 Feb 2020 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgBMPm3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 13 Feb 2020 10:42:29 -0500
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:8952
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729821AbgBMPm1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 13 Feb 2020 10:42:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdQofCgxSjj+vJmbbKQoFu3GguLU0t+IscCL0pTZQSUladHWsulU+KZdDPx3SGoHOTznSs9NXBH1bdTaXs/ZrneG3y56edE1aXiPqJGnMMh5dqtwkE12jethf5O5eE6of7+XYN02U3arR8IO7n4O9xr9/J6Ke5Huoec3ZhOZ6KI251WhxwqmjEvMevKTLUThnMWpOzewpfMvULddun/PqRsT4+h1xMEjnf6LYz4knzPIzshrf2C49EF4nektGfo8DgiLwGtpQyyjr9Q9Sa3vatvsv89yB4Sl8loQsgvlJSslYYjHp9z4gbivQEfYqjdU4srEhvsbn+GafNQRSJiFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGvqahlZWC384iWQnsYY/cRTbe4imEJCRPvSS63rwSg=;
 b=Xyqb1VUa5Kh5xVJL/1a7oZuZ+9PAINU8taqSkMqdMXrGRy/PSwflzZ4pFdEA8L+Rf45IdsEb9bnDLlMecm/NInICBNYc2UVQO8//vp1swGwKqID2WU3R5+olRNBF0VExbjhyWBcJd3LxdxMdbHKZwgx9+m+BYP28eIyOrpHh52WEoJHHMnu5UcaYosw1ZLPV2H12EvPfbJJVdxaEJ4x5hRooJ84fU98sYOrU0xDBDuwtdw7VgiMNMRjICNYWz7Lrs96tYL1+r1da0/f732wKjBBMIPoeckkikBkoY7IFEwuK6qJuV2KL/aefIFY/Vye/KdBIRj57ztGRx1998uBD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGvqahlZWC384iWQnsYY/cRTbe4imEJCRPvSS63rwSg=;
 b=xUwL6J4QKF71NMWHR9QmgLteb76txICV0bg2stCf1WF6aLfaDQU+Rleikp2WzdPjswfzutEXmOhW9fd/28/slFOz3uTWqGnWRu4s+JEm8M+yhynHpUHFTW/TT5iCIFcBjE1MHbIbO/o8RbAm8VikW2KthaXYvfILiOXewgPFcM0=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (10.165.163.10) by
 DB6PR03MB2854.eurprd03.prod.outlook.com (10.165.140.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 15:42:22 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1%6]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 15:42:22 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: FW: [PATCH] can/peak_canfd: fix echo management when loopback is on
Thread-Topic: [PATCH] can/peak_canfd: fix echo management when loopback is on
Thread-Index: AQHV23IuFClfX5OTjkeEOTGE4TK2wqgZJTKw
Date:   Thu, 13 Feb 2020 15:42:22 +0000
Message-ID: <DB6PR03MB3093B69C542061D1AE7DE745D61A0@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <20200204153357.25424-1-s.grosjean@peak-system.com>
In-Reply-To: <20200204153357.25424-1-s.grosjean@peak-system.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [185.109.201.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f03f867-e1cd-4ea2-c6ae-08d7b09b5156
x-ms-traffictypediagnostic: DB6PR03MB2854:
x-microsoft-antispam-prvs: <DB6PR03MB2854673B9F16BB19AB40EE81D61A0@DB6PR03MB2854.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39830400003)(346002)(136003)(199004)(189003)(6506007)(53546011)(26005)(6916009)(66574012)(86362001)(186003)(8676002)(2906002)(81156014)(81166006)(71200400001)(33656002)(15974865002)(55016002)(7696005)(9686003)(54906003)(52536014)(8936002)(66556008)(66446008)(64756008)(66476007)(66946007)(316002)(76116006)(508600001)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR03MB2854;H:DB6PR03MB3093.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEEe5mLJ/dh3f4lF+JLdTwiTjN9oT9PKzgPHXdyaiV7Iua1tGRyV8BxMBlj67Et51C+M/BYbv89oOQoRmIDABZqbhJEFMw/SWI7bnhzySji5dA+XKcW1Vbf5TYJGJ+aO008Eg6aYJG2J9v7D/aFkvEqhUIDk+wV843EMcwsKbl1mZhR6WEO719ddJP0E38tPIG1wlvGAd18nTASzXA9ZSpJNLFqV/YZG7Rjqv03zpGls4ROUvXROaoX5bBHZ0V8Hz4K3H4gPkWvLpg3huBY67LaT9vSnUGzGmlf8kuGmycuWc6ChO9IehJ7To6XDWlraIEAv/cXwTwm5ItomXaZUnq26JAyRyMGzHY8cghiI3qfV5uC5VufRBlYNoN90hYrwDXhODgufCTnNZvYMysFEM9/GEJE1k5ZvUZz5n6f4fWtxz3OAgj5V8ylIL+3MLkSMPOw2e7A5CDqeLZiCrsMMXOM0DmLqB+8yl4DCtsTXajAMr8EAnVlXGEQOzbEu9dG4NZX72bgh+m9YzeZ4Fi0stQ==
x-ms-exchange-antispam-messagedata: L//OEfNi3qjvmCUSNULEUWW3cJgcUOwXi5NlmxcGKkdHhb2e+jcmT81gyIgJxRiR23hCjsZDWaiObUnKUUaw96Gf3x9vLJwR1Ip5x5n4RkCw8kecQ5JyPjGAUUdgGlYlud0dB5EnlxspCXld1Gunjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f03f867-e1cd-4ea2-c6ae-08d7b09b5156
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 15:42:22.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njlc5rV/7tgMoJHDGjlVFOLnuE2+fjDqDJXMLT+Ln4mLpqR1u4OpaD+hHvoVy7uXb7fAJ9Ls8xJBGpkpAVU3wHU9ZzvvwlYkUyj6j2iFGaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2854
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

AFAIK I have no news about that patch...

Best regards,

- St=E9phane

> -----Original Message-----
> From: Stephane Grosjean <s.grosjean@peak-system.com>
> Sent: mardi 4 f=E9vrier 2020 16:34
> To: linux-can Mailing List <linux-can@vger.kernel.org>
> Cc: St=E9phane Grosjean <s.grosjean@peak-system.com>
> Subject: [PATCH] can/peak_canfd: fix echo management when loopback is
> on
>
> Echo management is driven by PUCAN_MSG_LOOPED_BACK bit, while
> loopback frames are identified with PUCAN_MSG_SELF_RECEIVE bit. Those
> bits are set for each outgoing frame written to the IP core so that a cop=
y of
> each one will be placed into the rx path. Thus,
>
> - when PUCAN_MSG_LOOPED_BACK is set then the rx frame is an echo of a
>   previously sent frame,
> - when PUCAN_MSG_LOOPED_BACK+PUCAN_MSG_SELF_RECEIVE are set,
> then the rx
>   frame is an echo AND a loopback frame. Therefore, this frame must be
>   put into the socket rx path too.
>
> This patch fixes how CAN frames are handled when these are sent while the
> CAN interface is configured in "loopback on" mode.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/peak_canfd/peak_canfd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c
> b/drivers/net/can/peak_canfd/peak_canfd.c
> index 10aa3e457c33..40c33b8a5fda 100644
> --- a/drivers/net/can/peak_canfd/peak_canfd.c
> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
> @@ -262,8 +262,7 @@ static int pucan_handle_can_rx(struct
> peak_canfd_priv *priv,
>                 cf_len =3D get_can_dlc(pucan_msg_get_dlc(msg));
>
>         /* if this frame is an echo, */
> -       if ((rx_msg_flags & PUCAN_MSG_LOOPED_BACK) &&
> -           !(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE)) {
> +       if (rx_msg_flags & PUCAN_MSG_LOOPED_BACK) {
>                 unsigned long flags;
>
>                 spin_lock_irqsave(&priv->echo_lock, flags); @@ -277,7 +27=
6,13 @@
> static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
>                 netif_wake_queue(priv->ndev);
>
>                 spin_unlock_irqrestore(&priv->echo_lock, flags);
> -               return 0;
> +
> +               /* if this frame is only an echo, stop here. Otherwise,
> +                * continue to push this application self-received frame =
into
> +                * its own rx queue.
> +                */
> +               if (!(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE))
> +                       return 0;
>         }
>
>         /* otherwise, it should be pushed into rx fifo */
> --
> 2.20.1
>
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm Unsere
> Datenschutzerklaerung mit wichtigen Hinweisen zur Behandlung
> personenbezogener Daten finden Sie unter www.peak-
> system.com/Datenschutz.483.0.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
