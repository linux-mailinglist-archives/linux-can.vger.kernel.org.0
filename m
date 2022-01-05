Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3FA484F4A
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiAEIZt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 03:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiAEIZs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 03:25:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992EC061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 00:25:48 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h21so52792844ljh.3
        for <linux-can@vger.kernel.org>; Wed, 05 Jan 2022 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq5LTXz8NnVPTvSuCSXSQt6fGNfhRikInLsVR+Fji3U=;
        b=bMygoir4gNOYd+ylhjKyx8ya6A2n9qZWO2+OwxIGDNCl9RiaTiiga7HsDXuw4CbEdE
         TGGTZe7SLxIgwGERO9oG8labk1p+lr8OI3p1Ac+lVWGjhUgOF8I+oBIAYZLtumnPVu3Q
         WBxnfCY7h1HcgugUnznJFoayi358oe8C6CA/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq5LTXz8NnVPTvSuCSXSQt6fGNfhRikInLsVR+Fji3U=;
        b=wzqTWom1Ap4BOyqXRAQWaWyoY5KvRYkeJScg1VGBjBC2JBrObi/WzzlBao00b5niAc
         Pw6ILHkDoXdCouo48xkpiHFpEnGgmawvwmgH0fW9quaIdSmePsBzfKMSVnQoN/pJpwPH
         xttEbjGw53iKNQn4AJENe0lYHdgIhsM48xwt9AP8vBr2jvYRk33h+5DL/gymSTpe0MfU
         RsE/HGXhEMiJO+ninZD9X7FIKDV8vkflxS4AE/XQm1mAZzyqzJ6xjo7JPS1QURYMHTbj
         5U68EEb4aTJbB/6VKpRVHmQ+xTpcLjb1hTxU6IpGu1nQDkX4QYEFyFoMHPlt4gn9Hi3O
         n2og==
X-Gm-Message-State: AOAM532ulk3t2mdBwzcb0buLwBD7+jJXEYJuQgXnFhEBXi3owaVQhRtZ
        r70tyIjuZZ9X4dSPKOP6uuk/j1JlKX24atKowEzM8w==
X-Google-Smtp-Source: ABdhPJzJE5VaHf8mNfsm/v6vUxamypL0R2P2cLGAEANPuJ3KSbVEP/O4rA4o6zyY0K9toHoKfFRR7l8kt8iDSQq/GXM=
X-Received: by 2002:a2e:8688:: with SMTP id l8mr43589993lji.203.1641371146542;
 Wed, 05 Jan 2022 00:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20220104154133.848784-1-mkl@pengutronix.de>
In-Reply-To: <20220104154133.848784-1-mkl@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 5 Jan 2022 09:25:35 +0100
Message-ID: <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,
resend in plain text

On Tue, Jan 4, 2022 at 4:42 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> this picks up Dario's work.
>
> Changes since RFC:
> - move driver into subdir
> - rename flexcan_main.c -> flexcan-core.c
>   (mcp251xfd and tcan4x5x driver have the same naming scheme)
> - use copyright notice from flexcan.c in flexcan.h
> - add private flag support to set rx-fifo
> - remove drvinfo, the kernel will fall back to the default implementation
>
> Show available private flags:
>
> | $ sudo ethtool --show-priv-flags can0
> | Private flags for can0:
> | rx-fifo: on
>
> Change private flag:
>
> | $ sudo ethtool --set-priv-flags can0 rx-fifo off
> | netlink error: Device or resource busy
>
> ...does not work if interface is up.
>
> Shut down interface and change "rx-fifo":
>
> | $ sudo ip link set dev can0 down
> | $ sudo ethtool --set-priv-flags can0 rx-fifo off
> | $ sudo ethtool --show-priv-flags can0
> | Private flags for can0:
> | rx-fifo: off
> |
> | $ sudo ip link set dev can0 up
> | $ sudo ethtool --show-priv-flags can0
> | Private flags for can0:
> | rx-fifo: off
>
> Is the name "rx-fifo" acceptable? Can you think of a better name?

If  I am not mistaken this series arises from the need to deactivate
the RxFIFO only if it is
acceptable not to receive the notification of RTR messages. I wonder
if this can be made
explicit to the user.
Do you think it makes sense to explicitly RTR ("rtr-notify") instead
of RxFIFO (rx-fifo) ?
And if it makes sense to make it clear that it occurs at the expense
of a smaller number
of messages allocated for reception?

>
> What about adding a new quirk to the driver, only if that quirk is
> that, it is allowed to change between rx-fifo and rx-mailbox mode?
>

What platforms are you thinking of for this type of quirk to add?

regards,
Dario
>
> What to you think?
>
> regards,
> Marc
>
>
>
>


-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
