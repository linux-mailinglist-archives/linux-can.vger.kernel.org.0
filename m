Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FE674743
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 00:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASXfq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 18:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASXfp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 18:35:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404593734
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:35:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jl3so3813244plb.8
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1BGM4Hbjy3zbaSD/tYJtAQN8/usCpF0FYZJ+Qah02M=;
        b=bZvvLf/g4e2Lxbqf9AYcVkxXaZUmdL/xYLDndZIrJYKTrDhCGFsDvgzfld2dIsgK00
         B9SQwzJf5W/goZI/UdsCfgV8GQ+rAuYPKl7TXKIHJiDmYm/s7JUDpGWEFkCYaYFqBq45
         jQKsu0dr/GpuaqlDNPE7wwacmRltUwYt77PAcf1oXKyDqpzB3f5HHPW/NvhZd7RArH6l
         n6BU9UcKMIMm3rj0DlZkclG0Qna57tzArv7HSkFnPCvgNCbBl0RWSrphUot+LFvyss6+
         peYWaVIxsq/c4f/o0niCeP4VgRyBzfhDuhxEbR4KgbgEPE1jqccMpPWize1l6Gf6nY1e
         9PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1BGM4Hbjy3zbaSD/tYJtAQN8/usCpF0FYZJ+Qah02M=;
        b=VnZ92kXM8MHEwZ/xWDvaniMhXDNGUCKMPu8oJFicc8BKYlIjng74DKXNrIkcCue14K
         LQOvpEJbS5ZVrujfWjruTxTf5ZMTylJWn66DbX6eGaEvzPsIee8zDTBfw4yd6SGKtLbr
         3zftg828LMRtIAyP+wbatfZdsCfIczp7UX2LzNUKTgahQo70mV8q0dU7+ec08uGI79gp
         EcadGA1qCbkIubbDDJoiuBO7iquLpiwaikGm/U3JhLKwicnSdeWgAK3h18AQETdMoZz3
         nkgNyZvpNQLmESGY7UKSHSESTh2cXAho4e0zcAva0GcDfX8e4UjkbrpydqhmUoElKHfs
         j8Gw==
X-Gm-Message-State: AFqh2krSczOGj5quY+30WY9AwuisDWYAVzOawEsCpQH11uGFA5cwULFq
        e3/Uf7R9zA/mrxadqdgBq4hkC5XFtWl1dexgL2o=
X-Google-Smtp-Source: AMrXdXuqZOzIYL2/7nJn1PmYqp5R/rGqbVaOeOrr6gHT7TFvgDRiHa417/HrGOPykxUPmcgBlsP9zOa9mfNrDbf0VOA=
X-Received: by 2002:a17:90a:12c9:b0:229:3523:1f6 with SMTP id
 b9-20020a17090a12c900b00229352301f6mr1213637pjg.92.1674171343802; Thu, 19 Jan
 2023 15:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com> <20230119154528.28425-5-uttenthaler@ems-wuensche.com>
In-Reply-To: <20230119154528.28425-5-uttenthaler@ems-wuensche.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 20 Jan 2023 08:35:32 +0900
Message-ID: <CAMZ6RqKcOyf9aHCU-+5P3ktsgHqALVc4zUoAM2V7iUV8rFxz0g@mail.gmail.com>
Subject: Re: [PATCH 4/8] can: ems_pci: Added read/write register and post irq functions
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 20 Jan 2023 at 01:15, Gerhard Uttenthaler
<uttenthaler@ems-wuensche.com> wrote:
> Added functions to read and write SJA1000 registers and also the
> post irq routine
>
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/sja1000/ems_pci.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
> index be61d39149c4..338233a5d337 100644
> --- a/drivers/net/can/sja1000/ems_pci.c
> +++ b/drivers/net/can/sja1000/ems_pci.c
> @@ -172,6 +172,24 @@ static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
>         writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
>  }
>
> +static u8 ems_pci_v3_read_reg(const struct sja1000_priv *priv, int port)
> +{
> +       return readb(priv->reg_base + port);
> +}
> +
> +static void ems_pci_v3_write_reg(const struct sja1000_priv *priv,
> +                                int port, u8 val)
> +{
> +       writeb(val, priv->reg_base + port);
> +}
> +
> +static void ems_pci_v3_post_irq(const struct sja1000_priv *priv)
> +{
> +       struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
> +
> +       writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
> +}
> +
>  /* Check if a CAN controller is present at the specified location
>   * by trying to set 'em into the PeliCAN mode
>   */
> @@ -265,6 +283,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                 conf_bar = EMS_PCI_V3_CONF_BAR;
>                 conf_size = EMS_PCI_V3_CONF_SIZE;
>         } else if (pdev->vendor == PCI_VENDOR_ID_PLX) {
> +

No newline here. I see that you fix it in PATCH 8/8, so this is an
obvious squash issue.

>                 card->version = 2; /* CPC-PCI v2 */
>                 max_chan = EMS_PCI_V2_MAX_CHAN;
>                 base_bar = EMS_PCI_V2_BASE_BAR;
> @@ -330,10 +349,14 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                         priv->read_reg  = ems_pci_v1_read_reg;
>                         priv->write_reg = ems_pci_v1_write_reg;
>                         priv->post_irq  = ems_pci_v1_post_irq;
> -               } else {
> +               } else if (card->version == 2) {
>                         priv->read_reg  = ems_pci_v2_read_reg;
>                         priv->write_reg = ems_pci_v2_write_reg;
>                         priv->post_irq  = ems_pci_v2_post_irq;
> +               } else {
> +                       priv->read_reg  = ems_pci_v3_read_reg;
> +                       priv->write_reg = ems_pci_v3_write_reg;
> +                       priv->post_irq  = ems_pci_v3_post_irq;
>                 }
>
>                 /* Check if channel is present */
> --
> 2.35.3
>
> --
> EMS Dr. Thomas Wuensche e.K.
> Sonnenhang 3
> 85304 Ilmmuenster
> HR Ingolstadt, HRA 170106
>
> Phone: +49-8441-490260
> Fax  : +49-8441-81860
> http://www.ems-wuensche.com
