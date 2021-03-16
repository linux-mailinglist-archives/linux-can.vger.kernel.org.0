Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2945233D715
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhCPPRp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Mar 2021 11:17:45 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:44253 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhCPPQN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Mar 2021 11:16:13 -0400
Received: by mail-yb1-f169.google.com with SMTP id f145so20790288ybg.11
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 08:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi5aDw+4Qx2u0nrB9217FJupS4B/RU6Jze73MgpkaQ8=;
        b=dsPC0wqffiSfV2XYCU9ch6M+pGV/uzqv3/03/ko4ci2tCAwFw7f0X6u43QHPQU9AvT
         olfAZvVO44nqD4OwSeOlhhjZk7f4dlFEBo4R9JTfu+vdItV8NAluiWUsrL7WcSEmVXzo
         xzn/hAzWYvOftNWA1Cvv+Cep6SnmcXoUkzaJklTaUJkulbcPlA8eeoACXOP92WHYPHRF
         FviTOcSEduNE+/EDDHn3bD69scpZbTNPDUEuDlGkrH14DLkX6uKp8g9hrphrYnlnOPlq
         +/hJgDgGLwHGCTlYBVGLt0M5gn77H9056rzm0b9TU5rhRSjxqQvwo/1t+dhAowaAD05E
         8MJg==
X-Gm-Message-State: AOAM532tCSscBry62CEKzlDcHOge9k6dR1ntNlZNMFvcdDBPVcWaeKc4
        hVY5TYrZvvFFtS0PMYLaLHHyvZeqN1ffB81kqA7ZBQhbf3chdQ==
X-Google-Smtp-Source: ABdhPJwAK40nqtrOkC7XFpLq1UTAq/+0L8xIAV9FGwdjy//GVtKgI8GeOehzMDZXe3GBTFdLQ8gK17yEyxj2OJLEzc0=
X-Received: by 2002:a25:254a:: with SMTP id l71mr7650222ybl.125.1615907772620;
 Tue, 16 Mar 2021 08:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr> <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
In-Reply-To: <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 17 Mar 2021 00:16:01 +0900
Message-ID: <CAMZ6RqJyMXzog1mu3S62yMAxJorTg0D5VL5OYKALYRoMxN_DdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 16 Mar 2021 at 00:59, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 24.02.2021 09:20:07, Vincent Mailhol wrote:
> > Add the netlink interface for TDC parameters of struct can_tdc and
> > can_tdc_const.
> >
> > Contrary to the can_bittiming(_const) structures for which there is
> > just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
> > here, an IFLA_CAN_TDC* entry is added for each of the TDC parameters
> > of the newly introduced struct can_tdc and struct can_tdc_const.
> >
> > For struct can_tdc, these are:
> >       IFLA_CAN_TDCV
> >       IFLA_CAN_TDCO
> >       IFLA_CAN_TDCF
> >
> > For struct can_tdc_const, these are:
> >       IFLA_CAN_TDCV_MAX_CONST
> >       IFLA_CAN_TDCO_MAX_CONST
> >       IFLA_CAN_TDCF_MAX_CONST
> >
> > This is done so that changes can be applied in the future to the
> > structures without breaking the netlink interface.
> >
> > All the new parameters are defined as u32. This arbitrary choice is
> > done to mimic the other bittiming values with are also all of type
> > u32. An u16 would have been sufficient to hold the TDC values.
>
> I just had a look at the ethtool-netlink interface:
>
> | Documentation/networking/ethtool-netlink.rst
>
> this is much better designed than the CAN netlink interface. It was done
> by the pros and much later than CAN. :D So I'd like to have a similar
> structure for new CAN netlink stuff.
>
> So I think I'll remove this patch for now from can-next-testing. The
> kernel internal interface to tdc is still OK, we can leave it as is and
> change it if needed. But netlink is user space and I'd like to have it
> properly designed.

Understood. However, I will need more time to read and understand
the ethtool-netlink interface. The new patch will come later, I
do not know when.


Yours sincerely,
Vincent
