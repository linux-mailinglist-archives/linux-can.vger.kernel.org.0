Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A834189D
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCSJlk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 05:41:40 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:39998 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSJlQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 05:41:16 -0400
Received: by mail-yb1-f180.google.com with SMTP id c131so5579033ybf.7
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 02:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBrg7V9rSoKqQSgFzVLqnL97SMA/h4gPobaUXR4rODo=;
        b=jaQ+18OiVhxMksjYnwH7xvNbs+Xrf1g00VJfqVwkW/VHMt+mhd3Vhe7VmxviMWn4nw
         eRR7GYRmTHVs5MC/UCr18jUYLWgOaA6hMXt9fjYoZCmldoXCXvZycpxXCDufe+pNwrvw
         f+D+nQu27w20YjskGxPsQfTdk91XJ8xFyOR8YPVCvWjWM2eCRxeVlojKbKqD1jQVXHio
         uULNrB9TVcLhlkjRTN7/aYwo2FKDMhHlHwB4Gsv+f7SYQS5V9TXjyvPjSEWO4Wq/hTt2
         OqV5JcHd962Lj57K1CilDxdcemf5WTT/jkYRiIvEo5cEpIujO/g7gzPzIGgqPX8p9NUV
         S0dQ==
X-Gm-Message-State: AOAM5335oNa8qPDzAH6zoHeJDM38FMBw/p/YLvFvpaK07X8299PlyxB9
        qpGqopodNlmbI40p5GmutbQOUzrpqIHk0J3hx/Y=
X-Google-Smtp-Source: ABdhPJyPk9y/gOqDl6975SYxWtu7AoazfiR/2ZZ7SbZsJ66RbH68gmxyGdr48/zCAx8iMTGMYXCA9S8iiR9liquP+ec=
X-Received: by 2002:a25:9704:: with SMTP id d4mr4907693ybo.307.1616146874747;
 Fri, 19 Mar 2021 02:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210317085223.91282-1-mailhol.vincent@wanadoo.fr> <20210319082928.jaoxkrswpvdgnaae@pengutronix.de>
In-Reply-To: <20210319082928.jaoxkrswpvdgnaae@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 19 Mar 2021 18:41:04 +0900
Message-ID: <CAMZ6Rq+8YSRqXU7CPrT9FKnWZ1G9xkSr3wt185r2CswmxhXPVg@mail.gmail.com>
Subject: Re: [PATCH] can: dev: do not increment rx stats when generating a CAN
 error skb
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Mar 2021 at 17:29, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 17.03.2021 17:52:23, Vincent Mailhol wrote:
> > CAN error skb is an interface specific to socket CAN. The CAN error
> > skb does not correspond to any actual CAN frame sent on the wire. Only
> > an error flag is transmitted when an error occurs (c.f. ISO 11898-1
> > section 10.4.4.2 "Error flag").
> >
> > For this reason, it makes no sense to increment the rx_packets and
> > rx_bytes fields of struct net_device_stats.
>
> I think we increment the rx packets and bytes (more or less
> consistently) in all drivers for CAN error skbs.

If I understand correctly your comment, you mean that this patch
alone is not good because it will create a discrepancy with the
drivers. This is fair enough.

The real question is what is the meaning of rx_packets and
rx_bytes? My understanding is that those statistics should
represent what is sent on the wire.  Do we agree? If not, what is
the rationale for counting error skb in the device statistics?
struct can_device_stats already keeps track of the errors
statistics so incrementing the struct net_device_stats adds no
information here.

I am fine to send a more complete patch which will also do the
cleanup on all drivers. But before starting that work, I prefer
to confirm that we are aligned.


Yours sincerely,
Vincent
