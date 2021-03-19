Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBF341BE8
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCSMBM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:01:12 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:46402
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhCSMAq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 19 Mar 2021 08:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP3ADXEyvhULU9ewv5CmI9cei4RTTFa1Ihog0YTBCU7mJffhKMq3ktmAalAZjIUIfEqXc7sp+S0Q21qpYJozSaw5kZmrQfEEvLDZk5y7e+aBryn6uIBgtYtA5CC1ZzLRI11/gFtp18FSH/svZpo8Y7WNmViBQGoWjD5Eovu3cLcjejntZsCMGwOyXYVir0jPu5WlJ6CtGKOkopS7PLEX6f6TVInftummavkMHAWX0kqCWLyXG+UDFcfNd9yb46XyFV3TFbV/Z+ZIm4UbiSWk3Vbk8lXWi6R6zrge0AVCM3vtN5/TA8ZPCFfTdwPP5OqHgYsPZ72OiraT8Wv6XWje7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rivfzLB422odwsyy+N3hcqXQ+ubtRIbOtvjwLq+NL1w=;
 b=Jmg/yhHnBquPQ9fmj12DoEhnXtQ4sg0WV3+PagJJvbMmE+obSxJUu4yRmIb+oLgS6rNpJrTGgpxRmFZ4ToU+E6uyveYuaphpddBXwjifZM/JI7N7XhvxuVcblfCNtA7eop802ORUl6bINTO/t6i1bmL5QQEDmANjnkwaoW8ydcXWyNXZj3iZrH9H7CKWpV+py+KQfNAijWbtkzR6VnG8rZ+p6Lxm1SEd6jxZ63YxoY7x/K4Jv7qyy74wp/GIh0V/0B+6hFE/GCvw/omU7gLJcVvZY1cydUXLBW4GrS0s7I6Joy1npawjbJWgwAr1UInGbJ0oWKfudMAXPxBbfVFoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rivfzLB422odwsyy+N3hcqXQ+ubtRIbOtvjwLq+NL1w=;
 b=HWQuwjVSLgDBkpYaqXkW+uTtMUU/ULUDVR9KU88ZrnDAISkjvI3St0hgab+0r0A42xc2TjLJzLVoZgR4cqScYqqPYuJr+dnRrzyGtKG3e6P/GAG+C2QgvQIRpPfVHE9VU9ghWnXv6kIvnXYevcN+iMb8bHjsZm/0FxZtErLGdyI=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB6781.eurprd03.prod.outlook.com (2603:10a6:102:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 12:00:43 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 12:00:43 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Thread-Topic: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Thread-Index: AQHXFL1R75nPbu5VUkWlVIO/v4mp+ap7yESAgA9E/ICAABLqAIAAAqAAgAADLwCAAB9LqA==
Date:   Fri, 19 Mar 2021 12:00:42 +0000
Message-ID: <PA4PR03MB6797CDB1A6B02711BDB9446ED6689@PA4PR03MB6797.eurprd03.prod.outlook.com>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com>
 <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
 <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de>
 <CAMZ6RqL_ua4NzJ5VMC8Nw0iSXfBDDuOpabVJv+EEK82c4AsnEQ@mail.gmail.com>
 <20210319095630.pheblaalfg6r6zvo@pengutronix.de>,<CAMZ6RqKNysYHXQHF+X+F_wbusdjByDaiQNwy9NvAtiAopFsG8g@mail.gmail.com>
In-Reply-To: <CAMZ6RqKNysYHXQHF+X+F_wbusdjByDaiQNwy9NvAtiAopFsG8g@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=peak-system.com;
x-originating-ip: [89.158.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42118aa4-defb-41e9-d766-08d8eace9f52
x-ms-traffictypediagnostic: PA4PR03MB6781:
x-microsoft-antispam-prvs: <PA4PR03MB6781D6CD76086DBC616605BFD6689@PA4PR03MB6781.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:422;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRRwt1T8FIZhX0y87U9HBaiyMdBmVzpiKjwIcVvydF+Rs8XDHZc0Au+a4Ti0Lp+yxYTdqc8tKqzVmUAhxF8sCuHOHwyvTKoscJL9x4U56tPNX4XKSUEQcWXsjcFUmluj/UAfODiHdAiN36U5bq69iG7Rs7YMQCtox6bHNhaarfWs5tU1g8r3laPKsspGuBg/MUoWbaaK3GdKotBgM7NU0mVFBnMaorX/mTunAGC7wut1c4Ybzn33eYEZ+AA4ZzzEbrZB4sClKiclhwl6b3bEvY19Tz1qHjpU9en80p3vrj1YNdeus1Gs/xpxAe5SA20u1N1a9hnkLtzxod6jeDGBzHPAnHGMVsofpfXTa80pfIF3l1omWPEc76TufWDt5S65HPlQJB9uo05BuL3EgBvS9CGz6QhuM5eZwga12GSZUyN91vt84SyXioXqBcRGs0CrEe+6IpDlTBwdtAMSV/VZYDhV4umCOlSbbgdh9I/aDPHSQmU0YR8jkohrTEYrBfn1bT0J1yu0oAxzJA7AdeRiAUseg4anqk5wtnVnafeQEv0SfrM3z7eAVQ164liNfBF2lftwfB9DlVu3lZH9kjOjIGg+p8Oj+6PyKnPJlfaeTiulnQXseqL+oOvvdX1TXdB3v1FcX+xbg+9JNZM/UXqN5LPKeSzZxg3LFTPPByetWlgwZwafZdXyxmXkifZI5r0khkKNh8ETfgXApBxhsQ4dVns62CsTBm5GOo2/4XLFAPDywflmg2NILTJp42zEwgf+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39840400004)(66476007)(2906002)(66556008)(110136005)(66446008)(966005)(53546011)(76116006)(64756008)(71200400001)(4326008)(5660300002)(15974865002)(38100700001)(33656002)(83380400001)(86362001)(66574015)(91956017)(186003)(66946007)(55016002)(6506007)(9686003)(7696005)(8936002)(8676002)(52536014)(26005)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?d4Gt/kyZmSJb8TCvlDilsNSXuFUE8apHdJQWBZruIvkofksNAs/WsiGY6s?=
 =?iso-8859-1?Q?9Yv90P6LuRzqaIuhIPBSGyeLdfBYyUQcpFDVQMPzsurhZIY8SiOT22HYxa?=
 =?iso-8859-1?Q?sNzyo3SDySvdfbRa1sDM0cZt97GMLRpQ0bMv8o0e8ubn+0O60VMWD0TDIK?=
 =?iso-8859-1?Q?Le5g5tTfTw35f6ddgUmz8DqD3LXpfF/rdPnWw9861bWahS5pMIdo5TZXR8?=
 =?iso-8859-1?Q?JlqHLH+sIsrhQuI43iZrsM9BReOjTcG4REE49BqOG/M8ISrfQztTq+a419?=
 =?iso-8859-1?Q?5XxjGCXAYhTfp12mi8JSGuXsE7tIGFD5gk74leXQbtqrwq5mgnJdyMxFX0?=
 =?iso-8859-1?Q?jMve/TYpwfFL6kgwbCjfGuo6Mow1DeemBPEDrfWNUgCQyuVvzCTMzYFokm?=
 =?iso-8859-1?Q?Ocr1PrP6pOno8zYf2xsVotZ2P/NzwOHRfsDcGubUKUuo64gpPOOUqzPTA7?=
 =?iso-8859-1?Q?teKYHqy0Qa5XpQj7SQ63AILpJhixtMb7wJmtK4SkVK+l4/635rEGC9rldC?=
 =?iso-8859-1?Q?l1IUyV83uFLSzn8323UzwqD1g2p8zNlO4I6hpYHE5pNeQUSpTL0Q3MqIcT?=
 =?iso-8859-1?Q?4IGqZ3CfaVRKvkXj9DBbjoEVcH3dUBdhHJgfcda5wxgF4fU3YbdE88UkOE?=
 =?iso-8859-1?Q?m4+lAUUGg0oTfhwCsAtP8pkrVEs/ypr2HNtyEMcIy21EpDKdoOcdwkRGQB?=
 =?iso-8859-1?Q?jQyw2p5PDl+2DvRMZaejtifIYmr+uCguFk0MrAfXb7z3LO1RKmSWP8Z8qe?=
 =?iso-8859-1?Q?qWp1SOceboN7L48Jt8FqDmNSMnq7PVcSk3ETPFolxYfJk36ih0umWOtjft?=
 =?iso-8859-1?Q?ta/pXvixiW8TsMnwzQuk6R7aH1F2JzaIMLvhAR4DonPJfeMFTysd+GIhKl?=
 =?iso-8859-1?Q?32+VV5wMj4HaXqefN17iDgrLxpwYwE4cmxljhWm5Bx+ccI4Uo56rFTcd9V?=
 =?iso-8859-1?Q?L6n7QUPUAgqNufB0tEt7PDLe8DpKRAgLlPFr2Ow0r8zIpmcO4s6T0+bw64?=
 =?iso-8859-1?Q?323cYppki8R9LwlJjRDU2Nh647xCFp6YKinen+2dLGuYc+SXkEmMiZU0zD?=
 =?iso-8859-1?Q?/KL5T8MS871uitcy9aE/XGglrRLGCu6dGCUv3SiBcEY/+9c6LTTmzknVc/?=
 =?iso-8859-1?Q?iXP/Uf2xEc6j705axw/5YvbdbTEKssqRgqB7TcU33ON0M6pYccfM0HihU5?=
 =?iso-8859-1?Q?UWD9qjBsq1Z41plQW9zQQbdbx2su8EZWSEkFfJkCbPfLPQZm7SwMnVtyl6?=
 =?iso-8859-1?Q?2wQgoD+M79Fhqmv5tygXI2wyyqlpQ/oH1/lFY6XbE4UwdZPAb40EJAwwe7?=
 =?iso-8859-1?Q?lKn8WaZN5WJDsCnn+xCTE8kkc9nHnifeqXGXcWyc6YZW1SDo4b4oMnxWb+?=
 =?iso-8859-1?Q?mTigKeh9Tj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42118aa4-defb-41e9-d766-08d8eace9f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 12:00:42.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1zV4/VusZNJrxgYN5JroQJznDyYw93p8/9o/SFvY22g07wfLanExh7VZVBt4LQH/potvCox72kYorIDarXXYGMPFlw9SyCNiK/rlvX/9PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6781
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Sorry guys for all that noise... :-/

-- St=E9phane


De : Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Envoy=E9 : vendredi 19 mars 2021 11:07
=C0 : Marc Kleine-Budde <mkl@pengutronix.de>
Cc : St=E9phane Grosjean <s.grosjean@peak-system.com>; linux-can Mailing Li=
st <linux-can@vger.kernel.org>
Objet : Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices

On Fri. 19 mars 2021 at 18:56, Marc Kleine-Budde <mkl@pengutronix.de> wrote=
:
> On 19.03.2021 18:47:06, Vincent MAILHOL wrote:
> > On Fri. 19 Mar 2021 at 17:39, Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
> > > On 09.03.2021 16:28:37, Marc Kleine-Budde wrote:
> > > > On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> > > > > Since the peak_usb driver also supports the CAN-USB interfaces
> > > > > "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this pat=
ch adds
> > > > > their names to the list of explicitly supported devices.
> > > > >
> > > > > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > > > > ---
> > > > >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers=
/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > index 6183a42f6491..8e6250c4c417 100644
> > > > > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > > @@ -19,6 +19,8 @@
> > > > >
> > > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> > > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> > > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> > > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
> > > >
> > > > I've exchanged these, to correspond the order of the device ids.
> > >
> > > Funny side note:
> > > MODULE_SUPPORTED_DEVICE was a noop define. All uses have been globall=
y
> > > removed from Linus' tree after this patch hit linux-net/master, but
> > > before it landed in Linus' tree.
> >
> > Silly question but does it mean that we should not use
> > MODULE_SUPPORTED_DEVICE in newly submitted patches?
>
> ACK - It's been removed from Linus' tree, see:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D6417f03132a6952cd17ddd8eaddbac92b61b17e0
>
> > After seeing St=E9phane's patch, I added it to my driver. Even if it is
> > a noop define, it adds meta information in the source code so I was
> > inclined to keep it.
>
> As the noop define has been removed, the driver will no longer compile.

Got it, thanks for the link to the commit!


Yours sincerely,
Vincent

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
