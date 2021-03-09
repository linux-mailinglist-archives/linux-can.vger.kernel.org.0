Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3B33266A
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhCINRJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 08:17:09 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:33174 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCINQ4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:16:56 -0500
Received: by mail-yb1-f178.google.com with SMTP id x19so13943356ybe.0
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 05:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJEyG0DJIHc2Xg3ng2gC3BX+v53wudZTdy7XpDSaXOo=;
        b=CR6GYAa9jYTfT4wjKSkgkWd3TW0r8jcjqDhITlt78sm+5BGl/PZH032pRHxqkSRvPZ
         S+Ll+pC7VCPAN7bt8i4RoIyCIh10x0dDCFQHuRur6b0nbKj5dTYysfutso18UDBfxYWK
         Xes7WzZlq9LBBhdYTDQKtldOiwf2AlpUJqOQtPln9rJ/FUfgfDZkRvfs+Hpb8xkuBGYG
         qxIZl9z5/yBidDrcdmZ+I1pVTrn0AhwCeVuwYE4rVE1dqlYsMPIyMXYSVpS1D+vlWiiS
         YEoOQF7xyhunhhagHhs//Ky3hYDP3CoLWv69UK7+aIY/owat2s1ewO5Twe3oaqsDzGDb
         FjDw==
X-Gm-Message-State: AOAM531m14S0doE60CD0nxm2D8zHUkais9MWY0WsNubJSHa/663rX8uQ
        /y5COatT3dSMr/aO/513aHfpaCK65WkeWTvOKkc=
X-Google-Smtp-Source: ABdhPJyiOCVLdyUBakx0nh6yNSB7khDIXBe0yAQL/B/u0YQ7bnEWqrXBx1kLJhsrf7x19qmqRDBgN9eSXOryyw/gmkE=
X-Received: by 2002:a25:2c96:: with SMTP id s144mr23449297ybs.487.1615295815787;
 Tue, 09 Mar 2021 05:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr> <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 Mar 2021 22:16:45 +0900
Message-ID: <CAMZ6RqLZ+LidnRka1-pX8dkHCaqNs3=bRujsMEs8LXnq0Y_E9Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 24 Feb 2021 at 09:20, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index c19eef775ec8..c3f75c09d6c8 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -19,6 +19,12 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>         [IFLA_CAN_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>         [IFLA_CAN_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
>         [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
> +       [IFLA_CAN_TDCV] = { .type = NLA_U32 },
> +       [IFLA_CAN_TDCV_MAX_CONST] = { .type = NLA_U32 },
> +       [IFLA_CAN_TDCO] = { .type = NLA_U32 },
> +       [IFLA_CAN_TDCO_MAX_CONST] = { .type = NLA_U32 },
> +       [IFLA_CAN_TDCF] = { .type = NLA_U32 },
> +       [IFLA_CAN_TDCF_MAX_CONST] = { .type = NLA_U32 },
>  };

Looking back at my patch, I just realized that the values are not
ordered in a consistent way. Here, I alternate between the TDCx
and the TDCx_CONST...

> (...)

> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index f730d443b918..e69c4b330ae6 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -134,6 +134,12 @@ enum {
>         IFLA_CAN_BITRATE_CONST,
>         IFLA_CAN_DATA_BITRATE_CONST,
>         IFLA_CAN_BITRATE_MAX,
> +       IFLA_CAN_TDCV,
> +       IFLA_CAN_TDCO,
> +       IFLA_CAN_TDCF,
> +       IFLA_CAN_TDCV_MAX_CONST,
> +       IFLA_CAN_TDCO_MAX_CONST,
> +       IFLA_CAN_TDCF_MAX_CONST,
>         __IFLA_CAN_MAX
>  };

... and there, all the TDCx and the TDCx_CONST are grouped together.

Marc, because the patches are already in the
linux-can-next/testing, how should I proceed to fix this? Should
I resend the full patch series with the changes or can I just
prepare one patch and ask you to squash it?


Yours sincerely,
Vincent
