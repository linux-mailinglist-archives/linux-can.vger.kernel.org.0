Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9102FFFB8
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhAVKEe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 22 Jan 2021 05:04:34 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:33400 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbhAVKBt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 05:01:49 -0500
Received: by mail-ua1-f41.google.com with SMTP id k22so1658750ual.0
        for <linux-can@vger.kernel.org>; Fri, 22 Jan 2021 02:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YaAZIqAPmFsR6HPfIa2URW/DrcQBaEUIZ5khP+gUUDY=;
        b=D0b9EX7XAb/mTSRfeM0Vt6YEJKmxuqu7wVPMhZv4nKf0o/2XI8smyEp5dij7IRFTUg
         Vn1Js7RAWqnnoAwSFV3mGVNgs6KbhQZNNU8jp0C77bJiNMdUfFGb3gFXDI5l7SjAd1av
         WDXkRkTpcrGb/B7wlNWx7ec4ERABokWeqAyU39BSEauTcKlVoLsPUh/tjN/WbQMhthWN
         TT9JYUGBlIHsBeF0wOm5B+SilhTWUCXybRBBKEXyu3TS6jxhG/+oaeToijL1VOHsYAZi
         JfBz6hh2TDvpx/E4h0vr5BMfWiLsPS4CgSaNzdFzmTgswGMfzSlkPbxGb6s79xWKOEqe
         kH4A==
X-Gm-Message-State: AOAM533qclLOZ8UHqTt7Jb2d3tpItkMvgEMXpd7HuD1JPcoERWBMAenK
        54OjKVFvi5cEHknq9i281jG6ol2UdUpyD1sZRIx86gDX1OU4Tg==
X-Google-Smtp-Source: ABdhPJwxD0qbmBYRlHcS8G+gy8rzkxWN5ZV+VdOYkq/p5+5JIjcnwieqrrVdZbNgNvDJmkkWGsspcBE+UmRhkmGBHP0=
X-Received: by 2002:a25:38e:: with SMTP id 136mr5730625ybd.226.1611309118749;
 Fri, 22 Jan 2021 01:51:58 -0800 (PST)
MIME-Version: 1.0
References: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <DB8PR04MB679559428DCCA341EE53A6E4E6A00@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <CAMZ6RqLuL_BzQisQ0kGEnj7zPTe3iKnsd6n2ivZQ+bPnZW_VhA@mail.gmail.com>
 <20210122092324.fchsd253qnrjxwvr@hardanger.blackshift.org> <20210122094030.dvyzutfy4bw2si6f@pengutronix.de>
In-Reply-To: <20210122094030.dvyzutfy4bw2si6f@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 22 Jan 2021 18:51:48 +0900
Message-ID: <CAMZ6RqKd-P32QPyzeeJ7J-L1agHg7HmJtZrzO8WcXCRjDw5Rpw@mail.gmail.com>
Subject: Re: [5.10 CAN BUG report] kernel dump about echo skb
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri 22 Jan 2021 at 18:40, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> On Fri, Jan 22, 2021 at 10:23:24AM +0100, Marc Kleine-Budde wrote:
> > On Fri, Jan 22, 2021 at 06:08:18PM +0900, Vincent MAILHOL wrote:
> > > > > 1. Kernel dump log:
> > > > > [  101.688327] ------------[ cut here ]------------ [  101.692968] refcount_t:
> > > > > addition on 0; use-after-free.
> > >
> > > The skb already had its refcount at zero when reaching
> > > can_put_echo_skb(). It is as if it was already freed/consumed!
> >
> > ACK
> >
> > > If you remove Oleksij’s patch, can_put_echo_skb() will probably not
> > > clone the skb and thus not check the refcount: this means that you
> > > will not see the warning, however, it does not necessarily mean that
> > > the bug did not occur.
> >
> > ACK
> >
> > > So far, it seems to me to be another bug which was invisible until
> > > now and which Oleksij’s patch just uncovered. But I do not yet fully
> > > understand what the root cause could be.
> >
> > Or it's the same bug, hitting earlier. Oleksij's backtrace was in the
> > TX-complete path and the problem was fixes by cloning the skb in before TX.
> > This means the refcount of the original skb was decremented between TX and
> > TX-complete. Here the refcount is decremented even before TX.
> >
> > Does this make sense?

Makes absolute sense.

That would mean that Olesij’s patch addressed the issue but too late
and that somewhere earlier in the TX path, the refcount is either:
  - decremented where it shouldn’t be
  - not incremented where it should be

Assuming that the skb reaches the xmit() funcion, what should be its
refcount?
2 if the socket is still opened and 1 if the socket is closed?
Something else?

> Is socket was closed just before TX?

Good question!
In addition, I would like to know which protocol is used (raw_can, j1939,
other?)


Yours sincerely,
Vincent

> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
