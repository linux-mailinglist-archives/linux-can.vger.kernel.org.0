Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A152F100D
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbhAKK0o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 11 Jan 2021 05:26:44 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:33398 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbhAKK0n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 05:26:43 -0500
Received: by mail-yb1-f176.google.com with SMTP id o144so16439328ybc.0
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 02:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ngJl67oXTlBTO2r1AbdrtgmfawJd+IyaoJUvVRysz9g=;
        b=KBF3mliypGWmB6hH47wJRYkNV0+N2OxnLzicJyB0RH5omt5bw9s4YkC+Id2KzwWlNP
         TjoY5ZKds9uabGEaLogIn7/0C1PRAbmRG61gBKVCxEC5odlyBtYmqeitxl/r+Dxth9xg
         lnVJ+uDDPazhHq3iCDxbxpmZr3t/kwY+IzLdF/D48ALWqmU7GWGRZbsORhOL5DQ5SJeD
         +8rzpc097F/fF7t6BshnjqzpvAz1qE/NBeH8A9Qt64cb0f7xx05Ulymzwq7xVV7Pg9nC
         cqFHXetZss+CX4jIVsRUq0Uq5gUzreHrfAxlZiGaafZqIm7I8nVrIL5GEGTpp6xP4Pg6
         dNSw==
X-Gm-Message-State: AOAM5332DzIomGfQymv/z9obyP42GzpN9wJ7ETeGDjRLZ1Ga8hfqv9HC
        kQglau5TzCfKcCSzZWfy05H34NOT/cE9R4fVJbouVpnVoZRs0Q==
X-Google-Smtp-Source: ABdhPJyTI3efw0qQWQOMwlC5U4jWmE/1NgUwUpflFj99GMPc3z5o+mIBSS9/76kv8PQyQskXO9VvKkpqxw6uoM7wRfw=
X-Received: by 2002:a25:4744:: with SMTP id u65mr25230209yba.239.1610360762372;
 Mon, 11 Jan 2021 02:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <CAMZ6RqJ-4rmFDzmzBeHvjw1-_pen4=yhnvnoRvybEtY5fqEQoQ@mail.gmail.com>
 <a93cad08-6653-720e-fa1c-da43fec7462d@pengutronix.de> <CAMZ6Rq+-i94d23zOeED6vh=N_aLfeR-Ex7qn58ZX3P4mKxHL5g@mail.gmail.com>
 <52fbb915-08c6-1d6d-487b-29e9be8d7c2a@pengutronix.de>
In-Reply-To: <52fbb915-08c6-1d6d-487b-29e9be8d7c2a@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 19:25:51 +0900
Message-ID: <CAMZ6RqLG3vYE6Bkg916GYQrviOxvb+9b4P7LNY46EchxJmLeLg@mail.gmail.com>
Subject: Re: [net-next 00/13] can: dev: cleanup and add CAN frame length
 handling support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 à 19:00, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/11/21 10:42 AM, Vincent MAILHOL wrote:
> > On Mon. 11 Jan 2021 at 17:26, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >>
> >> On 1/10/21 9:55 AM, Vincent MAILHOL wrote:
> >> [...]
> >>
> >>> Did you test it after the occurence of a can_bus_off() event?
> >>
> >> Not yet...
> >>
> >>> When the device restarts, you normally have to call
> >>> netdev_reset_queue(netdev) in order to reset all the BQL
> >>> statistics.
> >>
> >> I only included the relevant parts to illustrate the use of the changed API.
> >> There is a netdev_reset_queue() in mcp251xfd_ring_init(), which is called via:
> >> mcp251xfd_chip_start(), mcp251xfd_set_mode()
> >
> > Great then! I was just worried not to see it mentioned in the
> > patch.
> >
> > As a global comment for the series: I am done with my comments,
> > looking forward to the v2!
>
> Can I have re-add your S-o-B for "[net-next 10/13] can: length:
> can_skb_get_frame_len(): introduce function to get data length of frame in data
> link layer". If you have any contact to Arunachalam Santhanam, would be good to
> have his ack aswell. IMHO it's not critical, as this is based on your original
> patch.

I am not fully familiar with the process and I was thinking to
sign it off once all comments were addressed. But if you want to
directly add the sign-off-by in the v2 then yes, go ahead!

I also discussed previously with Arunachalam. He also
acknowledges the changes. So no problem to add his sign
off. Please let me know if he needs to send a message to the
mailing list.


Yours sincerely,
Vincent
