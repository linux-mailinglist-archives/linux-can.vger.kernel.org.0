Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7845155E67B
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiF1OHl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jun 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbiF1OHh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jun 2022 10:07:37 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6633E20
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 07:07:35 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 7621530B2946;
        Tue, 28 Jun 2022 16:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=x4DIm
        FGi66VgvNmKXvb8W2mrNAsS4u5UUAX4Q76WOrI=; b=nhCwwrm7rDabyJX/DUg0r
        Vs6HlBhDpgapwmizQsjYCx48oicr7MPL9EOPOyPkwQl4TYs4fqmX3ER2AIgv3yCq
        DDOfKCD/0xqsbBWlh/M6/UvcMolPcp1dee2hTCrXcputetI+OfQrCY50PW93RRP9
        8wBZNc5XSotI51VCBwcIWebL4CQVJ64A0eQPDSEGR/KF5qFI6hgmY8EOrxKd30ji
        GZckpxHx7Zwf/VsBB3peEvxTDvcISaVBRhGqjDPhA1pLaBY6fWRyr/31x8LwHdsQ
        ixbkmeb9lIiBSpgO9Yfv2KRg8jB+WfWJD5BdwD0fvCIjlK3dihNP+DfZSQrZLR4t
        g==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 9E88030ADC01;
        Tue, 28 Jun 2022 16:07:32 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 25SE7WLd010981;
        Tue, 28 Jun 2022 16:07:32 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 25SE7WaF010980;
        Tue, 28 Jun 2022 16:07:32 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ctucanfd: ctucan_interrupt(): fix typo
Date:   Tue, 28 Jun 2022 16:07:27 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, Ondrej Ille <ondrej.ille@gmail.com>,
        Martin Jerabek <martin.jerabek01@gmail.com>
References: <20220628083204.881311-1-mkl@pengutronix.de>
In-Reply-To: <20220628083204.881311-1-mkl@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202206281607.27936.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tuesday 28 of June 2022 10:32:04 Marc Kleine-Budde wrote:
> This patch fixes the typo "poniter" -> "pointer" in the kerneldoc of
> ctucan_interrupt().
>
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source
> IP core - bus independent part.") Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Ondrej Ille <ondrej.ille@gmail.com>
> Cc: Martin Jerabek <martin.jerabek01@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c
> b/drivers/net/can/ctucanfd/ctucanfd_base.c index 64990bf20fdc..14ac7c0ee04c
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -1087,7 +1087,7 @@ static void ctucan_tx_interrupt(struct net_device
> *ndev) /**
>   * ctucan_interrupt() - CAN Isr
>   * @irq:	irq number
> - * @dev_id:	device id poniter
> + * @dev_id:	device id pointer
>   *
>   * This is the CTU CAN FD ISR. It checks for the type of interrupt
>   * and invokes the corresponding ISR.


-- 
Yours sincerely

                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

