Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8172F04F7
	for <lists+linux-can@lfdr.de>; Sun, 10 Jan 2021 04:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAJDdm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 22:33:42 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:40750 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbhAJDdl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 22:33:41 -0500
Received: by mail-yb1-f173.google.com with SMTP id b64so13501839ybg.7
        for <linux-can@vger.kernel.org>; Sat, 09 Jan 2021 19:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMoovTx4wLVSqQ7m6fj16Vw9EW/tkf47g1NEmNwSKj0=;
        b=iUEsgWj0731aJpv+xt3yRq+0lF0efM0otDNqWt9W65HwfVImdnNhpS/3Qz7r52GESM
         TaIxGd4eWmgHszz74pN1wQt9WAyYw5N/HsotRLDDRFAL1bvftNVZq1nyWLDJ5Y4EUZDD
         X/2rFRpu0DfLITlq0iSWXnwdZsQ3c4PjUlnBzN0TJNHdCclixknMKZceKhShSPvbRsQj
         e67r/db9lJFcZylf9JkxdJdpE5WW+62Rxog7KJ0LN/kFIWHOjgnzY4/Lt4z89AZAyukE
         EMzorV8kK/mlUOOVBb1fv4C2+wPnQElfwV6lFuP1IwpIEmcxQWnQEq6mEOXVJ7qiS7Nh
         hIrQ==
X-Gm-Message-State: AOAM5338e3R3fii7/rgsPnfC5ZhZSmshC7kkUC6QeeAJ9Ensz279RJ5r
        gETbGAZKbWMeVgRszLrqP0e5HGwyA/WESpnIsfYYE7JIcEc=
X-Google-Smtp-Source: ABdhPJyOzJYO+XyK5RglOX+keU/IxxfFDynkvCcGwHxnMe01MVu6X0voi3lZ9AwX3H+OlPG+fvjGOFysJxhoNqDZskY=
X-Received: by 2002:a05:6902:4f4:: with SMTP id w20mr15594186ybs.125.1610249579533;
 Sat, 09 Jan 2021 19:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-11-mkl@pengutronix.de>
In-Reply-To: <20210109174013.534145-11-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 10 Jan 2021 12:32:48 +0900
Message-ID: <CAMZ6RqKBpAsEpwg+miG-ExEeNF3-u8_cGHZRvJ=uUgXtd20q+g@mail.gmail.com>
Subject: Re: [net-next 10/13] can: length: can_skb_get_frame_len(): introduce
 function to get data length of frame in data link layer
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 10 Jan 2021 at 02:40, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> This patch adds the function can_skb_get_frame_len() which returns the length
> of a CAN frame on the data link layer, including Start-of-frame, Identifier,
> various other bits, the actual data, the CRC, the End-of-frame, the Inter frame
> spacing.
>
> Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Not-Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Not-Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/length.c |  50 +++++++++++++++
>  include/linux/can/length.h   | 121 +++++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>
> diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
> index b90d30858935..5b9fa51a3ca3 100644
> --- a/drivers/net/can/dev/length.c
> +++ b/drivers/net/can/dev/length.c
> @@ -40,3 +40,53 @@ u8 can_fd_len2dlc(u8 len)
>         return len2dlc[len];
>  }
>  EXPORT_SYMBOL_GPL(can_fd_len2dlc);
> +
> +/**
> + * can_skb_get_frame_len() - Calculate the CAN Frame length in bytes
> + *     of a given skb.
> + * @skb: socket buffer of a CAN message.
> + *
> + * Do a rough calculation: bit stuffing is ignored and length in bits
> + * is rounded up to a length in bytes.
> + *
> + * Rationale: this function is to be used for the BQL functions
> + * (netdev_sent_queue() and netdev_completed_queue()) which expect a
> + * value in bytes. Just using skb->len is insufficient because it will
> + * return the constant value of CAN(FD)_MTU. Doing the bit stuffing
> + * calculation would be too expensive in term of computing resources
> + * for no noticeable gain.
> + *
> + * Remarks: The payload of CAN FD frames with BRS flag are sent at a
> + * different bitrate. Currently, the can-utils canbusload tool does
> + * not support CAN-FD yet and so we could not run any benchmark to
> + * measure the impact. There might be possible improvement here.
> + *
> + * Return: length in bytes.
> + */
> +unsigned int can_skb_get_frame_len(const struct sk_buff *skb)
> +{
> +       const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
> +       u8 len;
> +
> +       if (can_is_canfd_skb(skb))
> +               len = canfd_sanitize_len(cf->len);
> +       else if (cf->can_id & CAN_RTR_FLAG)
> +               len = 0;
> +       else
> +               len = cf->len;
> +
> +       if (can_is_canfd_skb(skb)) {
> +               if (cf->can_id & CAN_EFF_FLAG)
> +                       len += CANFD_FRAME_OVERHEAD_EFF;
> +               else
> +                       len += CANFD_FRAME_OVERHEAD_SFF;
> +       } else {
> +               if (cf->can_id & CAN_EFF_FLAG)
> +                       len += CAN_FRAME_OVERHEAD_EFF;
> +               else
> +                       len += CAN_FRAME_OVERHEAD_SFF;
> +       }
> +
> +       return len;
> +}
> +EXPORT_SYMBOL_GPL(can_skb_get_frame_len);
> diff --git a/include/linux/can/length.h b/include/linux/can/length.h
> index 0d796f96266b..7d8affcc3d9f 100644
> --- a/include/linux/can/length.h
> +++ b/include/linux/can/length.h
> @@ -3,11 +3,129 @@
>   * Copyright (C) 2006 Andrey Volkov <avolkov@varma-el.com>
>   *               Varma Electronics Oy
>   * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
>   */
>
>  #ifndef _CAN_LENGTH_H
>  #define _CAN_LENGTH_H
>
> +/*
> + * Size of a Classical CAN Standard Frame
> + *
> + * Name of Field                       Bits
> + * ---------------------------------------------------------
> + * Start-of-frame                      1
> + * Identifier                          11
> + * Remote transmission request (RTR)   1
> + * Identifier extension bit (IDE)      1
> + * Reserved bit (r0)                   1
> + * Data length code (DLC)              4
> + * Data field                          0...64
> + * CRC                                 15
> + * CRC delimiter                       1
> + * ACK slot                            1
> + * ACK delimiter                       1
> + * End-of-frame (EOF)                  7
> + * Inter frame spacing                 3
> + *
> + * rounded up and ignoring bitstuffing
> + */
> +#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> +
> +/*
> + * Size of a Classical CAN Extended Frame
> + *
> + * Name of Field                       Bits
> + * ---------------------------------------------------------
> + * Start-of-frame                      1
> + * Identifier A                                11
> + * Substitute remote request (SRR)     1
> + * Identifier extension bit (IDE)      1
> + * Identifier B                                18
> + * Remote transmission request (RTR)   1
> + * Reserved bits (r1, r0)              2
> + * Data length code (DLC)              4
> + * Data field                          0...64
> + * CRC                                 15
> + * CRC delimiter                       1
> + * ACK slot                            1
> + * ACK delimiter                       1
> + * End-of-frame (EOF)                  7
> + * Inter frame spacing                 3
> + *
> + * rounded up and ignoring bitstuffing
> + */
> +#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> +
> +/*
> + * Size of a CAN-FD Standard Frame
> + *
> + * Name of Field                       Bits
> + * ---------------------------------------------------------
> + * Start-of-frame                      1
> + * Identifier                          11
> + * Reserved bit (r1)                   1
> + * Identifier extension bit (IDE)      1
> + * Flexible data rate format (FDF)     1
> + * Reserved bit (r0)                   1
> + * Bit Rate Switch (BRS)               1
> + * Error Status Indicator (ESI)                1
> + * Data length code (DLC)              4
> + * Data field                          0...512
> + * Stuff Bit Count (SBC)               0...16: 4 20...64:5
> + * CRC                                 0...16: 17 20...64:21
> + * CRC delimiter (CD)                  1
> + * ACK slot (AS)                       1
> + * ACK delimiter (AD)                  1
> + * End-of-frame (EOF)                  7
> + * Inter frame spacing                 3
> + *
> + * assuming CRC21, rounded up and ignoring bitstuffing
> + */
> +#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
> +
> +/*
> + * Size of a CAN-FD Extended Frame
> + *
> + * Name of Field                       Bits
> + * ---------------------------------------------------------
> + * Start-of-frame                      1
> + * Identifier A                                11
> + * Substitute remote request (SRR)     1
> + * Identifier extension bit (IDE)      1
> + * Identifier B                                18
> + * Reserved bit (r1)                   1
> + * Flexible data rate format (FDF)     1
> + * Reserved bit (r0)                   1
> + * Bit Rate Switch (BRS)               1
> + * Error Status Indicator (ESI)                1
> + * Data length code (DLC)              4
> + * Data field                          0...512
> + * Stuff Bit Count (SBC)               0...16: 4 20...64:5
> + * CRC                                 0...16: 17 20...64:21
> + * CRC delimiter (CD)                  1
> + * ACK slot (AS)                       1
> + * ACK delimiter (AD)                  1
> + * End-of-frame (EOF)                  7
> + * Inter frame spacing                 3
> + *
> + * assuming CRC21, rounded up and ignoring bitstuffing
> + */
> +#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
> +
> +/*
> + * Maximum size of a Classical CAN frame
> + * (rounded up and ignoring bitstuffing)
> + */
> +#define CAN_FRAME_LEN_MAX (CAN_FRAME_OVERHEAD_EFF + CAN_MAX_DLEN)
> +
> +/*
> + * Maximum size of a CAN-FD frame (rough estimation because
> + * ES58X_SFF_BYTES() and ES58X_EFF_BYTES() macros are using the
> + * constant values for Classical CAN, not CAN-FD).
> + */
/*
 * Maximum size of a CAN-FD frame
 * (rounded up and ignoring bitstuffing)
 */
It is a leftover from my original comment. Does not apply anymore
thanks to your newly introduced CANFD_FRAME_OVERHEAD_EFF macro.

> +#define CANFD_FRAME_LEN_MAX (CANFD_FRAME_OVERHEAD_EFF + CANFD_MAX_DLEN)
> +
>  /*
>   * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
>   * Classical CAN frame into a valid data length of max. 8 bytes.
> @@ -48,6 +166,9 @@ u8 can_fd_dlc2len(u8 dlc);
>  /* map the sanitized data length to an appropriate data length code */
>  u8 can_fd_len2dlc(u8 len);
>
> +/* calculate the CAN Frame length in bytes of a given skb */
> +unsigned int can_skb_get_frame_len(const struct sk_buff *skb);
> +
>  /* map the data length to an appropriate data link layer length */
>  static inline u8 canfd_sanitize_len(u8 len)
>  {

Thanks for your patch series :)
Still reviewing but so far so good. Will also apply the changes
to the ES58X driver and send the v10 of the patch.
