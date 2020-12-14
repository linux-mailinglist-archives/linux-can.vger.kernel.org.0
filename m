Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367C72D9D1F
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 18:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLNRAm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 12:00:42 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38066 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393353AbgLNRAg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 12:00:36 -0500
Received: by mail-yb1-f194.google.com with SMTP id a16so16146507ybh.5
        for <linux-can@vger.kernel.org>; Mon, 14 Dec 2020 09:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/yyg2X8LCh6EeZr0AwDPkCJIbiCYhRuBBi/vNd7BD4=;
        b=Sv8zbvSXgWTehd9LgnrBqGu5M63s4X8EvBhup/YyQYbjim7NeFTN1tejP413woi89L
         t12umS3QBbXi0moUKm/PtOgX5x0iACEFdDMOkVKHvmffKeCDnlXI0AqSDDw0ygltBeEN
         q99y1DfkNG+VzJaVJZ0jINKXFOk799Gmrakhp1iSCi7UlBO+kjVM/6fq5QiEcnvUo3MK
         7PNnquNL0GN25JxL9z/XJUtVYAZQfilhmRtD3hFdAoY2kXkz9FkjTyErwUzOVfbwSsCq
         MpbNyBlGwGqnHvv3isni8eNVSkDX4KssFtfxP9wgmjDmdBpXjp4UQTgGRd3iVjHKvYFE
         KpIg==
X-Gm-Message-State: AOAM533KBsxIuWqrQNJBdUhUjlrazOCrFN9c8q0VmH2Nyggl3TooFWEq
        IYHn2Y6rn3s0xzw/nWe95bJ4QdDXoyh/eP239xs=
X-Google-Smtp-Source: ABdhPJwQWJE4xzNAZp/YIK5ENjndj1djWUX+kXMgnbjI5JMUofUOfb9mxTk+oXiz4jms6otpwjEpmAoCYQL7hsJb/og=
X-Received: by 2002:a25:4744:: with SMTP id u65mr40668968yba.239.1607965192572;
 Mon, 14 Dec 2020 08:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20201214091426.417867-1-mkl@pengutronix.de>
In-Reply-To: <20201214091426.417867-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 15 Dec 2020 01:59:41 +0900
Message-ID: <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon 14 Dec. 2020 at 18:14, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> This patch adds the function can_skb_get_dll_len() which returns the length of
> a CAN frame on the data link layer, including Start-of-frame, Identifier,
> various other bits, the CRC, the End-of-frame, the Inter frame spacing and the
> actual data.
>
> Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Not-Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Not-Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>
> while reviewing the etas_es58X driver and hacking on BQL support for the
> mcp251xfd driver, it turned out the a function to calculate the length of the
> CAN frame that's send over the wire should go into the generic CAN dev code.

It took me a bit of time to figure out how to use the BQL. Contrary to
the other features, I couldn't pull inspiration from the other CAN
drivers. I am happy to see that you want to extend it to other
drivers.

Also, on a side topic, please let me know if you have any comments on
the etas_es58x driver ;)

> Looking at the CAN and OSI layering I think the first layer where we have all
> the bits that we see on the wire is the data link layer (DLL).
>
> https://www.can-cia.org/can-knowledge/can/can-data-link-layers
>
> This is why I named the function can_skb_get_dll_len().

I would personally prefer to call it can_skb_get_frame_len(). The ISO
11898 standard defines the "frame" as:

   Protocol Data Unit of the data link layer specifying the
   arrangement and meaning of bits or bit fields in the sequence of
   transfer across the transmission medium.

I imagine that you want to introduce the term "dll" instead of "frame"
to clearly differentiate it from the struct can_frame and struct
can_fd_frame. But "frame" remains the most relevant term according to
the standard. I think that things are clear enough so that other
kernel hackers would understand that the len fields of struct can_frame
and struct can_fd_frame represent the length of the payload and that
can_skb_get_frame_len() is the length of the frame at the data link
layer.

> I'm planing to add a (better) calculation of the CAN-FD dll_len, depending on
> the data and including different CRC lengths.

Great! For my driver, everything seemed OK as it is currently but if
this gets merged to the generic CAN dev code this part should
definitely be improved (the comment I added in my code was there to
warn whoever wanted to reuse it about the limitations).

> As this code is copied from the etas_es58X driver, I've added the authors as
> Co-developed-by and I'd like to add their S-o-b to this patch.
>
> Please review and commnt on the naming on the functions.
>
> regards,
> Marc
>
>  drivers/net/can/dev.c   | 103 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h |   3 ++
>  2 files changed, 106 insertions(+)
>
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 81e39d7507d8..58c04785b46d 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -58,6 +58,109 @@ u8 can_len2dlc(u8 len)
>  }
>  EXPORT_SYMBOL_GPL(can_len2dlc);
>
> +/* Size of a Classical CAN Standard Frame in Bits:

Size of a Classical CAN Standard Frame in Bytes:

The macro divides the grand total by 8. The subtotal is indeed
presented in bits but the macro is in bytes.

> + *
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
> + * Rounded up and ignoring bitsuffing
> + */
> +#define CAN_DLL_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> +
> +/* Size of a Classical CAN Extended Frame in Bits:

Same as above.

> + *
> + * Start-of-frame                      1
> + * Identifier A                        11
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
> + * Rounded up and ignoring bitsuffing
> + */
> +#define CAN_DLL_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> +
> +/* Maximum size of a Classical CAN frame
> + * (rounded up and ignoring bitsuffing)
> + */
> +#define CAN_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CAN_MAX_DLEN)
> +
> +/* Maximum size of a CAN-FD frame (rough estimation because
> + * ES58X_SFF_BYTES() and ES58X_EFF_BYTES() macros are using the
> + * constant values for Classical CAN, not CAN-FD).
> + */

/* Maximum size of a CAN-FD frame (rough estimation because
 * CAN_DLL_OVERHEAD_SFF and CAN_DLL_OVERHEAD_EFF macros are using the
 * constant values for Classical CAN, not CAN-FD).
 */

Some leftovers from the etas_es58x :)

> + */
> +#define CANFD_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CANFD_MAX_DLEN)
> +
> +/**
> + * can_skb_get_dll_len() - Calculate the CAN Data Link Layer length in
> + * bytes of a given skb.
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
> + * Remarks:
> + * a.) The payload of CAN FD frames with BRS flag are sent at a
> + * different bitrate. Currently, the can-utils canbusload tool does
> + * not support CAN-FD yet and so we could not run any benchmark to
> + * measure the impact. There might be possible improvement here.

My initial idea was to convert the data transmitted at data bitrate
speed to their equivalent duration at nominal rate (example: 8 bytes
at 2Mbps are equivalent to 2 bytes at 500 Kbps).

Code would look as below:

unsigned int can_skb_get_frame_len(const struct can_priv *can,
                   const struct sk_buff *skb)
{
/* ... */

    if (cfd->flags & CANFD_BRS)
        len = mult_frac(CANFD_FRAME_OVERHEAD, can->bittiming.bitrate,
                 can->data_bittiming.bitrate);
/* ... */
}

This is just an overview, the data bitrate is also applied to some
other fields of the frame (e.g. the CRC). So when creating the macro
for the CANFD_FRAME_OVERHEAD, it should be split between the nominal
and data bitrates.

> + * b.) The macro CAN_DLL_OVERHEAD_EFF and CAN_DLL_OVERHEAD_SFF are
> + * for classical CAN. Need to do the addition for CAN-FD (the value
> + * are expected to be close enough so the impact should be minimal or
> + * none).
> + *
> + * Return: length in bytes.
> + */
> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb)
> +{
> +       const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
> +       u8 len;
> +
> +       if (can_is_canfd_skb(skb)) {
> +               len = cf->len + CAN_DLL_OVERHEAD_EFF;

The CAN-FD frame can also be sent in SFF. An additional check on the
CAN_EFF_FLAG is needed here.

> +       } else {
> +               if (cf->can_id & CAN_RTR_FLAG)
> +                       len = 0;
> +               else
> +                       len = cf->len;
> +
> +               if (cf->can_id & CAN_EFF_FLAG)
> +                       len += CAN_DLL_OVERHEAD_EFF;
> +               else
> +                       len += CAN_DLL_OVERHEAD_SFF;
> +       }
> +
> +       return len;
> +}
> +EXPORT_SYMBOL_GPL(can_skb_get_dll_len);
> +
>  #ifdef CONFIG_CAN_CALC_BITTIMING
>  #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
>
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 41ff31795320..fc830f919099 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -192,6 +192,9 @@ u8 can_dlc2len(u8 can_dlc);
>  /* map the sanitized data length to an appropriate data length code */
>  u8 can_len2dlc(u8 len);
>
> +/* get data link layer length of CAN/CAN-FD frame */
> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb);
> +
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>                                     unsigned int txqs, unsigned int rxqs);
>  #define alloc_candev(sizeof_priv, echo_skb_max) \

Yours sincerely,
Vincent
