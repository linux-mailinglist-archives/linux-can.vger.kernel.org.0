Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607357D067
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGUP4Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGUP4Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 11:56:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C041F46DB3
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 08:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58634B8239F
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 15:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD728C3411E;
        Thu, 21 Jul 2022 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658418980;
        bh=AwB9w17iYXRXJCGcJuxwX32BnoDP+E5pRxzspulhhRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3UkmJs3RrxlKb4jx4bnkteUvFyKxIas5FXGTcxQ+9ytTLCWdZglwDP3kN5I8+t4+
         LW/XBls5GXOPUZsyceN2sbUo2arf8yHHkvJu12JfEU0oHlIKt3A8roWlr/m2lUz1me
         UeymxGf+ZpMoT4BnBW/24674n5hmbSqsd0VOVvHhzAElNNX/umhdmSfv5np99fKpZP
         l5WiJCZsVH7mJuqFo9UAWMEmGXfrlAOg2umzzoza9EFX4yyXSz4KsmAquES+fZUN+a
         Sr45wyeYwAsUTm58HFG4FTKLYmYWhbNUJuUQokhRu4ZH83Uj3VGY1mYaZK0RAsFNVT
         s+94zbQjPNSKQ==
Date:   Thu, 21 Jul 2022 08:56:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: pch_can: fix uninitialized use of errc
Message-ID: <Ytl3I9MY9tkuqTKZ@dev-arch.thelio-3990X>
References: <20220721155228.3399103-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721155228.3399103-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jul 21, 2022 at 05:52:28PM +0200, Marc Kleine-Budde wrote:
> Fix the uninitialized use of errc by moving the ioread32() up, before
> accessing it.
> 
> Fixes: 3a5c7e4611dd ("can: pch_can: do not report txerr and rxerr during bus-off")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks a lot for the quick fix!

> ---
>  drivers/net/can/pch_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> index 50f6719b3aa4..32804fed116c 100644
> --- a/drivers/net/can/pch_can.c
> +++ b/drivers/net/can/pch_can.c
> @@ -489,6 +489,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
>  	if (!skb)
>  		return;
>  
> +	errc = ioread32(&priv->regs->errc);
>  	if (status & PCH_BUS_OFF) {
>  		pch_can_set_tx_all(priv, 0);
>  		pch_can_set_rx_all(priv, 0);
> @@ -502,7 +503,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
>  		cf->data[7] = (errc & PCH_REC) >> 8;
>  	}
>  
> -	errc = ioread32(&priv->regs->errc);
>  	/* Warning interrupt. */
>  	if (status & PCH_EWARN) {
>  		state = CAN_STATE_ERROR_WARNING;
> -- 
> 2.35.1
> 
> 
