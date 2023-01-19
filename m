Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED7674740
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 00:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjASXdu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 18:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASXdt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 18:33:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1B93736
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:33:46 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so2834865pgr.12
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yjo0gMRMcadCKrIqh2W3sAJv61NGQNflc72AqHbz+GU=;
        b=fCLGI7+Vu17ND3Fi3fYvUvfVLIETg63ZRyVgedDgdPKyL914Rgnop/acLWWeICvQMm
         KkBcqdb/L80mBp10n51n1AFTI4et/4rjxIsHnTRfG5oT1AGsbuA9YcLMyGo78y08G+BU
         ewoIm/vSkZhlXmkWNGf5C4ZnZpzibRYunx0umwMW0nliDYq5pyOmzkmHcNMiZRv0eNfa
         KRAYPNKcf4Dz1hgg2h8DIUtyuIZ8KwPd/uMW9mqr2XlgisxoN8DJQ6v8za10mIQwpkMs
         YV7fOLNqybQFQkwhDR3LMGispVtdcu60ja6ZCQxns3ho5vVGmKwZtosSN9MSxuULhBPL
         N2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjo0gMRMcadCKrIqh2W3sAJv61NGQNflc72AqHbz+GU=;
        b=Lr6uQBVS6g0oOmL/lSP9EhVkN5saemYwvCbZOavt3Wj7Csoqf7Uzrid8Gsq2ENVBvi
         gXQJc7c/sAooYUqbQCY7r5FonEkqu7oV+fBiEkNQyejKGTIyKyETx9s8U0QUIOgrdVc+
         UIVUJxnwQycZzP/pfR1Ymk2MlTuisgyeqMLgV3wgCJROpozA4CvSiMxY8SN8uCwnBOSx
         Fegok+BAlRqLy11decNxIgcxhApsgR50nqcVEDEg9qEKAdQq1CJ0PlFzVrZ4R+6KqvXi
         2Q+R1Wi+CRTIJSgp+i4LfOSouuFPq+4weYVrV35gegwk7/DGzZZxywFQFdbu3sbyv1WU
         hqmA==
X-Gm-Message-State: AFqh2kqmIceE9efywOyF11wZx/f+1//PbhXBjiBWGimGfh8qRQk1UBqm
        6B4CVaUXD5azzVhhZT/mo4EBVExezb5W661U3po=
X-Google-Smtp-Source: AMrXdXtI0O4fWKyXagHc+zHucepZDmCTP5Vjq/dUVnlmxB4dD+rw4FxZFrA/WjW2rRaQem56/RM464ISe+6KqqsreoQ=
X-Received: by 2002:a05:6a00:26c4:b0:58d:9588:88f8 with SMTP id
 p4-20020a056a0026c400b0058d958888f8mr1123323pfw.69.1674171225644; Thu, 19 Jan
 2023 15:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com> <20230119154528.28425-9-uttenthaler@ems-wuensche.com>
In-Reply-To: <20230119154528.28425-9-uttenthaler@ems-wuensche.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 20 Jan 2023 08:33:34 +0900
Message-ID: <CAMZ6RqJbYu=OVcd36hHtrieMdBEcfeg73y2H0Z4myH-6gJzL=Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] can: ems_pci: Added MODULE_AUTHOR
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
>
> Added myself ass module author and fix three code style issues
               ^^^
A self esteem lapsus? :)

>
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/sja1000/ems_pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
> index 68fdead6ad74..5c2f4afba2d0 100644
> --- a/drivers/net/can/sja1000/ems_pci.c
> +++ b/drivers/net/can/sja1000/ems_pci.c
> @@ -21,6 +21,7 @@
>  #define DRV_NAME  "ems_pci"
>
>  MODULE_AUTHOR("Sebastian Haas <support@ems-wuenche.com>");
> +MODULE_AUTHOR("Gerhard Uttenthaler <uttenthaler@ems-wuenche.com>");
>  MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
>  MODULE_LICENSE("GPL v2");
>
> @@ -283,7 +284,6 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                 conf_bar = EMS_PCI_V3_CONF_BAR;
>                 conf_size = EMS_PCI_V3_CONF_SIZE;
>         } else if (pdev->vendor == PCI_VENDOR_ID_PLX) {
> -

This line was inadvertently added in PATCH 4/8 and is now removed
here. Fix please.

>                 card->version = 2; /* CPC-PCI v2 */
>                 max_chan = EMS_PCI_V2_MAX_CHAN;
>                 base_bar = EMS_PCI_V2_BASE_BAR;
> @@ -331,7 +331,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                 /* ASIX chip asserts local reset to CAN controllers
>                  * after bootup until it is deasserted
>                  */
> -               writel(readl(card->conf_addr + ASIX_LIEMR) & ~ASIX_LIEMR_LRST, card->conf_addr + ASIX_LIEMR);
> +               writel(readl(card->conf_addr + ASIX_LIEMR) & ~ASIX_LIEMR_LRST,
> +                      card->conf_addr + ASIX_LIEMR);
>         }
>
>         ems_pci_card_reset(card);
> @@ -392,7 +393,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>                                 /* Enable IRQ in AX99100 */
>                                 writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
>                                 /* Enable local INT0 input enable */
> -                               writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN, card->conf_addr + ASIX_LIEMR);
> +                               writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN,
> +                                      card->conf_addr + ASIX_LIEMR);
>                         }
>
>                         /* Register SJA1000 device */
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
