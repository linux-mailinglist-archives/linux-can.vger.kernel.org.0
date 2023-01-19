Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58A674768
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 00:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjASXs5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 18:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASXsp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 18:48:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9B9FDDE
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:48:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso2427940pjq.5
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DFwIi0C3p8+mRwsWCJEWaaJOa3h6+7u1SeQVKrIZTos=;
        b=kMesK5ApbipPskD3ZZ8WdeTQv7CUjtaWKLZDxwuficMA/PZX0Rja7gItTWaM2nzR50
         SHUUYzVzKUJIdTuPC+HnnlygNWwxlOCEEi28islk9fRYwuUBFgCc21LfTuK3cavlz47s
         W2ftFSUrZf2BWZs1xvMr4e4wf4owd1MzWKuaOrjYfpWMTd6WeF6yFKMmVm3HOUZbCqRT
         R70DA5hCKJd3crqUXmmYVxQjjeTk09JtxVHsJIg27WH5hqxdUvWU8x4LPEgTBv2VqSDM
         MpSrGF0FfemHPF71x09yqOpxehbwgYwscUqlZPNv67ZVrmgQ8HNLA8MuQJ/BB3xGPtyo
         vGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFwIi0C3p8+mRwsWCJEWaaJOa3h6+7u1SeQVKrIZTos=;
        b=IliIEI0tecai77US2101khFBg/o0hfOJyEF1VHc3QLH2BcNpl6oXKEzuC7jGnz3vyB
         1Mofy8JdjcUh99Ydx07JilXliXpTaPL5DZZtf8RoIDk5pqRapV06GlLQmKTslL8Kd2nO
         Xvx+gQoNPrlp5CYwsTIsh+4AI0b1X8xJpikGPR5Cn+px/uxqz6hNcRUORGRpQDZWgc7E
         CFvvWl733N8HlH0s9WOyAskeQ/f817gzmWsAEGLj4QJmVcLVj8Fp+PqCJF8XvGPFjwdz
         YxqmEzeaWXOVFg2XrosT7O9htZ0up5KCB4Vb86WmTdEZ9jQsb92Z4qcGV5Cqcu2us1r8
         QV4g==
X-Gm-Message-State: AFqh2ko/wch4NjMb6FpjfY+5P4THEJg0m26e/wetwA/EPBsr+ZplNPEd
        eChl2a2EJj5Agr3uvA80Eof5uhXbKcoRkSqrk80igDZVz1Y=
X-Google-Smtp-Source: AMrXdXuVTZPMmF5LLDnQSO1rH2EaTrf8Wy14lKDIp8C3+DbxS80uu8MEeWL8ENXVTIpd3AT3iWjrwm1wzp92qcc1jcg=
X-Received: by 2002:a17:90a:e501:b0:229:d9d0:6df6 with SMTP id
 t1-20020a17090ae50100b00229d9d06df6mr630560pjy.222.1674172116372; Thu, 19 Jan
 2023 15:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com> <20230119154528.28425-2-uttenthaler@ems-wuensche.com>
In-Reply-To: <20230119154528.28425-2-uttenthaler@ems-wuensche.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 20 Jan 2023 08:48:24 +0900
Message-ID: <CAMZ6Rq+s2Y24DqtEaJe_qyzS9sopr6oqQeL+y1ctQy=KKvw_gQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] can: ems_pci: Fixed code style, copyright and email address
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

On Fri. 20 Jan 2023 at 01:02, Gerhard Uttenthaler
<uttenthaler@ems-wuensche.com> wrote:
> Fix code style complained by checkpatch.pl, added Copyright and
> fixed email address
>
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/sja1000/ems_pci.c | 43 +++++++++++++------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
> index 4ab91759a5c6..8071ff4708dc 100644
> --- a/drivers/net/can/sja1000/ems_pci.c
> +++ b/drivers/net/can/sja1000/ems_pci.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
>   * Copyright (C) 2008 Markus Plessing <plessing@ems-wuensche.com>
>   * Copyright (C) 2008 Sebastian Haas <haas@ems-wuensche.com>
> + * Copyright (C) 2023 EMS Dr. Thomas Wuensche
>   */
>
>  #include <linux/kernel.h>
> @@ -19,7 +20,7 @@
>
>  #define DRV_NAME  "ems_pci"
>
> -MODULE_AUTHOR("Sebastian Haas <haas@ems-wuenche.com>");
> +MODULE_AUTHOR("Sebastian Haas <support@ems-wuenche.com>");
>  MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
>  MODULE_LICENSE("GPL v2");
>
> @@ -40,8 +41,7 @@ struct ems_pci_card {
>
>  #define EMS_PCI_CAN_CLOCK (16000000 / 2)
>
> -/*
> - * Register definitions and descriptions are from LinCAN 0.3.3.
> +/* Register definitions and descriptions are from LinCAN 0.3.3.
>   *
>   * PSB4610 PITA-2 bridge control registers
>   */
> @@ -52,8 +52,7 @@ struct ems_pci_card {
>  #define PITA2_MISC          0x1c       /* Miscellaneous Register */
>  #define PITA2_MISC_CONFIG   0x04000000 /* Multiplexed parallel interface */
>
> -/*
> - * Register definitions for the PLX 9030
> +/* Register definitions for the PLX 9030
>   */
>  #define PLX_ICSR            0x4c   /* Interrupt Control/Status register */
>  #define PLX_ICSR_LINTI1_ENA 0x0001 /* LINTi1 Enable */
> @@ -62,8 +61,7 @@ struct ems_pci_card {
>  #define PLX_ICSR_ENA_CLR    (PLX_ICSR_LINTI1_ENA | PLX_ICSR_PCIINT_ENA | \
>                              PLX_ICSR_LINTI1_CLR)
>
> -/*
> - * The board configuration is probably following:
> +/* The board configuration is probably following:
>   * RX1 is connected to ground.
>   * TX1 is not connected.
>   * CLKO is not connected.
> @@ -72,8 +70,7 @@ struct ems_pci_card {
>   */
>  #define EMS_PCI_OCR         (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
>
> -/*
> - * In the CDR register, you should set CBP to 1.
> +/* In the CDR register, you should set CBP to 1.
>   * You will probably also want to set the clock divider value to 7
>   * (meaning direct oscillator output) because the second SJA1000 chip
>   * is driven by the first one CLKOUT output.
> @@ -100,8 +97,7 @@ static const struct pci_device_id ems_pci_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
>
> -/*
> - * Helper to read internal registers from card logic (not CAN)
> +/* Helper to read internal registers from card logic (not CAN)
>   */
>  static u8 ems_pci_v1_readb(struct ems_pci_card *card, unsigned int port)
>  {
> @@ -146,8 +142,7 @@ static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
>         writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
>  }
>
> -/*
> - * Check if a CAN controller is present at the specified location
> +/* Check if a CAN controller is present at the specified location
>   * by trying to set 'em into the PeliCAN mode
>   */
>  static inline int ems_pci_check_chan(const struct sja1000_priv *priv)
> @@ -185,10 +180,10 @@ static void ems_pci_del_card(struct pci_dev *pdev)
>                 free_sja1000dev(dev);
>         }
>
> -       if (card->base_addr != NULL)
> +       if (card->base_addr)
>                 pci_iounmap(card->pci_dev, card->base_addr);
>
> -       if (card->conf_addr != NULL)
> +       if (card->conf_addr)
>                 pci_iounmap(card->pci_dev, card->conf_addr);
>
>         kfree(card);
> @@ -202,8 +197,7 @@ static void ems_pci_card_reset(struct ems_pci_card *card)
>         writeb(0, card->base_addr);
>  }
>
> -/*
> - * Probe PCI device for EMS CAN signature and register each available
> +/* Probe PCI device for EMS CAN signature and register each available
>   * CAN channel to SJA1000 Socket-CAN subsystem.
>   */
>  static int ems_pci_add_card(struct pci_dev *pdev,
> @@ -222,8 +216,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>         }
>
>         /* Allocating card structures to hold addresses, ... */
> -       card = kzalloc(sizeof(struct ems_pci_card), GFP_KERNEL);
> -       if (card == NULL) {
> +       card = kzalloc(sizeof(*card), GFP_KERNEL);
> +       if (!card) {
>                 pci_disable_device(pdev);
>                 return -ENOMEM;
>         }
> @@ -248,13 +242,13 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>
>         /* Remap configuration space and controller memory area */
>         card->conf_addr = pci_iomap(pdev, 0, conf_size);
> -       if (card->conf_addr == NULL) {
> +       if (!card->conf_addr) {
>                 err = -ENOMEM;
>                 goto failure_cleanup;
>         }
>
>         card->base_addr = pci_iomap(pdev, base_bar, EMS_PCI_BASE_SIZE);
> -       if (card->base_addr == NULL) {
> +       if (!card->base_addr) {
>                 err = -ENOMEM;
>                 goto failure_cleanup;
>         }
> @@ -281,7 +275,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>         /* Detect available channels */
>         for (i = 0; i < max_chan; i++) {
>                 dev = alloc_sja1000dev(0);
> -               if (dev == NULL) {
> +               if (!dev) {
>                         err = -ENOMEM;
>                         goto failure_cleanup;
>                 }
> @@ -325,8 +319,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                         /* Register SJA1000 device */
>                         err = register_sja1000dev(dev);
>                         if (err) {
> -                               dev_err(&pdev->dev, "Registering device failed "
> -                                                       "(err=%d)\n", err);
> +                               dev_err(&pdev->dev, "Registering device failed (err=%d)\n", err);

          ^^^^^^^^

Remove the brackets. Ref:
  https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages
  Printing numbers in parentheses (%d) adds no value and should be avoided.

Optional for your series, but if you like, you can consider to print
the mnemotechnic instead of the error value:

                dev_err(&pdev->dev,
                    "Registering device failed: %pe\n",
                    ERR_PTR(err));

>                                 free_sja1000dev(dev);
>                                 goto failure_cleanup;
>                         }
> @@ -334,7 +327,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                         card->channels++;
>
>                         dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d\n",
> -                                       i + 1, priv->reg_base, dev->irq);
> +                                i + 1, priv->reg_base, dev->irq);
>                 } else {
>                         free_sja1000dev(dev);
>                 }
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
