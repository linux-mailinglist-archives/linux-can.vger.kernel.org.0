Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8916F998D
	for <lists+linux-can@lfdr.de>; Sun,  7 May 2023 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEGP66 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 7 May 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGP64 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 7 May 2023 11:58:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813411639
        for <linux-can@vger.kernel.org>; Sun,  7 May 2023 08:58:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso2452939a91.1
        for <linux-can@vger.kernel.org>; Sun, 07 May 2023 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683475134; x=1686067134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNu+G7caHREkZ/R++t5SVGqttygqbvUF/ROdD4CtQVU=;
        b=l/9igim2Gjp1+lc+YrrGqaeXb5HyLogWyDWIA7HELbJBn6J8IIOTLX8Vdjyh6CLv9j
         R0ScslKU5aHHabWkT/yx04sTJlrKHF6dDIzNifo1xRLJr+OeIwIIZ18D3QyizSW7rbNx
         qnpHyrzEWL95b2tQPzTU0zELUfuZiteXaQu0bV5seTwju1nFZXq5deP7gI6NE669cMki
         ZyqEz2XsHcZY9yBj/q4GUlgXzyZkA93U8oQPmQKLYvJhJINQg6TDHIJxdsWzI97JpPMq
         /1HIcKyPljmwMbJido2QlNKpC9z8JVrEPyh5gW8fp5o83YL4AuLtjAAZrexxPHenMqPr
         OlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683475134; x=1686067134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNu+G7caHREkZ/R++t5SVGqttygqbvUF/ROdD4CtQVU=;
        b=Y6NM9QPCGjOihoCyFzrUtnV3kT5pFsvMHZ84vumqVSDjrNLygE2mPXHL6PGBYU40cH
         3tpI/i1MKpNTbj1pmJZbj8uVwzoZ0WRxlQdvryYCnf0xbID/K+GDwH/ziq/wsLn2L+Ok
         3qmU45x+NM2LsgsUIVRoAl4XsqHH4Fdazrs0mVIaa2idThbbaJFqBokhWHFggPFKWN/y
         rv8OKqNrcnCVNs3E55RYFLJhKd9jv3BihOurc+T57Ji2mGDN6ypM9tFLdqEPJl2aSny4
         fZRK+3wH9w4OESmlDSpAM3z/JNSDCERUGisgBEVzyk1v31G5cEu/sia+CCx3AWP7r3yq
         a6zg==
X-Gm-Message-State: AC+VfDyFiFgIilvyCfw9b4MuJDLKcKKBR/eJe7RoOQKX7ViEq8Rpa+tN
        mK0Iyp0iILrUkzFxGayyjAtqiSiKIG5KIRb9HaQ=
X-Google-Smtp-Source: ACHHUZ6z3iqSNLZg9Af0Nf0QUE+LlRjP65lg2LRg0GDnhTyTOgM5pKQ6Zt7wXr7n71nLo2RQv9wtZZrs/hdXNqN+tg4=
X-Received: by 2002:a17:90a:8c17:b0:24d:f3cc:7d34 with SMTP id
 a23-20020a17090a8c1700b0024df3cc7d34mr7785123pjo.32.1683475134472; Sun, 07
 May 2023 08:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230505222820.126441-1-marex@denx.de>
In-Reply-To: <20230505222820.126441-1-marex@denx.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Mon, 8 May 2023 00:58:42 +0900
Message-ID: <CAMZ6RqKYVJP-_Qdmj3pSAft5fsQtTK5HTsfRv+LsYwa4ngKMrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: mcp251xfd: Increase poll timeout
To:     Marek Vasut <marex@denx.de>
Cc:     linux-can@vger.kernel.org, Fedor Ross <fedor.ross@ifm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marek,

The patches should have been in reverse order:

  1st: can: mcp251xfd: Move generic macros into length.h
  2nd: can: mcp251xfd: Increase poll timeout

so that you do not have to remove the lines just added in the previous patch.

On Tue. 6 May 2023 at 07:36, Marek Vasut <marex@denx.de> wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
>
> Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
> maximum of 1ms (arbitrarily chosen during driver development) and
> bit time of one full CANFD frame including bit stuffing and bus idle
> condition sample cycles, at the current bitrate. This seems to be
> necessary when configuring low bit rates like 10 Kbit/s for example.
> Otherwise during polling for the CAN controller to enter
> 'Normal CAN 2.0 mode' the timeout limit is exceeded and the
> configuration fails with:
>
> $ ip link set dev can1 up type can bitrate 10000
> [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
> [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
> RTNETLINK answers: Connection timed out
>
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Thomas Kopp <thomas.kopp@microchip.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: linux-can@vger.kernel.org
> ---
> V2: - Add macros for CAN_BIT_STUFFING_OVERHEAD and CAN_IDLE_CONDITION_SAMPLES
>       (thanks Thomas, but please double check the comments)
>     - Update commit message
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++++-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 68df6d4641b5c..207bcd5bf795b 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -227,6 +227,7 @@ static int
>  __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
>                           const u8 mode_req, bool nowait)
>  {
> +       const struct can_bittiming *bt = &priv->can.bittiming;
>         u32 con = 0, con_reqop, osc = 0;
>         u8 mode;
>         int err;
> @@ -251,7 +252,12 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
>                                        FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
>                                                  con) == mode_req,
>                                        MCP251XFD_POLL_SLEEP_US,
> -                                      MCP251XFD_POLL_TIMEOUT_US);
> +                                      max(MCP251XFD_POLL_TIMEOUT_US,
> +                                          (unsigned int)(CANFD_FRAME_LEN_MAX *
> +                                           BITS_PER_BYTE *
> +                                           CAN_BIT_STUFFING_OVERHEAD +

The goal is to have the exact number of bits, right?

It seems odd to me to use a rounded value and then try to recalculate
the exact length in bits.
I understand that because CANFD_FRAME_OVERHEAD_EFF is a multiple of
BITS_PER_BYTE, CANFD_FRAME_LEN_MAX happened to be the exact value.
Regardless, that is a fluke.

I think that we should have another set of definitions for the frame
lengths in bits. I sent a proposal here:

 https://lore.kernel.org/linux-can/20230507155506.3179711-1-mailhol.vincent@wanadoo.fr/

If you like it, you can rebase this patch on top of mine and use the
newly defined CANFD_FRAME_LEN_MAX_BITS_STUFFING.


> +                                           CAN_IDLE_CONDITION_SAMPLES) *
> +                                          USEC_PER_SEC / bt->bitrate));
>         if (err != -ETIMEDOUT && err != -EBADMSG)
>                 return err;
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index 7024ff0cc2c0c..412d58d84fb63 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -432,6 +432,15 @@ static_assert(MCP251XFD_FIFO_RX_NUM <= 4U);
>  /* Use Half Duplex SPI transfers */
>  #define MCP251XFD_QUIRK_HALF_DUPLEX BIT(5)
>
> +/* CAN bit stuffing overhead multiplication factor */
> +#define CAN_BIT_STUFFING_OVERHEAD      1.2
> +
> +/* Number of samples after which an idle condition is present on the bus
> + * as specified in the ISO. This is 11 consecutive sampled recessive bits
> + * after a full frame (if one is currently in transmission).
> + */
> +#define CAN_IDLE_CONDITION_SAMPLES     11
> +
>  struct mcp251xfd_hw_tef_obj {
>         u32 id;
>         u32 flags;
> --
> 2.39.2
>
