Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152F21FCF39
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2020 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQOOb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Jun 2020 10:14:31 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:59474 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgFQOOb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 10:14:31 -0400
Date:   Wed, 17 Jun 2020 14:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592403268; bh=wL3JAe2jcfZkVCwnlInsN6H4atx2cP8Lrx+yk/K/AWw=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=H7GGaJpP3eYlD8WKlZvsws8lXbUv8KVYczNUJWLwd9KHgzpb3yRLLP0KiaDjfqXhl
         P1fev9kvlfuHSKXTJG7eNH2/2lf7coqqwpkwNxc++kExSNVVo0X14ba75NzHMRf4Vq
         6YncwCsN5QKcvQziRtcR6/DY+1Hb4HpzLZ/R0okw5HiLA65mogfHpmr3fsYI10fEMA
         ysI7lmeFf6bynm8ARrsEUVs23rk6njDPuZh+ggnjeE0X0hxXzOX99noha9Q6vIBloJ
         XMZ0rGXMRU3ScF2bNz8XKzTOojT0wy5D+YJZgYmlHx3knacV8KFrknsx2PNgRDCnl0
         +OlUy/jIvVcZQ==
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   Arnej Duranovic <arnejduranovic@pm.me>
Reply-To: Arnej Duranovic <arnejduranovic@pm.me>
Subject: Re: J1939: /proc/net/can interface
Message-ID: <hnYzPLiW0iarondCAesso_T4K1RQoJphq2FgiwQa6cRGPv1X6RvEaMoyuJgN67Cr8PRr_TEVrPOSdgomsrdVsBapHgWua3xHQq3dtcrZQrg=@pm.me>
In-Reply-To: <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me> <20200617125949.GA12583@x1.vandijck-laurijssen.be> <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wednesday, June 17, 2020 8:03 AM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:

> On 6/17/20 2:59 PM, Kurt Van Dijck wrote:
>
> > > -   6.  /proc/net/can-j1939 Interface.
> > > -
> > > -
> > > -   Files giving you a view on the in-kernel operation of J1939 are l=
ocated at:
> > > -   /proc/net/j1939.
> > > -
> > > -   6.1 /proc/net/can-j1939/ecu
> > > -
> > > -   This file gives an overview of the known ECU's to the kernel.
> > > -   -   iface : network interface they operate on.
> > > -   -   SA : current address.
> > > -   -   name : 64bit NAME
> > > -   -   flags : 'L' =3D local, 'R' =3D remote
> > >
> > > I am interested in what happened to this feature since I do not see i=
t in the latest implementation or in the documentation?
> >
> > The feature got removed, as (almost) all of the /proc interface
> > for making mainline integration easier.
> > The idea was to restore the required interfaces when necessary.

That's what I thought, thanks!

>
> ...or rather use something modern and machine readable.
>
> > > I am interested in retrieving "known ECU's to the kernel" in the late=
st implementation. What is recommended?
> >
> > I understand your question. The simple answer right now is: there isn't=
.
> > we could debate about this being necessary in /proc,
> > or rather in debugfs,
> > since this knowledge should not be used in real applications?
> > Am I right that your intended use is debugging related?

I think this would be great for debugging and helpful in a development envi=
ronment but I am being asked to include this feature in production. If you =
have time, can you please elaborate on why this should not be used in real =
applications?

>
> Today we probably want to have a netlink interface to read that informati=
on from
> the kernel.
>
> Marc
>
> -------------------------------------------------------------------------=
----------------------------
>
> Pengutronix e.K. | Marc Kleine-Budde |
> Embedded Linux | https://www.pengutronix.de |
> Vertretung West/Dortmund | Phone: +49-231-2826-924 |
> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |


