Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456022F127F
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhAKMod (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 07:44:33 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:45638 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbhAKMod (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 07:44:33 -0500
Received: by mail-yb1-f176.google.com with SMTP id k78so16685257ybf.12
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 04:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huhauAJpQg0ddEv+xxXgGiWjxm6fLcYh1TnDIj8hh30=;
        b=DjPudTBO4LvW2nJN/5ZymK1i//23LoESWGlwqFrwV1qRAq3kfUMQnNGYlDbsGRgTls
         mNGnP/V5i/2q1KRnDh8JuXlLsadiAfHrJTyzDBuRXtMbRvgXuQQqGqtp5V5/EcC1MtdE
         +97pf9ciCBGciVuW3ZsQHKbdki8CrSYIklMnXQ96XTCRkZEsgF2C4hF1Gixh0qXts/w2
         Pu65nQybE7+z90BjBZoIu4YoasmchftJITGleQMjgdy4/wIVELp7lWgumwLezjcO11ZX
         8eOIV4As1odAUTnv9rQSkPQuDyHE2ER6ccOzkxUtpa2+DDk27fQMNXCiWnCOq9iuAA6a
         XehA==
X-Gm-Message-State: AOAM5327uyGclxP4y3aEy/C6Tz3k34k5M9bKLtzKCPox9Qnd+JBcGc5+
        IbxodjHsAbi1Wg9b69FVO5SxE2boSZ2QvdFKDOFdPqxOKJKM1w==
X-Google-Smtp-Source: ABdhPJxJYRPySemkLi1Vc41KawUSkHNWhuCbysrzrsn+4AEob6EJbbVta3cYcXrBPFv/O9wALgSEE6tdeDCiI4Waj+Y=
X-Received: by 2002:a25:76c3:: with SMTP id r186mr25952679ybc.226.1610369032539;
 Mon, 11 Jan 2021 04:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-12-mkl@pengutronix.de>
 <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com>
 <CAMZ6RqJ23-T8doazD+=0AO38VzetfudLWO3si+pO+mqE3vSgKw@mail.gmail.com>
 <20210111061335.39983-1-mailhol.vincent@wanadoo.fr> <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de>
 <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
 <20210111104139.47318-1-mailhol.vincent@wanadoo.fr> <a9d0a827-12c1-4469-1efa-973e5af30883@pengutronix.de>
In-Reply-To: <a9d0a827-12c1-4469-1efa-973e5af30883@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 21:43:41 +0900
Message-ID: <CAMZ6RqJszEXP68OrGrQHiFfqiop8v01hVmViwKO9hsr-Ergihg@mail.gmail.com>
Subject: Re: [PATCH v2] can: dev: can_put_echo_skb(): extend to store can
 frame length
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 19:54, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/11/21 11:41 AM, Vincent Mailhol wrote:
> > Add a frame_len argument to can_put_echo_skb() which is used to save
> > length of the CAN frame into field frame_len of struct can_skb_priv so
> > that it can be later used after transmission completion. Convert all
> > users of this function, too.
> >
> > Drivers which implement BQL call can_put_echo_skb() with the output of
> > can_skb_get_frame_len(skb) and drivers which do not simply pass zero
> > as an input (in the same way that NULL would be given to
> > can_get_echo_skb()). This way, we have a nice symmetry between the two
> > echo functions.
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > --
> > v2: make the assignemend unconditional.
> >
> > Hi Marc,
> >
> > If you like the idea to modify can_put_echo_skb(), you can use this
> > patch. Just put it between patches 12 and 13 of your series.
>
> I think I've done the same changes, why applying. The series I just send is
> based on your v1 with my changes.

No problem, I just missed your message saying that you will do
the changes.

The only difference is the change in the patch subject but that's
really a minor detail. The content is the same.


Yours sincerely,
Vincent
