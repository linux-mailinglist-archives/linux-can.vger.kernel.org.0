Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28723A9AB0
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhFPMqr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 08:46:47 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:35356 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhFPMqq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 08:46:46 -0400
Received: by mail-lf1-f43.google.com with SMTP id q20so4157135lfo.2
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 05:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HElZsMsAptujA39DX1S/oiELZbEinly2g/ae8+D0OlU=;
        b=i1iHSA52D7gKgCjYvlcXLa3jkfYBQD55Ssx6zlFKciVe4F0hwrfR0X5x/FygB5mTHt
         9rcHs7d9QiAh75bzWIrf6M/F+cgh0JnkWkDsnoEJGqsp+fXZlmb7I6U6WZ2uU6wEQtNO
         mQfzhRzNOPZHtTOXhSUzTnNYqR/IVFWvRYRRBXrWS30u/4lEXI+7eJOlg4Rmvgo3Mr6c
         lg3H7Ofkt3rdLsBOQSrLzFXWX73FZ4jSHpNWX+eIeVsqoJ/T8s9P3lS+lQGpCZs57CNd
         TXHp0lgLC3JurODj+L1dK/rZ14BELQ1OSL6e6UzULrHa2WPwCPsr2ZT0L4bF5iSuQicg
         2KRQ==
X-Gm-Message-State: AOAM531hCRhbyPcvbXXzJ9CqYhHNKaIiLzPpFXdccjEP2ZaZLfWVpYXm
        j3lm/d4sIlWWVI932p1uK+hL/VVPJ7mHd2wtVN4=
X-Google-Smtp-Source: ABdhPJzZcHIG3C4+d14n8GFC8VDZ8Sl9VmXT3hDsOyBEPBgcW3YV+xtUtaiOy8dypJCHIKwfoleLFgr/ah2MNjOSsWw=
X-Received: by 2002:a05:6512:3f2a:: with SMTP id y42mr3518924lfa.234.1623847478685;
 Wed, 16 Jun 2021 05:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr> <20210616095410.lsvqnismp4uydrmh@pengutronix.de>
In-Reply-To: <20210616095410.lsvqnismp4uydrmh@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 16 Jun 2021 21:44:27 +0900
Message-ID: <CAMZ6RqKs4D2P9LnnWDGj-ThT3GLPdfnfU7TH8vx9XfqKZVZJUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 16 Jun 2021 at 18:54, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 24.02.2021 09:20:04, Vincent Mailhol wrote:
> > At high bit rates, the propagation delay from the TX pin to the RX pin
> > of the transceiver causes measurement errors: the sample point on the
> > RX pin might occur on the previous bit.
> >
> > This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
> > delay compensation" (TDC).
> >
> > This patch adds two new structures: can_tdc and can_tdc_const in order
> > to implement this TDC.
> >
> > The structures are then added to can_priv.
> >
> > A controller supports TDC if an only if can_priv::tdc_const is not
> > NULL.
> >
> > TDC is active if and only if:
> >   - fd flag is on
> >   - can_priv::tdc.tdco is not zero.
> > It is the driver responsibility to check those two conditions are met.
> >
> > No new controller modes are introduced (i.e. no CAN_CTRL_MODE_TDC) in
> > order not to be redundant with above logic.
> >
> > The names of the parameters are chosen to match existing CAN
> > controllers specification. References:
> >   - Bosch C_CAN FD8:
> > https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf
> >   - Microchip CAN FD Controller Module:
> > http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Controller-Module-Family-Reference-Manual-20005678B.pdf
> >   - SAM E701/S70/V70/V71 Family:
> > https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  include/linux/can/bittiming.h | 65 +++++++++++++++++++++++++++++++++++
> >  include/linux/can/dev.h       |  3 ++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
> > index 707575c668f4..91bf9f8926a7 100644
> > --- a/include/linux/can/bittiming.h
> > +++ b/include/linux/can/bittiming.h
> > @@ -1,5 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0-only */
> >  /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> > + * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >   */
> >
> >  #ifndef _CAN_BITTIMING_H
> > @@ -10,6 +11,70 @@
> >
> >  #define CAN_SYNC_SEG 1
> >
> > +/*
> > + * struct can_tdc - CAN FD Transmission Delay Compensation parameters
> > + *
> > + * At high bit rates, the propagation delay from the TX pin to the RX
> > + * pin of the transceiver causes measurement errors: the sample point
> > + * on the RX pin might occur on the previous bit.
> > + *
> > + * To solve this issue, ISO 11898-1 introduces in section 11.3.3
> > + * "Transmitter delay compensation" a SSP (Secondary Sample Point)
> > + * equal to the distance, in time quanta, from the start of the bit
> > + * time on the TX pin to the actual measurement on the RX pin.
> > + *
> > + * This structure contains the parameters to calculate that SSP.
> > + *
> > + * @tdcv: Transmitter Delay Compensation Value. Distance, in time
> > + *   quanta, from when the bit is sent on the TX pin to when it is
> > + *   received on the RX pin of the transmitter. Possible options:
> > + *
> > + *     O: automatic mode. The controller dynamically measure @tdcv
>           ^
>
> I think this is supposed to be a 0, not a O?
> I'll send a patch

Absolutely. I am not sure how I did such a mistake. I was
probably not fully awake as there are two other grammar issues
there. I sent another patch to fix those.

Yours sincerely,
Vincent
