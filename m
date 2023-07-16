Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD04754FDB
	for <lists+linux-can@lfdr.de>; Sun, 16 Jul 2023 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGPQpa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Jul 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGPQpa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 12:45:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB857E51;
        Sun, 16 Jul 2023 09:45:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-997c4107d62so36392966b.0;
        Sun, 16 Jul 2023 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689525927; x=1692117927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKIpXva7ywFQzvsW5jQNH5m3B3QzrfOqCNOqVk8oz50=;
        b=kodCJleFEUOHRuJPtP26v+P84+kVvYPBCDu/itY+DlTNmCqAlCV8FZV/1YW2xkMj5q
         L9cTYZx9TavnKL5BFtFhHp0vEM94U1Lf+XVk1GseG/euUu0gUs7NsujKxjiKsiKJWfSR
         0nFHtdMPVhzVe2nneZStFqCUn4zA4mBifxZ5rODOyea9X1w5/G2p2i/XDEi9i/oP+hiP
         ybZSjI4aREC0wcEaoFOk29M3mNLLP1FU7ii/t1rbMvI5gVfZeukt7Kg9++oXHtjHMp4U
         83tjVNx0VweeKPE4XBtgrpbgQu8aY6V7tjPFNSFKPmGdseyldThIlYWNGbUAO/JCiXiO
         3keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689525927; x=1692117927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKIpXva7ywFQzvsW5jQNH5m3B3QzrfOqCNOqVk8oz50=;
        b=gfM/dd1zO5tshjLFUvFlo1+2njBtiOpUa0WhnJ7thINOa2R2rB23TyJ/J+pYPDLP3M
         D09obEiCkp96CCStoZd7f3NQXtPxs7eMm4f/gWsZ2vFWv5d3jn2W1+UPI6DI91xqYSi2
         65xCGVUqCk6hQQJUEq5U/wtfqpNTqpCg6R98wt4KIYXNg4oZJKhtYGTMHimBR87hpzr5
         dxpudmTmn6y5TSd3fgEQjOEqZh0aSHolwFBtLaaI0rAH5np6Nh5KgC0jfVrRaIiNR2gg
         JlFrKuZ5ZgWHsrYr/WMaXNZduXrT9PGinR4zBA/pKnOC+K7IVkhxEluN0MQXtjCvMv17
         WfLQ==
X-Gm-Message-State: ABy/qLYlVfKCtT7fYeM26pDZuLf8/8m1HZrNjJ84k9AQksoPzPidG07M
        X/tK9bYju2R+StR8URXsuhs=
X-Google-Smtp-Source: APBJJlH7dHV0aPBa0/hAZAevvgrCk4G69iZisJ5PGh3fHh08Fe+InkC8mXmUPnRa0o/WjvFIlH3qag==
X-Received: by 2002:a17:906:208d:b0:994:34a2:8727 with SMTP id 13-20020a170906208d00b0099434a28727mr11072273ejq.41.1689525926889;
        Sun, 16 Jul 2023 09:45:26 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906261a00b00992f8110a2bsm8161891ejc.150.2023.07.16.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 09:45:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev, Jookia <contact@jookia.org>
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/4] can: sun4i_can: Correctly set acceptance registers on the D1
Date:   Sun, 16 Jul 2023 18:45:25 +0200
Message-ID: <4844353.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230715112523.2533742-5-contact@jookia.org>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-5-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dne sobota, 15. julij 2023 ob 13:25:22 CEST je Jookia napisal(a):
> From: John Watts <contact@jookia.org>
> 
> The Allwinner D1's CAN controllers have the ACPC and ACPM registers
> moved down. Compensate for this by adding an offset quirk for the
> acceptance registers.
> 
> Signed-off-by: John Watts <contact@jookia.org>

This patch should precede patch 3, so in next patch you add full D1 support.

Best regards,
Jernej

> ---
>  drivers/net/can/sun4i_can.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index 06f2cf05aaf5..c508a328e38d 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -91,6 +91,8 @@
>  #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
>  #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
>  #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
> +#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1 
*/
> +#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 
on the D1
> */ #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer
> start */ #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN 
transmit
> buffer end */
> 
> @@ -205,9 +207,11 @@
>   * struct sun4ican_quirks - Differences between SoC variants.
>   *
>   * @has_reset: SoC needs reset deasserted.
> + * @acp_offset: Offset of ACPC and ACPM registers
>   */
>  struct sun4ican_quirks {
>  	bool has_reset;
> +	int acp_offset;
>  };
> 
>  struct sun4ican_priv {
> @@ -216,6 +220,7 @@ struct sun4ican_priv {
>  	struct clk *clk;
>  	struct reset_control *reset;
>  	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register 
writes */
> +	int acp_offset;
>  };
> 
>  static const struct can_bittiming_const sun4ican_bittiming_const = {
> @@ -338,8 +343,8 @@ static int sun4i_can_start(struct net_device *dev)
>  	}
> 
>  	/* set filters - we accept all */
> -	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
> -	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
> +	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv-
>acp_offset);
> +	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv-
>acp_offset);
> 
>  	/* clear error counters and error code capture */
>  	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
> @@ -768,14 +773,17 @@ static const struct ethtool_ops sun4ican_ethtool_ops =
> {
> 
>  static const struct sun4ican_quirks sun4ican_quirks_a10 = {
>  	.has_reset = false,
> +	.acp_offset = 0,
>  };
> 
>  static const struct sun4ican_quirks sun4ican_quirks_r40 = {
>  	.has_reset = true,
> +	.acp_offset = 0,
>  };
> 
>  static const struct sun4ican_quirks sun4ican_quirks_d1 = {
>  	.has_reset = true,
> +	.acp_offset = (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
>  };
> 
>  static const struct of_device_id sun4ican_of_match[] = {
> @@ -877,6 +885,7 @@ static int sun4ican_probe(struct platform_device *pdev)
>  	priv->base = addr;
>  	priv->clk = clk;
>  	priv->reset = reset;
> +	priv->acp_offset = quirks->acp_offset;
>  	spin_lock_init(&priv->cmdreg_lock);
> 
>  	platform_set_drvdata(pdev, dev);




