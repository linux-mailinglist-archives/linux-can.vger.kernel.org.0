Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224D92F3104
	for <lists+linux-can@lfdr.de>; Tue, 12 Jan 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbhALNOx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jan 2021 08:14:53 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:46020 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhALNOw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jan 2021 08:14:52 -0500
Received: by mail-yb1-f174.google.com with SMTP id k78so2090502ybf.12
        for <linux-can@vger.kernel.org>; Tue, 12 Jan 2021 05:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xa1mvsUs+DyEkUdxPjbrYJGIfndXRgeIDaJT5zmaBEI=;
        b=WIGU8amG35PNcVTjWag/3H2RUh/wwh7tYxfyYUjsbQ/OU4CEFN3j38k8prtsGUwDGe
         Va9qFq8EGIZVLUs9f8ii6s97vJdUJ6U9RlaacLhMqEwSRkIlk2eiuvElJE7UcYuKeZhu
         izq0EN1zO/gDIQ1fnJa1CP6F1/RP4B+gG2jm3bMDlwXo+087LscyZzRbHnDFwmaH0TyF
         k4I5EdW17cmcPCKLPix10kVafD+9T6mUzZxYSzBcL+fkRCIDw2kxoLE4IEa5+gc6bpbt
         tFxTrhNCEPiRyGMsVnIrwZ+Bljjy+2PVZFr5+z0B2KHux3FGUiKKjoLfSHFmAhPl65Bh
         nExA==
X-Gm-Message-State: AOAM532ZNUtBstjTXntLRGLghELZR705ulkB3YyIqK6SWDdqDgCmEkvJ
        esOCXEJTEN57O1md9fjt0JEoRj8rlidRdOrRvJ8=
X-Google-Smtp-Source: ABdhPJyxwN+3qPOipQDMRR5vu4RDjce+UVYWrJJacSTSNcl9EHX/pWUDLl+HSBrjlxLgulknlSbrlzgOHyDf3tL1XCU=
X-Received: by 2002:a25:4744:: with SMTP id u65mr6912232yba.239.1610457251512;
 Tue, 12 Jan 2021 05:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20210111141930.693847-1-mkl@pengutronix.de>
In-Reply-To: <20210111141930.693847-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 12 Jan 2021 22:14:00 +0900
Message-ID: <CAMZ6RqJ=dr9SnP6YAF7WSKff7tYkqnoTZS7zjgSV1u3=TsQYTw@mail.gmail.com>
Subject: Re: [net-next v3 00/15] can: dev: cleanup and add CAN frame length
 handling support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 23:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> this series splits the CAN driver related infrastructure into several files
> (patches 1...6), followed by some cleanup patches (7, 8), and support for CAN
> frame length handling (9...14). Totally unrelated is patch 15, which add
> software tx timestamping.
>
> I took the path and put the calculated frame length into the struct
> can_skb_priv and extended the can_get_echo_skb() and
> can_rx_offload_get_echo_skb() to optionally return the CAN frame length.
>
> Marc
>
> ---
>
> changes since v2:
> - 05: add missing skb.o to Makefile (this time for real)
> - 10: added S-o-b and A-b
> - 15: moved skb_tx_timestamp()
>
> changes since v1:
> - 04: changed copyright
> - 05: add missing skb.o to Makefile
> - 06: add missing netlink.o to Makefile
> - 10: fix comment for CANFD_FRAME_LEN_MAX
> - 12: new
> - 15: new

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed and tested the patch series, everything is OK for me.
Thanks Marc!


Yours sincerely,
Vincent
